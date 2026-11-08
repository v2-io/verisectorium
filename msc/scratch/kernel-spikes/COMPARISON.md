# Four kernels, one spec: Rust and Ada/SPARK, by Opus 5.5 and Fable 5.1

*Written 2026-11-07 by the Fable session coordinating the spikes, after reading all four `account.md` and `debrief.md` files whole and each branch's commit log. Nothing here is a re-run; I did not re-execute their builds, tests or proofs (CPU was the scarce resource). Per-agent spend is in `RUNS.md`. The four were independent by construction: separate worktrees, told not to read each other, no contact. Where they agree, that is evidence; where they differ, that is a decision the model has to make.*

## 1. What each landed

| | Rust / Opus | Rust / Fable | Ada / Opus | Ada / Fable |
|---|---|---|---|---|
| branch | `spike/kernel-rust-opus` | `spike/kernel-rust-fable` | `spike/kernel-ada-opus` | `spike/kernel-ada-fable` |
| tokens · tool uses | 354k · 180 | 204k · 58 | 293k · 91 | 370k · 113 |
| commits | 5 | 2 | 9 | 2 |
| kernel green (git) | +9 min | +10 min | +15 min (model proved) | +57 min (kernel proved and tested) |
| proved | nothing | nothing | 7 of 8 (418 checks) | 7 of 8 (463 checks, 4 deliberate justifications) |
| tested | all 8; 1024 logs/property vs naive oracle; coverage floor; 20/20 seeded faults caught | all 8; proptest 400/property; coverage probe; mutation 49/80 caught, 10 missed all in display code | all 8; AUnit; 400 random logs vs separate oracles | all 8; AUnit; random logs vs independent oracles; contracts executed in tests |
| verification reached for | Kani (8 runs aborted, no verdict) | Kani (no verdict), cargo-mutants | gnatprove level 2 | gnatprove level 2 |
| P8 (replay) | tested | tested | tested (text layer not SPARK) | tested (text layer not SPARK) |
| size | lib, 36 tests | lib ~670 lines, 23 tests | proved core ~1,400 lines; ~3,000 all in | SPARK units ~1,400 lines + store |

Wall clock is not comparable: all four ran at once, and the two Rust spikes' CBMC runs pinned eight cores. Part of Ada/Fable's time is a `2^24` contract-execution stall that a grep-filtered command chain, used on what it took to be the final run, kept out of view; its earlier runs were done properly, and the stall was found in minutes once the stages were run separately with full output. How long it cost is not measured.

## 2. Proof, property by property

| | Rust / Opus | Rust / Fable | Ada / Opus | Ada / Fable |
|---|---|---|---|---|
| P1 determinism | tested; not statable (no purity contract in Rust) | tested; not statable | **proved**: prefix lemma by induction + `Global => null` flow | **proved**: `Lemma_Fold_Prefix` + flow |
| P2 append-only | compiler-checked (4 `compile_fail`) + tested | by construction (privacy) + tested | **proved** (`Append` post) + private type | **proved** (`Append` post) + private type |
| P3 lapse exact | tested both ways; Kani unknown | tested both ways; mutants caught; Kani unknown | **proved**, with two qualifiers | **proved**, first run, no hints, under two added rules |
| P4 monotone | tested (strong form: acts never add owed items) | tested | **proved**, incl. affirmation moves nothing | **proved**, first run |
| P5 acyclicity | tested (refusal names a real cycle) | tested vs independent Kahn | **proved both directions** | **proved both directions** (completeness via a ghost count, +17 min) |
| P6 ceiling bound | tested incl. tightness (= min) | tested | **proved**, plus the defining equation and uniqueness | **proved** as the exact characterization |
| P7 steady ⇒ honest | tested | tested both ways | **proved** | **proved**, noted as contentless; proved frontier-list exactness instead |
| P8 replay | tested | tested | tested | tested |
| "the one property" | P3 + strong P4: not got | P3: not got (tests only) | state = fold of log, and ceiling = spec's ceiling: got both | P3: got, first run |

**What the Ada pair establishes, from two independent minds:** the spec's §3 definitions became postconditions nearly word for word, and gnatprove discharged P3 and P4 unaided on the first run for both. Both say the time went into the spec's meaning, not into making Ada accept it. Both proved P5 in both directions and P6 as the exact equation, beyond what the spec asked.

