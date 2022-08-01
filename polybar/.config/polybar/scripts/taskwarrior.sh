#!/bin/bash

n_active=$(task +ACTIVE count)
n_pending=$(task status:pending count)
n_next=$(task status:pending +next count)
n_overdue=$(task +READY +OVERDUE count)
#n_duetoday=$(task +READY +DUETODAY count)

#if [ $n_overdue -eq 0 ]; then
    #n_overdue="!$n_overdue"
#else
    #n_overdue=" OVERDUE:$n_overdue"
#fi

#active_project=""
declare active_project
decalare active_description
if [ "$n_active" -ne 0 ]; then
    active_project=$(task active rc.color:off rc.verbose: rc.report.active.columns:project rc.report.active.labels:1)
    active_description=$(task active rc.color:off rc.verbose: rc.report.active.columns:description rc.report.active.labels:1)
    #active_tags=$(task active rc.verbose: rc.report.active.columns:tags rc.report.active.labels:1)
fi

str="~$n_active!$n_overdue+$n_next/$n_pending"

if [ "$active_project" ]; then
    str="$str $active_project"
fi
str="$str  $active_description"

#if [ $n_overdue -eq 0 ]; then
    #str="$str"
#else
    #overdue_tasks_text=" "
    #for i in {0..$n_overdue}; do
        #task_project=$(task +OVERDUE export | jq -r '.[0] .project')
        #task_descriptipon=$(task +OVERDUE export | jq -r '.[0] .description')
        #overdue_tasks_text=" $overdue_tasks_text $task_project:$task_descriptipon"
    #done
    #str="$str $overdue_tasks_text  "
#fi

echo "$str"

