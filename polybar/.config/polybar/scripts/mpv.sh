#!/bin/bash
if pidof mpv > /dev/null; then
    position=$(echo '{ "command": ["get_property_string", "time-pos"] }' | socat - /tmp/mpvsocket | jq .data | tr '"' ' ' | cut -d'.' -f 1)
    remaining=$(echo '{ "command": ["get_property_string", "time-remaining"] }' | socat - /tmp/mpvsocket | jq .data | tr '"' ' ' | cut -d'.' -f 1)
    metadata=$(echo '{ "command": ["get_property", "media-title"] }' | socat - /tmp/mpvsocket | cut -b 10-30)
    printf '%s' "$metadata"
	printf ' | %d:%02d:%02d' $((position/3600)) $((position%3600/60)) $((position%60))
	printf ' - %d:%02d:%02d\n' $((remaining/3600)) $((remaining%3600/60)) $((remaining%60))
else
    exit
fi
