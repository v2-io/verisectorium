#!/bin/sh
# Re-run everything PERSPECTIVE.md says was run. Lean 4.35.0 via elan (~/.elan/bin).
# Full output goes to runs/; nothing is filtered here.
set -u
cd "$(dirname "$0")"
PATH="$HOME/.elan/bin:$PATH"
rm -rf .lake/build
lake build > runs/10-full-build.log 2>&1
echo "build exit=$? (0 expected)   -> runs/10-full-build.log"
for m in M1_wrong_frontier M2_early_checkpoint M3_good_news_without_holds; do
  lake env lean mutations/$m.lean > runs/11-mutation-$m.log 2>&1
  echo "$m exit=$? (1 expected: the mutation must be rejected)"
done
