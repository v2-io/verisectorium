#!/bin/sh
# usage: ./run.sh <cfg-name-without-.cfg> <module> [extra TLC args]
# full output goes to runs/<cfg>.out
cd "$(dirname "$0")"
cfg=$1; mod=$2; shift 2
/opt/homebrew/opt/openjdk/bin/java -XX:+UseParallelGC -Xmx4g -cp tla2tools.jar tlc2.TLC \
  -workers 2 -noGenerateSpecTE -metadir states/$cfg -config $cfg.cfg "$@" $mod > runs/$cfg.out 2>&1
echo "exit=$?" >> runs/$cfg.out
