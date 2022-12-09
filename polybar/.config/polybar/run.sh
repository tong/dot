#!/bin/sh
killall -q polybar
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar main >> /tmp/polybar1.log 2>&1 & disown
#polybar mon2 >> /tmp/polybar1.log 2>&1 & disown

