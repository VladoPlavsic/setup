#!/bin/bash
WEEK_ITEMS=(clock.cal.w1 clock.cal.w2 clock.cal.w3 clock.cal.w4 clock.cal.w5 clock.cal.w6)

i=0
while IFS= read -r line; do
  CALLINES[$i]="$line"
  i=$((i + 1))
done < <(python3 -c "
import calendar
from datetime import date

calendar.setfirstweekday(0)  # Monday first
today = date.today()
lines = calendar.month(today.year, today.month).splitlines()
for l in lines:
    if l.strip():
        print(l)
")

sketchybar --set clock.cal.header label="${CALLINES[0]}"
sketchybar --set clock.cal.days   label="${CALLINES[1]}"

for j in 0 1 2 3 4 5; do
  LINE_IDX=$((j + 2))
  sketchybar --set "${WEEK_ITEMS[$j]}" label="${CALLINES[$LINE_IDX]}"
done
