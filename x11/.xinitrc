#!/bin/sh

XRES="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xresources"
[[ -f $XRES ]] && xrdb -merge -I$HOME $XRES

# if [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile" ]; then
	#. "${XDG_CONFIG_HOME:-$HOME/.config}/x11/xprofile"
#else
	#. "$HOME/.xprofile"
#fi

# xset +fp $HOME/.local/share/fonts
# xset fp rehash

xset r rate 190 90 &
$HOME/.screenlayout/2-monitor.sh &
#picom -b --config $HOME/.config/picom.conf --dbus --experimental-backends &
# setbg &
#xwallpaper --zoom $HOME/img/wallpaper/pills-grey3.v.jpg

# Ensure that xrdb has finished running before moving on to start the WM/DE.
[ -n "$xrdbpid" ] && wait "$xrdbpid"

session=${1:-gnome-i3}
case $session in
    gnome-i3    ) exec gnome-session-i3;;
    i3|i3wm     ) exec i3;;
    sway        ) exec sway --unsupported-gpu;;
    *           ) exec $1;;
esac

