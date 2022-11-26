#!/bin/sh
PORT=22
sessions="$(lsof -Pi | grep ":$PORT")"
if [ -n "$sessions" ]; then
    echo "$(echo "$sessions" | cut -d ">" -f 2 | cut -d " " -f 1 | cut -d ":" -f 1 | awk '{printf " %s",$0} END {print ""}')"
else
    echo ""
fi
