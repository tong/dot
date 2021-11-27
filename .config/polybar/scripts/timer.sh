#!/bin/sh

TIMERFILE=/tmp/polybar_timer

# now=`date +%s`
# until=`expr 60 \* $2` 
# until=`expr $until + $now` 
# sec_rem=`expr $until - $now`
# while [ $sec_rem -gt 0 ]; do 
#     clear 
#     date 
#     let sec_rem=$sec_rem-1
#     interval=$sec_rem 
#     seconds=`expr $interval % 60` 
#     interval=`expr $interval - $seconds` 
#     minutes=`expr $interval % 3600 / 60`
#     interval=`expr $interval - $minutes` 
#     hours=`expr $interval % 86400 / 3600` 
#     # interval=`expr $interval - $hours` 
#     # days=`expr $interval % 604800 / 86400` 
#     # interval=`expr $interval - $hours` 
#     # weeks=`expr $interval / 604800` 
#     echo $hours:$minutes:$seconds 
#     sleep 1
# done

get_elapsed_seconds() {
    # if [ -f $TIMERFILE ]; then
    now=`date +%s`
    started=$(<$TIMERFILE) 
    elapsed=`expr $now - $started`
    let sec_rem=$elapsed
    interval=$elapsed 
    seconds=`expr $interval % 60` 
    interval=`expr $interval - $seconds` 
    minutes=`expr $interval % 3600 / 60`
    interval=`expr $interval - $minutes` 
    hours=`expr $interval % 86400 / 3600` 
    echo $hours:$minutes:$seconds
}

case "$1" in
    start)
        echo "Starting timer" `date +"%H:%M"`
        date +"%s" > $TIMERFILE
        ;;
    stop)
        if [ -f $TIMERFILE ]; then
            echo "Stopping timer"
            get_elapsed_seconds
            rm $TIMERFILE
        else
            echo 'Timer not running'
        fi
        ;;
    elapsed)
        if [ -f $TIMERFILE ]; then
            get_elapsed_seconds
        else
            echo 'Timer not running'
        fi
        ;;
    # --help)
    #     echo "Usage: $0 {start|stop|elapsed}"
    #     exit 2
    # *)
esac
