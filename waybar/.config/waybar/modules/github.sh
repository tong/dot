#!/bin/bash
notifications=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /notifications)
count=$(echo "$notifications" | jq '. | length')
if [[ "$count" != "0" ]]; then
    #tooltip=""
    #class=""
    echo '{"text":'$count',"tooltip":"$tooltip","class":"$class"}'
fi
