import glob
import html
import json

ICON = "󰊴"
LOW_BATTERY = 20

# BTN_GAMEPAD (BTN_SOUTH), present on real gamepads but not on keyboards
# exposing a joystick interface (e.g. QMK boards)
BTN_GAMEPAD = 0x130

BUS = {
    "0003": "USB",
    "0005": "Bluetooth",
}

# (vendor, product) -> name, for devices reporting generic names
NAMES = {
    ("054c", "05c4"): "DualShock 4",
    ("054c", "09cc"): "DualShock 4",
    ("054c", "0ce6"): "DualSense",
    ("054c", "0df2"): "DualSense Edge",
}


def read(path):
    try:
        with open(path) as f:
            return f.read().strip()
    except OSError:
        return None


def has_key(dev, code):
    # Bitmap of longs, most significant word first
    words = (read(f"{dev}/capabilities/key") or "0").split()[::-1]
    bits = 64 if any(len(w) > 8 for w in words) else 32
    idx, bit = divmod(code, bits)
    return idx < len(words) and bool(int(words[idx], 16) >> bit & 1)


def battery(dev):
    for ps in glob.glob(f"{dev}/device/power_supply/*"):
        capacity = read(f"{ps}/capacity")
        if capacity is not None:
            return int(capacity), read(f"{ps}/status")
    return None, None


def get_gamepads():
    pads = {}
    for dev in sorted(glob.glob("/sys/class/input/input*")):
        if not has_key(dev, BTN_GAMEPAD):
            continue
        vendor = read(f"{dev}/id/vendor")
        product = read(f"{dev}/id/product")
        uniq = read(f"{dev}/uniq") or read(f"{dev}/phys") or dev
        if uniq in pads:
            continue
        capacity, status = battery(dev)
        pads[uniq] = {
            "name": NAMES.get((vendor, product)) or read(f"{dev}/name"),
            "bus": BUS.get(read(f"{dev}/id/bustype"), "Other"),
            "capacity": capacity,
            "status": status,
        }
    return list(pads.values())


def main():
    pads = get_gamepads()
    if not pads:
        print(json.dumps({"text": "", "class": "empty"}))
        return

    parts = []
    lines = []
    low = False
    for pad in pads:
        info = pad["bus"]
        if pad["capacity"] is not None:
            charging = pad["status"] == "Charging"
            info += f", {pad['capacity']}% ({(pad['status'] or 'unknown').lower()})"
            if pad["capacity"] <= LOW_BATTERY and not charging:
                low = True
        parts.append(ICON)
        lines.append(f"<b>{html.escape(pad['name'])}</b> {info}")

    classes = ["connected"]
    if low:
        classes.append("low")

    print(
        json.dumps(
            {
                "text": " ".join(parts),
                "tooltip": "\n".join(lines),
                "class": " ".join(classes),
                "alt": "connected",
            }
        )
    )


if __name__ == "__main__":
    main()
