#!/bin/sh
# echo "DUNST_APP_NAME: $DUNST_APP_NAME" >> ~/.config/dunst/script/test.txt
# echo $DUNST_SUMMARY >> ~/.config/dunst/script/test.txt
# echo $DUNST_BODY >> ~/.config/dunst/script/test.txt
# echo $DUNST_ICON_PATH >> ~/.config/dunst/script/test.txt
# echo $DUNST_URGENCY >> ~/.config/dunst/script/test.txt
# echo $DUNST_ID >> ~/.config/dunst/script/test.txt
# echo $DUNST_PROGRESS >> ~/.config/dunst/script/test.txt
# echo $DUNST_CATEGORY >> ~/.config/dunst/script/test.txt

play_sound() {
    play "$VOID/sound/$1.wav" &> /dev/null
}
case "$DUNST_APP_NAME" in
    email)
        #espeak "You've got email" -p 30 -s 140 &> /dev/null
        play_sound "Blow" &
        ;;
    xmpp)
        play_sound "Frog" &
        ;;
    remind)
        play_sound "Tink" &
        ;;
    *)
        notify-send --app-name="dunst" "unknown notification event"
        ;;
esac