**What the Rust pair establishes, from two independent minds:** the kernel was written and green in about ten minutes, with the type system carrying the model's distinctions (an affirmation cannot carry a rung; the log cannot be written except by `append`); property testing with an independent oracle plus mutation testing gave strong evidence fast. Neither got a single verification verdict: Kani spent its budget inside std's B-tree and string code, and even with `u8` ids and a sorted-Vec map swapped in under `cfg(kani)` nothing finished. Both name the same cause: the idiomatic kernel is the wrong shape for CBMC, and the alternative is a checker-shaped second kernel or a verification dialect (Verus/Creusot/Prusti), untried, estimated at hours for the easy properties and days for the graph ones, leaving a less idiomatic kernel.

## 3. Fluency, which was the question

- **Writing the kernel** was fast in both languages for both models; Ada was not slower to write than Rust. All four say the language was not where the time went.
- **Proof cost in Ada** was real and had one dominant cause, found independently by both Ada agents: Ada's `=` on records is not the prover's logical equality, so "the kept state equals the fold of the log" would not prove until each wrote a ghost equality with `Annotate => (GNATprove, Logical_Equal)`, the device SPARK's own library uses. Ada/Opus found the cure in the shipped user-guide example in one round; Ada/Fable spent about a third of its proof time diagnosing it and left a probe unit in the tree so the next mind inherits the fact. That is the shape of the Ada turnover cost: two or three encoding facts that nothing in the code hints at, which must be inherited rather than rediscovered. Both are now written down in the branches.
- **Verification cost in Rust** had one dominant cause, found independently by both Rust agents: no deductive prover on stable Rust, and the bounded checker chokes on idiomatic data structures. Also a shared process cost: both ran CBMC in parallel on a shared machine without asking and starved the other spikes; both own it in their accounts.
- **Ada's standing cost** named by both: everything is bounded arrays (proofs re-ran unchanged at 1,000 pieces / 100,000 records, so they don't lean on the sizes, but they lean on fixed-size storage); growable structures in SPARK are untried and the largest unknown. No property-testing library (hand-rolled generators, ~470 lines for Ada/Opus). Contract execution in tests is slow.
- **A process datum, not a language one:** the grep-filtered build/test/prove chain (Ada/Fable, on what it took to be its final run, after earlier runs done properly; kept in memory as the anti-example) hid a stall its tool was reporting and cost an unmeasured part of its time. It would have cost the same in any language.

## 4. The spec was wrong, and four independent reads agree where

Convergent across all four, independent by construction (so this is evidence, not restatement):

1. **§6's expected frontier under-counts.** After the T changeset, §3 yields `overclaim(e)`, `unmet-need(d, c)`, `unmet-need(e, c)` in addition to the listed seven. (All four; each pinned by a test.) Rust/Opus adds that the listed `stale-reference(d, c)` cannot hold, since d was rewritten against c@2 in the same changeset; Ada/Opus kept d@2 seeing c@1 to match the list. Rust/Opus is right by the story. The list was written by asking "who points at c", which is the failure a computed frontier exists to prevent.
2. **An affirmation, as specified, computes nothing**, so S1 is unreachable: e is never rewritten and its reference stays stale. (All four.) Repairs differ, see §5.
3. **Hash vs counter for versions is a kernel-visible decision**: binding on `(id, version)` means a revert re-binds old acts, right under content hashes and a hole under counters. (All four.) Rust/Opus found the hole in its own kernel by a property test and now refuses version reuse log-wide.
4. **Ceiling of a missing target is undefined**; all four chose `sketch`, and two note the target then shows on the frontier twice (stale + unmet).
5. **"Veritoid identity under recut"**, the model's own gap, surfaced in every kernel as a refusal or a rule (an id belongs to the segment that introduced it; an id held by another segment is refused).

Found by one or two, each with a test or proof behind it:

