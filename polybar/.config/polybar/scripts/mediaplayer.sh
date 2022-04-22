#!/bin/sh
status=$(playerctl -s status)
if [ "$status" = "Paused" ]; then
    out="$(playerctl metadata --format "{{ artist }} - {{ album }} - {{ title }}")"
    echo "$out"
elif [ "$status" = "Playing" ]; then
    pos=$(playerctl position)
    #_pos_minutes=$( $pos / 60 )
    #pos_minutes=$(printf "%02d" $_pos_minutes)
    #pos_minutes=$(printf "%02d" $((pos / 60)))
    #pos_minutes=$(printf "%02d" $(($pos / 60)))
    out=$(playerctl metadata --format "{{ artist }} - {{ album }} - {{ title }}")
    echo "$out"
    #printf "%s %s" $out $pos
elif [ "$status" = "Stopped" ]; then
    echo ""
else
    echo ""
fi
