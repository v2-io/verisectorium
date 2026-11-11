# Account: KERNEL-SPEC draft 3 in Ada 2022 + SPARK

*2026-11-10, by the Ada/SPARK agent (Fable 5.2). For the lead and for Joseph. Built from `KERNEL-SPEC.md` at `9305775`. Nothing under `core/` and nothing in the spec was changed. `SPEC-AUDIT.md` beside this file is the earlier audit of draft 1; this account is about draft 3 only. Toolchain: GNAT 16.1.0, gnatprove 16.1.0 at level 2, Alire 2.1.1.*

Nothing here is a fact about the model until core adjudicates it. Each finding names the clause of the draft it is against.

## What exists

| file | lines | what |
|---|---|---|
| `src/vk.ads` | 266 | the objects of §2 and §3 as bounded tables: ontology, versions, facts, selection, constraint instances |
| `src/vk-model.ads`, `.adb` | 793 | §4 and §5: which evidence applies, warrants, the cap, decisions holding, the nine constraints as fifteen instance kinds, consistency, the frontier |
| `src/vk-lemmas.ads`, `.adb` | 810 | the proofs: ghost lemmas over the model |
| `tests/src/scenarios.adb` | 612 | the five invented moves and nine probes, 89 stated expectations |
| `tests/src/search.adb` | 1267 | random search with shrinking for Q2, Q4, Q5, Q6, Q7, Q9 |
| `runs/` | | the full output of every run this account cites |

```sh
cd msc/scratch/kernel-2/ada
alr build && alr gnatprove                        # 328 checks, all proved; 2m33s from a clean session
cd tests && alr build
./bin/scenarios                                   # 89 expectations, 0 failed
./bin/search 200000                               # about three minutes
```

Bounds: 5 ids, 3 versions each, 2 dimensions, 2 criteria per dimension, 4 warrant levels, 3 reference kinds, 12 evidence facts, 12 decisions. A proof below is a proof for every ontology, version table, selection and fact set of those bounded types satisfying the stated condition. A search result is a sample: 200,000 random worlds per property from a fixed seed, never exhaustive.

## The table

| | status | by what | condition, or counterexample |
|---|---|---|---|
| **Q1** No history | **holds by construction** | the model unit has no state; every function reads only its arguments | there is no log to disagree with |
| **Q2** Dead ends are inert | **tested**, 57,952 cases, 0 counterexamples; half **proved** | search; and a dead fact that *holds* adding nothing is an instance of the Q4 lemma | tested for evidence facts only, not for decisions about unselected versions |
| **Q3** Going back | **not attempted as stated** | scenario 1 shows one case | as written it is Q1 restated; see F11 |
| **Q4** Good facts do no harm | **proved**, for evidence that holds, same facts for evidence that holds, accept and affirm, any number at once | `Good_Facts_Do_No_Harm` | needs three conditions, each with a counterexample when dropped: `read_as` monotone; no promise or raise conditioned on a warrant or on consistency; same facts only for evidence that holds (F2, F3) |
| **Q5** A known defect cannot be selected away | **proved** | `Defect_Stays`; and 248,429 tested cases | three ways out remain, all visible: F8 |
| **Q6** Well defined, consistency | **proved**: a fixed point is reached, and it is the greatest | `Consistent_Is_Fixed`, `Consistent_Is_Greatest` | only if no promise, raise, waiver or set-aside is conditioned on consistency. Otherwise there may be **no fixed point** (F2). The fixed point is not unique (280 of 185,348 worlds had more than one) |
| **Q6** Well defined, `effective` | uniqueness **proved**; existence **tested** | `Cap_Unique`; the computed table was a solution in all 20,000 (world, dimension) pairs checked | unique given a ranking witnessing no capping cycle. With a cycle, 2,411 of 7,954 pairs had several solutions; the kernel takes the greatest |
| **Q7** Locality | **tested**, 75,147 (world, closed region) pairs, 0 counterexamples | search: rewrite everything outside the region, compare the frontier inside | the closure it needs is wider than §7 says (F9) |
| **Q8** Changesets compose | **shown by example** both ways; not proved | scenario 4, four variants | composes when the outline's *references* rely on anything; fails when *evidence about the outline read two parts at once* (F6) |
| **Q9** The three standards | **measured** | search and probe P7 | placement's frontier is always within the other two; decision and rule are incomparable (F10) |
| **Q10** Switches | **exhibited** | probes P5 and P9 | guards off: one piece, two versions, one fact. Written-against off: one affirmation per reference out of the edited piece, plus one per reference in that relies on everything |

## How the proofs were checked for emptiness

