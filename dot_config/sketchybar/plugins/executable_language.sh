#!/bin/bash
LANG_ID=$(defaults read com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null | awk -F'.' '{print $NF}')

case "$LANG_ID" in
  Russian) LANG="RU" ;;
  *)       LANG="$LANG_ID" ;;
esac

sketchybar --set "$NAME" icon="󰌌" label="$LANG"
