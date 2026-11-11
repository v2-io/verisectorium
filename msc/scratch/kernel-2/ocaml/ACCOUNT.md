# kernel-2 in OCaml: what was done and found

*2026-11-10, by the OCaml-side agent (Fable 5.2). Against `../KERNEL-SPEC.md` draft 3 at `9305775`. Nothing under `core/` and nothing in the spec was changed. Nothing here is a fact about the model until it has been adjudicated in core.*

## 1. What this is

`lib/model.ml` is draft 3 as an executable model: versions, the four facts, a selection, C1–C9, consistency, the frontier, stationarity. It is a pure function of (universe, selection, set of facts), about 500 lines. `lib/explore.ml` checks Q2–Q9 by visiting, inside a small universe, **every** subset of a pool of candidate facts and **every** selection. `test/test_kernel.ml` holds twelve hand-built universes, each small enough to read, that pin the counterexamples and run three of the invented moves.

**What "tested" means below, exactly.** A universe is an ontology, 3 ids (4 for Q7) with 2 versions each, and a pool of 5 to 10 candidate facts. Within a universe the visit is exhaustive. The universes themselves are drawn at random from seeds, 100 to 300 per batch, half of them with one id an assembly. So "no counterexample" means none in the universes visited, and "smallest" means the smallest the search met; where it matters I then built the smallest by hand and it is a test. Nothing is proved by a tool. Where I give an argument for why a property holds, it is marked as an argument.

**What the generator does not reach,** and so what no result below speaks to: more than one dimension; warrants that are not a total order (meets are `min`); assemblies nested in assemblies; references from assemblies (a pointing slot is not treated as a reference under C3/C4); more than one reference per version; descent longer than one edge in the random runs (the hand tests use one edge too); merges.

The full output of every run cited is in `runs/`, named as cited. `runs/run.sh NAME args` re-makes one; progress goes to the file per seed.

## 2. The table

| | property | result | to what bound | where |
|---|---|---|---|---|
| Q1 | no history | **holds by construction**: the frontier is computed from $(\sigma,F)$ and nothing else exists to read | not a test | `model.ml` |
| Q2 | dead ends are inert | **holds for evidence and same facts; fails for decisions** | 38.4M states, 59.5M removals of a dead fact | `main-v`, `main-a` |
| Q3 | going back | **true as far as it is a definition; false read fact by fact**, both ways | 12.8M states, 24.8M pairs of added facts | `q3-v`, `q3-a` |
| Q4 | good facts do no harm | **fails in general; holds under three conditions, with two exceptions** | 38.4M states, 118M additions, zero failures under the conditions | `q4-msc`; the failures in `main-*`, `q4-ms` |
| Q5 | a defect cannot be selected away | **holds by construction for the piece and its recorded descendants; fails for the same content under an id with no recorded descent** | 38.4M states | `main-*`, test `guards` |
| Q6 | well defined | **`effective` unique given C3 (by construction); the greatest fixed point fails to exist when a raise, promise or waive decision is conditioned; holds when none is** | 51.2M states with none conditioned: all have a unique greatest fixed point | `q6-c`, tests `Q6` |
| Q7 | locality | **fails for the neighbourhood the spec names; holds for a wider one that has to be read from every version and the descent relation, not from the selection** | 8M states at 4 ids: 41.6M checks of the wider one, zero failures | `q7-v`, `q7-a` |
| Q8 | changesets compose | **no failure when the wider neighbourhoods do not meet; fails when only the spec's do not** | 1.44M base states, 345M pairs of changes, of which 6.2M had non-meeting wider neighbourhoods: all 6.2M compose | `q8-v`, `q8-a`, `q8-a6`, test `Q8` |
| Q9 | the three standards | run side by side; **placement admits everything either other admits; decision and rule each admit what the other refuses** | 38.4M states | `main-*`, test `Q9` |
| Q10 | switches | guards off: **one piece, one fact**. Written-against off: **one affirmation per reference in or out of the edited piece** | hand-built | tests `guards`, `affirmations per edit` |

## 3. The counterexamples, smallest first

Each is a test in `test/test_kernel.ml` unless a run file is named.

**Q6. One piece, one fact, no fixed point.** A raise decision about p, on the condition that p is asserted and consistent. If p is consistent the question holds and is unanswered, so p is not consistent; if p is not, the question does not hold, so p is. Two pieces each carrying a question conditioned on the *other* give two fixed points and no greatest. *Argument for the condition:* every constraint is satisfied by more as more pieces are assumed consistent, except C8 (a promise that holds creates something owed) and C9 (a raise that holds does). If neither a promise nor a raise can come to hold because a piece is consistent, the step is monotone and the greatest fixed point exists and is unique. The run tested a stronger restriction (no conditions at all on raise, promise or waive): 51.2M states, none without one.

