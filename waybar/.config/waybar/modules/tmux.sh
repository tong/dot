#!/bin/bash
if list=$(tmux ls 2>/dev/null); then
    i=0
    color="#ffffff"
    echo "$list" | while read -r line; do
        session=$(echo "$line" | cut -d ':' -f 1)
        out="$session"
        i+=1
        # if [ $i != 0 ]; then
            #printf " "
        # fi
        if echo "$line" | grep -q "(attached)"; then
            #out="&lt;$out&gt;"
            out="$out"
            color="#d0d0d0"
        else
            color="#888"
        fi
        printf "<span color='$color'>%s</span>" "$out"
        #printf '{"text": "TEXT", "alt": "ALT", "tooltip": "TOOlTIP", "class": "CLASS", "percentage": 23 }'
    done
fi
