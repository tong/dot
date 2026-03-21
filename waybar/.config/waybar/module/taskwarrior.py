import os
import json
import html
import sys
from datetime import datetime, timezone
from tasklib import TaskWarrior


class WaybarTaskwarrior:
    def __init__(self):
        self.data_location = os.environ.get("TASKDATA", "~/.task")
        expanded_location = os.path.expanduser(self.data_location)

        if not os.path.exists(expanded_location):
            self._exit_with_error(f" {self.data_location} not found")

        try:
            self.tw = TaskWarrior(expanded_location)
        except Exception as e:
            self._exit_with_error(f" TaskWarrior error: {e}")

        self.max_next_tasks = 3
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
            "project": "#81a1c1",
        }
        self.symbols = {
            "right_arrow": "",
            "right_arrow_thin": "",
            "left_arrow": "",
            "left_arrow_thin": "",
            "pending": "📋",
            "urgent": "",
            "active": "󰮔",
            "waiting": "",
            "next": "",
            "timer": "",
        }

    def _exit_with_error(self, message):
        print(json.dumps({"text": message, "class": "error"}))
        sys.exit(0)

    def _pango(self, text, bg=None, fg=None, weight=None, size=None, style=None):
        attrs = []
        if bg:
            attrs.append(f'background="{bg}"')
        if fg:
            attrs.append(f'color="{fg}"')
        if weight:
            attrs.append(f'font-weight="{weight}"')
        if size:
            attrs.append(f'font-size="{size}"')
        if style:
            attrs.append(f'font-style="{style}"')

        safe_text = html.escape(str(text))
        return f"<span {' '.join(attrs)}>{safe_text}</span>"

    def _format_duration(self, start_time):
        if not start_time:
            return ""

        if start_time.tzinfo is None:
            start_time = start_time.replace(tzinfo=timezone.utc)

        now = datetime.now(timezone.utc)
        diff = now - start_time

        seconds = int(diff.total_seconds())
        hours, remainder = divmod(seconds, 3600)
        minutes, _ = divmod(remainder, 60)

        if hours > 0:
            return f"{hours}h {minutes}m"
        return f"{minutes}m"

    def get_tasks(self):
        self.pending = self.tw.tasks.pending()
        self.waiting = self.tw.tasks.waiting()

        # Filter from pending to ensure consistency
        self.active_tasks = self.pending.filter("+ACTIVE")
        self.next_tasks = self.pending.filter("+next")
        self.overdue_tasks = self.pending.filter("+OVERDUE")

        # Tasks that are pending but not active and not tagged 'next'
        self.other_pending = self.pending.filter("-ACTIVE -next")

        self.active_task = self.active_tasks[0] if self.active_tasks else None

    def build_text(self):
        parts = []

        # 1. Overdue Count
        if self.overdue_tasks:
            parts.append(
                self._pango(
                    f" {len(self.overdue_tasks)} {self.symbols['urgent']} ",
                    bg=self.colors["urgent"],
                    fg=self.colors["f_low"],
                    weight="bold",
                )
            )
            parts.append(
                self._pango(
                    self.symbols["right_arrow"],
                    fg=self.colors["urgent"],
                    bg=self.colors["background"],
                )
            )

        # 2. Waiting Count
        if self.waiting:
            parts.append(
                self._pango(
                    f" {len(self.waiting)} {self.symbols['waiting']} ",
                    bg=self.colors["b_med"],
                    fg=self.colors["f_low"],
                    weight="bold",
                )
            )

        # 3. Main Counts
        parts.append(self._pango(f" {len(self.pending)} "))
        if self.next_tasks:
            parts.append(self._pango(f"+{len(self.next_tasks)} ", weight="bold"))

        # 4. Active Task Detail
        if self.active_task:
            project = self.active_task["project"]
            desc = self.active_task["description"]
            duration = self._format_duration(self.active_task["start"])

            # Segment start
            parts.append(
                self._pango(
                    self.symbols["right_arrow"],
                    fg=self.colors["background"],
                    bg=self.colors["b_high"],
                )
            )

            if project:
                parts.append(
                    self._pango(
                        f" {project.upper()} ",
                        bg=self.colors["b_high"],
                        fg=self.colors["f_low"],
                        weight="bold",
                    )
                )
                parts.append(
                    self._pango(
                        self.symbols["right_arrow_thin"],
                        bg=self.colors["b_high"],
                        fg=self.colors["f_low"],
                    )
                )

            main_text = f" {desc} "
            if duration:
                main_text += f"({duration}) "

            parts.append(
                self._pango(
                    main_text,
                    bg=self.colors["b_high"],
                    fg=self.colors["f_low"],
                    weight="bold",
                )
            )

            # Segment end
            parts.append(
                self._pango(
                    self.symbols["left_arrow"],
                    fg=self.colors["background"],
                    bg=self.colors["b_high"],
                )
            )

        # 5. Next Tasks Peek
        if self.next_tasks:
            next_items = []
            for task in self.next_tasks[: self.max_next_tasks]:
                t_str = task["description"]
                if task["project"]:
                    t_str = f"{task['project']}:{t_str}"
                next_items.append(t_str)

            separator = f" {self.symbols['left_arrow_thin']} "
            parts.append(
                " " + self._pango(separator.join(next_items), fg=self.colors["b_med"])
            )

        return "".join(parts)

    def build_tooltip(self):
        lines = []

        def add_section(title, tasks, icon=""):
            if not tasks:
                return
            lines.append(self._pango(f"{icon} {title} ({len(tasks)})", weight="bold"))
            for t in tasks:
                proj = f"[{t['project']}] " if t["project"] else ""

                # Add duration for active tasks in tooltip
                duration = ""
                if t.active:
                    d = self._format_duration(t["start"])
                    if d:
                        duration = f" ({d})"

                lines.append(f"  • {proj}{t['description']}{duration}")
            lines.append("")

        if self.active_task:
            add_section("Active", [self.active_task], self.symbols["active"])

        add_section("Overdue", self.overdue_tasks, self.symbols["urgent"])
        add_section("Next", self.next_tasks, self.symbols["next"])
        add_section("Waiting", self.waiting, self.symbols["waiting"])
        add_section("Pending", self.other_pending, self.symbols["pending"])

        return "\n".join(lines).strip()

    def run(self):
        try:
            self.get_tasks()

            classes = ["taskwarrior"]
            if self.active_task:
                classes.append("active")
            if self.overdue_tasks:
                classes.append("urgent")

            output = {
                "text": self.build_text(),
                "tooltip": self.build_tooltip(),
                "class": " ".join(classes),
                "alt": "active" if self.active_task else "idle"
            }
            print(json.dumps(output))
        except Exception as e:
            self._exit_with_error(f"Runtime error: {e}")


if __name__ == "__main__":
    WaybarTaskwarrior().run()
