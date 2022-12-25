#!/bin/sh
PORT=22
sessions="$(lsof -Pi | grep ":$PORT")"
if [ -n "$sessions" ]; then
    hosts=$(echo "$sessions" | cut -d ">" -f 2 | cut -d " " -f 1 | cut -d ":" -f 1 | awk '{printf "%s",$0} END {print ""}')
    echo -e "$hosts" # | tr -s "\n" ":"
else
    echo ""
fi
