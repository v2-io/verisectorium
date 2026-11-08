#!/bin/sh
# Usage: run-parallel.sh TAG HARNESS...
# Runs the harnesses concurrently (CBMC is single-threaded); full output of
# each goes to kani-logs/<harness>.<TAG>.log; waits for all.
cd "$(dirname "$0")/.."
tag="$1"; shift
for h in "$@"; do
  ( { /usr/bin/time -p cargo kani --harness "$h"; echo "exit $?"; } > "kani-logs/$h.$tag.log" 2>&1 ) &
done
wait
