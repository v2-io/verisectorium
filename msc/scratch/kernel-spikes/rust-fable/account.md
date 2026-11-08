# Account: the v2 kernel in Rust (Fable 5.1)

*Spike branch `spike/kernel-rust-fable`, 2026-11-07. Built against `../KERNEL-SPEC.md` at commit `8e46d9b`. Everything here is about what is in `src/` and `tests/` on this branch; where I say "proven" or "tested" I mean by an artifact you can run, named in the text.*

## 0. What is here

| Path | What |
|---|---|
| `src/lib.rs` | The kernel: objects, `State` (fold, `with`), the five computed things, refusals, `Log` (append, `state_at`, JSON-lines write/read), builders. ~670 lines with doc comments. |
| `src/example.rs` | §6 of the spec as a log built step by step, with named checkpoints. |
| `src/main.rs` | CLI: `kernel example [OUT.jsonl]` prints every checkpoint's state and frontier and writes the log; `kernel show LOG.jsonl [N]` loads a log (replaying it through the kernel) and prints the state as of record N. |
| `tests/worked_example.rs` | §6 step by step (14 unit tests), the refusals, and the edges the spec leaves open. |
| `tests/properties.rs` | P1–P8 and frontier-completeness as proptest properties over random logs (9 properties, 400 cases each). |
| `tests/coverage_probe.rs` | A probe that the random-log generator actually reaches every class the properties speak about (cycle refusals, lapses, steady non-empty states, all three owed kinds, dangling references). |
| `src/kani_proofs.rs` | Bounded model-checking harnesses for P3–P7 under `cfg(kani)`, two families (symbolic ids; concrete ids). **No harness ran to a verdict**; see §4 for exactly what was started and stopped. |

Run: `cargo test` (all of the above except Kani), `cargo clippy --all-targets` (clean), `cargo run -- example`, `cargo kani --harness <name>`.

Dependencies added to the base: `serde` + `serde_json` (serialization). Verification tools installed on the machine for this spike: `kani-verifier 0.68.0` (CBMC 6.11.0), `cargo-mutants`.

## 1. The kernel as built

The shape follows the spec almost one to one, which is itself a finding: §2–§3 of the spec is already nearly a type signature.

- Ids, segment ids, versions, actors and criteria are `String` newtypes. Versions are opaque; only equality is used.
- `Rung` is an enum whose declaration order is the ladder; `Ord` is derived, so `<` on rungs *is* the ladder and `min`/`max` are the lattice operations. There is no separate ladder object.
- `State` holds `BTreeMap<VeritoidId, Veritoid>` and `Vec<Act>`; both private, so the only way to get a state is to fold records. `State::with(&self, &Record) -> Result<State, Refusal>` is the one step of the fold and is pure (the receiver is untouched on refusal). `State::fold` iterates it.
- `Log` holds the record vector and a cached head state; `append` is the only mutator and it pushes. Records are exposed only as `&[Record]`.
- The five computed things are methods on `State`: `binds`, `position`, `ceiling`, `frontier`, `steady`, implemented as literal transcriptions of §3. `ceiling` is recursive with a memo; `frontier` shares one memo across the whole pass.
- Serialization is JSON lines through serde derives, one record per line. `Log::read_from` replays each parsed record through `append`, so a file that would have been refused is refused on load (tested).

### Decisions the spec left to me, with why

1. **A refusal is reported, not recorded** (P5 asks which). Every record in the log is a record that was applied; so a fold never skips, `state_at(n)` is literally "fold the first n", and P1/P8 are statements about the record sequence with no carve-out. Recording refusals would make the log a log of *attempts*, which is a different, also-honest design; it buys an audit trail of who tried to write a cycle, at the cost of every consumer of the log having to know which records are inert. If the model wants that trail I would put it in a separate intake log, not in the store's log.
2. **A reference to a missing target contributes `sketch` to the ceiling**, and `ceiling` of an id that does not exist is `sketch`. The spec defines `ceiling` only over existing targets. What rests on nothing is supported by nothing. The consequence (tested, `a_removed_target_counts_as_sketch_and_is_owed_twice`) is that a dangling reference appears on the frontier twice: `stale-reference` (target gone) and `unmet-need` (ceiling `sketch` below any need above `sketch`). See §2.3 on whether the model wants that.
3. **Three refusals besides the cycle**: a veritoid naming a different segment than its changeset; the same id twice in a changeset; an id currently held by another segment. The third is the model's open gap "veritoid identity under recut" surfacing exactly where the spec said it would: the kernel does not know what moving a veritoid between segments means, so it refuses to let it happen by accident. A changeset with an empty veritoid list retires the segment.
4. **Acts are never refused.** An act whose reads are already stale when recorded simply does not bind (tested). The log records what happened; whether it was useful is computed.
5. **Dangling references are allowed.** A segment may be written before the segment it rests on; the frontier reports the debt.

