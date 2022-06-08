#!/bin/sh

XMODMAP="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xmodmap"
[[ -f $XMODMAP ]] && xmodmap $XMODMAP

if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ]; then
	. "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"
else
	. "$HOME/.xprofile"
fi

session=${1:-gnome-i3}
case $session in
    gnome-i3    ) exec gnome-session-i3;;
    i3|i3wm     ) exec i3;;
    sway        ) exec sway --unsupported-gpu;;
    *           ) exec $1;;
esac

