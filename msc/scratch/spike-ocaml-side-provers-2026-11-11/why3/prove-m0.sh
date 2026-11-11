#!/bin/sh
# Every obligation of m0.mlw under Alt-Ergo, then under Z3, one process at a time.
# No single solver proves all of them; each is proved by at least one. Outputs in runs/.
cd "$(dirname "$0")" || exit 2
W="opam exec --switch=rocq-try -- why3"
for P in alt-ergo z3; do $W prove -P $P -a split_vc -t 10 m0.mlw > runs/23-m0-$P.txt 2>&1; done