## 2. Where the spec is ill-formed or under-determined, and what I built against

### 2.1 The §6 expected frontier is a strict subset of what §3 yields

After the T changeset (`c@2`, `d@2`, `e@1` affirmed), §6 lists seven owed items. §3's definitions force ten. The three §6 omits:

- `overclaim(e)`: `ceiling(e) = min(position(e) = drafted, ceiling(c) = sketch) = sketch`, and `e` claims `drafted`.
- `unmet-need(d, c)`: `d` needs `c` at `drafted`; `ceiling(c) = sketch`.
- `unmet-need(e, c)`: same.

Nothing in §2–§3 lets `e` escape: affirmations never count toward a rung, and `ceiling` is a plain `min`. §6 was derived by hand from the same definitions and under-counted; the spec's sentence "where this spec and the model disagree, the model is being corrected by your finding" applies, and the correction is to §6 not §3. The tests assert the ten (`after_the_t_changeset_b_lapses_and_the_frontier_opens`) and separately assert that §6's seven are a subset.

Whether the ten is what the *model* wants is a different question (§2.3).

### 2.2 The §6 repair sequence closes only if a reference can be reconciled without a content-version change

For the frontier to empty at S1, `e`'s reference must come to say "seen `c@2`". §6 never mentions touching `e` after the first changeset, and never mentions anyone re-checking `e`. The only reading on which §6's sequence ends steady is: in the `d@3` changeset, A also reconciles `e`'s reference to `c@2` *while leaving `e` at version 1*, so A's `drafted` check on `e@1` keeps binding. That is what `example.rs` does, marked `SPEC:`.

This exposes a real model question the spec does not answer: **does a veritoid's content version cover its references (and its claimed level), or only its text?** The spec says the version "changes when the content changes" and lists references as a separate field. Under that reading an author can silently re-point `d`'s reference to a different premise while keeping `d@2`, and B's check of `d@2` keeps binding although the derivation now invokes something else. Under the other reading (version is a hash of the whole written record) the §6 sequence needs one more act (someone re-reads `e@2` at `drafted`), and the spec's expected S1 is reached one record later. My recommendation to the model: the version should cover references, because a `predicated-on` reference is, in the model's own words, a *use* and a use is part of the derivation. Claimed level is more arguable; it is compared against the computed ceiling, not attested by the check, so it can plausibly stay outside the hash.

I did not pick that reading because §6 as written needs the other one, and the brief asked me to build the well-formed version of what was posed. Switching is a one-line change in `example.rs` plus one more record.

### 2.3 Frontier items that §3 produces and the model may not want as separate items

