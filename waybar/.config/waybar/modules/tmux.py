import subprocess

#TEXT = " "

r = subprocess.check_output(['tmux', 'ls'])
sessions_attached = []
sessions_detached = []
for line in r.splitlines():
    l = line.decode("utf-8")
    session = l[0:l.find(":")]
    attached = l.find("(attached)") > -1
    if attached:
        sessions_attached.append(f"<span weight='bold'>[{session}]</span>")
    else:
        sessions_detached.append(f"<span>{session}</span>")
out = "".join(sessions_attached)
if len(sessions_detached) > 0:
    out = out + f"/{"/".join(sessions_detached)}"
print(out, flush=True)
