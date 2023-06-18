#!/bin/bash

n_inbox=$(notmuch count tag:inbox)
n_tagged=$(notmuch count tag:flagged)
n_today=$(notmuch count tag:inbox and date:today)
n_unread=$(notmuch count tag:inbox and tag:unread)
lastmailsync="$(date -r "${XDG_CONFIG_HOME:-$HOME/.config}/mutt/.mailsynclastrun")"

TEXT=""
ALT=""
TOOLTIP="<span size='24pt' font='Inter Bold'>INBOX $n_inbox</span>\n<sub>$lastmailsync</sub>\n\n<span>$n_unread Unread</span>\n<span>$n_tagged Tagged</span>\n<span>$n_today Today</span>\n"
CLASS="unread"

function htmlEscape () {
    local s
    s=${1//&/&amp;}
    s=${s//</&lt;}
    s=${s//>/&gt;}
    s=${s//'"'/&quot;}
    printf -- %s "$s"
}

if [ "$n_unread" -gt 0 ]; then
    #headers="$(notmuch show --format=json tag:inbox and tag:new and tag:unread | jq -r '.[0][0][0].body[0].content[0].content[0].content')"
    headers=$(notmuch show --format=json tag:inbox and tag:new and tag:unread | jq -r '.[0][0][0].headers')
    #unread_from="$(echo $headers | jq -r '.From')"
    #unread_subject="$(echo $headers | jq -r '.Subject')"
    #ALT="$(htmlEscape $body)"
    #TOOLTIP="<span>$body</span>"
    ICON="󰇮"
    [ "$n_unread" -gt 1 ] && ICON="󰻧"
    TEXT="<tt>$ICON</tt><tt> $n_unread</tt>"
fi

printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s", "percentage": %i }' "$TEXT" "$ALT" "$TOOLTIP" "$CLASS"
