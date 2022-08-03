#!/bin/sh

#XRES="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources"
#[[ -f $XRES ]] && xrdb -merge -I$HOME $XRES

#XMODMAP="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xmodmap"
#[[ -f $XMODMAP ]] && xmodmap $XMODMAP

#XPROFILE=${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile
XPROFILE=$HOME/.xprofile
[ -f $XPROFILE ] && . $XPROFILE

#if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ]; then
#	. "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"
#else
#	. "$HOME/.xprofile"
#fi

#session=${1:-gnome-i3}
session=${1:-xfce}
case $session in
    gnome-i3    ) exec gnome-session-i3;;
    #i3|i3wm     ) exec i3;;
    xfce        ) exec startxfce4;;
    #sway        ) exec sway --unsupported-gpu;;
    *           ) exec $1;;
esac