- **Cascading overclaims.** Every veritoid predicated, directly or transitively, on an overclaimed root is itself overclaimed (its ceiling falls to the root's). After the T changeset, `c`, `d`, `e`, `u` are all overclaims although only `c` changed. By the frontier def ("veritoids whose claimed level is above what is now earned") this is correct, and it is what makes P7 true. But an agent working the frontier has one cause and four items. The kernel should keep the raw set, since it is what can be recomputed by a stranger; grouping by cause is porcelain. The model may want a word for "owed because of" so the porcelain has something to compute.
- **Double-counting a dangling target** (stale-reference and unmet-need both fire). If `unmet-need` is meant to presuppose the target exists, §3 should say so.
- **Lapsed acts are not items.** The model's `frontier` def lists "acts that no longer bind where a value rested on them" as an item kind; the spec's §3.4 does not, and the lapse shows up only through the overclaim it causes. That is a deliberate narrowing by the spec, I think, and a good one: a lapsed act that nothing rested on is not owed.

### 2.4 Lapse is exact, and so is re-binding

P3 says a changeset makes an act stop binding iff it touched something the act read. True, and tested both ways. The converse case the spec does not mention: a changeset that *reverts* a veritoid to a version an old act read makes that act **bind again** (`a_reverted_version_makes_an_old_act_bind_again`). With content-hash versions that is right: the content is byte-identical to what was checked. With counters it is an author re-using a number, and a store would have to forbid reuse. The kernel cannot tell which it has; the model should say which versions are.

### 2.5 Affirmations: an act in the spec, part of the changeset in the model

The model's `segment⸱changeset` def puts the affirmation *inside* the changeset ("every inner dependent either changed or carried with the author's affirmation"). The spec makes it an act kind. I followed the spec: `e@1 affirmed` is an affirmation act recorded right after the changeset. Two records for one logical instant is exactly the gap the model's two-kinds-of-time discussion warns about; folding the affirmation into the changeset record would close it. The act's `rung` field is meaningless for affirmations (set to `sketch`, ignored); a kind-specific payload would be cleaner.

### 2.6 Smaller things

- `position(v)` ranges over check acts that read `v` *among other things*: B's check reading `{c, d}` at `rederived` attests both at `rederived`. The spec says this; it is worth knowing that one act can lift several veritoids.
- An act with no reads binds vacuously and moves nothing (tested).
- The spec's P5 says "the reference graph among veritoids is acyclic"; references to ids that do not exist are not edges. Otherwise a reference to a not-yet-written segment would have to be refused, which contradicts dangling references being owed rather than forbidden.

## 3. The language: what it made easy, what I fought, time

### Easy

- **The spec transcribes.** `Rung` with derived `Ord`; `State::with` as `Result<State, Refusal>`; `frontier` returning `BTreeSet<Owed>` where `Owed` is an enum of the three item kinds. Each §3 definition is a 3–8 line method that reads like the sentence it came from. I did not design a data model; I typed the spec.
- **Purity is visible in the signatures.** `with(&self, &Record) -> Result<State, Refusal>` cannot mutate its receiver; `records()` returns `&[Record]`; `State`'s fields are private. P2 is a property of the API that a reader can check by reading the `impl` block's signatures, and that the compiler enforces against every caller, including future ones. That is less than a proof and more than a test.
- **Equality for free.** `#[derive(PartialEq, Eq)]` on `State` and `Log` makes P1 and P8 one `assert_eq!` each, structurally, with no hand-written comparison to get wrong. `BTreeMap`/`BTreeSet` give canonical order, so serialization is deterministic without effort.
- **Serialization was zero work.** serde derives plus `serde_json`, one `#[serde(tag = "record")]` for the enum; the file format in `example.jsonl` is readable, and `read_from` replays through `append` so refusal-on-load came free.
- **proptest.** The generator is ~60 lines; nine properties with shrinking; the whole suite runs in under a second. The coverage probe took ten minutes and answered the question a green suite cannot ("does the generator reach cycle refusals at all?": 376 in 600 logs; "steady non-empty states?": 13 in 600, thin but present).
- **Edition 2024 niceties**: let-chains (`if let Some(cur) = … && cur.segment != …`), `let … else`.

### Fought

- **Kani and heap-shaped state.** See §4. The one real fight of the spike: the kernel is written over `String`-keyed `BTreeMap`s and `Vec`s because that is the natural Rust, and CBMC did not leave symbolic execution in ~12 CPU-minutes on the smallest symbolic-id harness; the path explosion is, I believe (not measured), in symbolic-key insertions into the B-tree and the per-step `clone()`. The second harness family fixes the ids and leaves only values symbolic; it was never allowed to finish (§4.1, P7 row). This is a toolchain limit on *this shape of code*, not on the properties; a kernel written over fixed arrays indexed by small integers would verify further and be worse Rust. Also a cost worth naming for the comparison: CBMC pins a core at 100% for as long as it runs, and with two Rust spikes on one machine that starved the other agents; the run was stopped for that reason.
- **My own process error**: a `pkill -f` pattern that matched both the harness I meant to stop and the one I meant to keep. Cost one restart; recorded because the comparison is about turnover and this is the kind of thing turnover does.
- **Nothing else of substance.** Two `unused_mut` warnings, one clippy nit about a needless lifetime, one about doc-list indentation. The borrow checker did not object to anything in the kernel; the memoized recursive `ceiling` needed one lifetime annotation (`&'a self`, `&'a VeritoidId` in the memo map) and compiled on the first try after it.

### Time (felt, marked as such; `git log` carries measured)

Measured: base commit 17:24; first full commit (kernel + example + CLI + 23 tests passing) 17:34; the second commit (Kani harnesses, mutation run, this account, debrief) carries its own timestamp. The first ten minutes felt like fifteen; nearly all of it was reading the spec twice and tracing §6 by hand (which is where §2.1 and §2.2 surfaced, before any code), then typing. After that, roughly: 20% of attention on the spec's edges and this account, 5% on Rust as a language, 75% on verification tooling (Kani's install and two harness families, cargo-mutants, and waiting on CPU). The kernel itself was not where the time went; the language was not where the time went; the checker was.

