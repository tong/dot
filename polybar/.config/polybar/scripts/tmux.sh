#!/bin/bash
if sessions=$(tmux ls 2>/dev/null); then
    printf " "
    bg=$(xrdb -get background)
    fg=$(xrdb -get foreground)
    fg_low=$(xrdb -get color8)
    echo "$sessions" | while read -r line; do
        session=$(echo "$line" | cut -d ':' -f 1)
        if echo "$line" | grep -q "(attached)"; then
           # color="%{B$bg}%{F$fg}"
            color="%{B#00}%{F$fg}"
        else
            color="%{B#00}%{F$fg_low}"
        fi
        printf "%s%s%s " "$color" "$session" "%{B- F-}"
    done
else
    echo ""
fi