A proof that goes through on the first run deserves suspicion, and most of these did (the Q4 lemma among them; only the fixed-point lemma needed a second attempt). So: a false assertion planted at the end of `Good_Facts_Do_No_Harm` and of `Consistent_Is_Fixed` is rejected (`runs/mutation-1`). Dropping each hypothesis in turn (monotone `read_as`; plain obligations; same only for holding evidence; stratified) makes the proof fail in each case (`runs/mutation-2` to `-5`). A failed proof is not a counterexample, but for each of the four the search found one independently.

The refactoring that made consistency and the cap provable (loops rewritten as iterated steps) left all 200,000-world search figures identical before and after, which is a check on the refactoring.

## Findings against draft 3

Ordered by how much I think turns on each. F1 to F5 were sent to the lead mid-flight and agreed as switches; they are here in full because the account is what gets read later.

**F1. Evidence has no reads (§3 Fact, §4 "applies").** A fact is `evidence(p@v, d, criterion, outcome)` and applies while p is selected at v. A check of u that read premise c still applies after c is rewritten; C4 then asks for an affirmation of u's reference, which is a decision, and u is consistent with no new check. `def/act.md`'s "an unchanged piece needs a fresh check after its premise moves" cannot be said, and neither can a whole read of an assembly lapsing on a part. §2 declares what a view relies on in each filler and §4 never uses it; C2 speaks of evidence "against" a second piece, which the fact's signature cannot carry. *Built*: evidence carries up to two reads, each with how far it relies (existence, assertions, everything) and its own same set; `Reads_On` off is the literal draft. Scenario 1's last two lines show the difference on the small move.

**F2. Consistency can have no fixed point (§4 "holds", Q6).** A raise about p conditioned on "p is asserted and consistent" holds exactly when p is consistent, and when it holds p has an unmet C9 and is not. Probe P1 is the smallest case: one piece, one decision. The same goes for a promise. The proof of Q6 needs, and uses, that only accept and affirm decisions carry a consistency condition (`Stratified`). Decisions that add an obligation or remove one must be conditioned on something consistency does not feed. Random unstratified worlds almost never hit this (0 of 14,652), which is why it wants stating and not testing.

**F3. Q4's exact conditions.** Three, each necessary:
- *`read_as` monotone*: more criteria with holding evidence never gives a lower warrant. Counterexample (2 pieces): `read_as` gives 2 for no evidence and 0 for criterion 2 alone; p2 claims p1 stands at 2; add holding evidence on p1; C7 on p2.
- *Same facts only for evidence that holds.* §7 lists "a same fact" as good without qualification. Counterexample (1 piece, 2 versions, 1 fact): evidence fails at p@2, p@1 is selected and clean, add `same(p@2, p@1, for that fact)`: C6 at p@1.
- *No obligation conditioned on a warrant.* Counterexample: a raise about p2 "if warrant(p5) ≥ 1"; add holding evidence about p5; C9 on p2. The spec's own exception (a promise adds a C8 instance) is the unconditioned case of the same thing.

