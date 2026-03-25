#!/bin/bash
USED=$(vm_stat | python3 -c "
import sys, re
vm = sys.stdin.read()
page  = int(re.search(r'page size of (\d+)', vm).group(1))
active = int(re.search(r'Pages active:\s+(\d+)\.', vm).group(1))
wired  = int(re.search(r'Pages wired down:\s+(\d+)\.', vm).group(1))
comp   = int(re.search(r'Pages occupied by compressor:\s+(\d+)\.', vm).group(1))
print(f'{(active + wired + comp) * page / 1073741824:.1f}GB')
")
sketchybar --set "$NAME" icon="󰍛" label="$USED"
