#!/bin/sh
#N=$(find $HOME/.local/share/mail/$EMAIL/INBOX/new -type f -newer "${XDG_CONFIG_HOME:-$HOME/.config}/mutt/.mailsynclastrun" 2> /dev/null)
UNREAD=$(find "$HOME/.local/share/mail/$EMAIL/INBOX/new" -type f | wc -l)
if [ "$UNREAD" = "0" ]; then
    echo ""
else
    echo " $UNREAD"
fi
