#!/bin/sh
# Runs the batches listed on stdin (one "NAME args..." per line), two at a time.
cd "$(dirname "$0")/.." || exit 2
xargs -P 2 -L 1 ./runs/run.sh
