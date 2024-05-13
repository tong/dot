import datetime
import json
import os
import subprocess
import time
from datetime import datetime, timedelta

# shows timewarrior tracking time elapsed

def format_time_part(t):
    if t < 10:
        return f"0{t}"
    return str(t)

def getTimeElapsed(start):
    now = datetime.now() - timedelta(hours=2) # HACK: timewarror doesn't store tz
    diff = now - start
    total_secs = diff.total_seconds()
    secs = diff.seconds % 60
    mins = total_secs / 60
    hours = int(mins / 60)
    if hours > 0:
        hours = int(hours)
        mins = int(mins % 60)
    else:
        mins = int(mins)
    r = format_time_part(hours)+":"+format_time_part(mins)
    if hours == 0 and mins == 0:
        r = r + format_time_part(secs)
    return r

obj = {}
lastupdate = 0.0
start = None

while True:
    lastmod = os.path.getmtime("/home/tong/.local/share/timewarrior/data")
    if lastmod > lastupdate:
        lastupdate = time.time()
        data = json.loads(subprocess.check_output(['timew', 'export']))
        last = data[-1:][0]
        if "end" not in last:
            start = datetime.strptime(last["start"], "%Y%m%dT%H%M%SZ")
            obj["text"] = getTimeElapsed(start)
            obj["tooltip"] = "\n+".join(last["tags"])
        else:
            start = None
            obj["text"] = ""
            obj["tooltip"] = ""
        print(json.dumps(obj), flush=True)
    if start is not None:
        obj["text"] = getTimeElapsed(start)
        print(json.dumps(obj), flush=True)
    time.sleep(1)
