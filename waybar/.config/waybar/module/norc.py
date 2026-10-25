#!/usr/bin/env python3
"""
norc: calls, unread messages and mentions, file offers and transfers, presence requests, typing contacts, your
presence and the online contacts of a running norc (with api = 1 or --api): at its Unix socket if it has one, else
over TCP. Most of it is norc's status (the status event, /overview): norc counts the unread messages, entering a
chat (/chat) or writing in it reads them.

Runs continuously (no interval): prints a JSON line on each change, reconnects when norc restarts.
    norc.py [ACCOUNT] [--icon ICON]
ACCOUNT: the account of the norc (as `norc -a <account>`), default: the only norc running with the api. --icon: the
icon in front of the text (default 󰭹), e.g. a letter per account. One module per account, in the Waybar config:
    "custom/norc#work": {"exec": "python ~/.config/waybar/module/norc.py work --icon W",
                         "on-click": "pkill -USR1 -f 'module/norc.py work( |$)'", "return-type": "json"}
(CSS: #custom-norc as for all, #custom-norc.work for this one.)
SIGUSR1 (on-click) mutes the ringtone and dismisses what is shown: the attention requests and the unread messages
so far (newer ones show again).
A ringing call plays the ringtone (RINGTONE) in a loop, not with your presence dnd; your call the ringback tone
(RINGBACK) until it is answered.

Classes (by priority): ringing, calling, connected, call (connecting), attention, unread (also mentions),
files (file offers), transfer (files being sent or received), pending (presence requests), typing,
offline (also connecting, reconnecting), away, dnd, online.
"""

import html
import json
import os
import signal
import shutil
import socket
import subprocess
import sys
import threading
import time

# in the text after the icon
TYPING = "󰏫"  # nf-md-pencil (✎ is in no installed font)
REQUEST = "+"
FILE = "↓"
TRANSFER = "⇅"
MENTION = "@"
ATTENTION = "!"
RECORDING = "●"
# calls by state (Nerd Font: phone-incoming, phone-outgoing, phone, phone-in-talk)
CALL_ICONS = {
    "ringing": "\U000f03f7",
    "calling": "\U000f03fc",
    "connecting": "\U000f03f2",
    "connected": "\U000f03f6",
}
# played in a loop while a call rings (not with your presence dnd), and while your call waits to be answered;
# a click mutes it
RINGTONE = "/usr/share/sounds/freedesktop/stereo/phone-incoming-call.oga"
RINGBACK = "/usr/share/sounds/freedesktop/stereo/phone-outgoing-calling.oga"
PLAYERS = (["pw-play"], ["paplay"], ["canberra-gtk-play", "-f"])

STATE_DIR = os.path.join(
    os.environ.get("XDG_STATE_HOME") or os.path.expanduser("~/.local/state"), "norc"
)

def options(args):
    """The account and the icon of the command line"""
    account, icon = None, "󰭹"
    i = 0
    while i < len(args):
        if args[i] == "--icon" and i + 1 < len(args):
            icon = args[i + 1]
            i += 1
        elif args[i].startswith("--icon="):
            icon = args[i][len("--icon=") :]
        elif account is None:
            account = args[i]
        i += 1
    return account, icon


ACCOUNT, ICON = options(sys.argv[1:])
# typing without a change for this long: stopped (a client may not send `paused`)
TYPING_TIMEOUT = 60
# seconds between redraws while a call is connected (its duration) or a file is transferred
TICK = 5


class State:
    def __init__(self):
        self.jid: str | None = None
        self.error: str | None = None  # why offline (connection, login)
        self.status: dict | None = None  # norc's status (the status event, /overview)
        self.contacts = {}  # bare jid -> {"name", "presence"} of available contacts
        self.attention = []  # (name, text) of /attention
        self.typing_since = {}  # bare jid -> when it started typing (for TYPING_TIMEOUT)


state = State()
# dismissed with a click: the unread messages (and mentions) per chat then
dismissed = {}


