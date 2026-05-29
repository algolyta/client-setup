#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null) || exit 1
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null) || exit 1

idx=$(( capacity / 20 ))
idx=$(( idx > 4 ? 4 : idx ))
icons=("" "" "" "" "")

if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    echo "{\"text\": \" $capacity%\", \"tooltip\": \"$status - $capacity%\"}"
else
    echo "{\"text\": \"${icons[$idx]} $capacity%\", \"tooltip\": \"$status - $capacity%\"}"
fi
