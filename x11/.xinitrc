#!/bin/sh
if [ -f "$HOME/.config/x11/xprofile" ]; then
    . "$HOME/.config/x11/xprofile"
fi
session=${1:-xfce}
case $session in
    #gnome-i3) exec gnome-session-i3;;
    i3|i3wm ) exec i3;;
    xfce    ) exec startxfce4;;
    *       ) exec $1;;
esac

