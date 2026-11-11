#!/bin/sh
# Proves every obligation of ../../idiomatic-slice-2026-11-11/why3.mlw, one solver process at a time.
# Pass 1 sends everything to Alt-Ergo. Pass 2 is the goals Alt-Ergo does not get that way,
# each with the solver or the named step that does get it. Output: runs/10-slice-final.txt
cd "$(dirname "$0")" || exit 2
F=../../idiomatic-slice-2026-11-11/why3.mlw
W="opam exec --switch=rocq-try -- why3"
O=runs/10-slice-final.txt
{
echo "### pass 1: everything, Alt-Ergo, 10 s each"
$W prove -P alt-ergo -a split_vc -t 10 $F
echo "### pass 2: by name"
one () { echo "## $1 / $2 / $3 / $4"; $W prove $F -T $1 -G $2 -a $3 -P $4 -t 20; echo "exit $?"; }
one Reach    "reached_from'vc"         split_vc        z3
one Reach    closed_has_canon          induction_pr    alt-ergo
one Instance what_reaches_what         compute_in_goal alt-ergo
one Instance from_o                    compute_in_goal alt-ergo
one Instance from_t                    compute_in_goal alt-ergo
one Instance those_five_pass_the_check compute_in_goal alt-ergo
one Instance t_in                      split_vc        z3
one Instance c_d_k_in                  split_vc        z3
one Instance canon_here                split_vc        z3
one Instance uu_is_not_in_canon        split_vc        z3
} > $O 2>&1
