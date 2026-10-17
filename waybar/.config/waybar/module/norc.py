#!/usr/bin/env python3
"""
norc: presence, calls, new messages, mentions, typing contacts, presence requests, file offers and online contacts
of a running norc (with api = 1 or --api).

Runs continuously (no interval): prints a JSON line on each change, reconnects when norc restarts.
    norc.py [ACCOUNT]    default: the only norc running with the api
SIGUSR1 resets the new messages, mentions and attention requests, and mutes the ringtone (on-click).
A ringing call plays the ringtone (RINGTONE) in a loop, not with your presence dnd; your call the ringback tone
(RINGBACK) until it is answered.

Classes (by priority): ringing, calling, connected, call (connecting), attention, unread, files (file offers),
pending (presence requests), typing,
offline, away, dnd, online.
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

ICON = "󰭹"
# in the text after the icon
TYPING = "󰏫"  # nf-md-pencil (✎ is in no installed font)
REQUEST = "+"
FILE = "↓"
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
ACCOUNT = sys.argv[1] if len(sys.argv) > 1 else None
# seconds between requests of the own presence, presence requests and file offers (norc has no event when they end)
REFRESH = 30
# typing without a new chat state for this long: stopped (a client may not send `paused`)
TYPING_TIMEOUT = 60


class State:
    def __init__(self):
        self.online = False
        self.jid: str | None = None
        self.error: str | None = None  # why offline (connection, login)
        self.presence: dict | None = None  # own: {"state", "status"}
        self.contacts = {}  # bare jid -> {"name", "presence"} of available contacts
        self.calls = {}  # id (else the peer) -> {"from", "name", "state", "media", "incoming", "recording"}
        self.unread = {}  # contact name, or "nick in room" for mentions -> new messages
        self.typing = {}  # bare jid -> (name, time of the chat state)
        self.requests = {}  # bare jid -> name: asking to see your presence
        self.offers = {}  # id -> {"from", "file", "size"}: files offered to you
        self.attention = []  # (name, text) of /attention


state = State()


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
            threading.Thread(target=self.loop, args=(self.generation, sound), daemon=True).start()

    def loop(self, generation, sound):
        while generation == self.generation:
            try:
                self.proc = subprocess.Popen(self.player + [sound], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
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


def describe(p):
    return p["state"] + (f" ({p['status']})" if p.get("status") else "")


def size(n):
    if n is None:
        return "?"
    for unit in ("B", "KB", "MB", "GB"):
        if n < 1024 or unit == "GB":
            return f"{n:.0f} {unit}" if unit == "B" else f"{n:.1f} {unit}"
        n /= 1024


def show():
    s = state
    count = sum(s.unread.values())
    ringing = [c for c in s.calls.values() if c["state"] == "ringing"]
    # the text: the icon, then what waits for you
    parts = []
    if count:
        parts.append(str(count))
    if s.attention:
        parts.append(ATTENTION)
    if s.typing:
        parts.append(TYPING + ", ".join(name for name, _ in s.typing.values()))
    if s.requests:
        parts.append(f"{REQUEST}{len(s.requests)}")
    if s.offers:
        parts.append(f"{FILE}{len(s.offers)}")
    if s.calls:
        c = (ringing or list(s.calls.values()))[0]
        rec = f" {RECORDING}" if any(c.get("recording") for c in s.calls.values()) else ""
        parts = [f"{CALL_ICONS.get(c['state'], c['state'])} {c['name']}{rec}"] + parts
        cls = {"ringing": "ringing", "calling": "calling", "connected": "connected"}.get(c["state"], "call")
    elif s.attention:
        cls = "attention"
    elif count:
        cls = "unread"
    elif s.offers:
        cls = "files"
    elif s.requests:
        cls = "pending"
    elif s.typing:
        cls = "typing"
    elif not s.online:
        cls = "offline"
    else:
        own = (s.presence or {}).get("state", "available")
        cls = {"away": "away", "xa": "away", "dnd": "dnd"}.get(own, "online")
    data = {"text": " ".join([ICON] + parts), "class": cls}
    calling = any(c["state"] == "calling" for c in s.calls.values())
    ringer.update(
        RINGTONE if ringing and (s.presence or {}).get("state") != "dnd" else RINGBACK if calling else None
    )

    lines = [f"<b>norc</b> {esc(s.jid or ACCOUNT or '')}"]
    if not s.online:
        lines.append("offline" + (f": {esc(s.error)}" if s.error else ""))
    elif s.presence:
        lines.append(esc(describe(s.presence)))
    if s.calls:
        lines += ["", "<b>Calls</b>"]
        for c in s.calls.values():
            direction = "from" if c["incoming"] else "to"
            lines.append(
                f"  {esc(c['state'])} {direction} {esc(c['name'])} ({esc(c['media'])})"
                + (f" {RECORDING} recording" if c.get("recording") else "")
            )
    if s.attention:
        lines += ["", "<b>Attention</b>"] + [
            f"  {esc(name)}" + (f": {esc(text)}" if text else "") for name, text in s.attention
        ]
    if s.unread:
        lines += ["", "<b>New messages</b>"] + [
            f"  {esc(name)}: {n}" for name, n in s.unread.items()
        ]
    if s.typing:
        lines += ["", "<b>Typing</b>"] + [f"  {esc(name)}" for name, _ in s.typing.values()]
    if s.requests:
        lines += ["", "<b>Asking to see your presence</b>"] + [
            f"  {esc(name)}  <i>/contacts accept {esc(jid)}</i>" for jid, name in s.requests.items()
        ]
    if s.offers:
        lines += ["", "<b>Files offered</b>"] + [
            f"  {esc(o['file'] or 'file')} ({size(o['size'])}) from {esc(bare(o['from']))}  <i>/file accept {id}</i>"
            for id, o in s.offers.items()
        ]
    if s.online and s.contacts:
        lines += ["", f"<b>Online</b> ({len(s.contacts)})"]
        for c in sorted(s.contacts.values(), key=lambda c: c["name"].lower()):
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
    ringer.mute()
    state.unread.clear()
    state.attention.clear()
    show()


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


def bare(jid):
    return jid.split("/")[0]


def data(request, d):
    """The result of a request"""
    s = state
    if request == "presence":
        s.online = d["online"]
        s.presence = {"state": d["state"], "status": d.get("status")}
    elif request == "config":
        s.jid = bare(d["values"].get("jid") or "") or None
    elif request == "contacts":
        s.contacts = {
            c["jid"]: {"name": c.get("name") or c["jid"], "presence": c["presence"]}
            for c in d["contacts"]
            if c.get("presence")
        }
    elif request == "requests":
        s.requests = {jid: s.requests.get(jid, jid) for jid in d["requests"]}
    elif request == "transfers":
        s.offers = {
            t["id"]: {"from": t["peer"], "file": t.get("file"), "size": t.get("size")}
            for t in d["transfers"]
            if t["direction"] == "receive" and t["state"] == "offered"
        }
    elif request == "calls":
        s.calls = {
            c.get("id", c["peer"]): {
                "from": c["peer"],
                "name": bare(c["peer"]),
                "state": c["state"],
                "media": c["media"],
                "incoming": c["incoming"],
                "recording": bool(c.get("recording")),
            }
            for c in d["calls"]
        }


def event(name, d):
    s = state
    if name == "login":
        s.online = True
        s.error = None
    elif name == "logout":
        s.online = False
        s.contacts.clear()
        s.typing.clear()
    elif name == "error" and d.get("kind") in ("connection", "stream", "login"):
        s.error = d.get("text")
    elif name == "presence":
        jid = bare(d["from"])
        if jid == s.jid:
            return
        if d["state"] == "offline" and not d.get("resources"):
            s.contacts.pop(jid, None)
            s.typing.pop(jid, None)
        elif d["state"] != "offline":
            s.contacts[jid] = {"name": d["name"], "presence": describe(d)}
    elif name == "chatstate":
        jid = bare(d["from"])
        if d["state"] == "composing":
            s.typing[jid] = (d["name"], time.time())
        else:
            s.typing.pop(jid, None)
    elif name == "message" and not d.get("delayed") and not d.get("carbon"):
        s.unread[d["name"]] = s.unread.get(d["name"], 0) + 1
        # a message ends typing
        s.typing.pop(bare(d["from"]), None)
    elif name == "room" and d.get("mention") and not d.get("own") and not d.get("delayed"):
        key = f"{d['nick']} in {d['room'].split('@')[0]}"
        s.unread[key] = s.unread.get(key, 0) + 1
    elif name == "sent":
        # answered
        s.unread.pop(d["name"], None)
    elif name == "attention":
        s.attention.append((d["name"], d.get("text")))
    elif name == "subscribe":
        s.requests[bare(d["from"])] = d.get("name") or bare(d["from"])
    elif name == "roster":
        # accepted (from, both) or removed: no longer asking
        if d.get("subscription") in ("from", "both") or d.get("action") == "removed":
            s.requests.pop(d["jid_contact"], None)
    elif name == "file-offer":
        s.offers[d["id"]] = {"from": d["from"], "file": d.get("file"), "size": d.get("size")}
    elif name in ("file-received", "file-failed"):
        peer = d.get("from") or d.get("peer")
        for id, o in list(s.offers.items()):
            if o["from"] == peer and (name == "file-received" or o["file"] == d.get("file")):
                del s.offers[id]
    elif name == "call":
        # by its id: the peer changes from the bare jid to the client answering (a call to all clients)
        key = d.get("id", d["from"])
        if d["state"] == "ended":
            s.calls.pop(key, None)
            if "id" not in d:
                # norc without ids: all calls of the contact
                for k, c in list(s.calls.items()):
                    if bare(c["from"]) == bare(d["from"]):
                        del s.calls[k]
        else:
            s.calls[key] = {
                **s.calls.get(key, {}),
                "from": d["from"],
                "name": d["name"],
                "state": d["state"],
                "media": d["media"],
                "incoming": d["incoming"],
            }
    elif name == "recording":
        for c in s.calls.values():
            if c["from"] == d["from"]:
                c["recording"] = d["state"] == "started"


def expire_typing():
    """Removes typing contacts without a chat state for `TYPING_TIMEOUT`, returns whether any were removed"""
    now = time.time()
    old = [jid for jid, (_, t) in state.typing.items() if now - t > TYPING_TIMEOUT]
    for jid in old:
        del state.typing[jid]
    return bool(old)


def run(path):
    with open(path) as f:
        info = dict(line.split(" = ", 1) for line in f.read().splitlines() if " = " in line)
    with socket.create_connection((info["host"], int(info["port"]))) as sock:
        # woken up for the refresh and to expire typing
        sock.settimeout(5)

        def request(*cmds):
            sock.sendall("".join(json.dumps(c) + "\n" for c in cmds).encode())

        def refresh():
            request(
                {"id": "presence", "cmd": "presence"},
                {"id": "requests", "cmd": "contacts requests"},
                {"id": "transfers", "cmd": "file transfers"},
            )

        request(
            {"auth": info["token"]},
            *({"id": c, "cmd": c} for c in ("config", "contacts", "calls")),
        )
        refresh()
        refreshed = time.time()
        buffer = b""
        while True:
            try:
                chunk = sock.recv(65536)
            except socket.timeout:
                if expire_typing():
                    show()
                if time.time() - refreshed >= REFRESH:
                    refresh()
                    refreshed = time.time()
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
                    event(msg["event"], msg["data"])
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
        # norc doesn't run: the new messages are kept
        unread, attention = state.unread, state.attention
        state.__init__()
        state.unread, state.attention = unread, attention
        show()
        time.sleep(5)


if __name__ == "__main__":
    main()
