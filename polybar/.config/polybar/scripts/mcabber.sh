#!/bin/bash
FILE=$HOME/.mcabber/mcabber.state
if [ -f "$FILE" ];then
    NUM_UNREAD="$(grep -e "$" -c "$FILE")"
    if [[ $NUM_UNREAD == 1 ]];then
        JID=$(cat "$FILE")
        echo " $JID"
    else
        echo "ﮠ $NUM_UNREAD"
    fi
else
    if [ -p "$HOME"/.config/mcabber/fifo ]; then
        echo "ﳽ"
    else
        echo "ﳤ"
    fi
fi
