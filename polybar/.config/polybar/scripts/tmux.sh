#!/bin/bash
if sessionlist=$(tmux ls 2>/dev/null); then
    echo "$sessionlist" | while read -r line; do
        session=$(echo "$line" | cut -d ':' -f 1)
        if echo "$line" | grep -q "(attached)"; then
            color="%{B#00000000}%{F#e0e0e0}"
        else
            color="%{B#00000000}%{F#9E9E9E}"
        fi
        printf "%s%s %s" "$color" "$session" "%{B- F-}"
    done
fi
