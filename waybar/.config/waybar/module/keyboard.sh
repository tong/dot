#!/bin/bash

MAC="${TOTEM_MAC:-DD:47:1E:F7:48:A4}"

INFO=$(bluetoothctl info "$MAC" 2>/dev/null)

if echo "$INFO" | grep -q "Connected: yes"; then
  NAME=$(echo "$INFO" | grep "Name:" | cut -d' ' -f2-)
  BATTERY_VAL=$(echo "$INFO" | grep -i "Battery Percentage" | awk '{print $3}')

  # Handle hex (0x64) or decimal formats
  if [[ $BATTERY_VAL =~ ^0x ]]; then
    PERCENT=$((BATTERY_VAL))
  else
    PERCENT="${BATTERY_VAL:-0}"
  fi

  # Determine icon based on battery level
  if [ "$PERCENT" -ge 90 ]; then
    ICON="󰁹"
  elif [ "$PERCENT" -ge 70 ]; then
    ICON="󰂀"
  elif [ "$PERCENT" -ge 50 ]; then
    ICON="󰁿"
  elif [ "$PERCENT" -ge 30 ]; then
    ICON="󰁼"
  else ICON="󰁺"; fi

  printf '{"text":"󰌌","class":"connected","tooltip":"<b>%s</b>\\nBattery: %d%% %s"}\n' "$NAME" "$PERCENT" "$ICON"
else
  printf '{"text":"󰌐","class":"disconnected","tooltip":"Keyboard Disconnected"}\n'
fi
