#!/bin/sh
# Rebuilds everything here from nothing and keeps the whole output.
# One process. Needs the opam switch `rocq-try` (Rocq 9.3).
cd "$(dirname "$0")" || exit 2
R="opam exec --switch=rocq-try --"
log=runs/full-build.log
: > "$log"
find Vk mutations \( -name '*.vo' -o -name '*.vok' -o -name '*.vos' -o -name '*.glob' -o -name '.*.aux' \) -delete
for f in Reach M0 Story Checkpoint GoodNews Extract; do
  echo "=== Vk/$f.v" >> "$log"
  $R rocq compile -Q Vk Vk "Vk/$f.v" >> "$log" 2>&1 || { echo "FAILED: $f" | tee -a "$log"; exit 1; }
done
echo "=== mutations (m1, m2, m3 must fail; m4 is a probe and must pass)" >> "$log"
for f in mutations/*.v; do
  echo "--- $f" >> "$log"
  $R rocq compile -Q Vk Vk "$f" >> "$log" 2>&1; echo "exit $?" >> "$log"
done
echo "=== the story, run by the extracted OCaml" >> "$log"
( cd extract && $R ocamlfind ocamlopt -O3 m0_extracted.mli m0_extracted.ml story_driver.ml -o story_driver >> ../"$log" 2>&1 \
  && ./story_driver >> ../"$log" 2>&1; rm -f *.cm* *.o story_driver )
echo "=== the slice (../../idiomatic-slice-2026-11-11/rocq.v)" >> "$log"
( cd ../../idiomatic-slice-2026-11-11 && $R rocq compile rocq.v >> ../spike-ocaml-side-provers-2026-11-11/rocq/"$log" 2>&1; echo "exit $?" >> ../spike-ocaml-side-provers-2026-11-11/rocq/"$log"; rm -f rocq.vo rocq.vok rocq.vos rocq.glob .rocq.aux )
find Vk mutations \( -name '*.vok' -o -name '*.vos' -o -name '*.glob' -o -name '.*.aux' \) -delete
rm -f mutations/*.vo
echo "done; see $log"
