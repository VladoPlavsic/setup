#!/bin/bash
SUMMARY=$(ipconfig getsummary en0 2>/dev/null)
ACTIVE=$(echo "$SUMMARY" | awk '/LinkStatusActive :/{print $NF}')

if [ "$ACTIVE" != "TRUE" ]; then
  sketchybar --set "$NAME" icon="󰤭"
else
  sketchybar --set "$NAME" icon="󰤨"
fi