- **The act needs `concerns ⊆ reads`** (Rust/Opus): an honest re-derivation of u reads its premise c and would certify c under the spec's position rule, so the spec's own example under-records, and u's check then never lapses when c changes. Ada/Opus saw the same shape from the other side: a check that read two pieces stops counting entirely when either changes, which will push actors toward reading as little as possible.
- **What the version covers** (Rust/Fable, Ada/Fable): the example needs a reference's "version seen" to change while content version does not, so that field is written state that is not content; Rust/Fable recommends the version cover references (a reference is a use, and a use is part of the derivation), after which §6 needs one more act.
- **P3 needs rules to be true** (Ada/Fable, Ada/Opus): acts can *start* binding when a read version appears later, and ids aren't tied to segments; two rules make it exact as written (id belongs to its segment for life; acts read only introduced ids).
- **P6 as stated is too weak** (Ada/Opus): all-sketch satisfies it; the real contract is the defining equation plus uniqueness, which both Ada spikes proved. Acyclicity is needed for uniqueness, not existence.
- **P7 has no content beyond the frontier's definition** (Ada/Fable): the fact worth asking for is that the computed frontier list is exactly the set the predicates define; proved.
- **Only writing ever adds an owed item** (Rust/Opus, tested); **`needed` on a reference mostly duplicates the ceiling** (Rust/Opus): an unmet need implies an overclaim unless `needed` exceeds the piece's own claim, and the ceiling ignores `needed`; so either the ceiling should consult it or it is a separate assertion whose job the model hasn't stated.
- **One finding, nine (or ten) owed items** with one cause (Ada/Opus, Rust/Fable): the model may want a word for "owed because of", computed as porcelain over the raw set.
- **Affirmation inside the changeset vs beside it** (Rust/Fable): the model puts it inside, the spec made it a separate act, which is two records for one logical instant.

## 5. Where they diverged, which is where the model must decide

| question | Rust / Opus | Rust / Fable | Ada / Opus | Ada / Fable |
|---|---|---|---|---|
| affirmation's effect | reconciles references of what it concerns; never raises a rung; lapses like any act | none; instead let a reference be reconciled without a version bump (and recommend the opposite rule) | required to rewrite references without a content change; otherwise refused | recorded, consumed by nothing; names it a spec gap |
| refusals | recorded; verdict computed at fold, never stored | reported only; the log holds only applied records | recorded with reason; fold skips; loader re-validates; CLI audits | reported with a witness set; log does not move |
| version reuse | refused log-wide (a version names one content for the life of the store) | allowed; flagged | allowed; flagged (`Test_Resurrection`) | allowed; flagged |
| what the version covers | content; references separate; `concerns` added to acts | should cover references (recommendation) | content; references separate, reconciled by affirmation | content; "version seen" is written non-content state |

## 6. What I take from it, for the language decision

- **For the kernel as this model defines it, SPARK does what was claimed for it.** Two independent minds turned §3 into postconditions and had the load-bearing ones (P3, P4) discharged on the first run; the exact ceiling, both directions of acyclicity, and the prefix lemma followed with lemmas. That is a stronger statement than anything the Rust side could make, and both Rust agents say so unprompted.
- **The Ada turnover cost is specific and inheritable:** the equality encoding, inlined expression functions, ghost-code execution cost, stale proof sessions. Each is now written in two branches and can go into a short "SPARK facts no code hints at" note; the second Ada mind to arrive would not pay for them. The cost that is not yet measured is unbounded data in SPARK.
- **Rust's cost is the opposite shape:** nothing to inherit, nothing to prove. Fast to build, fast to test hard, no route to an unbounded proof on the shipped code without a verification dialect and a rewrite.
- **Writing speed did not separate the languages;** both models wrote both kernels in minutes. What separated them was what happened after the kernel was green.
- **The spec corrections are worth more than the comparison** (Ada/Opus said this and I agree): four independent kernels found the same three faults in the worked example, the inert affirmation, and the hash/counter question. The model's `act`, `reference`, `segment⸱changeset` and `frontier` entries all have work to absorb from §4.

My recommendation, as the lead and from one reading: a SPARK-proven kernel is viable and was reached twice without heroics; whether v2 should be written in Ada turns on the unbounded-data question and on how much of v2 is kernel versus porcelain, neither of which this spike measured. The next spike worth running is a single one: the same kernel over SPARK's formal containers (or ownership pointers) with the fixed-size bound removed, by whichever Ada agent is still on the line, since both have the encoding facts hot.
