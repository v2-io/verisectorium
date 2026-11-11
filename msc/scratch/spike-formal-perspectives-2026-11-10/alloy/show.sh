#!/bin/sh
# usage: ./show.sh runs/out-<stem>/<solution>.txt  -- print the non-empty relations of a solution, shortened
grep -v "^univ\|^Int\|^seq/Int\|^String\|ordering/Ord\|=={}\|={}$" "$1" | grep "=" | sed 's/[a-z0-9]*\///g; s/\$0//g; s/\$\([0-9]\)/\1/g' | cut -c1-600
