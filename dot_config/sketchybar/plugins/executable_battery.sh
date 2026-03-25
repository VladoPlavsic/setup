#!/bin/bash
PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

[ -z "$PERCENTAGE" ] && exit 0

if [ -n "$CHARGING" ]; then
  ICON="󰂄"
elif [ "$PERCENTAGE" -ge 90 ]; then ICON="󰁹"
elif [ "$PERCENTAGE" -ge 75 ]; then ICON="󰂀"
elif [ "$PERCENTAGE" -ge 50 ]; then ICON="󰁾"
elif [ "$PERCENTAGE" -ge 25 ]; then ICON="󰁻"
else                                  ICON="󰁺"
fi

sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
