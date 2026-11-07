# De novo read of `model-and-lexicon.md`, 1

*From a fresh Opus 5.5 agent, 2026-11-05 (evening), for the Fable session that wrote the document. It is meant to be weighed before Joseph reads the document tomorrow. I read the document whole and cold first, and took my notes before opening any source. Then I checked its attributions against the sources: the building-blocks dialog (whole), Joseph's extracted messages (whole), his short aat-v3 messages from `~/.claude/history.jsonl` (the extract leaves out anything under 150 characters), PLAN (A0–A2 and targeted passages), RC1 (targeted passages in 02, 03, 06, 07, 08, 10, 11 and 95), the Appendix A feedback report (targeted), and the first version's Part 9. I did not read `plan-review-1.md`, `knowledge-graphs.md`, the other reading notes, or the address theory. The findings below are the content of this report. Where it says nothing about a section, that is not a verdict that the section is sound.*

---

## The short version

The document's strongest move is the work-time and steady-time split, together with the worked example in 4.2. The example is the most useful thing in the document because it can be checked. Several of the problems below came out of running the rules against it. The provenance marking is mostly accurate: I checked about forty [J], [RC1], [PLAN] and feedback-report attributions, and the few that are off are listed in §3.

Five problems seem to me to go to the model itself rather than to its wording. I would want each resolved, or explicitly named as open, before Joseph reads from the top:

1. **There is no place for a *claimed* level, and the frontier depends on one.** (§1.1)
2. **"State" is too thin to support "every value is computed from the log as of a state".** (§1.2)
3. **There is exactly one working state, and Joseph raised concurrent work himself.** (§1.3)
4. **Under the rules as written, every change lapses the coherence of every enclosing projection, up to the theory.** A steady state would then be unreachable short of re-reading everything. PLAN had the fix, and the document dropped it. (§1.4)
5. **Veritoids have only positional addresses, yet split and promote are said to disturb nothing.** (§1.5)

---

## 1. Problems in the model

### 1.1 A claimed level has no home, and the frontier, completion and softening all run on it

The document makes a clean rule: values are computed from the log and never typed (2.2, Part 8). Then the machinery of Part 4 needs something that *can* disagree with a computed value:
- 4.3's frontier includes "things claiming a level above what their premises now allow";
- 4.3's completion test is "every claimed level is either re-earned or honestly lowered";
- 2.5 asks "can this still be called a theorem?";
- 4.4 speaks of softening a claim and of keeping "the earlier level".

