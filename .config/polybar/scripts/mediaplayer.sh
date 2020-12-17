#!/bin/sh
status=$(playerctl status)
if [ "$status" = "Paused" ]; then
    out=$(playerctl metadata --format "{{ artist }} - {{ album }} - {{ title }}")
    echo "$out"
elif [ "$status" = "Playing" ]; then
    out=$(playerctl metadata --format "{{ artist }} - {{ album }} - {{ title }}")
    echo " $out"
else
    echo ""
fi