**F4. A wrong finding has no way out that leaves the piece alone (C6, §3's "contesting" row).** Contrary evidence on the same criterion at the same version is a conflict and clears nothing: C6's first clause is still violated. Only a waiver or a new version helps, and `impl-a-finding-is-answered` step 4 cannot be said. C6's third clause is also redundant as written: two facts on one criterion disagree only if one of them does not hold, which the first clause already catches. *Built*, as the lead leaned: a decision that sets one evidence fact aside while its own (plain) conditions hold; scenario 3 step 4 runs it both ways. Related: at the very version found wrong, the guard is violated as well as the first clause and nothing but conflicting evidence could meet it, so one defect needs two waivers (probe P3).

**F5. The guard is for ever, and I think that is the price of having no history.** Every defect ever found needs, at every later version of the piece, either fresh evidence that holds on that criterion or a same fact carrying an earlier answer (scenario 3, last two lines: a comma moved, and the old finding is owed again). The cost is one fact per guard per edit, growing with the piece's history. The reason is structural. "Answered since" needs versions to be ordered, and a selection has no order: v3 is not *after* v2, it is only another version. So a guard cannot be discharged once; it can only be met wherever one stands. This is the one thing the log did that the selection model cannot, and it is my main answer to §9's question. Descent is the model's only order, and it is among ids, not versions.

**F6. Q8, and what an outline must rely on.** Scenario 4, two repairs in unrelated pieces under one outline:
- outline points, relying on existence only: both apply together, stationary;
- outline's pointing relies on assertions: still composes, because each changeset supplies its own affirmation and affirmations are per pair (outline, part);
- a whole read of the outline, as evidence that read both parts' assertions: each changeset re-reads the outline against its own selection; neither read applies to the combined one; the outline fails the rule. They meet at the outline. This is the audit's M5 and trial 1's finding 12, confirmed.  
So the answer to Q8's question is not about the outline's references at all. It is that **one piece of evidence reading two parts is a conjunction, and conjunctions do not compose**. An outline whose coherence is evidenced part by part, or by a read that relies only on what repairs leave alone, does not join changesets. The second half of the move (x comes to rest on c) meets at x's reference, as core says.

**F7. C8 asks for a consistent filler, and that makes every document a hub (C8).** A required or promised slot must be "filled by an asserted, consistent piece". So a claim found wrong makes its document inconsistent, and whatever requires the document (scenario 1: both T and U join the frontier on one finding; probe P4). It also un-keeps a kept promise whenever the filler is later unsettled (scenario 2, step 5), where `def/segment.md` has a promise "kept when what fills the slot is accepted" and a whole that "stays settled while one of them is unsettled". Switch `Slot_Needs_Consistent`; off, the document stays consistent.

**F8. Q5's three ways out.** Proved: with guards on, a failing fact about p or an ancestor, at any version, puts C6 on every selection asserting p without holding evidence on that criterion there. What still sheds it (probe P6): (a) the same content under a fresh id with no descent recorded: nothing ties them, since content is opaque and descent is whatever was recorded; (b) selecting p without asserting it: free for any piece nothing rests on and no slot requires; (c) a set-aside, by design. And a waiver covers. (b) is the audit's M4, now the same under all three standards because what is asserted is chosen. The frontier is blind to unasserted pieces, which is trial 1's finding 16 unchanged.

**F9. Locality needs a wider closure than "what it references and rests on" (Q7).** Tested with the region closed under: reference and pointing targets; held fillers; what a standing claim is about; what evidence about a member read; the pieces named by conditions and affirmations of decisions about a member; decisions a member reports; **every assembly that could hold a member**; and **descent in both directions**. Leaving out holders gave 276 failures in 79,732, descent 628 in 78,170, reported decisions 20 in 76,838. Holders are needed only because C1's "held by exactly one" is an instance about the held piece and reads upward; stated about the assemblies, regions would close downward only. Descendants are needed only because C3 lets a sole selected descendant resolve a reference.

**F10. Q9.** On the same selection and facts, 200,000 worlds: placement's frontier was within decision's and within rule's every time. Decision owed something rule did not in 120,214 worlds and the reverse in 15,322. Stationary under decision and not under rule: 82; under rule and not decision: 2,434; under placement and not decision: 5,616; under placement and not rule: 3,264. So each of decision and rule admits stationary selections the other calls inconsistent, and placement admits everything either does. What a new assertion costs (P7, two claims, one resting on the other): under decision, an accept each, the second conditioned on the first being sound; under rule, a check each; under placement, nothing beyond the affirmation of the reference. A rewrite of an asserted piece costs, under decision, a new accept of it, the affirmations C4 asks of what references it, and no other accept *if* the dependents' accepts were conditioned on soundness and not on the version (scenario 2, step 6: R1's and R2's acceptances stand again unasked once D@2 is accepted). There is no latch, which settles the audit's M1 one way.

**F11. Q3 says less than it seems to.** "Stationary again exactly when no fact in $F' \setminus F$ violates a constraint at $\sigma$" is true by Q1 and tells the reader nothing about which facts those are. The content is Q2 and Q4 together: of what was added, good facts and dead ones cannot break $\sigma$; what can is evidence that fails where $\sigma$ stands, a same fact carrying a failure there, a withdrawal, a promise, a raise, and recorded descent.

**F12. Smaller, each against its clause.**
- *C9* is met by any evidence on the dimension that applies, however old (scenario 5, step 2): a question raised on an already-checked piece is no question. It wants a criterion, or "evidence other than what was there".
- *C4's "written against counts as its own affirmation"* needs the version each reference was written against; §3's Version does not carry one. I treat it as an affirm fact made with the version, which is the same thing and keeps Q10's switch a matter of which facts exist.
- *C3* lets a reference resolve to a sole selected descendant; `def/reference.md` says a reference to a retired id "is never silently redirected". Switch `Redirect`; I let it affect C3 only.
- *`effective`* is defined in Q6 only for selections satisfying C3, but the frontier has to be computed on those that do not. The kernel takes the greatest solution everywhere.
- *Waivers do not stop spreading.* A covered violation still makes its piece inconsistent, so everything resting on it needs a waiver of its own (probe P3: a chain of five, four more). Switch `Waived_Is_Consistent`.
- *Nothing says* a held id must be selected, or an asserted piece selected. I made the first a C1 violation.
- *The fixed point is not unique* (probe P8): for two claims each accepted on the other being sound, "both" and "neither" are fixed points. The greatest is the right one, and the order of acceptance does not matter.

## What removing the log lost

Checked against my own audit's list (I have not read the OCaml agent's, to keep the two lines apart).

