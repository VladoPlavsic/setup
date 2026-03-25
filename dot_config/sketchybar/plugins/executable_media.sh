#!/bin/bash
DATA=$(media-control get 2>/dev/null)
TITLE=$(echo "$DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('title',''))" 2>/dev/null)
ARTIST=$(echo "$DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('artist',''))" 2>/dev/null)
PLAYING=$(echo "$DATA" | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('playing',False))" 2>/dev/null)

if [ -z "$TITLE" ]; then
  sketchybar --set media.prev    drawing=off \
             --set media.play    drawing=off \
             --set media.next    drawing=off \
             --set spotify       drawing=off \
             --set media_bracket background.drawing=off
else
  [ "$PLAYING" = "True" ] && ICON=$(python3 -c "print('\uf04c', end='')") || ICON=$(python3 -c "print('\uf04b', end='')")
  sketchybar --set media.prev    drawing=on \
             --set media.play    drawing=on icon="$ICON" \
             --set media.next    drawing=on \
             --set spotify       drawing=on label="$ARTIST — $TITLE" \
             --set media_bracket background.drawing=on
fi