class Ringer:
    """Plays a sound in a loop (in a thread) until stopped or another is played"""

    def __init__(self):
        self.sound = None  # playing
        self.muted = None  # the sound muted until it stops
        self.proc = None
        # each loop plays while it is the current one
        self.generation = 0
        self.player = next((p for p in PLAYERS if shutil.which(p[0])), None)

    def update(self, sound):
        """Plays `sound` in a loop (`None`: nothing), unless it was muted"""
        if sound != self.muted:
            self.muted = None
        if sound == self.sound:
            return
        self.stop()
        if sound and sound != self.muted and self.player and os.path.exists(sound):
            self.sound = sound
            threading.Thread(
                target=self.loop, args=(self.generation, sound), daemon=True
            ).start()

    def loop(self, generation, sound):
        if not self.player:
            return
        while generation == self.generation:
            try:
                self.proc = subprocess.Popen(
                    self.player + [sound],
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )
                self.proc.wait()
            except OSError:
                return
            time.sleep(0.5)

    def stop(self):
        self.generation += 1
        self.sound = None
        if self.proc and self.proc.poll() is None:
            self.proc.terminate()

    def mute(self):
        if self.sound:
            self.muted = self.sound
            self.stop()


ringer = Ringer()


def esc(s):
    return html.escape(str(s), quote=False)


def describe(state, status=None):
    return state + (f" ({status})" if status else "")


def size(n):
    if n is None:
        return "?"
    for unit in ("B", "KB", "MB", "GB"):
        if n < 1024 or unit == "GB":
            return f"{n:.0f} {unit}" if unit == "B" else f"{n:.1f} {unit}"
        n /= 1024


