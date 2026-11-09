# De novo read of `core-2/` — report 1

*Fable 5.1, 2026-11-08, for Joseph and the session that wrote `core-2/` this evening. Brief received: "a de novo read of `core-2/` (everything under it)". I read every file under `core-2/` whole, in the README's order, before anything else. I did not open `core/`, `msc/notes/`, or any transcript, so nothing here speaks to fidelity to Joseph's turns or to whether the terms dropped from `core/` were rightly dropped; that is outside what a cold read can judge. After the read I ran the gate the README names and checked the two examples against their primary sources (asf's git history and `vsect`), because the README says the examples are "the place it is most likely to be wrong" and the examples themselves flag one claim as unchecked. Treat this report's findings, not its silence, as its content.*

---

## 1. What landed, in one paragraph

The spine is readable cold. `MODEL.md`'s five sentences plus the written/done/computed table carry the whole thing, and every def I opened afterward was a refinement of something the overview had already placed; I never had to read ahead to understand a word. The dependence order works. The two examples do the job the README gives them: they are where I formed most of my questions, which is what a test is for. `bin/defs check core-2` passes: 10 terms, 13 subtypes, 31 relations, nothing unresolved. If the question is "can a cold reader build an instance from this," my answer after one evening is: a schema, yes; a working store, not yet, and §2 below is the list of the decisions that stopped me. Several of them are the same decision seen from different defs.

## 2. Findings that bear on the model

Ordered by how much I think rides on each. Where I offer a fix it is a suggestion for the author's adjudication, not a recommendation I am confident in.

### 2.1 "Assertion" is two different things, and only one of them can be compared with a warrant

The honesty constraint, assertion ≤ warrant, is the load-bearing rule of the model (§4; it is what catches the stopped bound in `examples/stopped-bound.md`). It presumes the assertion and the warrant lie on one ordering. Reading the examples of assertions the model gives, they split:

- **Claimed standing**: "ratified", "faithful to §4", "exact" in the sense of *proven*. These say how well the piece stands. They are comparable with a warrant.
- **Content scope**: "conditional on (S1)–(S5)", "exact under its finiteness hypotheses", "axiomatic" in the sense of *definitional, not derived*. These say *what is claimed*, not how well it is established. A check confirms the statement *as written*, hypotheses included; narrowing them is a content change. Comparing these with a warrant is a type error.

ASF's `exact` straddles the two, and the model inherits the straddle. The consequence shows in the stopped-bound example: under the standing reading, (i) asserting *exact* on 2026-04-22 is an overclaim from the day it was written, and so is every fresh claim in every segment until a second mind checks it, which means the frontier of any freshly written segment is nothing but overclaims, and the only clean assertion for new work is none. Under the content reading, (i) asserted nothing about standing; its validity was *never asked*, which the model then surfaces not on the frontier but in every checkpoint's stated conditions. Both are visible, which is the model's real achievement; but they are different mechanisms (owed vs conditioned), and the example claims the first without saying it depends on which reading of "exact" is meant.

Where this lives in the defs: `dimension.md` declares five things and says the kind declares "which assertions the content may carry, in what form"; nothing declares how the assertion vocabulary embeds in the *read as* ordering. I think there is a sixth slot missing, or a sixth sentence in *read as*: **asserts as**: the assertion values a piece may carry on this dimension and their place on the warrant ordering. If a dimension's assertions are content-scope rather than standing, the slot says so and the constraint does not apply to them. That would also give `kind.md`'s "which assertions, in what form" something to point at.

### 2.2 "Capped" and "overclaim" are the same item or the model contradicts itself

`MODEL.md` §4 constraint 3 and `reference.md` say validity *caps* along predicated-on: "nothing is warranted above what it rests on." That is a rule about how the warrant is computed. `frontier.md` then lists **capped** as a frontier item separate from **overclaim**, with the clearer "the premise earning more, or the author asserting less." If the cap lowers the warrant, then an assertion above the cap is already an overclaim and **capped** is redundant. If **capped** is a separate violation, then a piece's warrant can exceed its cap, and "nothing is warranted above what it rests on" is false as stated.

I suspect the honest shape is two warrants: a piece's *own* warrant (read from the acts that concern it) and its *effective* warrant (own, lowered by caps). Then **capped** is not a violation but information, "own exceeds effective," which a working agent wants to see (a well-checked claim resting on an unchecked premise), and **overclaim** compares the assertion with the effective warrant. `MODEL.md` §7 lists six item kinds and `frontier.md` seven; this is the seventh.

### 2.3 An act that reads a warrant lapses when the warrant rises

`act.md`: an act may read "a piece's warrant on a dimension when that is all it relied on," and binds "while every one of its reads is unchanged." Warrants are computed and move whenever acts arrive or lapse. So a chapter review that read its members' warrants lapses when a member gets a *new confirming check*. And `checkpoint.md`'s invariant, "a confirming check on a checkpoint reaches a new checkpoint at once, since nothing becomes owed," is false whenever any bound act read the warrant that check just raised. Either a warrant-read lapses only on a fall (an exception to "unchanged" worth stating), or the invariant goes. I lean to the exception; the alternative makes reviews of wholes lapse on good news.

### 2.4 The reconciliation cascade

A veritoid's version hashes "references with the versions they were last reconciled against" (§3, `reference.md`). So when premise A changes, B's reference goes **stale**; clearing it is a write; the write mints a new version of B; every act that read B lapses; every reference *to* B goes stale; and so on transitively through the predicated-on graph, in reconciliation writes that change no content. The model gives one argument for this ("a derivation that now uses a different premise is a different derivation"), and the argument is right for re-pointing to a *different* id but does not obviously cover re-reconciling to the *same* id at a new version. `MODEL.md` §11 item 2 names the first-order cost (a premise change lapses dependents' checks, which is right: the check read the premise); the second-order cost, that reconciliation itself propagates the collapse to things that read nothing that changed, is not named, and it is the larger one on a 1,234-record store.

One alternative that stays inside the model's own words: hash content, assertions and reference *targets* (ids); carry seen-versions beside the hash; treat reconciliation to the same id as an **affirmation** ("I looked; I still rely on it"), which the model already has and already says never counts as an independent check. Staleness stays computable; second-order lapses stop.

### 2.5 How does an author write a reference to a veritoid?

The model needs references and read sets at veritoid grain: veritoids have ids and no names, "a rendering reaches it through its segment," and `reference.md`'s first invariant is that a reference points at the specific veritoid, not its segment. The surface authors actually write on has segment names and ASF's `#tags`, and the record the examples lean on shows read sets at segment grain ("read set: segment:scope-adaptive-system, segment:def-action-transition, …"). The model is finer than anything any present tool records or any author presently writes, and the write path is the thing agents do every minute. I would make this a gap row of its own (how a veritoid is addressed by a human or an agent at write time) rather than leaving it inside "the recording cost," because it is a design decision and not only a cost.

### 2.6 Producers that are not act subtypes

`dimension.md`'s examples name producers: "a run act," "a script comparing two texts," "a reader event," "a read-check," "the graph." `act.md` declares six subtypes (check, finding, attestation, crossing, rule·firing, outside·change) and mentions "a run, a review" in passing as finding-out acts. A cold reader cannot tell whether a run is a ‹check› whose actor is a script at a version, or a seventh subtype; nor whether "I read this" is an attestation (making so, as `act.md` says) or a reader event (finding out, as the comprehension dimension implies). One sentence would settle it; my guess at the right one is "a run is a check whose actor is an instrument at a version; a reader event is an attestation of reading."

### 2.7 Where the ontology lives and how it changes

A verisectorium is "ontology, store, history." `verisectorium.md`: "nothing in its store is changed by hand." Outline: the ontology is "written by hand for now." `kind.md`: "a kind has versions … the ontology change is a perturbation like any other." `act.md`: ‹outside·change› is for "something the store does not hold." So an ontology change, which every piece's kind-version depends on, enters the log as an outside change, if at all, and the ontology's own history is not in the history. Either the ontology is content of a special segment (deferred by Joseph, per `kind.md`'s Working Notes) or there is a third kind of record beside written and done. The written/done/computed table in §2 has no row for it.

### 2.8 The model's own outline is a better model of rows than the model's "row"

`core-2/` lists itself as an example verisectorium. Its canonical projection, `model.outline.md`, keeps two columns: `mark` (accepted / promised / provisional / gap, about commitment and decision) and `def` (present / stub / inline / –, about existence). The model's inline word **row** fuses them into one three-valued state, provisional / promised / present, where the first two are commitment and the third is existence. `dimension.md`'s own invariant says "two things that can move independently never share a dimension; the tell for a fused one is a scale whose steps are combinations of two other scales' steps." The outline's practice obeys the invariant; the model's definition of row violates it. I would make the outline's two columns the definition.

Same neighborhood, two smaller self-application notes: the log's actor is typed ("Fable 5.1 session, with Joseph"), against `act.md`'s "read from the harness, never typed," which is fine for now but worth a line in the log's header saying so; and **determinant** is declared a subtype in `dimension.md`'s KDL while the def's body argues it is "a role and not a term." A role is a mark the ontology sets on a dimension; a subtype is a different kind of thing. The body is right and the KDL should probably follow it, or the def should say why a role is declared as a subtype.

### 2.9 A segment invariant rests on a facility the act def lists as open

`segment.md`: a projection's coherence "lapses only on what its kind says a review of it reads of each member (headline and assertion, not every proof step), so one edit does not lapse the whole theory." That requires an act to read *part* of a veritoid, or a veritoid's assertion without its content. `act.md` lists exactly this as open ("a store may want *reads* to distinguish 'relied on at a warrant' from 'read the text'"). The segment invariant is stated as settled; the act def says the thing it needs is not. One of them should move.

### 2.10 Kinds that open no dimension

`kind.md`: "every veritoid kind opens at least one dimension." The example ontology's kinds *non-claim*, *question*, and *guard* open none in either example's table. This is the rule meeting a real ontology on day one, which is good; it just wants an answer written down (non-claim: fidelity, "does the text indeed not claim it"? question: answered? guard: validity?), or the invariant softened to "every kind that carries assertions."

### 2.11 Smaller consistency items

- `README.md` says the outline has "a dozen plain words defined inline"; the outline has nineteen, and `log.kdl` says nineteen.
- `MODEL.md` §4 says the ontology declares each dimension "with five things" over a six-row table (the sixth, *passes along*, is optional per `dimension.md`; say so in §4 or count six).
- `model.outline.md` Part II lists *standing, bind, coherence, orphan, order·exception, delivery, planned·segment, gap·segment* among the dissolved, and the README says `MODEL.md` §12 "lists what was deliberately not carried and why"; §12 does not mention those eight.
- `verisectorium.md` defines "assembles the pieces into coherent wholes"; `MODEL.md` §1 says "into wholes." Small, but the def is the canonical one and the extra word is a claim.
- `frontier.md` lists seven item kinds, `MODEL.md` §7 six (see 2.2).

## 3. The examples, checked against their sources

I take the README at its word that these are the test. Anchors first, then what did not hold.

**`stopped-bound.md`.** Every anchor I checked is in the report it cites (`~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md`): `80b40d28` on 2026-04-22, `3d582e9b` on 05-16 with "(i)/(ii)/(iii′)/(iv) each exact," adjudication 628401's sentence, the "RESOLVED in canon — do not re-open" note, the verifier's 15:50 commit. The reading of the record through the model is persuasive and is the strongest page in the directory. Two things to carry over from the report: it explicitly says of its table, "**None of these is a recorded check in the vsect sense**; vsect's first version is 2026-10-30," while the example says "fourteen recorded passes." The example's §2 table does say "an act, *if recorded*," so the model-level point survives; the one-paragraph summary overstates the record. And "fourteen" is the example author's count; the report's table has fifteen rows, three of which say nothing about the stopped bound. Not wrong, but a reader who goes to the source will not find the number.

**`scope-adaptive-system.md`.** The act count is right: `vsect why segment:scope-adaptive-system` reports 162 acts. The example flags one claim as unchecked ("it needs the per-item diff of `40754025`, and I have only its commit message") and `MODEL.md` §10 repeats the claim with less hedging ("the forty-odd that read (b), (g), (g′), (h), (h′) and the housing result stay bound. That is a concrete, checkable difference"). I checked it. Four results:

1. **The narrow claim holds.** The final reword touched exactly two hunks of the file: item (c)'s lemma (π-system, Dynkin) and the Epistemic Status import sentence (Ferguson). Nothing else moved in that commit.
2. **The commit hash is not on `main`.** `40754025` is unreachable from HEAD; the same change, byte-identical in this file, is `4dd77b14` on `main`. A reader of `main` cannot find the hash the example cites.
3. **The example's statement of what vsect shows is wrong, and contradicts its own table.** The example says "every one of the 162 acts marked 'stale: own text changed' … the segment has been reworded since." `vsect read segment:scope-adaptive-system` today: 13 checks hold (✓), 50 lapsed (↻), 14 broken-open (⚠), 26 open questions. The 13 that hold are check 8's eight acts and five "A.1 round-7 integrator" confirmations, all recorded 10-31 at `9fde935e`, which is HEAD; the file has not changed since (last commit to it 2026-10-30 21:11 -0600, which *is* the reword, before check 8 at 03:28Z). The example's own table has check 8 confirming "on `9fde935e`," so the sentence after it cannot be right. The five round-7 integrator confirmations are absent from the example's table altogether.
4. **The "forty-odd survive" claim does not follow from the narrow claim.** Reread-1 read `12ea0186`, the pre-integration text; between that and HEAD the record passes through nine versions (`12ea0186`, `5e613630`, `26a703b0`, `48dd5554`, `55f592c5`, `85e9aebf`, `6e778ade`, `a8958128`, `9fde935e`). Comparing each lettered item's text at the pre-integration commit (`9ca09dbc`) with HEAD: (a), (d), (f) unchanged; **(b), (e), (g), (g′), (h), (h′) changed**. So under per-veritoid binding, reread-1's and check-4's acts on (b), (g), (h), (h′) lapse too, because those items were rewritten during the 10-30 integrations, not by the final reword. The acts that per-veritoid binding would keep alive are those recorded at the version just before the reword (`d13f592b`-equivalent) on items other than (c), and I did not do the version-by-version census to count them. The honest form of the result is "fewer than vsect lapses, more than zero, and the number needs a per-item diff per version pair," not "forty-odd."

None of this touches the modeling argument of the example (grain by adjudication; independence by producer; the Epistemic Status as four kinds of thing), which I found convincing. It touches the one quantitative claim the example makes about what the model would show that vsect does not, and `MODEL.md` §10 carries that claim to a reader who will not see the hedge.

One thing vsect already does that is worth noticing from the model's side: its dashboard line for this segment reads "a check narrowed it … ; its author typed status: axiomatic." That is a one-line instance of §2's "a typed status word is a written thing wearing computed clothes," already surfaced by the 0.1 tool against the live record.

## 4. What I could and could not build from this

Could: the table of §2; a schema with ids, versions, segments, slots, references with seen-versions, acts with reads/concerns/answers; the frontier as a recomputation. Could not, without a decision on each: which assertions compare with warrants (2.1); whether a cap is a warrant input or a violation (2.2); whether reconciliation is a write (2.4); how an author names a veritoid (2.5); whether a run is a check (2.6). Those five are the shortest path from "a model" to "a store an agent can write into," and I think they are smaller than they look, because each is a sentence in a def rather than a new term. The ten-term discipline held under this read; nothing I hit wanted an eleventh.

## 5. Scope and method, honestly

Read whole: every file under `core-2/`. Ran: `bin/defs check core-2`; `vsect why`, `vsect read`, bare `vsect` in asf; `git show`/`git log`/`git diff` on `01-aat-core/src/scope-adaptive-system.md`; a per-item text comparison at three commits. Read in part: the missed-error report (its §1, §2.1, §2.4 and the lines my greps hit). Not read: `core/`, `msc/notes/`, transcripts, `deriv-sector-condition.md` at any version, `bin/defs` itself. Not done: the version-by-version per-item census that would give the true count for §3 item 4; any check of the KDL blocks beyond what `bin/defs` verifies; any check of the examples' sketched AAT ontology against ASF's actual conventions. If any finding in §2 turns on something `core/` or the notes already settled, I would not know, and that is the first thing the authoring session can tell me.
