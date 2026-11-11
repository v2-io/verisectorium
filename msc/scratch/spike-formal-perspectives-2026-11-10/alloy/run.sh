#!/bin/sh
# usage: ./run.sh <file.als> [extra alloy exec options]
# Runs every command in the file; whole output to runs/<stem>.log, solutions to runs/out-<stem>/
cd "$(dirname "$0")"
f="$1"; shift
stem=$(basename "$f" .als)
/opt/homebrew/opt/openjdk/bin/java -Xmx3g -jar tool/alloy.jar exec -f -o "runs/out-$stem" -t text "$@" "$f" > "runs/$stem.log" 2>&1
echo "exit=$?" >> "runs/$stem.log"
