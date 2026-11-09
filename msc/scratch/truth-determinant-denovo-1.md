# De novo audit of `core/def/truth-determinant.md`

*2026-11-08. Opus 5.5 agent `a05e593c2bdfe6778`. For Joseph and the lead, ahead of deciding whether to accept the term.*

The file audited is the uncommitted working-tree version (`git hash-object` `b325dcd`). Others are working in this tree, so it may have moved since. `L23` means line 23 of that version, D3 is the third Discussion item, and WN2 is the second Working Note. Everything below comes from reading text and reasoning about it. No store has yet declared determinants, so none of this has been tried on real material.

## Bottom line

Accept the idea. Do not mark this text decided yet.

Giving a determinant two parts, an aspect and what the aspect is held against, is a real gain over the committed version. So are the separations from dimension, criterion and ground. The prose is clear for a cold reader.

Three things are wrong or undetermined in what the definition itself says, and accepting this text would lock them in:

1. The sentence defining "better" cannot produce what AAT calls better, and it conflicts with the decided «verisectorium».
2. "Held against" is doing two jobs, the standard and the instrument. Together with invariants 4 and 5 that gives wrong results.
3. Much of what is held against differs piece by piece, while the definition says determinants are declared once. It does not say how both hold.

Finding 4 is a decision rather than a defect: nothing yet reads a determinant. Findings 1 to 4 are what I would settle before acceptance. Findings 5 to 11 can stay open if they are written into the Working Notes; most are not there now. The small corrections at the end are cheap either way.

## Settle before acceptance

### 1. "Better" promises more than determinants can deliver

L19: "'Better', said of a verisectorium or of anything in it, means answering better to those determinants." There are four separate problems with this.

**AAT's own "better" cannot be derived from it.** The decided «verisectorium» says of AAT: "better is stronger claims more firmly established" («ontology» says the same). This file gives AAT validity against logic and reproducibility against runs (L39–40). A weaker claim answers to logic at least as well as a stronger one, since «theory⸱claim» defines strength as entailment. A store softened to tautologies would answer perfectly on those two determinants and so be the best AAT possible. Note 13, which this file cites, keeps the two apart: it has the "answers to" table and, separately, a `better` line per store, and says "'Better' has to be said per store."

**Determinants can only partly order the work.** WN2 (L54) says two determinants are "never combined into one score". That is defensible, but then one version is better than another only if it improves on one and loses on none. A clearer but less faithful explanation is neither better nor worse. «verisectorium» Discussion 4 says "That sense of better is what orders the work." A partial order cannot do that among options it leaves incomparable. (The committed version leaned the other way: "let the kind say how they combine.")

**The file now disagrees with «verisectorium» about what orders the work.** D3 (L31) says importance and who stands behind a choice bear on no determinant and yet "organize the work". The committed version had the invariant "Work ordered by anything else is somebody's mood wearing a number." The rewrite dropped that and asserts close to the opposite, without saying so. The new position looks more honest to me, but then «verisectorium» Discussion 4 needs revisiting, and that term is decided.

**"Answering better" has two readings.** D5 (L33) says "How far a piece has got is a «value»." But a value is what is *warranted*, and a true theorem nobody has checked is right and has earned nothing. If "answering better" means the content actually agrees more, then an independent re-derivation of unchanged text makes nothing better, and "more firmly established" is not better. If it means warranted agreement, then "better" is computed, and D2 (L30) says it is only plain English.

What would resolve it, in order of my preference: say that "better" is ordered only partly by determinants, and that each store states the rest in its own `better` line, as note 13 had it. Alternatively give AAT a third determinant for reach (completeness against what the theory undertakes to settle), which addresses the tautology case but not the other three. Either way the sentence wants to say which reading of "answering better" it means.

### 2. "Held against" is both the standard and the instrument

L17: "What it is *held against* says what settles that." Its list mixes what the content must agree with (logic, the world, a canon, a source, intent) with what checks agreement (a proof checker).

