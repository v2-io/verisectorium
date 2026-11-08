# Account: the v2 kernel in Ada 2022 + SPARK (Fable)

*Spike landed 2026-11-07 on branch `spike/kernel-ada-fable`, from base `58dd5c1`. Toolchain: GNAT FSF 16.1.0, gnatprove 16.1.0 (Why3 1.8.2, Alt-Ergo 2.6.1, cvc5 1.3.2, Z3 4.15.4), Alire 2.1.1, AUnit 26.0.0. Everything below was true of the tree at the final commit of this branch; `git log` carries the measured times.*

## 1. What was built

`src/` is the kernel, all of it SPARK except the file format:

| unit | lines | what |
|---|---|---|
| `Kernel` | 265 | the objects of spec §2: rungs, ids, versions, references, acts, changesets, log records. Every list is a bounded array with a count. |
| `Kernel.States` | 841 | a state; `binds`, `position`, `ceiling`, `frontier`, `steady`; `Apply` (a segment changeset) and `Record_Act`, with P3–P7 as their contracts. |
| `Kernel.Logs` | 269 | the append-only log; `Fold` / `State_At` (state as of an index); P1 as a lemma; P2 as `Append`'s postcondition. |
| `Kernel.Store` | 305 | one-line-per-record text serialization and a loader that goes through `Append`. Not SPARK (it reads files). |
| `Kernel.Equality_Probe` | 85 | evidence, kept on purpose: what `=` on a `State` does and does not give the prover (§4.3 below). |

`tests/` is a separate Alire crate: an AUnit suite (6 tests, 4 s) and `kernel_cli LOGFILE [INDEX]`, which loads a log, folds it, and prints state and frontier. `examples/worked-example.log` is spec §6, written by the test that replays it.

```sh
cd ada && alr build && alr test && alr gnatprove      # all three pass
cd tests && ./bin/kernel_cli ../examples/worked-example.log 6   # the state after the perturbation
```

### Design decisions, each a fact about the kernel

