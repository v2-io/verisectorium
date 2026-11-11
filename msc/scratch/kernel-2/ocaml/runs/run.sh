#!/bin/sh
# Usage: run.sh NAME args...   Full output goes to runs/NAME.txt.
cd "$(dirname "$0")/.." || exit 2
name=$1; shift
./_build/default/bin/explore_main.exe "$@" > "runs/$name.txt" 2>&1
echo "exit $?" >> "runs/$name.txt"