The word "settles" is already taken. The three regime defs say content differs "by which «truth⸱determinants» it answers to **and how it settles**" (my emphasis), treating those as two things. The outline's Part III has "way of settling" as its own pattern, listing derive, measure, machine-check and others. «ground» has "the instrument follows the ground".

The table shows the cost. L39 has AAT with validity against logic; L41 has a machine-checked theory with validity against a proof checker. Read those with the invariants:

- L25: "Agreement with one never stands in for agreement with another." So a passing machine check would be no evidence of validity against logic. Note 13 calls machine check "the strongest act on 'valid'".
- L26: changing a determinant changes what "better" means and is "usually a large" perturbation. So a theory that adopts a proof checker has changed what better means, when it has only gained a stronger way of settling the same question.

Note 13's table has the same mix, so L41 is inherited. The invariants are what make it bite.

What would resolve it: define held-against as the standard, and leave instruments to ways of settling and to ground. A store may still take a checker as its standard outright ("what Lean accepts"), but then that is a statement about that store and worth saying as such.

### 3. What is held against is often per piece; the declaration is once

L23 declares determinants "in one place, for the whole verisectorium". D4 (L32) says a determinant "stands for the whole verisectorium and outlasts any act or piece". But in the file's own words the thing held against is often different for each piece: "each claim's stated hypotheses" (L39), "the cited work itself" (L46), "a named source" (L17), "what it explains" (L54).

Read literally, "a named source" means one determinant per source, and replacing one citation is a large perturbation of the whole store. Clearly that is not meant, but nothing says what is. The table lists fixed standards and per-piece ones without distinguishing them, and an ontology author needs the difference.

WN4 (L56) makes it sharper: a question "answers to the same determinant as what it concerns". That makes the determinant depend on the piece's target, whereas L19 and L23 say the kind chooses.

The model has a likely home for this. A determinant could name a role ("each piece's cited work") that each piece fills through a «reference», which would tie it to note 13's `faithful-to` and `explains`. That is my reading, not something any file says.

The same gap leaves a determinant without identity. It has no name and is only its pair. So "change a determinant" (L26) cannot be told from dropping one and adding another, which matters for WN6.

### 4. Nothing reads a determinant yet

A determinant is a free-text pair. Aspect names are coined per ontology (WN7). "Better" is not a term. No def that computes anything (frontier, act, value as described in the outline) mentions determinants. The only checkable consequence today is that a kind lists at least one.

The tie that would give it work is WN3 (L55), that a dimension names the determinant it bears on, and that is open. Its wording is also circular: "every dimension that asks about rightness" is defined by bearing on a determinant. "Every dimension either names a determinant or is declared as organizing the work" says what is meant and can be checked.

A related gap: «act» says a ‹finding› says something is broken, with no criterion fixed beforehand. Broken against which determinant? A finding naming one would be a second place this term does work.

If WN3 stays open, acceptance accepts a term with no operational consequence yet. That may be fine, but it should be a decision.

## Can stay open, but should be in the Working Notes

### 5. Changing a determinant has no machinery, and the standard can move on its own

L26 calls a change a «perturbation». WN6 honestly opens what happens to acts. Beyond that:

- «atomic⸱changeset» holds segment changesets and acts. An act "never changes what is written", and an ontology is not a segment. So the write that L26 calls a perturbation has no place in the changeset it would open.
- «frontier»'s invariant lists what can be owed. A changed determinant is not among the items, unless a rule is written to raise one.
- A kind re-choosing among existing determinants changes what better means for its pieces and is not covered by L26.
- Each piece follows one version of its kind, so presumably pieces can be on different versions at once. During such a migration "the" determinants are ambiguous.

Not touched anywhere in the file: **what is held against can change while the determinant's text does not.** Intent shifts, a canon grows, a cited work is corrected, a simulator or proof checker gets a new version. Acts bind to what they read in the store, and these are outside it. The model has ‹outside⸱change› and note 11's def-state ("such as a simulator's version"), but this file does not connect to them. Intent is the hardest case: it is written nowhere, so it can only be read by asking someone, which runs into the outline's open "steward attestation" gap (how "it was Joseph" is attested).

