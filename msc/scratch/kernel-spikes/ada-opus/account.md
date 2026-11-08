# Account: the v2 kernel in Ada 2022 + SPARK (ada-opus)

*Opus 5.5, 2026-11-07, branch `spike/kernel-ada-opus`. Everything below was re-read against the code, the test assertions and `gnatprove.out` before writing. "Proven" means discharged by gnatprove 16.1.0 at `--level=2` with `--checks-as-errors=on`, with no `pragma Assume` and no justified checks anywhere. "Tested" means by the AUnit suite in `tests/`.*

## What exists

| Unit | SPARK | What it is |
|---|---|---|
| `src/kernel-model.ads/.adb` | yes | Objects (rung ladder, veritoid, reference, act, state). `Binds`, `Position`, `Positions`, `Ceilings`/`Ceiling`, `Frontier`, `Steady`. Lemmas for P6, P7 and ceiling uniqueness. |
| `src/kernel-store.ads/.adb` | yes | Changesets, records, outcomes (refusals), `New_Table`, `Compute_Rank` (acyclicity), `Try` (one step), `Step`, the private `Log` type, `State_At` (fold), `Store` with `Append`, `Push`. Lemmas for P1 (prefix), P3, P4, P5 (both directions). |
| `src/kernel-text.ads/.adb` | no | Porcelain: names for ids, a line-per-record log format, `Save`/`Load`, printing of a state and its frontier. |
| `tests/src/kernel_cli.adb` | no | `kernel_cli LOG [K]` prints the state and frontier as of record K and audits every recorded outcome against what the kernel computes now; `kernel_cli --example OUT` writes the worked example and prints it at every mark. |
| `tests/src/example_tests.adb` | no | The worked example; the literal reading of it; refusals; reverted content; replay. |
| `tests/src/property_tests.adb` | no | Randomized P1–P8 against oracles written separately (a plain recursive ceiling, DFS cycle detection, a frontier computed straight from §3). |

Commands, from `ada/`: `alr build`, `alr gnatprove` (418 checks, about 27 s wall clock from clean on this machine), `alr test` (6 tests; the property test defaults to 60 trials, `KERNEL_TRIALS=400 alr test` for the full run, which took about ten minutes because every kernel contract is also executed at run time).

The kernel's ids are small integers, and every collection is a bounded array: 32 veritoids, 4 references each, 4 reads per act, 64 acts, 8 items per changeset, 128 records. Running out of room is a recorded refusal (`Act_Capacity`), or a reported one when the log itself is full (`Log_Full`); nothing is silently truncated. I re-proved the whole library with 1000 veritoids, 16 references, 10,000 acts, 64 items and 100,000 records, and everything still proved. So the proofs do not depend on the small numbers. They do depend on the data structures being fixed-size arrays.

## Where the spec is ill-formed, and what I built against

