#!/bin/bash

# Fetch failed system units
FAILED_SYSTEM=$(systemctl --failed --no-legend --plain --state=failed | awk '{print $1}')
COUNT_SYSTEM=$(echo "$FAILED_SYSTEM" | grep -c .)
[ -z "$FAILED_SYSTEM" ] && COUNT_SYSTEM=0

# Fetch failed user units
FAILED_USER=$(systemctl --user --failed --no-legend --plain --state=failed | awk '{print $1}')
COUNT_USER=$(echo "$FAILED_USER" | grep -c .)
[ -z "$FAILED_USER" ] && COUNT_USER=0

TOTAL=$((COUNT_SYSTEM + COUNT_USER))

if [ "$TOTAL" -eq 0 ]; then
    printf '{"text":"✓","class":"ok","tooltip":"All systemd units are OK"}\n'
else
    TOOLTIP="<b>Failed Systemd Units ($TOTAL)</b>\\n"
    
    if [ "$COUNT_SYSTEM" -gt 0 ]; then
        TOOLTIP="$TOOLTIP\\n<b>System:</b>\\n$(echo "$FAILED_SYSTEM" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/^/  • /')"
    fi
    
    if [ "$COUNT_USER" -gt 0 ]; then
        [ "$COUNT_SYSTEM" -gt 0 ] && TOOLTIP="$TOOLTIP\\n"
        TOOLTIP="$TOOLTIP\\n<b>User:</b>\\n$(echo "$FAILED_USER" | sed ':a;N;$!ba;s/\n/\\n/g' | sed 's/^/  • /')"
    fi
    
    printf '{"text":"✗ %d","class":"failed","tooltip":"%s"}\n' "$TOTAL" "$TOOLTIP"
fi