### 6. Determinants attach only to veritoid kinds; several can only be answered by a whole

L19 speaks of "anything in it", but the only relation is `veritoid⸱kind answers-to`. «segment⸱kind» (no def yet) is not given one. Yet completeness is on the aspect list (L17). Coherence is in the table (L47), and the outline defines «coherence» as a *segment's* owned value. Effectiveness and "understood" (L48–49) are about `core/` as a whole.

The `{0,N}` on `answered-to-by` allows a determinant no kind answers to. It would change what better means while nothing could ever be asked about it. Perhaps that is exactly where whole-level determinants belong, but the file does not say.

### 7. The AAT rows fail the file's own test

If L39–40 are AAT's declaration, then under L23 ("adds none of its own") several AAT kinds have nothing to choose. Other defs and note 13 give AAT explanations (faithful to a claim, landing with a reader), proposed models ("adequate for a purpose by degree"), and definitions and assumptions ("captures its intent", "where does it hold"). WN1 says a store in that position has "found that its declaration was incomplete".

Probably the rows are illustrative, since AAT's ontology does not exist yet (`~/src/aat-v3/` has only `preparations/`). The table does not say so, and a reader will take these as AAT's list. Also, the world leads the Definition's list but no table row names it.

### 8. WN5's lean rests on a counterexample that is not one

WN5 (L57) asks whether at least one determinant must lie outside the store and leans no, "since a novel's canon is inside by design". That only shows one determinant can be inside. The same novel has "the author's intent" (L45), which is outside. Every verisectorium in the table has at least one standard the store's own writes cannot alter. So the file's evidence favors the rule, and a rule worth attempting is: at least one determinant is held against something no write to the store can change.

It would not settle note 16's question, though. AAT passes through logic alone and could still be honest and pointed the wrong way. The question there is about purpose, and no AAT row reaches purpose.

### 9. "Every kind answers to at least one" meets content that is meant to answer to nothing

«ground»'s third invariant makes a declared empty ground legitimate "for content whose value is that nobody repairs it (a sketch, a raw reflection)", and the outline makes sketches, ideas and anecdotes first-class kinds. WN4 considers questions and auditors' notes but not these, which seem the harder collision with L24. «verisectorium» Discussion 3 lists "authenticity" among the aspects and this file omits it; fidelity to what the author thought at the moment may be the answer.

Separately, WN4's reason, that a question "can be right or wrong", does not hold for questions. A question can be apt or misposed. A regression guard does assert something, so it is fine.

### 10. The regimes rest on this term and it never mentions them

«theory⸱claim», «empirical⸱fact» and «proposed⸱model» say content falls into two regimes "by which truth determinants it answers to", and that this "is about what content can answer to at all". This file does not mention regimes or say whether agreement with a determinant is yes-or-no or by degree. That property seems to belong to the determinant, and it decides what "better" can mean for it.

### 11. "Aspect of truth" does not cover "effective" and "understood"

A false-but-clear text can be understood, and a true text can fail to be. L49 has an aspect of "understood". This is plainly intended (the decided «verisectorium» Discussion 2 includes instilling a mental model), but D1 argues only across branches of truth, so nothing here owns the extension to fitness for use. A sentence would do, and it would also sharpen the `avoid "fitness function"` line, since effectiveness against what is built from it is what many people would call fitness.

## Invariants that their own Working Notes call open

L23 and WN1 (L53) state the same rule, one flatly and one as "Open. Lean." L24 and WN4 likewise. A reader cannot tell which is true. On acceptance WN1 should close, and L24 should be either settled with finding 9 or marked.

## Small corrections

