#!/bin/sh
notifications=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /notifications)
count=$(echo "$notifications" | jq '. | length')
#subjects=$(echo "$notifications" | jq -r '.[].subject.title' |  tr -d '\n')
if [ "$count" != "0" ]; then
    TOOLTIP=$(echo "$notifications" |jq -r '.[] | { repo:.repository.full_name, subject:.subject.title, id:.id } | "<b>"+.repo+"</b> <tt>"+.subject+"</tt>"' | while read -r line; do printf "<span>%s</span>\r" "$line"; done)
    printf '{"text": "%s", "alt": "%s", "tooltip": "%s", "class": "%s", "percentage": %i }' "$count" "" "$TOOLTIP" "" ""
fi