## 4. Proof

*Answered the same way as the other three spikes, per spec §5.*

### 4.1 P1–P8

| | Status | By what |
|---|---|---|
| **P1 Determinism** | **Tested** (property, 400 random logs, every prefix) | `p1_determinism`: cached head equals from-scratch fold; folding twice equal; `position`/`ceiling`/`frontier` equal on equal states. Not proven: Rust has no purity annotation a tool could discharge; `with(&self, …)` not mutating its receiver is enforced by the borrow checker, but "no hidden global state" is not stated anywhere a tool checks. |
| **P2 Append-only** | **Tested** (property) + **by construction** | `p2_append_only`: after any append, accepted or refused, the earlier records are an unchanged prefix. By construction: `Log`'s fields are private, `append` is the only `&mut self` method, `records()` is `&[Record]`. The compiler enforces this against all callers of the crate. It is not a proof that `append` pushes (a test is), it is a proof that nothing else can touch the vector. |
| **P3 Lapse is exact** | **Tested** (property). Kani harness written, **not run to completion** | `p3_lapse_is_exact`: for every act binding before an accepted changeset, binds after iff no read's current version changed or was removed; and acts whose reads are all outside the segment before and after are unaffected. Kani `fixed_p3_lapse_is_exact` exists; never started (see §4.4). |
| **P4 Monotone under acts** | **Tested** (property). Kani harness written, **not run** | `p4_monotone_under_acts`, also checks that ceilings never fall under an act (not asked). Kani `fixed_p4_monotone_under_acts` exists; never started. |
| **P5 Acyclicity** | **Tested** (property, against an independent Kahn-style cycle test). Kani harness written, **not run** | `p5_acyclicity`: every prefix state of every accepted log is acyclic by the independent test; every `Cycle` refusal was for a changeset whose blind application has a cycle and the reported path is a real cycle in it; no other refusal kind hides a cycle. Kani `fixed_p5_reachable_states_are_acyclic` (Warshall closure) exists; never started. |
| **P6 Ceiling bound** | **Tested** (property). Kani harness written, **not run** | `p6_ceiling_bound`. Kani `fixed_p6_ceiling_bound` exists; never started. |
| **P7 Steady means honest** | **Tested** (property, both directions). Kani: **bounded check started, aborted for CPU; result unknown** | `p7_steady_means_honest`, plus: an overclaim item is on the frontier iff some claimed level exceeds its ceiling. Kani `p7_steady_means_honest` (symbolic ids): ran ~12 CPU-minutes without leaving symbolic execution, stopped by me. Kani `fixed_p7_steady_means_honest` (concrete ids): started twice, the first run killed by my own mistaken `pkill`, the second stopped at the coordinator's request after ~6 CPU-minutes because the Rust spikes' CBMC processes were starving the other agents. Neither run reached a verdict. **Nothing below counts a Kani result as evidence.** |
| **P8 Replay** | **Tested** (property) | `p8_replay`: write, read, structurally equal `Log` (records and head) and equal frontier; every record round-trips alone. Also on §6. Not proven: it would need a proof about `serde_json`. |

