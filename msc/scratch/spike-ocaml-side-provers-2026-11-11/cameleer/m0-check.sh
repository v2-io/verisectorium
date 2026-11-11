#!/bin/sh
# Checks m0.ml. Three lemmas need structural induction on a list; the
# transformation is named here because nothing in the file can name it.
cd "$(dirname "$0")" || exit 2
export WHY3CONFIG="$PWD/why3.conf"
W="opam exec --switch=cameleer-try -- why3 prove -P alt-ergo -t ${T:-10}"
echo "== every obligation, split into cases (the four list lemmas are expected to time out here)"
$W -a split_all_full m0.ml
for g in unread_reads_stand write_elsewhere_leaves_findings write_elsewhere_leaves_checks a_read_lapses_in_the_list; do
  echo "== $g, by induction on the list"
  $W m0.ml -T M0 -G $g -a induction_ty_lex
done
