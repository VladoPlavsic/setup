#!/bin/bash
VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" = "true" ]; then
  ICON=$(python3 -c "print('\uf026', end='')")
elif [ "$VOLUME" -le 33 ]; then
  ICON=$(python3 -c "print('\uf027', end='')")
else
  ICON=$(python3 -c "print('\uf028', end='')")
fi

sketchybar --set "$NAME" icon="$ICON" label="${VOLUME}%"