Lost and, I think, mattering:
1. **Later.** F5. No order among versions, so nothing can be answered once.
2. **Reads.** F1. Restored here as a field on evidence.
3. **Overturning.** F4. Restored here as a decision.
4. **Slot states.** A slot is empty, holding or pointing. "Suggested" and "gap" cannot be written, so the adviser's idea and nothing at all look the same; and promising no longer changes the assembly, so in scenario 2 step 1 the outline's acceptance is untouched where core has it reopened.
5. **Routing and retirement.** No routing decision and no retirement. Scenario 5 says "already present" as an affirmation of the chunk against its target, which works and un-routes when the target is rewritten; nothing is owed for it either way.
6. **Cause and address.** A frontier item has no cause and nobody it is addressed to. "Several changesets open at once" becomes "stationary on a set of pieces", which the kernel can say.

Lost and, I think, well lost: path-dependence (the audit's K15: whether a piece owes no longer depends on whether it was once accepted); refusals (a draft is a selection that is not stationary; a cycle is a violation); the latch on reopened decisions; every question about who may answer, carry or contest. The audit's M1, M3 and most of M2 are gone as the lead said.

Changed shape: M4 (un-asserting is always available, F8); M5 (F6); M6 (the promise now has one home).

## Where this departs from the letter of the draft

Each is marked `DEPARTS:` in `src/vk.ads`. Warrants are a total order (the spec allows a lattice). Two criteria per dimension stand for its means, and `read_as` is a table over which of them have holding evidence; it returns no conflict flag. One filler per slot. One standing claim and one reported decision per version. A fact's same set is held already closed (reflexive, symmetric, transitive), per fact; so "does carrying compose" is assumed, not tested. Descent is held transitively closed. A pointing slot is a reference of a kind the ontology names. C1 to C9 are fifteen instance kinds. Conditions on a warrant read the own warrant; the rule standard reads the effective one, on the dimensions the kind opens. C2 is met by an affirmation or by applying evidence about one filler that read the other.

## Ada and SPARK

**Policies as data worked without friction.** An ontology is a record value; every lemma takes it as a parameter; a condition on it (`Monotone`) is a precondition. That is "for every policy" in the plain sense, within the bounds, and it needed no generics. The switches are fields of the same record, so a lemma that does not mention a switch holds under both settings: the Q4 and Q6 proofs cover `Reads_On`, `Set_Aside_On`, `Waived_Is_Consistent`, `Slot_Needs_Consistent` and `Redirect` either way, and all three standards.

**What proved with no help.** The transfer of every one of the fifteen instance kinds between two fact sets (`Inst_Transfer`, a null body), monotonicity in the consistent set, uniqueness of the cap, and Q5, all at level 2.

**What had to be shaped for the prover.** Consistency and the cap were first written as loops and could not be reasoned about across two runs. Rewritten as an iterated step function with its defining equation as postcondition, the induction lemmas were short. Reaching a fixed point in five rounds is a counting argument, done with the number of members as the measure. The earlier spike's trap (array equality does not give `F (A) = F (B)`) appeared once and was avoided twice over: the iteration stops as soon as a step changes nothing, and "equal sets are both fixed or neither" is proved through monotonicity each way.

**What is not proved and could be.** Q7 and Q2 as frame lemmas (the frontier inside a closed region depends on nothing outside) are the same shape as the Q4 transfer, both directions; I would expect them to go through. That the iterated cap is a solution of the cap equations. Q8, which wants Q7 first.

**Small things.** `accept` and `raise` are reserved words (the decision kinds are `Admit` and `Ask` in the code); a type named `Standard` collides with the package; Alire wants crate names of three letters or more.

## What I would say across a table

Draft 3 is a better object for formal work than draft 1 was. The frontier is a pure function of a selection and a set of facts; the two hardest properties (good facts do no harm; consistency is well defined) proved for every ontology of the bounded types without a struggle, and the proofs said exactly which conditions they needed. Under draft 1 I had predicted I would be deriving exit tables by search.

The same shape has one cost I would want decided knowingly (F5), and two places where a constraint as written undoes something core argued for at length: C8's consistent filler brings back resting on parts (F7), and a whole read of two parts brings back the outline as a meeting place (F6). Neither is forced by the shape. Both are one word in a constraint.

And the question that is Joseph's is still there, in a sharper form. What is asserted is now simply chosen, the frontier sees nothing else, and under placement nothing gates the choice. Whether an asf `stage: draft` segment is asserted is the whole of what its frontier shows.

Nothing is committed. I am on the line.
