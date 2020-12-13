dchr#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh --daemonize)
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh --daemonize)
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

#export GDK_DPI_SCALE=2
#export XDG_CURRENT_DESKTOP=GNOME
#export GDK_BACKEND=wayland
#export CLUTTER_BACKEND=wayland
#export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
#export GNOME_SHELL_SESSION_MODE=classic

#xset +fp /home/tong/.local/share/fonts
#xset fp rehas

#if [ -z $XDG_CURRENT_DESKTOP ]; then
    #export XDG_CURRENT_DESKTOP="GNOME-Flashback:GNOME"
#fi

#exec /usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh --daemonize
#exec /usr/lib/gnome-settings-daemon/gsd-xsettings

exec gnome-session-i3
#exec gnome-session
#exec gnome-session --session=gnome-classic
#exec sway