- **Bounded everything.** 24 veritoids, 8 segments, 6 references per veritoid, 6 reads per act, 12 veritoids per changeset, 48 acts, 96 records. These are constants; raising them changes nothing in the proofs. The reason is that SPARK proves most readily over arrays indexed by small discrete types; unbounded data would mean the SPARK formal containers or ownership-checked pointers, both heavier to specify. The cost to the model is stated in §3.
- **Ranks are the acyclicity witness.** A state carries a rank for every present veritoid such that every reference to a present target points strictly downward (`Well_Ranked`). A changeset is accepted only if the resulting table can be ranked; the ranking is a layered Kahn pass, canonical (a veritoid's rank is the length of the longest reference chain below it), so it does not spoil "the state is a function of the log". `ceiling` is then computed level by level, which is the well-founded recursion of spec §3.3 made iterative.
- **An id belongs to its segment for life.** A changeset for segment T may name only ids never seen before or ids T already owns (`Owns_Or_Fresh`); a veritoid T drops becomes a tombstone that keeps its owner. And an act may read only ids that have been introduced (`Reads_Known`). The spec does not say either; both are what make P3 true as the spec states it (§2.1).
- **A refused changeset is reported, not recorded.** `Apply`/`Append` return a `Refusal` and, for a cycle, a witness set; the log does not move. The reasoning: the log records what happened to the store, and a refused write did not happen to it. Recording refusals is a work-time concern (who tried what), real but not this kernel's. The witness is the set of veritoids that could not be ranked: every member has a present reference target in the set (`Closed`), so a finite set like that contains a cycle; it holds the cycle's members and everything resting on them.
- **A reference to nothing supports nothing.** When a reference's target no longer exists, that reference contributes `sketch` to the ceiling. The spec's recursion is undefined there (§2.2).
- **Equality is structural and normalized.** Every slot beyond a list's count holds a `Null_*` value, by construction in every constructor, so predefined `=` on states and logs means what the spec means by "equal states". This is maintained, not proved (§4.4).

## 2. Where the spec is not well-formed, and what I built against

### 2.1 P3 is false under the spec's own definitions unless two rules are added

P3 says a changeset makes an act stop binding iff it changed or removed something the act read, and that acts reading nothing in the segment are unaffected. Under definition §3.1 alone, both halves fail:

- An act can *start* binding: if act A read `x@1` while `x` did not exist (or had been removed), a later changeset introducing `x@1` makes A bind. So "unaffected" fails for an act reading nothing in the segment.
- Ids could migrate between segments or be re-introduced, so "the segment the read was in" is not even well defined.

With "an id belongs for life to the segment that introduced it" and "an act reads only introduced ids", P3 holds exactly as written and is proved (`Lapse_Exact`, a postcondition of `Apply`). I believe the first rule is what the model intends anyway (`recut` is explicitly a separate move), and the second is the model's own "an act binds to exactly what it read": it has to have read something. One thing the rules do *not* exclude, deliberately: an act that lapsed can re-bind if its segment later writes the same version back (content hash restored). P3 as written is silent about that and so is the proof; I think it is right under content addressing and wrong under counters, and the spec should say which it means by "version".

### 2.2 The worked example's expected frontier is short of its own definitions

After the perturbation (c@2, d@2, e@1), spec §6 lists seven owed items. Definition §3.3 gives `ceiling(e) = min(position(e), ceiling(c)) = min(drafted, sketch) = sketch`, so `e`'s claimed `drafted` is an overclaim; and `ceiling(c) = sketch` is below `d`'s and `e`'s needed `drafted`. Three items are missing from the list: `overclaim(e)`, `unmet-need(d, c)`, `unmet-need(e, c)`. The test asserts all ten and the CLI prints them. I built against the definitions; the list should be corrected. (Nothing in the rest of §6 changes.)

### 2.3 Other gaps the spec leaves, and the choice made

- `ceiling` when a target no longer exists: undefined in §3.3; I chose `sketch` (above).
- `unmet-need(v, r)` when the target no longer exists: with the choice above it is owed iff `needed > sketch`. Consistent with "stale-reference" also being owed for that reference.
- Affirmations are recorded and consumed by nothing. The frontier of §3.4 has no item "carried veritoid not affirmed", so the kernel cannot tell a draft from a changeset, which the model's `segment⸱changeset` def says is the distinction that matters. The affirmation act is in the log (the worked example records one) but the kernel never reads it. A frontier item for it would need the changeset to say which veritoids it carried unchanged, which the spec's changeset does not carry explicitly (it is computable: same id, same version).
- Reconciling a reference without changing content. The worked example needs `e@1`'s reference to `c` re-seen at `c@2` while `e` stays at version 1 (the spec says "e@1 affirmed", and expects `stale-reference(e, c)` to clear). So a reference's "version seen" is written state that is *not* part of the content version. The kernel allows exactly that (an entry's `Refs` can change with its `Vers` unchanged), and acts bound to `e@1` keep binding. The spec should say so, because it decides what "content version" covers.
- A changeset may set any version, including an old one. The kernel does not order versions; the spec calls them opaque. See the re-binding note in §2.1.
- "State" is defined as current veritoids plus acts. Mine also carries the ranks; they are computed, canonical, and never typed, so I read this as within the spec's "computed, never typed" rule rather than a change to the state.

## 3. The language

### What Ada/SPARK made easy

- **The contracts are the spec.** `Is_Position`, `Is_Ceiling`, `Lapse_Exact`, `Well_Ranked`, `Closed` are first-order sentences a reader of the spec can check against §3 line by line, and they are the postconditions the prover discharged. P3 and P4 proved at level 2 on the first run with no hints; P6 (as the exact characterization of `ceiling`, not merely the bound) needed two assertions saying which ranks a write cannot disturb.
- **Enumerations as ladders.** `type Rung is (Sketch, Drafted, Checked, Rederived)`; `<` and `'Min` are the ladder. Nothing to prove.
- **Bounded arrays with a count** as the one data shape. Quantified contracts over them are what the provers are good at; 130 run-time checks (index, range, overflow) proved without a single annotation.
- **Flow analysis for free.** 73 flow checks (initialization, non-aliasing, termination of 61 loops) with no annotation; `Subprogram_Variant` proved termination of the three recursive ghost functions.
- **Contracts run in the tests.** The library is built with `-gnata`, so every randomized test is also a run of every postcondition in `Kernel.States`. The tests' oracles are written independently (a memoized recursive ceiling, a direct closure check) so that they are not the contracts restated.

### What I fought

- **Record equality is not logical equality for the provers (the big one).** `A = B` on a `State` (records of arrays of records of arrays) gives the prover component equality but *not* `F (A) = F (B)` for an opaque `F`, not even for a function returning one field, at level 2 or level 4. `Kernel.Equality_Probe` has the measurements. Everything in `Kernel.Logs` that says "this state equals that fold" was unprovable until stated with `Same`, a ghost function carrying `Annotate => (GNATprove, Logical_Equal)`, which the prover reads as logical equality and which runs as `=`. That annotation is what the SPARK library itself uses for the same problem. It cost about a third of the proof time to diagnose, and the diagnosis needed the probe: the symptoms were time-outs on lemmas that looked trivially true.
- **Inlined expression functions can hurt.** `Valid` as an expression function (its quantified definition visible everywhere) made the same congruence fail even where it should not have; it is now a regular function with its definition as postcondition.
- **Recursive expression functions as axioms.** `Fold` as a recursive expression function timed out everything that used it; as a regular ghost function whose postcondition is its defining equation, with explicit calls in code where its unfolding is needed, it proves at once.
- **Frame reasoning through a list.** "Pushing an item for V disturbs no row below V" is obvious and was the slowest thing to get through: it wanted a ghost lemma (`Lemma_Push`) stated over the item's three components, since SPARK cannot quantify over a record type, and `Rows_Done`/`Row_Done` as named ghost predicates in the loop invariants.
- **Two tool restrictions met head-on.** A non-scalar ghost object may not be declared before a loop invariant in the same body (so a snapshot of the ceilings array became a procedure with `'Old`); a loop invariant placed at the end of a body forbids any such declaration above it.
- **Ghost code runs.** With `-gnata`, ghost lemmas and ghost `Fold` execute; the lemma loop in `Append` is a fold per record per append, which made the first test run take minutes. `Kernel.Logs` now has `Assertion_Policy (Ignore)`: its contracts are proved, not executed. `Kernel.States` keeps both.
- **Stale proof sessions.** Deleting a unit left its old results in `obj/*/gnatprove`, and `--checks-as-errors` kept failing on checks that no longer existed. Known once seen; cost one cycle.
- Small things: `(others => <>)` is "obsolescent" under Ada 2022 warnings for arrays (`[others => <>]`); the test runner prints only pass/fail unless run directly; an iterated array aggregate needed an explicit assertion restating its components before the prover used it.

### What I would want in the model that this spec lacks

- A word for what a reference's "version seen" belongs to (§2.3): it is written, it is not content, and it changes what binds.
- The affirmation's consumer: either a frontier item or a rule that a changeset must affirm what it carries, so the draft/changeset distinction is checkable.
- Whether versions are content hashes or counters, since "lapse is exact" and "re-bind on restore" differ by that.
- A word for the refusal witness (the unrankable set), and a decision on whether refusals are work-time records.

### Time

Measured: base commit 17:24, first kernel commit about 18:25, so roughly an hour to the kernel with everything proved and tested, then the account and debrief. Felt: the kernel design and code took about a quarter of it and went straight through; the proof took the rest, of which about a third was the equality diagnosis (§4.3), a third the frontier-list frame reasoning, and the rest the ceiling levels, the ranking invariants, and tool restrictions. The kernel itself (the state and its five functions) was never the hard part; the hard part was convincing the prover of two framing facts (a write at this level touches nothing below it; a push for this row touches no other row) and one equality.

## 4. Proof

The final `alr gnatprove` (level 2, `--checks-as-errors`, unproved as errors) passes: `Success: all checks proved (423 checks)`. The summary table is at the end of this file. Four checks are *justified* (`pragma Annotate (GNATprove, Intentional, …)`), all in `Kernel.Equality_Probe`, and they are the four deliberate failures that document the equality finding; delete the pragmas to watch them fail. Nothing in the kernel proper is justified or assumed; there is no `pragma Assume` anywhere.

### 4.1 P1–P8

| | status | by what | notes |
|---|---|---|---|
| **P1 Determinism** | **proved** (lemma), plus by construction | gnatprove level 2 | Every function is SPARK with `Global => null`: flow analysis establishes that `State_At`, `Position`, `Ceilings`, `Frontier` read nothing but their arguments, which is "function of the state" in the language's own sense. The content is `Lemma_Fold_Prefix`: two logs with the same first K records have the same `Fold` at K (`Same_Prefix ⇒ Same (Fold (A, K), Fold (B, K))`), proved by induction with a `Subprogram_Variant`; and `State_At` (the loop) is proved equal to `Fold` (the definition). Also tested: fold twice, and fold a copy of a random prefix. |
| **P2 Append-only** | **proved** | level 2 | `Append`'s postcondition: length grows by one, the new record is last, `Prefix_Preserved` (every old record is where it was), and on refusal `L = L'Old`. `Log` is private and `Append` is its only mutator, so this is the whole statement. Also `Well_Formed (L'Old) ⇒ Well_Formed (L)` (every record was admitted by the state before it), proved via the prefix lemma. |
| **P3 Lapse is exact** | **proved** | level 2, no hints | `Lapse_Exact (Before, After, C, A)` for every recorded act, as a postcondition of `Apply`: `(binds before ∧ ¬binds after) = (binds before ∧ Touches)` where `Touches` is "some read's id is owned by C's segment and C drops it or gives it another version"; and "reads nothing in the segment ⇒ binds unchanged". Holds under the two rules of §2.1. Also tested directly (the test re-derives `Touches` by hand). |
| **P4 Monotone under acts** | **proved** | level 2, no hints | Postcondition of `Record_Act`: for every V, `Position` does not drop, and is unchanged if the act is an affirmation or did not read V. Also tested directly. |
| **P5 Acyclicity** | **proved** (soundness); **tested** (completeness) | level 2 | Proved: `Apply` accepts only tables with `Well_Ranked` ranks, and a well-ranked table has no reference cycle (every edge to a present target strictly lowers the rank). Proved: when `Rank_All` refuses with `Cycle`, the witness set is non-empty and `Closed` (every member has a present target in the set), which is a cycle certificate. **Not proved**: that the third outcome, `Exhausted` (all `Max_Veritoids` passes made progress yet something is unranked) never happens. It cannot: each pass with progress ranks at least one new veritoid, so N passes rank everything; but that is a counting argument (cardinality of a set of ids), which SPARK can do with a ghost count and a lemma about it, and I did not reach it. The outcome is a distinct refusal code, so nothing is hidden; the tests see only `Cycle` on the cycles they plant. |
| **P6 Ceiling bound** | **proved**, as the exact characterization | level 2, two assertions | `Ceilings`' postcondition is `Is_Ceiling` for every present V: `C (V) ≤ Position (V)`, `C (V) ≤` every reference's `Rest`, and `C (V)` equals one of them, i.e. `ceiling = min(position, min over refs)` exactly, not only the inequality P6 asks for. The hints: before writing `C (V)`, no veritoid at or below V's level has V as a present target. Also tested against a memoized recursive oracle. |
| **P7 Steady means honest** | **proved** | trivial (level 2, null body) | `Lemma_Steady_Is_Honest`: `Steady (S) ⇒ ∀V present: Claimed (V) ≤ Ceiling (V)`. It is a one-step consequence of `Steady`'s definition, and it should be said that P7 as stated has no content beyond the definition of the frontier; the substantive fact is that `Frontier (S)` (the list) is exactly the set the predicates define — `Contains (F, item) = predicate` for all three kinds, and `F.Count = 0 ⟺ Steady (S)` — which is proved. |
| **P8 Replay** | **tested** | AUnit: worked example and 5 random logs | `Save` then `Load` gives an equal `Log` (record by record and as a whole) and equal `State_At` at every index. Not proved: `Kernel.Store` is not SPARK (file I/O, `Unbounded_String`, exceptions). A proof would need a SPARK parser over a bounded buffer and `Parse (Line_Of (R)) = R` for every record; stateable, not reached, and it is porcelain. |

### 4.2 What I believe could be proved here but was not reached, and the cost

- **Completeness of refusal** (`Exhausted` unreachable): a ghost `Count_Unranked` over the id range, a lemma that ranking one more veritoid decreases it by one, and a loop variant. Half an hour to an hour; the cardinality lemma is the known SPARK chore.
- **Normalization as an invariant** (`Normal` on every list; unused slots blank), which is what makes `Same`'s run-time body (`=`) coincide with logical equality. Stateable as type predicates on the list records; every constructor's postcondition would then carry it. An hour; mostly mechanical.
- **The refusal witness as a cycle**, not a closed set: returning an actual cycle (a sequence) needs a path type and a walk; a few hours.
- **`Store` round trip**: as above, a SPARK parser; a day.
- **`Position`, `Ceilings`, `Frontier` as total functions of the "observable" state**: they are, by flow analysis; a lemma that two states equal in `Veritoids` and `Acts` give equal `Position` holds today via `Is_Position` uniqueness and would follow for ceilings with `Same`-style equality on tables.

### 4.3 What cannot be stated as a contract, and whose fault it is

- **Acyclicity itself** ("there is no reference cycle") is a reachability property; SPARK's contract language is first-order over the data, with no transitive closure. It is stated through its standard witness, a ranking, which is stronger (it fixes the ranks) and equivalent in truth. The language, not the spec.
- **Logical equality of states** cannot be *written* in Ada except as `=`, which the provers read structurally. `Logical_Equal` closes the gap by fiat: the function is read as logical equality, and the user is responsible for its run-time body agreeing. That is the toolchain, and it is documented tool behavior, but it is the kind of thing that costs a newcomer an afternoon.
- **"The refusal is recorded"** was a choice the spec left open; either choice is stateable.
- **"The state is a function of the log prefix"** is stateable (`Lemma_Fold_Prefix`) and was discharged. **"Position is a function of the state"** is stateable only through the language's purity (flow analysis), and that is a fine place for it.
- **P7** is stateable and discharged, but as noted it is the definition; the spec might want to ask for the stronger `Frontier`-list exactness instead, which is what I proved.
- **Quantifying over a record type** (`for all X : Frontier_Item`) is not allowed; quantify over its components instead. Language.
- The spec's **"split or merge veritoids within the segment"** is not a kernel-visible operation (ids are just dropped and introduced); nothing to state until the model says what identity survives a recut. Spec (and the model says so itself).

### 4.4 What the verification story buys the model, judged from this side

What gnatprove discharged automatically: all run-time checks; termination of every loop and the recursive ghosts; P3 and P4 outright; `Candidate_Table`'s pointwise spec; `Append`'s structural postconditions. What needed ghost code or lemmas: P1 (`Fold`, `Same`, `Lemma_Fold_Prefix`, the ghost lemma loop in `Append`); P5's ranking invariants (seven loop invariants, one ghost snapshot); P6's level loop (`Done_Through`, `Set_Ceiling` with two assertions); the frontier list (`Lemma_Push`, `Rows_Done`, `Row_Done`, `All_Done`, and an explicit case split for the `Steady` equivalence). What remained a check rather than a proof: the four `Equality_Probe` failures (deliberate), and nothing else in the kernel. What is tested and not proved: P8, completeness of P5's refusal, and the normalization that `Same` rests on.

What this buys that the other language's story would not, as far as I can judge from one side: the properties the model cares about are postconditions on two procedures (`Apply`, `Record_Act`) and one function (`Ceilings`), and here they are *the* specification, read by the compiler, executed in tests, and discharged by a prover, in one notation. A Rust kernel would carry the same facts as tests (proptest) or, with Kani/Creusot/Prusti/Verus, as annotations in a second notation with its own fluency curve. The particular things I would not expect Rust to give cheaply: the exact `Is_Ceiling` characterization proved over the level loop, `Lapse_Exact` for every act as a universal statement rather than a sampled one, and the frontier-list exactness. What Rust would give that this did not: unbounded data without a second thought, and no equality-encoding trap.

On fluency under turnover, which was the question: a mind like mine wrote the kernel and its contracts in one pass and they were right; the proof then took three times as long as the code and most of that time was spent learning two facts about the prover's encoding (record equality, inlined expression functions) that nothing in the spec or the code hints at. Both are now written down here and in the source. The next mind inherits them; the first one paid for them.

### 4.5 The one property

The one whose proof most changed my confidence in the kernel: **P3, `Lapse_Exact`**, and I got it, at level 2, with no hints, on the first run. It is the sentence the model stands on ("an act binds to exactly what it read; it lapses when that changes"), it is where I had expected to find the spec quietly wrong, and the attempt to prove it is what surfaced the two rules of §2.1 that make it true. Close behind it is the exact `ceiling` characterization: `ceiling` is the only recursive computation in the kernel, and "below everything and equal to something" is the form in which a mistake in the level loop would have had nowhere to hide.

### Summary table

From the final `alr gnatprove` run on this branch (`obj/release/gnatprove/gnatprove.out`):

```
SPARK Analysis results        Total   Flow                         Provers   Justified   Unproved
Initialization                    8      8                               .           .          .
Non-Aliasing                      4      4                               .           .          .
Run-time Checks                 130      .   130 (CVC5 98%, Z3 2%, altergo 1%)       .          .
Assertions                       90      .    90 (CVC5 73%, Trivial 15%, Z3 5%, altergo 7%)     .
Functional Contracts            127      .   123 (CVC5 80%, Trivial 7%, Z3 7%, altergo 5%)   4  .
Termination                      64     61     3 (CVC5)                              .          .
Total                           423     73 (17%)              346 (82%)         4 (1%)          .
```

The four justified checks are the four deliberate failures in `Kernel.Equality_Probe`.
