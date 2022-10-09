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

str="%{F#9E9E9E}"

if [ "$n_active" -ne 0 ]; then

    active_project=$(task active rc.color:off rc.verbose: rc.report.active.columns:project rc.report.active.labels:1)
    active_description=$(task active rc.color:off rc.verbose: rc.report.active.columns:description rc.report.active.labels:1)
    active_tags=$(task active rc.verbose: rc.report.active.columns:tags rc.report.active.labels:1)

    in=$(timew export | jq -r '.[-1].start')
    time_start=$(date -d "${in:0:4}-${in:4:2}-${in:6:2} ${in:9:2}:${in:11:2}:${in:13:2}" +%s)
    time_now=$(date +%s)
    secs=$((time_now - (time_start+7200))) # TODO HACK for wrong timew config (+2h)
    time_elapsed=$(printf '%02d:%02d:%02d' $((secs/3600)) $((secs%3600/60)) $((secs%60)))
fi

[ "$current_context" ] && str="$str $current_context:"
str+="$n_pending~$n_active+$n_next!$n_overdue"
[ "$active_description" ] && str+=" %{F#f0f0f0} $active_description "
[ "$active_project" ] && str+=" %{F#9E9E9E}$active_project"
if [[ -n $active_tags ]]; then
    str+="%{F#9E9E9E}"
    IFS=' ' read -ra tags <<< "$active_tags"
    for i in "${tags[@]}"
    do
        str+=" +$i"
    done
fi
[ "$time_elapsed" ] && str+=" $time_elapsed"
echo "$str"

