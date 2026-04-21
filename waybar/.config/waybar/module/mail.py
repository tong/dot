#!/usr/bin/env python3
import os
import json
from pathlib import Path

MAIL_DIR = Path.home() / ".local/share/mail"
EMAIL = os.environ.get("EMAIL", "tong@disktree.net")
MAILBOXES = [
    ("INBOX", "󰇰"),
    ("Work", "󰠚"),
    ("spambucket", "󰛱"),
]


def count_unread(mailbox_name):
    mailbox_path = MAIL_DIR / EMAIL / mailbox_name
    if not mailbox_path.is_dir():
        return 0

    unread_count = 0

    new_dir = mailbox_path / "new"
    if new_dir.is_dir():
        unread_count += len(list(new_dir.iterdir()))

    cur_dir = mailbox_path / "cur"
    if cur_dir.is_dir():
        for item in cur_dir.iterdir():
            if item.is_file():
                parts = item.name.split(":2,")
                if len(parts) > 1 and "S" not in parts[1]:
                    unread_count += 1

    return unread_count


def main():
    total_important = 0
    total_spam = 0
    mailbox_details = []

    for mailbox, icon in MAILBOXES:
        count = count_unread(mailbox)
        mailbox_details.append(f"{icon} {mailbox}: {count}")
        if mailbox == "spambucket":
            total_spam += count
        else:
            total_important += count

    if total_important > 0:
        data = {
            "text": f"󰇰 {total_important}",
            "tooltip": "<b>󰇰 Unread Mail</b>\n" + "\n".join(mailbox_details),
            "class": "unread",
        }
    else:
        data = {"text": "", "tooltip": "", "class": "read"}

    print(json.dumps(data))


if __name__ == "__main__":
    main()
