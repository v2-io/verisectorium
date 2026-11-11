# The slice in WhyML (Why3): notes

*2026-11-11, by the Why3 fork of the OCaml builder (Fable 5.2). The file is `why3.mlw`; `why3_extracted.ml` is the OCaml that Why3 produced from it, unedited. Proved by `../spike-ocaml-side-provers-2026-11-11/why3/prove-slice.sh`; every run's output is in that directory's `runs/`.*

**What it does.** Canon comes out as c, d, k, T, O (ids 1, 2, 3, 4, 7) and the one promised-and-empty slot as T's description. That is from running the extracted OCaml. Separately, and inside Why3, `canon_here` is proved: by the two rules, canon in this instance is exactly those five; and `uu_is_not_in_canon`.

**What I reached for.**

- **A contract on every function.** `ensures { … }` above a body is the function's sentence; the solvers show the body keeps it. `canon_of`'s contract is the whole point of the file: *if it answers, its answer is canon exactly, for any verisectorium*. It answers `None` when its own check fails, so it never says something it has not established.
- **`inductive canon`**: the two rules, as rules, with nothing about how to find it.
- **A module written about an unknown, then handed the real thing** (`Reach`, cloned into `Slice`). I did not plan this. With the slice's own `out` in view, the solvers timed out on obligations that had nothing to do with how `out` is computed. Proved once for "anything that says what reaches what", they go through at once. It is also why the same module would serve for *rests on*.
- **Phantom tags for veritoid kinds**: `veritoid claim`, `veritoid step`. They survive into the extracted OCaml (`claim veritoid`), which Rocq's extraction may not manage for an index.
- **Records for assembly kinds, option and list for how many**, as in OCaml.

**What it refused.**

- A step in the claim slot: a type error, as in OCaml.
- A recursion with no reason to stop. `grow` had to be given a number of rounds. The contract does not say the rounds are enough; the check afterwards does.
- **The ε.** `"…within any ε of it"` is rejected: "illegal character in string". Content has to be ASCII or escaped (`\xCE\xB5`). Of everything here this is the one refusal that is about content.<!--md-press:not-math:ε-->
- Three of my variable names: `at`, `reads` and `label` are words of the language. The first two are its words for *the value at an earlier point* and *what a function reads*.

**What it did not refuse.** Holding one piece in two places; a root that names a veritoid or nothing (roots are ids). Both would be a predicate with a goal to prove for each instance, not a type.

**What was awkward.**

- Everything is first-order. No closures to speak of: where OCaml has one `List.concat_map`, this has a named recursive function per traversal (`firm_steps`, `reaches_entries`, `held_results`, `promised_steps`). The file is about twice the OCaml one for that reason.
- **The particular was harder than the general.** The contract for every verisectorium was proved almost at once. "Canon *here* is these five" needed eleven small lemmas as stepping stones, one of which went through only by asking Why3 to compute, and a second solver for two of the others. Solvers do not evaluate functions; they reason about them.
- No one solver proved everything. Of 62 obligations Alt-Ergo alone proved 56 in ten seconds each. The rest needed Z3 (4), induction asked for by name (`induction_pr`, 1), or computation (`compute_in_goal`, 1). Two goals that timed out when run alone were proved when the whole file was run, so a result is not the same from one invocation to the next. Which goal needs which is a recipe in a shell script, because the usual home for it is a session kept by Why3's graphical tool, which I did not use.
- Ids are numbers. Strings can be stored and not compared in a program, so the README's letters became `c_ = 1` and so on.
- `why3 execute`, the built-in interpreter, stopped with a type error on this file and on the M0 file, both of which typecheck and extract. I ran them as extracted OCaml.

**Where it departs from the slice as worded.** The same three as the OCaml and Rocq files (a fifth slot state, `Untouched`; a gap as an entry of an outline; roots beside the store), and one of Rocq's: an outline may hold a veritoid or a result, and can only *point at* another outline, which keeps every type non-nested. Pointing is by id into a store, so a pointer to nothing can be written, and is simply in canon as a name with nothing behind it; nothing here notices.
