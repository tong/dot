#!/bin/sh

ICONS_DIR=$VOID/void-icons/actions
SOUNDS_DIR=$VOID/void-sound

SOUND_MSG_IN="$SOUNDS_DIR/Morse.wav"
#SOUND_MSG_OUT="$SOUNDS_DIR/Purr.wav"
#SOUND_STATUS="$SOUNDS_DIR/Purr.wav"

event=$1
arg1=$2
arg2=$3
filename=$4

play_sound() {
    /usr/bin/play $1 > /dev/null 2>&1 
}

show_notification() {
    notify-send --app-name="" --icon="$ICONS_DIR/$3.svg" "$1" "$2"
}

if [ "$event" = "MSG" ]; then
    case "$arg1" in
        IN)
            # Incoming message from buddy $arg2
            [ $SOUND_MSG_IN ] && play_sound $SOUND_MSG_IN
            if [ -n "$filename" -a -f "$filename" ]; then
                M="$(cat $filename)"
                rm $filename
                show_notification "$arg2" "$M" "im-message-new"
                #espeak "$M"
            fi
            ;;
        MUC)
            # Groupchat message in room $arg2
            [ $SOUND_MSG_IN ] && play_sound $SOUND_MSG_IN
            if [ -n "$filename" -a -f "$filename" ]; then
                M="$(cat $filename)"
                rm $filename
                show_notification "$arg2" "$M" "im-message-new"
            fi
            ;;
    OUT)
        # Outgoing message for buddy $arg2
        [ $SOUND_MSG_OUT ] && play_sound $SOUND_MSG_OUT 
        ;;
    esac
elif [ "$event" = "STATUS" ]; then
    #show="" #(_, O, I, F, D, N, A)"
    icon="presence_unknown"
    case "$arg1" in
        O)
            show="available"
            icon="stock_person"
            ;;
        D)
            show="away"
            icon="presence_away"
            ;;
        F)
            show="chatty"
            icon="stock_person"
            ;;
        A)
            show="away"
            icon="presence_away"
            ;;
        N)
            show="gone"
            icon="presence_offline"
            ;;
        _)
            show="offline"
            ;;
        *) show=$arg1;;
    esac
    show_notification "$arg2" "$show" $icon
    [ $SOUND_STATUS ] && play $SOUND_STATUS
    echo > /dev/null
elif [ "$event" = "UNREAD" ]; then
    # $arg1 contains 4 numbers separated with space chars:
    # Nr of unread buffers, nr of unread buffers with attention sign,
    # nr of MUC unread buffers, nr of MUC unread buffers with attention sign.
    notify-send --app-name=mcabber " $arg1 $arg2"
    echo > /dev/null
fi
