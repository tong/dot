#!/bin/bash

current_context=$(task _get rc.context)
n_active=$(task +ACTIVE count 2>/dev/null)
n_pending=$(task status:pending count 2>/dev/null)
n_next=$(task status:pending +next count 2>/dev/null)
n_overdue=$(task +READY +OVERDUE count 2>/dev/null)
#n_duetoday=$(task +READY +DUETODAY count)

#if [ $n_overdue -eq 0 ]; then
    #n_overdue="!$n_overdue"
#else
    #n_overdue=" OVERDUE:$n_overdue"
#fi

# function print_next_tasks() {
    #jq -r '.[] | "\(.id): \(.description)"'
    #jq -r '.[] | select(.priority == "H") | .description'
#     descriptions=$(task status:pending +next export | jq -r '.[].description')
#     printf '%s' "$descriptions"
# }

bg=$(xrdb -get background)
fg=$(xrdb -get foreground)

out="%{F$fg}"
[ "$current_context" ] && out+="$current_context:"

if [ "$n_active" -ne 0 ]; then

    out+="$n_pending!$n_overdue~$n_next"

    active_project=$(task active rc.color:off rc.verbose: rc.report.active.columns:project rc.report.active.labels:1)
    active_description=$(task active rc.color:off rc.verbose: rc.report.active.columns:description rc.report.active.labels:1)
    active_tags=$(task active rc.verbose: rc.report.active.columns:tags rc.report.active.labels:1)

    in=$(timew export | jq -r '.[-1].start')
    time_start=$(date -d "${in:0:4}-${in:4:2}-${in:6:2} ${in:9:2}:${in:11:2}:${in:13:2}" +%s)
    time_now=$(date +%s)
    #secs=$((time_now - (time_start+7200))) # TODO HACK for wrong timew config (+2h)
    secs=$((time_now - time_start - 3600)) # TODO HACK for wrong timew config (+2h)
    #time_elapsed=$(printf '%02d:%02d:%02d' $((secs/3600)) $((secs%3600/60)) $((secs%60)))
    time_elapsed=$(printf '%02d:%02d:%02d' $((secs/3600)) $((secs%3600/60)) $((secs%60)))

    #out+=" | "
    [ "$active_project" ] && out+="  %{F$fg}project:$active_project"
    #out+=" %{B#f0f0f0} $active_description  %{B#}"
    out+="  %{B$fg}%{F$bg}%{B$fg}%{F$bg}  $active_description  %{B#00}"
    if [[ -n $active_tags ]]; then
        out+="%{F$fg}"
        IFS=' ' read -ra tags <<< "$active_tags"
        for i in "${tags[@]}"
        do
            out+=" +$i"
        done
    fi
    out+=" $time_elapsed"
else
    out+="$n_pending!$n_overdue~$n_next"
    next=$(task +next export)
    project="$(echo "$next" | jq -r '.[0].project')"
    description="$(echo "$next" | jq -r '.[0].description')"
    out+="%{F#505050}  "
    [ "$project" ] && out+="$project: "
    [ "$description" ] && out+="$description"
    out+=" +$n_next"
    # task +next export | jq -r '.[] | .description' | while read description; do
    #   #echo "Task: $description"
    #     out+=" $description"
    # done
fi

printf '%s' "$out"
