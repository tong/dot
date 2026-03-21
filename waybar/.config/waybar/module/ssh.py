#!/usr/bin/env python3
import subprocess
import json
import socket
import re


def get_ssh_connections():
    try:
        # -t: TCP, -n: Numeric, -p: Process info
        output = subprocess.check_output(
            ["ss", "-tnp", "state", "established"],
            encoding="utf-8",
            stderr=subprocess.DEVNULL,
        )
        lines = output.strip().split("\n")
        if len(lines) < 2:
            return []

        # Detect column indices from header
        header = lines[0]
        # We look for the start positions of 'Local', 'Peer', and 'Process'
        local_idx_start = header.find("Local")
        peer_idx_start = header.find("Peer")
        proc_idx_start = header.find("Process")

        connections = []
        for line in lines[1:]:
            parts = line.split()
            if len(parts) < 4:
                continue

            # Find which part contains ':' (the ports)
            addr_parts = [p for p in parts if ":" in p]
            if len(addr_parts) < 2:
                continue

            # In established state with -tnp, usually:
            # [State] Recv-Q Send-Q Local:Port Peer:Port Process
            # If 'State' is missing (as in user's output), addr_parts[0] is Local, addr_parts[1] is Peer.

            local = addr_parts[0]
            peer = addr_parts[1]

            # Process info is usually the last part or contains "users:"
            process_info = parts[-1] if "users:" in parts[-1] else ""

            is_ssh = False
            direction = "Outgoing"

            if local.endswith(":22") or local.endswith("]22"):
                is_ssh = True
                direction = "Incoming"
            elif peer.endswith(":22") or peer.endswith("]22"):
                is_ssh = True
                direction = "Outgoing"

            if is_ssh:
                # The peer address is what we want to show
                peer_addr = peer.rsplit(":", 1)[0].replace("[", "").replace("]", "")

                # Get hostname
                try:
                    host = socket.getnameinfo((peer_addr, 0), 0)[0]
                except:
                    host = peer_addr

                # Extract process name
                proc_name = "unknown"
                if process_info:
                    match = re.search(r'"([^"]+)"', process_info)
                    if match:
                        proc_name = match.group(1)

                connections.append(
                    {
                        "host": host,
                        "ip": peer_addr,
                        "direction": direction,
                        "proc": proc_name,
                    }
                )

        return connections
    except Exception:
        return []


def main():
    conns = get_ssh_connections()
    count = len(conns)

    if count == 0:
        print(json.dumps({"text": "", "class": "idle"}))
        return

    text = f"󰣀 {count}"

    tooltip_lines = ["<b>Active SSH Connections</b>", ""]
    for c in conns:
        icon = "󰣀" if c["direction"] == "Incoming" else "󰒍"
        line = f"{icon} <b>{c['host']}</b> ({c['ip']})\n"
        line += f"   <i>{c['direction']} • {c['proc']}</i>"
        tooltip_lines.append(line)

    print(
        json.dumps(
            {
                "text": text,
                "tooltip": "\n".join(tooltip_lines),
                "class": "active",
                "count": count,
            }
        )
    )


if __name__ == "__main__":
    main()
