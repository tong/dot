#!/bin/zsh
UNREAD=$(mail-unread)
if [ "$UNREAD" = "0" ]; then
    echo
else
    echo " $UNREAD"
fi

