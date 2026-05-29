#!/bin/bash
bat=$(find /sys/class/power_supply -name 'BAT*' 2>/dev/null | head -1)
[ -z "$bat" ] && exit 1

capacity=$(cat "$bat/capacity" 2>/dev/null) || exit 1
status=$(cat "$bat/status" 2>/dev/null) || exit 1

idx=$(( capacity / 20 ))
idx=$(( idx > 4 ? 4 : idx ))
icons=("" "" "" "" "")

if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    echo "{\"text\": \" $capacity%\", \"tooltip\": \"$status - $capacity%\"}"
else
    echo "{\"text\": \"${icons[$idx]} $capacity%\", \"tooltip\": \"$status - $capacity%\"}"
fi
