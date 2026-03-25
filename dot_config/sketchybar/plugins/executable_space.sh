#!/bin/bash
source "$CONFIG_DIR/colors.sh"

SPACE_ID=$(echo "$NAME" | sed 's/space\.//')

if [ "$FOCUSED" = "$SPACE_ID" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on  \
    icon.color=$HIGHLIGHT_COLOR
else
  sketchybar --set "$NAME" \
    background.drawing=off \
    icon.color=$SUBTEXT
fi