A computed value cannot be over-claimed, because it *is* what was earned. Once a check lapses, the value has already dropped. So "honestly lowered" has no referent unless something other than the value asserts a level. "Level" is used throughout 2.5 and Part 4 and is never defined; it is not in the lexicon. It is sometimes a position (2.5's "at least independently re-derived") and sometimes an epistemic label like "theorem".

PLAN had the concept. A2 asks of a content change "does it still earn what it claims?", and its adjudication "discovers that claimed and established standing have come apart". The document dropped "claimed" along with PLAN's "standing".

The candidate homes I can see, without having tested any of them:
- **The claim is content.** The text says "Theorem" or "exact", and a consistency rule of the form "asserted label ≤ computed ceiling" puts a mismatch on the frontier. This fits Joseph's "can this … be a theorem anymore?" most directly, and ASF's five label surfaces (feedback report, finding 1) are all claims of this kind.
- **The claim is a bound** (3.4: "what this content is allowed to assert"). But a bound is "simply stated", and the document never says by whom or how it changes.
- **The claim is only a downstream requirement**, a predicated-on pointer "at re-derived or better". This is the only kind of claim the worked example uses, and it can't express "this calls itself a theorem".

Whichever is chosen, softening (4.4) becomes the act of changing the claimed level. At present the model can't say what softening changes.

### 1.2 State = "which version every veritoid is at" is not enough to compute values from

The document's definitions conflict with each other here:
- **Acts change values without changing content.** Part 9 #6 says a confirming check is an atomic changeset of size one that "changes a value and no content". But a state is only veritoid versions, so S and the next steady state are the same state with different values. "Computed from the log as of a state" can't then be a function of the state.
- **Time and external versions move values with no act.** 3.1: "a simulation result expires when the simulator's version moves on". 2.2: rule firings over attributes such as age. Then "steady: … no rule would fire" (4.3) is a property that decays with the clock. Every steady state containing a time rule eventually stops being steady while nothing happens. 2.2 also says a rule firing "is recorded like anything else", which makes the value a function of the log after all. Both can't hold unless the firing is an act by someone or something, at a definite moment.
- **Definition versions are recorded but not part of state.** 4.6: each veritoid records "which version of its kind it follows".
- **Reference changes may not be part of state either.** If pointers are values (§1.6), changing one doesn't change any veritoid's version.

PLAN carried the missing piece as eras (A2: "a calibration update is an era … the change is an event, not drift"). The document mentions the simulator case but drops eras as an object. I'd suggest a steady state be indexed by a position in the log, with content versions, the definition version and eras all derived from that position. "Steady" then also needs an "as of" for the clock-driven rules.

### 1.3 One working state, while many minds work at once

3.1 defines *the* working state as "the last steady state plus whatever has been staged so far", and 4.3 moves the store only by complete atomic changesets. With many minds working (Part 1's own definition of a verisectorium), the questions this raises are not storage questions:
- **Two unrelated perturbations at once.** Must they become one atomic changeset? If not, which working state does each act belong to?
- **What "belongs to that step" means** (3.1, item 3). Suppose an agent confirms an unrelated segment at 10:00 in the 4.2 example. Is that act in T's atomic changeset? Does it wait for 14:00?
- **The steady line may rarely advance.** If the store is almost always in some working state, steady states could become rare.

Joseph raised this himself on 11-05 (16:11 local) and deliberately punted it:

> *"When two repose both have non-git-conflicting atomic-changesets merged into their main and try to combine-- is the union also known to be stable / internally coherent?? This is way too big a question for us to answer though right now"*

He also said (15:53) that "a subgraph or single instance can get quite a bit of work done on it independently / in parallel with 'canon'". The document mentions neither. Its single working state quietly answers the question he left open, by excluding concurrency. I'd at least list it beside 4.4 as the second open question this picture sharpens, in his words.

### 1.4 Projections make every change lapse the whole theory's coherence

As written:
- a projection is a segment whose own dimension is coherence (2.6);
- coherence is moved by a whole-read act that "binds to the exact versions it read" (3.1, 4.1);
- the frontier includes "checks and whole-reads that no longer bind" (4.3);
- the atomic changeset is complete only when the frontier is empty or accepted.

So a change to any segment lapses the coherence of its chapter, part and volume, and of the theory. Steady is then unreachable without re-reading all of them. The 4.2 example reaches "Nothing owed" only because it doesn't mention the projections that hold T and U.

PLAN had two pieces that prevent this, and both are missing here:
- **Upward lapse is a declared rule, not automatic** (PLAN A1: "Without that, every edit would lapse the whole theory").
- **A check can bind to a value it read, not only to text** (PLAN A1: "If it read a section's standing, a change of standing does").

The document's binding is to versions only, so a chapter read that cared only about each segment's headline claim and its credence band has no way to say so. This is also the concrete form of RC1's open question 7, "what is the projection rule upward". 2.3 says Joseph's aliased/derived/own answers that question. It answers how a segment's values come from its veritoids, but not how lapse travels up through projections.

### 1.5 Veritoid identity: positional addresses, and split and promote said to disturb nothing

2.4 addresses veritoids as `name#slot[i]`, and Part 7 has a veritoid belonging to exactly one segment and slot, with no identity of its own. Meanwhile 2.5 says pointers target specific veritoids, and 2.3 and 2.4 say split and promote disturb nothing that points in. These don't fit together:
- **Split shifts every index after it.** If `derivation[2]` is split in two, what was `derivation[4]` becomes `derivation[5]`, and pointers to it now reach the wrong step.
- **Split doesn't say who inherits.** When one veritoid becomes several, which of them do existing predicated-on pointers now reach: all of them, one, or none until re-pointed? Do checks that bound the old version bind to none of the pieces? (Presumably none, but it should be said.)
- **Promote moves a veritoid out of its segment.** If the moved veritoid keeps its identity, then identity isn't `name#slot[i]`. If it doesn't keep it, "everything that pointed at them keeps working" is true only through the pointer left behind, and only for addresses that go through the old slot.

The dialog left exactly this open ("An atom's identity: derived or minted?", councils-46's question 1 at 21:53Z), and Joseph did not answer it. The first version's one-type model answered it; withdrawing that model reopened the question, and the document doesn't list it as open. Address theory may already settle it, and the document says it hasn't read address theory.

Promote also strains two other definitions:
- **Pointers in ordinary segments.** "Their old place now holds a pointer to it" puts a segment pointer in an ordinary segment's slot. That contradicts 2.6 and Part 9 #2, where a projection differs from a segment *only* in that its slots hold pointers.
- **Two segments in one changeset.** Promote creates a segment and empties a slot in another, inside one changeset. That contradicts 4.1's "the veritoids of one segment". 4.1's list of what a segment changeset may do also includes "create new segments".

### 1.6 Are references content or values?

2.2 makes a reference a kind of dimension and therefore a value: "never typed in by hand … computed from what has been recorded". 4.1 says "values are not the author's to set". Yet 2.5 has a pointer that "someone declared … on a date", and 4.1 lists "change pointers" among what an author's segment changeset does. In 4.2, changeset 3 is what rebinds U's pointer.

I think pointers are plainly content in this model: authored, versioned with their veritoid, and reconciled at once under the write rule. What is computed is whether the pointer still holds, its "bound to c2" status. Saying that would also fix 2.5's "a pointer is a value like any other", and would put pointer changes inside "state" (§1.2).

### 1.7 Weakening versus refuting: the worked example contradicts the classification

2.5 follows RC1 06: a *weakened* premise ("narrowed, or dropped a rung, or its credence fell") means "nothing downstream is thereby wrong". The 4.2 example is a narrowing, though: T's claim gains hypothesis H. And it makes U's claim wrong as stated: "U's claim follows only if U also assumes H". So narrowing can attack a downstream conclusion. RC1 itself says why in its "honest residue": partial dependence on one clause of a premise "requires grain on the edge". The classification needs a third case, or "narrowed" needs to move to the hard side whenever the dependent used the part that was cut away.

Related, and about the mathematics: the "one formula, roughly" says a conclusion is "*at most* as credible as all its premises holding together times its own derivation being valid", and that refuting a premise "sets the first factor to zero". As probability this runs the wrong way. P(premises ∧ valid) is a *lower* bound on P(conclusion), the support this line gives; a refuted premise leaves the conclusion unsupported, not false. The refuted bullet just above it says this correctly ("until it is re-derived without the premise **or falls too**"). Read literally, the formula sets the conclusion's credence to zero, which is denying the antecedent. A single credence number also can't tell *unsupported* (back to some prior) from *refuted* (near zero) unless the prior is explicit. That distinction matters to Joseph's "known-broken" case.

### 1.8 Content changes: the document's all-or-nothing drop versus Joseph's lowered certainty

4.1 quotes Joseph (11-04 20:24): a content change "would automatically lower the certainty which would effectively trigger the two sides of the adjudication at the same time". The document realizes this as binding. Checks that read the old version simply stop counting, and in 4.2 the derivation drops at once to "drafted". Joseph's next message (20:35) imagines something graded and shaped: "a content change decreases certainty-- but shaped more heavily toward a lowering of the epistemic value rather than equal chance that it rises".

The split between position and credence can carry both. Position honestly drops to "drafted" for the new text. But credence need not fall to the prior, because evidence about c1 is some evidence about a minimally reworded c2. As written, lapsed checks contribute nothing at all. That is a modelling choice and could be the right one, but it shouldn't sit under his quote as if it were his model.

### 1.9 Removing surface: the model has operations that add structure and none that take it away

Part 1 sets the model the job of making "nothing was ever retired" impossible or visible. Part 5 retires sources. Inside the store, though, the structural operations are split, promote and create, which all add surface. There is no merge (the inverse of split, for when two veritoids turn out to be one claim, which `restates` can detect), no demote (the inverse of promote), and no removal of a veritoid or a segment. "Supersedes" and the bound "do not revive" mark old things, but they don't remove them. I'd at least say how a refuted stand-alone result, or a redundant restatement, leaves the store's present truth.

### 1.10 Role separation and the second sprint failure

Part 6 says the second failure (fixes generating findings generating fixes) is addressed by binding, by "the same mind that revised does not confirm", and by the frontier. Joseph's own account of its cause was different, and it was about role *turnover*:

> *"we have reinforcement feedback loops when we do things like wrong integrator agent after a verification pass with a new mind--- causing almost half of our 'fixed' claims…"* (11-02 18:54)

> *"Why does a new integrator land the independent checker's findings instead of the original integrator? That seems extremely wasteful and prone to error"* (10-30 21:44)

So the cause he named was a fresh mind integrating verification findings. The remedy his remarks point to is continuity: the original integrator lands the checker's findings. The three mechanisms the document names are fine, but none of them speaks to that cause, and "revisor ≠ confirmer" is orthogonal to it. 3.5's closing remark, that role separation is the only constraint of this sort ASF has needed, is accurately quoted from the feedback report. Next to Joseph's diagnosis, though, it reads as if separation were the lesson, when part of the lesson was an over-applied separation.

### 1.11 Smaller model points

- **Where certainty lives** (2.2). "Certainty is kept apart from the value", but the next sentence makes credence and the judged-value spread "three forms a value can take", and Part 8 says "certainty" loosely covered all three, position included. Joseph's first objection to PLAN (11-04 20:06) was this exact slip: "you talk about how you can't conflate the label with its separate certainty-level-- even though the example you give looks like it's doing exactly that". He will be reading for it. I'd say plainly that a value *has* a certainty, and that credence and the spread are how that certainty is held for two of the forms.
- **What the auditor's finding is** (4.2). The finding that starts the example doesn't fit the three recorded sorts. If it's recorded as an act at, say, 08:30, then S0 is no longer steady, because something is "known inconsistent". If it isn't recorded until A's changeset, it was unrecorded work, which 3.1 calls dishonest. 4.3 defines a perturbation as a segment changeset, while Part 8 says "segment changeset or act". This is 4.4's open question appearing inside the example, so the example is a good place to show it.
- **What the 4.2 table leaves out of the frontier.**
  - Changeset 3 replaces u1 with u2 by C. Any check that read u1 lapses, and the whole-read at 14:00 is the only act on u2.
  - Fidelity checks on e1 that read c1 lapse too, despite A's affirmation.
  - k2 is new.

  "Nothing owed" holds only if U had no evidence of its own and nothing outside T and U narrates either. I'd state that closure, or add the rows.
- **B's 11:00 check.** B passed d2, which contained the error A fixed at 11:30. That isn't neutral record about B, as the example says. It is evidence of a miss, which is just what calibration needs (PLAN A2's Dawid–Skene subpopulation).
- **Wording in 4.2.** "B has independently re-derived d1 from c1": the derivation establishes the claim, so it should probably be "re-derived c1 by way of d1". The example also leaves unclear which veritoid holds the "re-derived" position, the derivation or the claim. U's pointer is on T's *claim*, yet the position belongs to the derivation. A rule saying how a claim's evidence position comes from its derivation slot is missing.
- **Decisions as acts.** 3.1 and Part 7 list "decision" as an act, but 3.3 gives a decision four dimensions of its own. Acts don't carry values in this model. The 3.3 table resolves it for decisions about the subject itself, which are veritoids, but not for the other three rows. "A routing note with an expiry" has no place among the recorded sorts at all.
- **Standing versus independence** (3.5). "A check by the author … does not count as independent" is about independence weight, not standing, which the section defines as binary.
- **Joseph's own standing.** CC_AGENT gives the main session's key as the session itself. An act recorded from Joseph's main session can't be told apart, by harness identity, from one the main-session agent made on its own initiative. "Only you may record a decision as *ruled*" therefore needs some attestation channel the harness doesn't yet provide.
- **Independence between same-model checkers.** 3.2's default is that two lines share a source unless shown otherwise. Nearly every checker here is the same model family. What, if anything, makes two Claude instances independent lines? Joseph set this aside for *councils* (11-03 12:41), but for evidence combination it carries weight.
- **The inbox.** Part 5 calls it "a slot", but slots hold veritoids or pointers, and Part 7 draws the inbox separately from the slots. Chunks belong to sources: what is the source of a note written straight into an inbox?
- **"Found everything"** (Part 5). Per-chunk crossings answer the first sprint failure only if the chunks *partition* the source. If a reader cuts chunks only around what they noticed, then "every chunk has a final crossing" is still "found something". I'd state exhaustive cutting as an invariant.
- **Dimensions that grow into kinds.** Joseph asked for this directly on 11-04 (18:46): "novelty" starting as a soft label and becoming a rule-backed assertion, then an auditable value, then a kind of its own with content and freshness. The document doesn't take it up. The model can express it, as a definition change (4.6) that adds a novelty-assessment slot and aliases the segment's novelty dimension to it. Showing that would answer a question of his directly.
- **The recursion moved rather than disappeared** (Part 9 #1). The recursion now lives at the segment level, as projections of projections. "Two levels, and only two" is true of veritoids and of what a segment changeset touches, but not of the structure as a whole. I'd say which.

---

## 2. Internal consistency and wording

- **Promises in the header.** The header says each word is introduced before it is used. It isn't quite so:
  - **store** is never defined in the body (first use at line 36);
  - **segment** appears at line 52, before 2.3;
  - **dimension** appears in 2.1 before 2.2;
  - **level** is never defined (§1.1);
  - **sink** appears once (3.3) and never again.
- **"Written as one act"** (2.3, 2.6). "Act" is a defined term that the lexicon says is "not a change of content". Here the meaning is a segment changeset.
- **Crossings per chunk.** Part 5 says each chunk has "exactly one current crossing"; Part 7 says "at most 1".
- **What steady means.** 4.3 defines steady as "nothing is known to be inconsistent", but a steady state may also hold what has been "explicitly accepted" (4.3, Part 7). The definition should include the accepted remainder.
- **Which dependencies the write rule follows.** The rule says "every veritoid that depends on a changed one". The inner dependencies are declared on the segment kind (2.3), while predicated-on pointers are per-veritoid values (2.5). It should say which the rule follows, or both.
- **What "reach" means for orphans** (2.6, Part 8). The direction isn't given. A top-level result that depends on others, with nothing depending on it, isn't an orphan in the intended sense, but "reached by no dependency" could be read to make it one.
- **The 3.3 example.** "Sending two spans of an influx file to a sink" is filed under "one veritoid's state", but spans are chunks. Joseph's category (11-04 18:14) was wider: interior routing decisions. He also said the line between interior and domain decisions blurs when the project *is* the store, as with ASF, and the table drops that caveat.
- **The argument against PLAN** (2.4). It says PLAN's rule "silently detaches everything downstream". PLAN's rule links the new record by `supersedes` (A1), which is one of the document's own references, so the detachment isn't silent. The real difference is which side does the work by default: a pointer that keeps following a changed meaning, versus one that stays on the old meaning and is flagged. The OBO rule exists because the first case can quietly carry a pointer onto a claim its author never saw. I'd give that argument its full weight before overruling it.
- **Wording of the lift** (4.6). It wrote "six sub-headings". The feedback report says six *slots* (Candidate Brief … Belongs elsewhere) plus an Off-ramp, so near enough. "Retired none" in Part 5 is, in the report, "retired zero *sources*", not items.

---

## 3. Fidelity to sources

**Checked and accurate** (verbatim or fair paraphrase, at the stated date):
- Joseph:
  - the capitals rule;
  - "almost half";
  - slugs and the mapping;
  - certainty kept apart;
  - the sort by what builds;
  - attributes and threshold rules;
  - the nesting of coherent levels;
  - interior and domain decisions;
  - "who has standing";
  - the session id as actor;
  - "set-asides";
  - liveness;
  - several mechanisms per queue;
  - the Working Notes quote;
  - instance-isolated changesets;
  - latent levels;
  - "known honesty";
  - the canonical grouping;
  - orphans;
  - the dependency graph as distinct from projecting groups;
  - "holistic-enough";
  - "legitimately mixing";
  - turtles;
  - slots with cardinality above one;
  - intertwined fates;
  - the gradient of kind changes;
  - the ladder-type predicate left open;
  - storage left undecided;
  - "rebut versus undercut";
  - "practical sequence";
  - "projection" confirmed (19:24, "Spot on … totally on board").
- RC1:
  - the "intuitions and tentative results" quote (08);
  - "immediately, visibly" (06);
  - the open depth and upward question (10 Q7, and 03's "unresolved");
  - licence → bound and foundation → ground;
  - the fusion tell (values paraphrased);
  - placement for influence (07);
  - silence versus overclaim (08);
  - cardinality and empty results (06);
  - events on one record only (02), and the field trial's multi-record gap (95);
  - projection as "any computed summary" (02);
  - authority rungs up to *ruled*;
  - weakened as undercut (06);
  - edge kinds earning their place by being routed differently (06).
- PLAN: OBO identity, testimony, the three value forms, cycles as grain defects.
- The feedback report: roughly 2,000 items disposed of, the 120-segment lift, and the remark that role separation is the only mover constraint ASF has needed.

**Off, in decreasing order of how much I think it matters:**
- **Part 1's flow diagram, marked [J, 11-03], drops a word from Joseph's.** His diagram ends "Mental Models/**Projections**/Pedagogy/Implications". The document's ends "mental models, pedagogy, implications". He used "projections" there in the rendering sense, and again on 11-04 ("v2 starts projecting into aat-v3 … the right projections and reports / dash"). He confirmed the new sense on 11-05, so the redefinition is legitimate. But a quotation marked [J] shouldn't have been edited silently to avoid the collision. I'd keep his word and note the shift.
- **Part 9 #1, "This is your model."** When he read the first version, Joseph said of its #1 and #2: "With #1 and #2 I'm still not sure" (19:24). At 18:50 he leaned toward keeping the recursion in the mathematics: "It might be wise to model it mathematically even if as a practical matter … there is a *practical* granularity". Two levels is a defensible choice, but it is the author's resolution of his uncertainty, not his stated model.
- **2.3, aliased/derived/own, "[J, exactly as you said it]".** His words contain all three ("often via aliasing … plus derived and plus its own that apply to the whole"). Naming them as a three-way division, and the examples (freshness as the minimum, coherence as the segment's own), came from councils-46's reply at 21:53Z. "Exactly as you said it" is stronger than the source.
- **2.5's quotation in quotation marks** reads "an array dimension from a claim atom to other instances' claim atoms". His words were "an array dimension from a 'claim' atom to those other instance's claim atoms". The meaning is the same, but it is a paraphrase inside quotation marks.
- **4.1's attribution.** Joseph's 20:24 quote is attached to a binding mechanism he didn't describe (§1.8).
- **Part 6's date.** "Importance fixes how much agreement is required [J, 11-03]": the clearest statement is 11-04 12:52 (a charter "depends on which axes are being adjudicated and therefor what kind of consensus is required"). 11-03 15:06 carries the importance-and-unity half. A minor point.

---

## 4. What I would keep exactly as it is

- **Two kinds of time.** The statement and the 4.2 table format, with a work-time column and a column for what is still owed, are the right instrument for this model. I'd add rows rather than prose when fixing §1.4 and §1.7.
- **The 4.1 split.** Content is reconciled at once by the author, and values come back one act at a time. It turns Joseph's "fully coherent and reconciled and correct" into something checkable without demanding instant independent review, and the affirmation as an attested act that never counts as independent is well judged.
- **The inbox outside the segment's state.** It is grounded in a measured cause, not taste.
- **The reference table's column "does anything pass along it?"**, with RC1's admission rule.
- **The ground declared at creation.** "Not open" becomes a recorded fact rather than a gap.

---

## 5. What this read did not cover

- I didn't check the address theory, `knowledge-graphs.md` or `plan-review-1.md`. Any of them might already resolve §1.5 or §1.7, or contradict them.
- I didn't trace 3.2's and 3.4's RC1 attributions beyond the passages named in §3.
- I didn't re-derive any of the credence mathematics beyond the direction of the bound in §1.7.
- I read only the first version's Part 9 and the opening of the correction note, to place Joseph's "#1 and #2" remark.

I'll stay on the line for follow-up questions.
