#!/bin/bash

bg=$(xrdb -get background)
fg=$(xrdb -get foreground)

print_datetime() {
    secs=$1
    # str=""
    # [ $secs -gt 3600 ] && str+=$(printf '%02d:' $((secs/3600)))
    # [ $secs -gt 60 ] && str+=$(printf '%02d' $((secs%3600/60)))
    # [ $secs -gt 60 ] && str+=$(printf ':%02d' $((secs%60)))
    printf '%02d:%02d:%02d' $((secs/3600)) $((secs%3600/60)) $((secs%60)) 
}

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

out="%{F$fg}"
[ "$current_context" ] && out+="$current_context:"
out+="$n_pending!$n_overdue~$n_next"

if [ "$n_active" -ne 0 ]; then

    task_active=$(task export active)

    active_project=$(task active rc.color:off rc.verbose: rc.report.active.columns:project rc.report.active.labels:1)
    active_description=$(task active rc.color:off rc.verbose: rc.report.active.columns:description rc.report.active.labels:1)
    active_tags=$(task active rc.verbose: rc.report.active.columns:tags rc.report.active.labels:1)

    in=$(timew export | jq -r '.[-1].start')
    time_start=$(date -d "${in:0:4}-${in:4:2}-${in:6:2} ${in:9:2}:${in:11:2}:${in:13:2}" +%s)
    time_now=$(date +%s)
    #TODO: calculate time elapsed from timewarrior
    secs=$((time_now - time_start - 3600)) # TODO HACK for wrong timew config (+2h)

    [ "$active_project" ] && out+="  %{F$fg}project:$active_project"
    out+="  %{B$fg}%{F$bg}%{B$fg}%{F$bg}  $active_description  %{B#00}"
    if [[ -n $active_tags ]]; then
        out+="%{F$fg}"
        IFS=' ' read -ra tags <<< "$active_tags"
        for i in "${tags[@]}"
        do
            out+=" +$i"
        done
    fi

    # time_estimated=$(echo "$task_active" | jq -r '.[0].estimate')
    # if [ -n "$time_estimated" ]; then
    #     time_estimated=$((time_estimated * 60))
    #     if [ $secs -gt "$time_estimated" ]; then
    #         overtime=$((secs - time_estimated))
    #         out+=" %{F#ff0000}$(print_datetime $secs) %{B#ff0000}%{F$bg}  +$(print_datetime $overtime)  %{B$bg}"
    #     fi
    # else
    #     out+=" $(print_datetime $secs)"
    # fi
else
    next=$(task +next limit:3 export)
    # for task in $(task +next limit:5 export | jq -r '.[]'); do
    #     #project="$(echo "$task" | jq -r '.[0].project')"
    #     #echo $project
    #     echo "##### "
    #     echo $task
    # done
    project="$(echo "$next" | jq -r '.[0].project')"
    description="$(echo "$next" | jq -r '.[0].description')"
    out+="%{F#505050}  "
    [ "$project" ] && out+="$project: "
    [ "$description" ] && out+="$description"
    #out+=" +$n_next"
    # #task +next limit:3 export | jq -r '.[] | .description | to_entries'
    
    # for task in $(task +next limit:3 export | jq -r '.[]'); do
    #     echo "------------------------------"
    #     echo $task
    # done

    #task +next export | jq -r '.[] | to_entries' | while read description; do
        #echo "-------------: $description"
    # #     out+=" $description"
    #done
fi

printf '%s' "$out"