| Where | Issue |
|---|---|
| L3 | `synonyms "truth aspects"` names one half of a thing L17 says means nothing in halves. |
| L5, L32 | "stands for the whole verisectorium" reads as "represents". "Holds for" or "is declared for" seems meant. |
| L32 | "outlasts any act". Acts are in an append-only log, and WN6 exists because acts can outlast a dropped determinant. |
| L24 | After "Every kind answers to at least one", "Content that answers to none … not content" has nothing to refer to. "Material that answers to none" would work. |
| L26 | "usually a large one" is a tendency, not an invariant. It may belong in Discussion. |
| L29 | "The word also ties to the *veri*": which word? "Truth" does; "determinant" does not. |
| L31 | "Independent re-derivation" is a rung, not a dimension (notes 09 §2.2 and 11 give the derivation ladder as "sketch, drafted, premises checked, independently re-derived"; «property» and «act» use it the same way). The example needs a different pair. |
| L31 | "Who stands behind a choice" bears on none: true for validity, but where the standard is someone's intent (L43, L45), their standing behind it is the evidence. |
| L47 | Two aspects in one row, against L22 and L25. «verisectorium» Discussion 2 counts them as two. Also "the model itself" as the standard for coherence is close to circular. |
| L49 | Stray adjective among noun aspects. |
| L46 | A citation manager is a tool; its library is the verisectorium. Also «empirical⸱fact» calls this same association "never simply true", while "factual correctness" reads as yes-or-no. |
| L54 | "An explanation answers to what it explains and to a reader" names two standards and no aspects, against L22. |
| L54 | "the fusion «dimension» forbids": «dimension» has no def. The rule is stated in note 11's draft as "a scale whose steps are combinations of two other scales' steps", which is near this case (a score combining two determinants) but not it. |
| L56 | "those two defs" should be three: the same sentence is also in «veritoid⸱kind»'s Intro. |
| L58 | Cites untracked `rowan-ash-research.md`; commit it together. Its §5 speaks of dimensions and acts, not determinants, and calls itself inference, so "does not answer this" is an extension of it. |
| `ontology.md` | The working tree adds `rel declares truth⸱determinant`, but its one-line definition, Intro and outline row still list only kinds, dimensions, reference kinds and moves. A cold reader of «ontology» never learns it declares these. |
| Body prose | Bare "determinant(s)" throughout; it is not a declared synonym. |
| Word "aspect" | Now load-bearing. It was a model term meaning an ontology extension until `fe6631e`, still has that sense in note 13 and the Rowan research, and note 11 put it on «dimension»'s avoid list. Plain English is fine, but one sentence would prevent the collision. |

## What I checked and found sound

- `bin/defs check` passes (29 terms, 63 relations). Its pass means «dimension», «criterion», «value» and «inbox» resolve only to provisional outline rows. None has a def, so D3–D5 currently distinguish this term from outline descriptions.
- The one-line definition matches the outline row. Cardinalities agree with «verisectorium», «ontology» and «veritoid⸱kind».
- D4's statements of criterion and ground match those terms.
- Citations hold: note 13's lens and its pedagogy question; note 16 question 3; the rename in `core/log.kdl` (2026-11-07); `bound.md` does list "which of two conflicting things yields".

## Scope

I read the target first, cold, then the repository layout, the READMEs, the outline, the log, and the diff against the committed version. Then, whole: `ontology`, `veritoid⸱kind`, `verisectorium`, `veritoid`, `content`, `perturbation`, `bound`, `ground`, `act`, `empirical⸱fact`, `proposed⸱model`, `theory⸱claim`, `data⸱store`, `steady⸱state`, `property`, `claimed⸱level`, `accepted⸱remainder`, `frontier`, `atomic⸱changeset`; notes 13, 14, 16; the Rowan research; note 11's dimension and verisectorium drafts.

Read in part: note 09 (§2.2, §4.6), note 12 (its end). Searched only: the other notes, the kernel spikes, `aat-v3`. Not read: the top-level `.archive/`, the kernels, the remaining defs (`affirmation`, `log`, `reference`, `segment⸱changeset`, `state`, `steady⸱time`, `version`, `work⸱time`, `working⸱state`), and the earlier audit at note 10, which I left alone to keep this read unprimed. I read handoff 17 (`msc/notes/.archive/`) only after the findings had formed.

Two adjacent items, outside this file: the outline legend still describes the retired `«TERM»` capitalized first mention; and `bin/defs` strips the outline's preamble with a pattern for `## I.`, which stopped matching at `## Part I`, so the legend now gets checked too (harmless at present).
