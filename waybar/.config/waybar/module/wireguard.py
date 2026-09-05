import json
import subprocess
import sys

PROFILES = {
    "dev": "wg-sf-dev",
    "prod": "wg-sf-prod",
}
ORDER = list(PROFILES.keys())
ICON = "󰖂"


def active_profile():
    try:
        out = subprocess.check_output(
            ["wg", "show", "interfaces"], encoding="utf-8", stderr=subprocess.DEVNULL
        )
    except Exception:
        return None
    up = set(out.split())
    for name, iface in PROFILES.items():
        if iface in up:
            return name
    return None


def switch_to(target):
    if target not in PROFILES:
        return
    current = active_profile()
    if current == target:
        return
    if current:
        subprocess.run(["sudo", "-n", "wg-quick", "down", PROFILES[current]], check=False)
    subprocess.run(["sudo", "-n", "wg-quick", "up", PROFILES[target]], check=False)


def disconnect():
    current = active_profile()
    if current:
        subprocess.run(["sudo", "-n", "wg-quick", "down", PROFILES[current]], check=False)


def cycle():
    current = active_profile()
    if current is None:
        switch_to(ORDER[0])
        return
    switch_to(ORDER[(ORDER.index(current) + 1) % len(ORDER)])


def print_status():
    current = active_profile()
    if current:
        other = ORDER[(ORDER.index(current) + 1) % len(ORDER)]
        data = {
            "text": f"{ICON} {current}",
            "tooltip": f"<b>WireGuard: {current}</b> ({PROFILES[current]})\n"
            f"Click to switch to {other} • right-click to disconnect",
            "class": f"connected {current}",
            "alt": current,
        }
    else:
        data = {
            "text": f"{ICON} off",
            "tooltip": "WireGuard: disconnected\nClick to connect",
            "class": "disconnected",
            "alt": "off",
        }
    print(json.dumps(data))


def main():
    if len(sys.argv) > 1:
        action = sys.argv[1]
        if action == "cycle":
            cycle()
        elif action == "off":
            disconnect()
        elif action in PROFILES:
            switch_to(action)
        subprocess.run(["pkill", "-RTMIN+8", "waybar"], check=False)
    else:
        print_status()


if __name__ == "__main__":
    main()