1. **The worked example's frontier after A's changeset doesn't follow from §3.** Here is the derivation. After `c@2`, B's check on `(c@1, d@1)` lapses. So `position(c) = sketch` and `ceiling(c) = sketch`. A's check on `e@1` still binds, so `position(e) = drafted`. But `ceiling(e) = min(drafted, ceiling(c)) = sketch < drafted`, so **`overclaim(e)`** is owed. Both d and e need c at `drafted`, and `ceiling(c) = sketch`, so **`unmet-need(d, c)`** and **`unmet-need(e, c)`** are owed. The spec lists `unmet-need(u, c)` for the same reason, but it omits these three. The listed **`stale-reference(e, c)`** also can't coexist with the expected outcome. Nothing later in the sequence touches e, so if e's reference still sees `c@1` after this changeset, S1 can never be steady. I built the reading where A's affirmation of e reconciles e's reference to `c@2`. Under that reading S1 is steady and `stale-reference(e, c)` never appears. `Test_Literal_Reading` builds the other reading and shows S1 ending with `stale-reference(e, c)` still owed. The well-formed expectation after A's changeset is: `overclaim(c), overclaim(d), stale-reference(d, c), unmet-need(d, c), overclaim(e), unmet-need(e, c), overclaim(u), stale-reference(u, c), unmet-need(u, c)`. I also had to choose that `d@2` still sees `c@1`, because the spec expects `stale-reference(d, c)`; `d@3` sees `c@2`.
2. **As specified, an affirmation does nothing computable.** It never counts toward a rung, and `stale-reference` reads only the reference's seen version, so nothing reads the affirmation. **My addition (not in the spec):** a changeset may keep a veritoid at its content version and still rewrite its references, but only if that item carries the author's affirmation. Without it the changeset is refused with `Unaffirmed_Reconcile`. That makes the affirmation the recorded act that clears a stale reference without a content change. Whether this is the model's meaning is a decision for the model.
3. **Ceiling of a removed target** is undefined in §3. Here it is `sketch`: nothing supports what isn't there. The reference also shows up on the frontier as `stale-reference`.
4. **Acyclicity is not what makes the ceiling well-defined.** On any graph, the ceiling the kernel computes is the greatest solution of the spec's equation `ceiling(v) = min(position(v), min ceiling(target))`, reached by iterating down from the positions. That solution equals the least position over everything reachable from v. What acyclicity adds is uniqueness: on an acyclic table the equation has exactly one solution, and that is proven (`Lemma_Ceiling_Unique`). Without acyclicity, "all sketch" also solves it. So in the kernel, P5 protects the meaning of the ceiling (one answer, no circular support), not its existence.
5. **P6 as stated is weak.** Ceilings that are all `sketch` satisfy it. The real contract is the defining equation, written as "below each term, and equal to one of them". `Ceilings` is proven to satisfy it, and uniqueness is proven. A mutation check confirmed that returning all-`sketch` ceilings fails the proof.
6. **P3 needs two qualifiers.** (a) The "iff" holds for acts that bound before the changeset. (b) An act that read an id the changeset *adds* to the segment can start binding. So "reads nothing in that segment" has to mean before *or* after. The lemma is stated with both.
7. **Reverting content brings old acts back.** The spec allows the content version to be "an opaque hash or counter". With a hash, reverting content restores the old version, and an act that read it binds again. `Test_Resurrection` pins this, and the random run saw 491 re-binds. With a counter it can't happen. The two choices are observably different, so the model should pick one.
8. **Binding is all-or-nothing, and the example shows a cost of that.** B's re-derivation of `(c@2, d@2)` stops binding when only d moves to `d@3`. c loses its support with it: at the `Fixed` mark `overclaim(c)` is back, though c did not change. This follows the spec ("binding to nothing"), and it is honest that an act is one judgement. But it pushes actors toward acts that read as little as possible, and the model may want to say so.
9. **One finding, nine owed items.** The single perturbation yields nine frontier items with one root cause. A frontier that records which item is a consequence of which would read better at scale. That would be a model addition.
10. **Recording refusals (P5's choice).** A refused record is appended to the log with its outcome (`Cycle`, `Duplicate_Item`, `Foreign_Id`, `Unaffirmed_Reconcile`, `Act_Capacity`), and the fold skips it. Only `Log_Full` is merely reported, since there is no room to record it. I chose recording because the act definition in the model says recording too little is as dishonest as claiming too much. The fold also re-validates records marked accepted, so a hand-edited log can't make it produce an ill-formed state. `kernel_cli` reports any record whose recorded outcome disagrees with what it computes now; I tested that on a tampered file.

## The proof section

### P1–P8

| | Status | By what |
|---|---|---|
| **P1** Determinism | **Proven** (language + prover), also tested | The SPARK units have no package-level variables, and SPARK functions cannot have side effects. So `State_At`, `Position`, `Ceilings`, `Frontier` and `Steady` are mathematical functions of their arguments; flow analysis checks the data dependencies. The spec's sentence ("same records in the same order give equal states") is `Lemma_Prefix`: two logs that agree on the first K records give logically equal states as of K, proved by induction. Tested by rebuilding each random log record by record and comparing every prefix state. |
| **P2** Append-only | **Proven**, also tested | `Log` is a private type whose only mutators are `Append` and `Push`. That is compiler-enforced encapsulation, not a contract. Both postconditions say the log grows by exactly one canonical record and every earlier record is logically unchanged. If the log is full, nothing changes. Refusals are among the appended records. |
| **P3** Lapse is exact | **Proven** (`Lemma_Lapse_Exact`, with the qualifiers in finding 6), also tested against an independent "changed or removed" oracle | |
| **P4** Monotone under acts | **Proven** (`Lemma_Monotone`), also tested | Appending a check: no position falls, unread positions are unchanged, and a read one rises to at most `max(old, level)`. Appending an affirmation changes no position. |
| **P5** Acyclicity | **Proven in both directions**, also tested | Soundness: every accepted changeset leaves a state carrying a valid ranking, an invariant (`Well_Formed`) carried through `Try`, `Step`, `State_At` and `Append`. Completeness: `Lemma_Cycle_Exact` shows a changeset refused as `Cycle` leaves a table that has no ranking at all. It goes through `Compute_Rank`'s "closed" postcondition and an induction over any witness ranking (`Lemma_Rank_Complete`). "Has a ranking" is the definition of acyclic used throughout. The random run also checked 910 cycle refusals against DFS. |
| **P6** Ceiling bound | **Proven** (`Lemma_Ceiling_Bound`), and the stronger equation plus uniqueness are proven too; tested against a plain recursive ceiling | |
| **P7** Steady means honest | **Proven** (`Lemma_Steady_Honest`), also tested | |
| **P8** Replay | **Tested only** | The text layer isn't SPARK. Tested on the worked example and all 400 random logs: every record round-trips through save and load, and the state as of every index is logically equal after replay. The fold half ("equal logs give equal states") is P1, which is proven. |

Also proven for all the SPARK code: absence of run-time errors (157 range, index and overflow checks), and termination of every loop and recursion (67 checks; the fixpoints carry explicit variants).

The store invariant is proven too: the state the store keeps always equals the fold of its log (`Valid`, pre- and postcondition of `Append`). In practice this is what "computed from recorded acts, never typed" means for the state a user is shown.

### What this solution could prove but didn't

- **P8 by proof.** I'd write the codec in SPARK over bounded strings, with hand-written digit encoding instead of `'Image`/`'Value`, and prove `Decode (Encode (L)) = L`. My felt estimate is several hours to a day, most of it lemmas about decimal digits (division and modulo by 10). I didn't attempt it.
- **The CLI's listing matches the frontier set** (`Frontier_Items`). Easy, maybe half an hour, but it's porcelain.
- **Unbounded structures.** Moving from bounded arrays to SPARKlib's formal containers or ownership pointers is untried. I expect proof effort to rise there, but that is an expectation, not a measurement.

### What cannot be stated as a contract here

- **"No other operation alters a record."** This is a fact about the API surface. Ada's private types enforce it at compile time; a contract can't express it. One caveat: `Push`, the loader's path, appends whatever outcome a file claims. P2 still holds, and the fold re-validates, so the state can't be corrupted that way. The recorded outcome can lie, though, which is why the CLI audits it.
- **P1's "is a function"** is a language guarantee rather than a contract. What can be stated (the prefix lemma) is stated and proven.
- **Equality.** Predefined `=` on records that contain arrays is not the prover's logical equality. "Equal states give equal results" became provable only after 13 layered `Logical_Equal` functions (9 in the model, 4 in the store), and gnatprove proves each annotation correct. So this is the toolchain being exact about what `=` means, not the language being unable to say it.
- **Spec imprecision, not the language:** findings 1, 2, 5, 6 and 7 above.

Trusted, not proven: the compiler, gnatprove and its provers, the `Logical_Equal` annotation proofs, Ada.Text_IO, and the text layer.

### What gnatprove discharged, and what it needed

It discharged automatically all run-time checks and most functional contracts, often on the first run. The whole model package, including the ceiling fixpoint and the uniqueness lemma, proved on its first gnatprove run with no iteration. I was suspicious of that, so I checked with mutations: dropping acyclicity from the uniqueness lemma fails it, and so do all-`sketch` ceilings, a ranking that accepts a target ranked in the same pass, a `New_Table` that keeps removed veritoids, `Compute_Rank` without its `Closed` postcondition, and stopping the layering after one pass.

What it needed from me:

- loop invariants in every loop;
- ghost functions as termination measures, `Sum` for the ceiling fixpoint and `Count_Ranked` for the layering, each with a lemma proved by recursion;
- recursive lemmas for induction: `Lemma_Prefix`, `Lemma_Sum_Mono`, `Lemma_Count`;
- a handful of `pragma Assert` steps;
- the `Logical_Equal` layering.

Nothing remained a run-time check only.

### What the verification story buys, judged from one side

The spec's §3 became postconditions nearly word for word. `Position`'s postcondition is the definition of position, and `Frontier`'s postcondition is §3.4. Those same contracts are proven for every input and also executed in the tests. A reader can check the claim in the `.ads` file without reading the body. For a model whose central rule is that a status is trustworthy only if a stranger can recompute it, a proven postcondition is the same move applied to the code. I can't judge the Rust side's tools from here. Bounded model checking (Kani) would cover these properties only up to a bound. Deductive tools (Creusot, Verus, Prusti) are the comparable thing, and how fluent they are is what the other spikes measure.

### The one property whose proof would most change my confidence

**That the state the store keeps is always the fold of its log** (`Valid`), together with **the ceiling being the spec's ceiling** (the equation plus uniqueness). The first is the model's founding claim made true of the code. The second is the one subtle computation in the kernel. I got both.

## The language

**Easy.**
- Contracts sit in the specification files and read like the spec.
- The enumeration type is the ladder, with ordering for free.
- Lemmas are ordinary procedures, and induction is a recursive ghost procedure with a variant.
- gnatprove messages name the exact conjunct that failed.
- With `-gnata`, the tests check every contract at run time as well, so they double as contract checks.
- The first proof of the core needed no iteration.

**Where I fought the tool.** Each of these took one round to resolve:
- Predefined record equality isn't logical equality. This was the only real conceptual snag. I found the fix in the user-guide example shipped with gnatprove (`share/examples/.../ug__logical_eq_implementation`).
- Bounded arrays keep stale data past their counts. Equality sees it and the text format doesn't write it, so the first random P8 run failed. Records are now stored canonically, and a removed veritoid is reset whole. This could bite any SPARK design built on bounded arrays.
- `Loop_Variant` has to sit next to a `Loop_Invariant`.
- Record aggregates take `()` and array aggregates `[]`.
- A function named like a use-visible type is hidden by it, so I renamed things to `Veritoid_Named` and friends.
- `for X of [...]` needs a typed aggregate.
- Once the test crate had two executables, `alr test` needed an explicit `alr run kernel_tests`.
- Run-time contract cost. A function call inside a quantified postcondition is evaluated again for every element; the `Frontier` postcondition re-evaluates `Ceilings` about 290 times per call. Proof doesn't care, but the fully contract-checked property run is slow.
- There's no property-testing library, so the generator and oracles are hand-rolled, about 470 lines. I didn't try `strategy` 0.1.0.

Separately, one of my scripted edits silently missed a postcondition because of a line-wrap difference. That's my tooling, not the language; the next edit's assertion caught it.

**Time.** Measured by `git log`: base commit 17:24, model proven 17:39, store proven 17:45, text layer, worked example and CLI 17:49, random properties and canonical records 18:06 (about ten minutes of that was waiting for the 400-trial run), P5 completeness 18:10, last commit 18:11. That's about 47 minutes from the base commit. Felt split: about three quarters on the kernel and the spec's meaning (the worked example, affirmation, how to compute the ceiling) and about a quarter on the language. None of the language fights took more than one round.

## What I'd want in the model that this spec lacks

- What an affirmation does to the computation (finding 2).
- Whether a check of v should also read what v rests on. As written, B's check on `u@1` never lapses when c changes; only u's ceiling falls.
- Hash or counter for content versions (finding 7).
- Whether frontier items record which one caused which (finding 9).
- Whether an act declares which of its reads it is about and which it merely relied on (finding 8).
- Who a refusal belongs to. Here it's the kernel's outcome, recomputable from the log.
