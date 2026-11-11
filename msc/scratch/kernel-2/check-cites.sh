#!/bin/sh
# Confirms every cited phrase in KERNEL-SPEC.md is still in the def it names. Run from the repo root.
cd "$(dirname "$0")/../../.." || exit 2
perl -ne 'while(/`((?:def|src)\/[a-z-]+\.md)`: ((?:"[^"]+"(?:; )?)+)/g){ my($f,$qs)=($1,$2); while($qs=~/"([^"]+)"/g){ print "$f\t$1\n" } }' msc/scratch/kernel-2/KERNEL-SPEC.md | while IFS="$(printf '\t')" read -r f q; do
  grep -qF -- "$q" "core/$f" || { echo "MISSING in $f: $q"; bad=1; }
done
echo "checked"
