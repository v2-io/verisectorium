#!/bin/sh
# Checks cameleer.ml: every obligation after splitting into cases, then the
# one lemma that needs induction on the two rules of canon.
# Needs the opam switch cameleer-try (see ../spike-ocaml-side-provers-2026-11-11/cameleer/).
cd "$(dirname "$0")" || exit 2
: "${WHY3CONFIG:=../spike-ocaml-side-provers-2026-11-11/cameleer/why3.conf}"
export WHY3CONFIG
W="opam exec --switch=cameleer-try -- why3 prove -P alt-ergo -t ${T:-10}"
$W -a split_all_full cameleer.ml
$W cameleer.ml -T Cameleer -G closed_has_canon -a induction_pr
