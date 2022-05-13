#!/bin/sh
FILE=/tmp/himalaya-counter
if [[ -f "$FILE" ]]; then
    UNREAD=$(tail -n 1 $FILE)
    if [ $UNREAD -ne 0 ]; then
        echo " $UNREAD"
    fi
fi
