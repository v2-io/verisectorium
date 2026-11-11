# Notes on `cameleer.ml`

*2026-11-11, by the Cameleer/GOSPEL fork of the OCaml builder. The fuller account is in `../spike-ocaml-side-provers-2026-11-11/cameleer/`.*

`cameleer.ml` is ordinary OCaml with its specification in comments. `ocaml cameleer_run.ml` runs it with any OCaml and prints canon as O, T, c, d, k and T's description as the one promised, empty slot. `./cameleer-check.sh` checks it (needs the switch `cameleer-try`): 70 obligations proved by Alt-Ergo after splitting into cases, the one lemma proved by induction on the rules (two cases), and one obligation not proved (below). Output: `../spike-ocaml-side-provers-2026-11-11/cameleer/runs/20-slice-check.log`.

## What I reached for

- **A kind is a value, and "what fills a slot" is an invariant under the record.** The opposite choice from `ocaml.ml`, and made for the tool: a solver reasons about `v.kind = Claim` easily and about phantom types not at all. Building T is then four obligations, one per line of the invariant.
- **Canon as two rules, in the specification**, and a function beside it whose postconditions say what it returns. What is proved, for every store: everything the function lists is in canon; and any closed list has all of canon. `canon_checked` gives back the list only when it passes the check, and is proved exact when it does.
- **Plain first-order recursion over lists.** No closures, no library functions, integers for identity.

## What the tool refused

- A function with no reason to stop. Hence the counted passes.
- A file that prints (an internal error), hence `cameleer_run.ml`.
- Proving the lemma about the rules without being told, from the command line, to use induction.

## What it did not refuse, or refused quietly

- A step in the formal-claim slot is not an error. It is one obligation of four that comes back `Timeout`, with the line range of the whole record and no word about which rule (`runs/22-wrong-kind.log`).
- That the invariant can be satisfied at all (`derived_result'vc`) is not proved by either solver tried.
- Holding one veritoid in two places: nothing says anything.
- Pointing at an id that nothing has: allowed, and it is then in canon as an id with nothing behind it.

## Where it departs from the slice as worded

1. The fifth slot state, `Untouched`, as in `ocaml.ml`.
2. A gap is an entry of an outline, as in `ocaml.ml`.
3. Identity is an integer and the names O, T, c are a table in the run file. Strings as identity would have meant string equality inside the solver, which I did not try.
4. An outline may hold a veritoid or a result and can only point at another outline, to keep the types non-recursive.
5. `reach_store`, which turns slots into (from, to) pairs, has no specification. The proofs are about canon over pairs. That the pairs are what the slots say is read off twenty lines of code, not proved.
6. Roots are ids, so marking a veritoid as a root is not refused.
