#!/bin/sh
#N=$(find $HOME/.local/share/mail/$EMAIL/INBOX/new -type f -newer "${XDG_CONFIG_HOME:-$HOME/.config}/mutt/.mailsynclastrun" 2> /dev/null)
N=$(find "$HOME/.local/share/mail/$EMAIL/INBOX/new" -type f | wc -l)
if [ "$N" = "0" ]; then
    echo ""
else
    echo ""
fi