Also tested, not in the spec's list: frontier items are exactly their defining conditions (`frontier_items_are_exactly_their_conditions`); every refusal kind; a file that would be refused is refused on load; the §6 walk at every checkpoint.

Also measured: **mutation testing** (`cargo mutants`, library only, excluding the CLI and the `cfg(kani)` module): 80 mutants, 49 caught, 10 missed, 20 unviable, 1 timeout. Every missed mutant is in presentation code (`Display` impls, `render`, `is_empty`, the line number inside a parse-error message) or equivalent (`State::empty` → `Default::default()`). Every mutant in `with_changeset`, `find_cycle`, `binds`, `position`, `frontier`, `steady`, `append`, `state_at`, `write_to`/`read_from` was caught; the one timeout turns the DFS index increment into `*=`, an infinite loop, caught in effect. This is the strongest statement I can make about the tests: on the kernel's logic, the suite distinguishes the code as written from every single-point mutation cargo-mutants knows how to make.

### 4.2 What I believe this solution could prove in Rust, and what it would cost

- **P3–P7, bounded, with Kani on the code as written**: I believe the `fixed_*` harness family (concrete ids, symbolic versions/rungs/targets/acts) terminates, because nothing in it inserts a symbolic key into a B-tree; I have no evidence, since no run finished. Cost to find out: one quiet machine for perhaps an hour, run one harness at a time. If it does terminate, each harness is a proof of its property over every state reachable by the fixed shape (three veritoids in two segments, one reference each, up to one act of up to two reads) and every value in the alphabet. That is a proof of the *values* logic on a *fixed shape*, which is roughly the quality of a well-designed exhaustive test, done by a tool that cannot forget a case.
- **P3–P7, bounded, with symbolic shapes**: not with this code. The symbolic-id harness did not leave CBMC's symbolic execution in ~12 CPU-minutes for the smallest state (one changeset of two veritoids, one act). The cost would be a kernel written for the checker: ids as small integers, veritoids in fixed arrays, no `String`, no `BTreeMap`, no `clone()` of the state per step. A day, and the result would be a less idiomatic kernel verified further, or a verified *model* of the kernel beside the real one, with the gap between them unverified.
- **P6 unbounded, deductively**: with Creusot or Verus one could state `ceiling(v) <= position(v)` as a postcondition and I believe it would discharge nearly automatically, since it is `min` applied to `position`. The second half (`ceiling(v) <= ceiling(target)`) needs the acyclicity invariant as a precondition on the state and an induction on the reference graph; that is a lemma, and in Verus a day's work for someone who has done it before, more for me. Not attempted: none of those tools was installed, each wants its own toolchain, and I judged the spike's budget better spent on the kernel, the spec's edges, and the test/mutation evidence. That is a judgment, not a finding.
- **P1, P2, P8 unbounded**: not statable as contracts in Rust (§4.3). P2 is enforced by the type system, which is a different and in this case stronger kind of guarantee than a contract.

### 4.3 What cannot be stated as a contract in this language

- **P1 (purity / determinism) cannot be stated.** Rust has no `pure` or `Post => result == f(args)` annotation; verification tools for Rust (Kani) check assertions in harnesses, not function contracts (Kani has `#[kani::requires]`/`#[kani::ensures]` function contracts, but they are themselves bounded model checks over harnesses, not deductive proofs). This is the language and the toolchain together, not the spec.
- **P2 is stated by the type system, not as a contract.** Privacy plus `&self` is a real, compiler-checked statement that nothing but `append` mutates the log; it is not a contract *about* `append`.
- **P8 cannot be stated** without a model of the serializer.
- **P3–P7 can be stated** as assertions in harnesses, bounded. They cannot be stated as *contracts on the kernel's functions* in a way a prover discharges unboundedly in the stable toolchain I used. Creusot/Prusti/Verus could state P6 as a postcondition on `ceiling` and attempt a deductive proof; none was installed, Verus requires its own fork of rustc, and I judged that a day's setup against a finding of "it would have proved P6 for `min`" was not where the comparison's value lay. That is a judgment, recorded as such.
- **The spec is imprecise in two places that matter for contracts**: `ceiling` of a missing target (§2 item 2) and whether version covers references (§2.2). Both had to be decided before any property could be stated at all; a prover would have demanded the decision as a precondition.

