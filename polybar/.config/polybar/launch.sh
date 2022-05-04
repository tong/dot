#!/usr/bin/env bash

killall -q polybar

echo "---" | tee -a /tmp/polybar1.log
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar main >> /tmp/polybar1.log 2>&1 & disown
#polybar mon2 >>/tmp/polybar2.log 2>&1 & disown
# polybar stat >>/tmp/polybar3.log 2>&1 & disown
# polybar meta >>/tmp/polybar2.log 2>&1 & disown
#polybar test >>/tmp/polybar2.log 2>&1 & disown
#polybar main >>/tmp/polybar2.log 2>&1 & disown
#polybar bar2 >>/tmp/polybar2.log 2>&1 & disown
