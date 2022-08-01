#!/bin/sh
PORT=22
sessions="$(lsof -Pi | grep ":$PORT")"
if [ -n "$sessions" ]; then
    count=$(echo "$sessions" | wc -l)
    echo "$count $(echo "$sessions" | cut -d ">" -f 2 | cut -d " " -f 1 | cut -d ":" -f 1 | tail -n 1)"
else
    echo ""
fi