### 4.4 What the verification story buys the model

Judged from the Rust side only; I have not seen the Ada spikes.

**What I reached for**: proptest (property testing), `cargo mutants` (mutation testing), and Kani (bounded model checking, CBMC). Not Creusot, Prusti or Verus.

**What each gave.**

- *Property testing* gave P1–P8 stated as executable universally-quantified sentences over random logs, with shrinking, in under a second, and a generator whose reach I could measure (the coverage probe: 376 cycle refusals, 3078 lapsed acts, 13 steady non-empty states in 600 logs; the last is thin and would be the first thing to improve). It states the properties in the vocabulary of the spec and runs them; it does not prove them.
- *Mutation testing* gave the only number here I would put weight on: the suite catches every logic mutant in the kernel. It is a statement about the tests, not the kernel; but "the tests pin the kernel's logic down to the operator" is what a stranger wants to know before trusting "23 tests pass".
- *Kani* gave nothing I can report as a result. The harnesses are written against the real code and are, I believe, correct statements of P3–P7 on bounded shapes; the symbolic-id family does not terminate on this code's data structures, the fixed-id family was never allowed to finish. The lesson that *is* a result: **the idiomatic Rust kernel (String ids, BTreeMap, clone-per-step) is the wrong shape for CBMC**, and getting bounded proofs means either a fixed-shape harness family (cheap, limited) or a checker-shaped kernel (expensive, and then two kernels).

**What Rust's story buys that I would guess Ada's does not** (guess marked): the type system doing P2 for free and enforcing it on every future caller; structural equality and canonical ordering making P1 and P8 one-line checks; serde making P8 a non-event; proptest and cargo-mutants as mature, five-minute installs with no ceremony. The whole kernel plus its properties fit in one head in one sitting, and the spec transcribed into types nearly line for line.

**What I would guess Ada/SPARK's story buys that Rust's did not** (guess): P6 and P7 as `Post` aspects on `Ceiling` and `Steady`, discharged by gnatprove *unboundedly* for all inputs, with the acyclicity invariant as a type predicate or precondition; P3 and P4 the same way with a ghost model of the previous state. That is a strictly stronger statement than anything here, if it discharges. Where I would expect them to fight: the recursive `ceiling` over a graph (termination and the acyclicity precondition), the unbounded containers (Ada's formal containers or arrays with bounds), and anything resembling P8. And the comparison the brief cares about, fluency under turnover: this kernel took about ten minutes to write and have green; I do not know the Ada number and that number is the decisive one.

**For the model**: what the kernel's properties most need is not a stronger prover but a sharper spec in two places (§2.2 version coverage, §2.3 item presuppositions). Both languages would have had to decide those before stating anything. A prover forces the decision earlier; a test suite lets you defer it and then quietly bakes it in. I baked two in (§1), marked.

### 4.5 The one property whose proof would most change my confidence

**P3, lapse is exact**, and specifically its contrapositive: that nothing *other* than a changeset touching a read can make an act stop binding, and nothing other than a changeset can make it start. Everything the model promises a stranger ("the status you see was recomputed from acts that still bind to what you are reading") rests on binding being exactly this and nothing more. P6 and P7 are `min` and a definition; P3 is where a bug would silently lie about support. **Did I get it?** No, not as a proof. I have it as a property test in both directions over random logs, with every mutant in `binds` and `with_changeset` caught, and the reverted-version edge (§2.4) found and pinned by a test. The bounded check exists as a harness and never ran to a verdict. I would trust this kernel's P3 to the degree I trust proptest's 400 cases times the generator's reach, which is "no counterexample found where one would be easy to make", not "none exists".

## 5. What I would want in the model that this spec lacks

1. A decision on what the content version covers (§2.2). This is the largest; it changes whether §6 is reachable as written.
2. Whether versions are hashes or counters, because re-binding on revert is right under one and a hole under the other (§2.4).
3. Whether `unmet-need` presupposes an existing target (§2.3).
4. A causal grouping for frontier items, as porcelain, so that "four overclaims from one changed root" is one thing to a reader and four to the kernel.
5. Affirmation inside the changeset record, not beside it (§2.5).
6. What moving a veritoid between segments means; today the kernel refuses it (§1 item 3).
