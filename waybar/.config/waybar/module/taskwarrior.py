import os
import json
import html
from tasklib import TaskWarrior


class WaybarTaskwarrior:
    def __init__(self):
        self.data_location = os.environ.get("TASKDATA", "~/.task")
        if not os.path.exists(os.path.expanduser(self.data_location)):
            print(json.dumps({"text": " TASKDATA not found", "class": "error"}))
            exit(1)

        self.tw = TaskWarrior(self.data_location)
        self.colors = {
            "background": "#090909",
            "b_high": "#a1a1a1",
            "b_med": "#707070",
            "b_low": "#595959",
            "b_inv": "#272727",
            "f_high": "#272727",
            "f_med": "#181818",
            "f_low": "#111",
            "f_inv": "#818181",
            "urgent": "#ff0000",
        }
        self.powerline_symbols = {
            "right_arrow": "",
            "right_arrow_thin": "",
            "left_arrow": "",
            "left_arrow_thin": "",
        }

    def _pango_markup(self, text, bg=None, fg=None, weight=None, element="span"):
        attributes = []
        if bg:
            attributes.append(f'background="{bg}"')
        if fg:
            attributes.append(f'color="{fg}"')
        if weight:
            attributes.append(f'font-weight="{weight}"')

        # Pango markup requires XML-escaping for text content.
        safe_text = html.escape(str(text))
        return f"<{element} {' '.join(attributes)}>{safe_text}</{element}>"

    def get_tasks(self):
        self.pending_tasks = self.tw.tasks.pending()
        self.waiting_tasks = self.tw.tasks.waiting()
        self.active_tasks = self.tw.tasks.filter("+ACTIVE")
        self.next_tasks = self.tw.tasks.filter("+next")
        self.overdue_tasks = self.tw.tasks.filter("+OVERDUE")

        self.active_task = self.active_tasks[0] if self.active_tasks else None

    def build_text(self):
        parts = []

        # Counts
        pending_count = len(self.pending_tasks)
        next_count = len(self.next_tasks)
        overdue_count = len(self.overdue_tasks)
        waiting_count = len(self.waiting_tasks)

        if overdue_count > 0:
            parts.append(
                self._pango_markup(
                    f" {overdue_count}  ",
                    self.colors["urgent"],
                    self.colors["f_low"],
                    "bold",
                )
            )
            parts.append(
                self._pango_markup(
                    self.powerline_symbols["right_arrow"],
                    self.colors["urgent"],
                    self.colors["background"],
                )
            )

        if waiting_count > 0:
            parts.append(
                self._pango_markup(
                    f" {waiting_count}  ",
                    self.colors["b_med"],
                    self.colors["f_low"],
                    "bold",
                )
            )

        parts.append(self._pango_markup(f" {pending_count} "))
        if next_count > 0:
            parts.append(self._pango_markup(f"+{next_count} "))

        # Active task
        if self.active_task:
            project = self.active_task["project"]
            description = self.active_task["description"]

            if project:
                parts.append(
                    self._pango_markup(
                        self.powerline_symbols["right_arrow"],
                        self.colors["b_high"],
                        self.colors["background"],
                    )
                )
                parts.append(
                    self._pango_markup(
                        f" {project.upper()} ",
                        self.colors["b_high"],
                        self.colors["f_low"],
                        "bold",
                    )
                )
                parts.append(
                    self._pango_markup(
                        self.powerline_symbols["right_arrow_thin"],
                        self.colors["b_high"],
                        self.colors["background"],
                    )
                )
            else:
                parts.append(
                    self._pango_markup(
                        self.powerline_symbols["right_arrow"],
                        self.colors["b_high"],
                        self.colors["background"],
                    )
                )

            parts.append(
                self._pango_markup(
                    f" {description} ",
                    self.colors["b_high"],
                    self.colors["f_low"],
                    "bold",
                )
            )
            parts.append(
                self._pango_markup(
                    self.powerline_symbols["left_arrow"],
                    self.colors["b_high"],
                    self.colors["background"],
                )
            )

        # Next tasks
        if self.next_tasks:
            next_strings = []
            for task in self.next_tasks[:3]:  # show first 3
                s = task["description"]
                if task["project"]:
                    s = f"{task['project'].upper()}:{s}"
                next_strings.append(s)

            parts.append(
                " "
                + self._pango_markup(
                    f" {self.powerline_symbols['left_arrow_thin']} ".join(next_strings),
                    fg=self.colors["b_med"],
                )
            )

        return "".join(parts)

    def build_tooltip(self):
        tooltip_lines = []
        tooltip_lines.append("<b>Taskwarrior</b>")

        if self.active_task:
            tooltip_lines.append(
                f"\n<b>Active:</b> {html.escape(self.active_task['description'])}"
            )
            if self.active_task["project"]:
                tooltip_lines.append(
                    f"  <i>Project: {html.escape(self.active_task['project'])}</i>"
                )

        if self.overdue_tasks:
            tooltip_lines.append(f"\n<b>Overdue ({len(self.overdue_tasks)}):</b>")
            for task in self.overdue_tasks:
                tooltip_lines.append(f"  - {html.escape(task['description'])}")

        if self.waiting_tasks:
            tooltip_lines.append(f"\n<b>Waiting ({len(self.waiting_tasks)}):</b>")
            for task in self.waiting_tasks:
                tooltip_lines.append(f"  - {html.escape(task['description'])}")

        if self.next_tasks:
            tooltip_lines.append(f"\n<b>Next ({len(self.next_tasks)}):</b>")
            for task in self.next_tasks:
                tooltip_lines.append(f"  - {html.escape(task['description'])}")

        pending_non_next = [
            t for t in self.pending_tasks if not t.active and "+next" not in t["tags"]
        ]
        if pending_non_next:
            tooltip_lines.append(f"\n<b>Pending ({len(pending_non_next)}):</b>")
            for task in pending_non_next:
                tooltip_lines.append(f"  - {html.escape(task['description'])}")

        return "\n".join(tooltip_lines)

    def run(self):
        try:
            self.get_tasks()
            text = self.build_text()
            tooltip = self.build_tooltip()

            output = {"text": text, "tooltip": tooltip, "class": "taskwarrior"}
            print(json.dumps(output))

        except Exception as e:
            print(json.dumps({"text": f"Error: {e}", "class": "error"}))


if __name__ == "__main__":
    WaybarTaskwarrior().run()