**Q4. Three ways a "good" fact adds a violation, and what remains when they are excluded.**
1. A **same** fact for failing evidence carries the defect to the selected version (one piece, two facts; guards off, so the old version's defect was otherwise shed). `same` is not a good fact; it is good or bad as the fact it is for.
2. `read_as` not monotone in holding evidence (the model's deliberately odd `Odd`): more evidence lowers a warrant.
3. A raise or promise with a condition: evidence that holds about q raises q's warrant, a question about p conditioned on that warrant now holds, and p has an unanswered question (two pieces, two facts).

With those three excluded, 118M additions of a good fact added nothing except: **(a)** a promise, whose consequences are more than its own C8 instance: the assembly it is on becomes inconsistent, so C5 falls on whatever rests on that assembly and C8 on any slot it fills; **(b)** holding evidence on a criterion that already fails on that piece adds a conflict instance (the piece was already violated on that criterion). So the condition on `read_as` alone is not the exact condition; it is `read_as` monotone, **and** `same` restricted to facts that are themselves good, **and** no raise or promise conditioned on a warrant or on consistency.

**Q5. The same content under a fresh id.** Failing evidence about p. Select and assert r, an id with no recorded descent from p, whose version has p's content. Nothing is violated. Rewording, a recorded split and a recorded replacement all keep the guard, as Q5 says; what sheds it is a replacement that does not record descent, and nothing in the kernel can tell that from new material. With no actors and no log, descent is something whoever writes the version chooses to declare.

**Q2. A decision about a version nothing selects still holds.** A decision's subject is not one of its conditions (§4: it holds when not withdrawn and its conditions are true). An accept of p@v with no conditions holds in every selection, including ones that select p elsewhere or not at all, and a piece whose content reports that decision satisfies C7 by it. Remove the "dead" decision and C7 is violated. For evidence and same facts Q2 held in every case visited.

**Q3, read fact by fact.** "Stationary again exactly when no fact in $F' \setminus F$ violates a constraint at $\sigma$" has no content unless "a fact violates" means something for one fact alone, and then it is false both ways. Each alone harmless, together not: failing evidence about an old version (guards off) and a same fact reaching the selected one; a question and the evidence that makes its condition true. One alone breaks it, together fine: failing evidence about an old version (a guard) and holding evidence on that criterion at the selected one; a withdrawal of the only accept and a second accept. Facts act jointly. The true statement is the definitional one: $\sigma$ is stationary under $F'$ iff the frontier of $(\sigma,F')$ has nothing uncovered.

**Q7 and Q8. What an instance reads.** The spec's neighbourhood (the piece, what it references, what it rests on) is not closed. Changing something outside it changed instances about the piece through: the subject of a claim (C7); the conditions of a reported decision, a raise, a waiver; and, the two that do not go away when the neighbourhood is widened along the selection: **(i)** evidence about an id the piece *descends from*, which need not be selected (a guard arrives); **(ii)** an unselected reference target's descendant becoming selected, anywhere (C3 resolves or stops resolving, and C4, C8 with it). (C1's "held by exactly one" has the same shape: any id may come to hold the piece.) With the neighbourhood taken from every version and the whole descent relation, no failure in 41.6M checks; and of 345M pairs of changes, the 6.2M whose wider neighbourhoods do not meet all compose, while 69k pairs whose spec neighbourhoods do not meet fail to. The smallest non-composing pair whose spec neighbourhoods do not meet: one change records failing evidence about a retired id; the other asserts its descendant (`runs/q8-v.txt`).

**Q8's outline question, answered for a reference kind** (the assembly "view" parameter cannot answer it; see §4.3). An outline referencing c and x by a kind that relies on **existence only**: repairs of c and x never touch it. By a kind that relies on **assertions or everything**: each repair leaves the outline's reference unreconciled (C4), and then how it is reconciled decides everything. Reconciled by an **affirm decision**, the two repairs compose: each adds its own fact, facts accumulate, the union is stationary. Reconciled by **rewriting the outline** against the new version, they do not: each repair selects its own version of the outline and no selection holds both. So changes meet harmlessly through facts and harmfully through selections. That is the sharpest thing this build has to say about Q8: *two changesets fail to compose only where they select different versions of one id, or where one's facts are read by the other's pieces.*

**§6. A blind spot in the definition of an atomic changeset.** "Stationary on the pieces whose selection or consistency differs." A piece with a waived defect is inconsistent. A second, unwaived defect arrives: its selection is unchanged and it is inconsistent before and after, so it is not among the pieces that differ, and $(\sigma,F) \to (\sigma,F')$ is an atomic changeset with something uncovered in it. "Whose selection or **set of uncovered violated instances** differs" closes it.

## 4. Where draft 3 had to be read one way to be built

Each is a finding against the spec section named. The reading taken is in `model.ml` at a comment marked CHOICE.

1. **§4 "a decision that C5 relies on".** With several accept decisions about a piece, some holding and some not, "everything it rests on" depends on which one is meant. Taken as: C5 is met when *some* accept decision holds and everything *that* decision has a condition about is asserted and consistent. Read as "every accept decision's conditions", a second, stricter decision would break a piece the first already carried, and the step would not be monotone.
2. **§3 evidence has no second subject, and C2 wants one.** C2 asks for evidence "for the filler of a ... against the filler of b"; an evidence fact is about one piece at one version. Built with affirm decisions only.
3. **§2's "what a view of the whole relies on in each filler" is read by nothing in §4–§5.** An assembly's version is its slots; evidence about an assembly applies while that version is selected; so a check of a whole document goes on applying while every part of it is rewritten. The whole reads that lapse at 09:25 in `impl-a-small-move` and at step 5 of `impl-an-outline-fills-in` cannot be said. Either evidence about an assembly records the versions of the parts it read, or an assembly's version covers them as far as the view relies.
4. **C4's "written against" needs the version to say what it was written against.** Added as a field on a reference. `def/veritoid.md` argues at length for keeping exactly that out of the version ("Why the version leaves out what a reference last saw"). Under draft 3 the two are not in conflict the way they were (reconciling by affirmation is a fact and mints nothing), but the field is in the version, and that should be said.
5. **C3 "one selected descendant".** Read as exactly one. After a split with both halves selected the reference does not resolve, which seems right, and it should be stated.
6. **C3/C4 for a pointing slot.** `def/reference.md` counts a slot's pointing as a reference kind; the spec's C3 and C4 say "every reference of an asserted piece". Not applied to slots here; C8 is the only constraint on them.
7. **`same` is symmetric and chains.** Assumed. "For the purposes of fact f" was kept: a same fact is indexed by the one fact it is for.
8. **Which warrant.** C5's rule and a decision's "warrant at least w" read the piece's own warrant; C7 and C8 read the effective one, as written.
9. **§6 "pieces whose ... consistency differs"** needs a definition of consistency for a pair of different fact sets; taken as membership in each one's greatest fixed point.
10. **Q3** could only be tested after choosing a reading; see §3.

## 5. The five invented moves

| move | as one or two atomic changesets? | what it shows that draft 3 cannot say |
|---|---|---|
| `impl-a-small-move` | **Yes**, one: ({c@0, u@0}, 2 facts) → ({c@1, u@1}, +4 facts). Test `a small move`. | The whole reads of T and U (§4.3). And one thing it says differently: the fewest facts that close it is **two**, not the move's three. Answering is evidence that holds on the finding's criterion, and that evidence is also all the warrant the rule asks of the new c; B's separate recheck is not needed. Whether an answer to a finding should count as a check is `read_as`'s to say, and the spec gives it no way to tell the two apart. The 11:00 check of the d that was replaced is a fact about a version nothing selects, and is inert, as the move says. Going back to S0 is not stationary: the finding stays learned. |
| `impl-two-moves-at-once` | **Yes**, both halves. Test `two moves at once`: after M1's repair the selection is stationary on {c, u} and not on {x, w}; when x's repair is written against the new c it cannot be stationary until c is repaired, and the two close as one. | Nothing lost. "Belongs to", cause and scope are gone and were not needed. |
| `impl-a-finding-is-answered` | Steps 1–2 (a rewording carried) and 5–6 (a right finding answered): yes, as same facts and evidence. **Step 4 cannot be said.** Test `a wrong finding`. | A wrong finding, contested, with the piece left alone. Failing evidence about c@v applies while c@v is selected, forever; E's contrary evidence is a conflict (C6), also forever. No set of facts makes the untouched piece stationary again. The only ways out are a waiver, or a new version of c, identical if need be, with the question looked at afresh there or E's check carried to it by a same fact. So the model's own example of "a wrong finding has a way out that leaves the piece alone" has no way out that leaves the piece alone. |
| `impl-an-outline-fills-in` | **Not built.** By reading the spec: promising, filling and accepting are a promise decision, two selections and an accept; step 7 (a named assumption fails) is an accept decision with a condition on the assumption written as a piece, and the test `costs and disagreements` exercises that shape. | O's whole read lapsing at steps 1 and 5 (§4.3). "A promise is kept by acceptance": C8 asks that the filler be asserted and consistent, which under *placement* is free. |
| `impl-intake` | **Not built**, and mostly out of scope by §1. | Routing and retirement have no decision kind and no constraint reads them. Step 7 (a routing reopened by a later edit) would be a decision with a "selected at this version" condition that stops holding, which the kernel can represent and nothing in it would notice. A relayed finding from an unattested source is the standing layer's. |

## 6. Whether removing the log lost anything that matters

Checked against §F of my audit of draft 1 (`SPEC-AUDIT.md`). **I have not read the other audit of draft 1** that the spec's header mentions; this section speaks for one list only.

- **A1** (reopening computed or sticky): dissolved. A decision holds or does not, as a function.
- **A2** (split, deletion, withdrawal): changed shape. Which pieces are asserted is chosen, so every exit is now one exit, *assert less*, and it is visible only as a difference between two selections. The kernel has no notion that a changeset which asserts less is worse; that is "better", and out of scope. Guards cover recorded descent; §3's Q5 hole is the unrecorded kind.
- **A5** (answer, then restore the old text): dissolved, and well. Go back to the old version and the failing evidence applies again (test `a small move`, "going back").
- **B1** (fixed points): half dissolved. Evidence has no fixed point at all now, since warrants do not read consistency. Consistency's fixed point is chosen greatest, and §3's Q6 is what remains.
- **B3/B4** (item identity, cause, membership): dissolved; what replaced them has the blind spot in §3.
- **A8** (what a reference last saw): now explicit in C4, with a cost Q10 measures: with "written against" on, any rewrite of a dependent reconciles its references without anyone being asked whether it relied on what changed.
- **C3** (moves across freestanding segments): dissolved; a selection moves two ids at once.

**Lost, and I think it matters:**

1. **Bad news cannot be wrong.** §5's wrong finding. Facts only accumulate, there is no fact that says an earlier fact was mistaken, and contrary evidence at the same version is a conflict, not a correction. Good news can be contested (failing evidence at that version); bad news cannot. A mistaken **same** fact is worse: nothing opposes it at all, and it carries its fact to the other version for good. Draft 3 defers who may assert a fact to a later layer; this is not that. Even with every actor trusted, an honest mistake needs a retraction, and `withdrawn` exists for decisions only.
2. **`same` is the whole of lapsing, and nothing constrains it.** With one same fact per fact per edit, no evidence ever lapses and no decision is ever reopened. The log-era carrying act had an asker who was not the editor. Here that is entirely the deferred layer's, so the deferred layer is carrying more than "standing, initially any" suggests: under "any", Q5 and the lapsing of evidence hold only against people who do not write same facts.
3. **Whole reads** (§4.3).
4. **Path-dependence is gone, deliberately,** and with it `def/segment.md`'s "one that was once accepted owes and one that never was does not". I think this is a gain. It should be decided in core, not inherited from a spec.

**Not lost:** everything the two-moves and small-move examples needed.

## 7. Where I think the model, and not the spec, has something to decide

1. Whether a finding can be wrong without the piece being rewritten (§6.1). Core says yes and shows it; draft 3 cannot.
2. Whether descent is a declaration or something a later layer can check (Q5). As a declaration, "replacing a piece wholesale ... sheds nothing" is true only of replacements that say they are replacements.
3. Whether a decision's subject is a condition of it (Q2). If accepting p@v does not require p to be at v, an accept is a free-floating fact that any content may report.
4. Whether questions and promises may be conditional (Q6, Q4). Every failure of well-definedness and most failures of "good facts do no harm" came from a raise or a promise with a condition. Unconditional ones lose little: a question about p can simply be withdrawn.
5. What an instance reads (Q7). Guards through descent and resolution through descent make every constraint read ids that are not selected. Locality is true, of a neighbourhood nobody can see by looking at the selection.
6. Whether reconciling by rewriting and reconciling by affirming are meant to differ as much as they do (Q8). The first makes repairs collide at every shared dependent; the second never does.

## 8. On the instrument

Exhaustive visiting of small universes suited this draft better than it would have suited the log drafts: with no history, a state is $(\sigma,F)$, and "every state up to a size" is a finite set a laptop finishes in minutes. Every counterexample above was either found by the search, or predicted by hand and then met by the search or pinned as a test. A proof assistant would now be worth its cost for exactly two statements, both short: Q6 under the condition in §3 (a monotonicity argument), and Q7 for the wider neighbourhood (each constraint reads only named things). I did not attempt either. QCheck is installed and unused; random generation with shrinking would add depth (more ids, more versions) that exhaustive visiting cannot afford, and is the natural next thing if the spec holds still.

## 9. What was not done

- No property is proved by a tool.
- The bounds in §1 are small: 3 or 4 ids, 2 versions, one dimension, pools of 5 to 10.
- Two of the five moves were not built (§5), and the two real-root impls were not attempted.
- The three standards were compared on the same states and on one hand-built cost example; "what a new assertion costs" has one data point per standard (decision 1 fact, rule 1, placement 0, per piece; a rewritten premise costs 2, 2, 1), not a characterization.
- The other audit of draft 1 was not read.
- I ran ten explorer processes at once before being asked to keep it to two or three; the later runs were capped at two.