def duration(seconds):
    s = int(seconds)
    h, m = divmod(s // 60, 60)
    return f"{h}:{m:02}:{s % 60:02}" if h else f"{m}:{s % 60:02}"


def bare(jid):
    return jid.split("/")[0]


def unread_chats(s):
    """The chats with unread messages not dismissed: (chat, unread, mentions) with the counts since the click"""
    chats = []
    for c in s.get("chats", []):
        seen = dismissed.get(c["jid"], (0, 0))
        unread, mentions = c["unread"] - seen[0], c["mentions"] - seen[1]
        # rooms: only mentions show, the other messages of rooms only in the tooltip
        if unread > 0 and (not c["room"] or mentions > 0):
            chats.append((c, unread, mentions))
    return chats


def typing(s):
    """The contacts typing (not for longer than TYPING_TIMEOUT without a change)"""
    now = time.time()
    current = {t["jid"]: t for t in s.get("typing", []) if t["state"] == "composing"}
    for jid in list(state.typing_since):
        if jid not in current:
            del state.typing_since[jid]
    for jid in current:
        state.typing_since.setdefault(jid, now)
    return [
        t
        for jid, t in current.items()
        if now - state.typing_since[jid] < TYPING_TIMEOUT
    ]


def show():
    st = state
    s = st.status or {"connection": "offline", "presence": "available"}
    online = s["connection"] == "online"
    calls = s.get("calls", [])
    ringing = [c for c in calls if c["state"] == "ringing"]
    chats = unread_chats(s)
    count = sum(n for c, n, _ in chats if not c["room"])
    mentions = sum(m for _, _, m in chats)
    offers = [t for t in s.get("transfers", []) if t["state"] == "offered"]
    transfers = [t for t in s.get("transfers", []) if t["state"] != "offered"]
    requests = s.get("requests", [])
    typists = typing(s)

    # the text: the icon, then what waits for you
    parts = []
    if count:
        parts.append(str(count))
    if mentions:
        parts.append(f"{MENTION}{mentions}")
    if st.attention:
        parts.append(ATTENTION)
    if typists:
        parts.append(TYPING + ", ".join(t["name"] for t in typists))
    if requests:
        parts.append(f"{REQUEST}{len(requests)}")
    if offers:
        parts.append(f"{FILE}{len(offers)}")
    if transfers:
        sized = [t for t in transfers if t.get("size")]
        done = (
            sum(t["bytes"] for t in sized) / sum(t["size"] for t in sized)
            if sized
            else None
        )
        parts.append(
            TRANSFER
            + (f"{int(done * 100)}%" if done is not None else str(len(transfers)))
        )
    if calls:
        c = (ringing or calls)[0]
        rec = f" {RECORDING}" if any(c.get("recording") for c in calls) else ""
        since = f" {duration(time.time() - c['since'])}" if c.get("since") else ""
        parts = [
            f"{CALL_ICONS.get(c['state'], c['state'])} {c['name']}{since}{rec}"
        ] + parts
        cls = {
            "ringing": "ringing",
            "calling": "calling",
            "connected": "connected",
        }.get(c["state"], "call")
    elif st.attention:
        cls = "attention"
    elif count or mentions:
        cls = "unread"
    elif offers:
        cls = "files"
    elif transfers:
        cls = "transfer"
    elif requests:
        cls = "pending"
    elif typists:
        cls = "typing"
    elif not online:
        cls = "offline"
    else:
        cls = {"away": "away", "xa": "away", "dnd": "dnd"}.get(s["presence"], "online")
    data = {"text": " ".join([ICON] + parts), "class": cls}
    calling = any(c["state"] == "calling" for c in calls)
    ringer.update(
        RINGTONE
        if ringing and s["presence"] != "dnd"
        else RINGBACK
        if calling
        else None
    )

    lines = [f"<b>norc</b> {esc(st.jid or ACCOUNT or '')}"]
    if not online:
        lines.append(esc(s["connection"]) + (f": {esc(st.error)}" if st.error else ""))
    else:
        lines.append(esc(describe(s["presence"], s.get("status"))))
    if calls:
        lines += ["", "<b>Calls</b>"]
        for c in calls:
            direction = "from" if c["incoming"] else "to"
            lines.append(
                f"  {esc(c['state'])} {direction} {esc(c['name'])} ({esc(c['media'])})"
                + (f" {duration(time.time() - c['since'])}" if c.get("since") else "")
                + (f", muted {esc(', '.join(c['muted']))}" if c.get("muted") else "")
                + (f" {RECORDING} recording" if c.get("recording") else "")
            )
    if st.attention:
        lines += ["", "<b>Attention</b>"] + [
            f"  {esc(name)}" + (f": {esc(text)}" if text else "")
            for name, text in st.attention
        ]
    if s.get("chats"):
        lines += ["", "<b>Unread</b>"]
        for c in s["chats"]:
            lines.append(
                f"  {'#' if c['room'] else ''}{esc(c['name'])}: {c['unread']}"
                + (f" ({MENTION}{c['mentions']})" if c["mentions"] else "")
                + ("  <i>/chat " + esc(c["jid"]) + "</i>" if not c["room"] else "")
            )
    if typists:
        lines += ["", "<b>Typing</b>"] + [f"  {esc(t['name'])}" for t in typists]
    if requests:
        lines += ["", "<b>Asking to see your presence</b>"] + [
            f"  {esc(jid)}  <i>/contacts accept {esc(jid)}</i>" for jid in requests
        ]
    if offers:
        lines += ["", "<b>Files offered</b>"] + [
            f"  {esc(t['file'])} ({size(t.get('size'))}) from {esc(t['jid'])}  <i>/file accept {t['id']}</i>"
            for t in offers
        ]
    if transfers:
        lines += ["", "<b>File transfers</b>"]
        for t in transfers:
            progress = f" {int(t['bytes'] / t['size'] * 100)}%" if t.get("size") else ""
            what = (
                "reading, then offering to"
                if t["state"] == "preparing"
                else "to"
                if t["direction"] == "send"
                else "from"
            )
            lines.append(f"  {esc(t['file'])} {what} {esc(t['jid'])}{progress}")
    if s.get("command"):
        lines += [
            "",
            "<b>Command waiting</b>",
            f"  {esc(s['command']['node'])} of {esc(s['command']['jid'])}  <i>/command submit</i>",
        ]
    if online and st.contacts:
        lines += ["", f"<b>Online</b> ({len(st.contacts)})"]
        for c in sorted(st.contacts.values(), key=lambda c: c["name"].lower()):
            lines.append(
                f"  {esc(c['name'])}"
                + (
                    ""
                    if c["presence"] == "available"
                    else f" <i>{esc(c['presence'])}</i>"
                )
            )
    data["tooltip"] = "\n".join(lines)
    print(json.dumps(data, ensure_ascii=False), flush=True)


def reset(*_):
    """A click: mutes the ringtone, dismisses the attention requests and the unread messages so far"""
    ringer.mute()
    state.attention.clear()
    dismissed.clear()
    for c in (state.status or {}).get("chats", []):
        dismissed[c["jid"]] = (c["unread"], c["mentions"])
    show()


def update_status(s):
    state.status = s
    # read in norc (fewer than when dismissed): count from there again
    counts = {c["jid"]: (c["unread"], c["mentions"]) for c in s.get("chats", [])}
    for jid, seen in list(dismissed.items()):
        now = counts.get(jid, (0, 0))
        if now[0] < seen[0] or now[1] < seen[1]:
            del dismissed[jid]


def api_file():
    """The address and token of the socket interface, `None` if norc doesn't run (or several do, without ACCOUNT)"""
    names = (
        [ACCOUNT]
        if ACCOUNT
        else (sorted(os.listdir(STATE_DIR)) if os.path.isdir(STATE_DIR) else [])
    )
    files = [
        os.path.join(STATE_DIR, n, "api")
        for n in names
        if os.path.isfile(os.path.join(STATE_DIR, n, "api"))
    ]
    return files[0] if len(files) == 1 else None


def data(request, d):
    """The result of a request"""
    s = state
    if request == "overview":
        update_status(d)
    elif request == "account":
        s.jid = bare(d.get("jid") or "") or None
    elif request == "contacts":
        s.contacts = {
            c["jid"]: {"name": c.get("name") or c["jid"], "presence": c["presence"]}
            for c in d["contacts"]
            if c.get("presence")
        }


def event(name, d):
    """An event; `False` if it changes nothing shown"""
    s = state
    if name == "status":
        update_status(d)
    elif name == "login":
        s.error = None
    elif name == "logout":
        s.contacts.clear()
    elif name == "error" and d.get("kind") in ("connection", "stream", "login"):
        s.error = d.get("text")
    elif name == "presence":
        jid = bare(d["from"])
        if jid == s.jid:
            return False
        if d["state"] == "offline" and not d.get("resources"):
            s.contacts.pop(jid, None)
        elif d["state"] != "offline":
            s.contacts[jid] = {
                "name": d["name"],
                "presence": describe(d["state"], d.get("status")),
            }
    elif name == "attention":
        s.attention.append((d["name"], d.get("text")))
    else:
        return False
    return True


def connect(info):
    """The Unix socket of the api file if it has one (only you can connect, no token), else TCP"""
    if "socket" in info:
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            sock.connect(info["socket"])
            return sock
        except OSError:
            sock.close()
            if "port" not in info:
                raise
    return socket.create_connection((info["host"], int(info["port"])))


def run(path):
    with open(path) as f:
        info = dict(
            line.split(" = ", 1) for line in f.read().splitlines() if " = " in line
        )
    with connect(info) as sock:
        # woken up to redraw durations and progress, and to expire typing
        sock.settimeout(TICK)
        sock.sendall(
            "".join(
                json.dumps(r) + "\n"
                for r in [
                    # over the Unix socket answered ok without token
                    {"auth": info.get("token", "")},
                    {"id": "account", "cmd": "account"},
                    {"id": "contacts", "cmd": "contacts"},
                    {"id": "overview", "cmd": "overview"},
                ]
            ).encode()
        )
        buffer = b""
        while True:
            try:
                chunk = sock.recv(65536)
            except socket.timeout:
                s = state.status or {}
                if s.get("calls") or s.get("transfers") or state.typing_since:
                    show()
                continue
            if not chunk:
                return
            buffer += chunk
            *lines, buffer = buffer.split(b"\n")
            for line in lines:
                msg = json.loads(line)
                if msg["type"] == "data":
                    data(msg.get("id"), msg["data"])
                elif msg["type"] == "event":
                    if not event(msg["event"], msg["data"]):
                        continue
                elif msg["type"] == "error" and msg.get("id") == "overview":
                    # a norc without status (before /overview)
                    state.error = "this norc has no /overview: update norc"
                else:
                    continue
                show()


def main():
    signal.signal(signal.SIGUSR1, reset)
    while True:
        path = api_file()
        try:
            if path:
                run(path)
        except (OSError, ValueError, KeyError):
            pass
        # norc doesn't run: the attention requests are kept
        attention = state.attention
        state.__init__()
        state.attention = attention
        show()
        time.sleep(5)


if __name__ == "__main__":
    main()
