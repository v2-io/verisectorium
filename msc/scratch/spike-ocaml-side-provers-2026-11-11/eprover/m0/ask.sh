#!/bin/sh
# ask.sh ROW NAME 'formula' [seconds]   -> prints the SZS status; output kept in ../runs/
row=$1; name=$2; formula=$3; secs=${4:-5}
f="q-row$row-$name.p"
{ echo "include('m0.ax')."; echo "include('story.ax')."; echo "include('row-$row.ax')."; echo "tff($name, conjecture, $formula)."; } > "$f"
opam exec --switch=rocq-try -- eprover --auto --cpu-limit=$secs -s "$f" > "../runs/m0-row$row-$name.txt" 2>&1
grep 'SZS status' "../runs/m0-row$row-$name.txt" | sed 's/# SZS status //'
