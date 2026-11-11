# The model, as I currently hold it

*To Joseph, from the Fable 5.2 session of 2026-11-10. You asked for this at the level, register and length of note 09, or shorter, with the newer words and the newer understanding. It is my synthesis, not a settled design, and nothing in it is accepted. It is about a third the length of note 09.*

*It is written to be read top to bottom. Each word is introduced before it is used. Part 7 is the lexicon. Part 8 says where I chose, what is open, and what from `core/` I have left out on purpose.*

*Where each idea comes from (yours, with the date; note 09; today's tests; or mine and least tested) is in the footnotes, so the text reads straight through. A footnote says where an idea came from. It is not a reason to believe the idea, whoever it names; Part 8 says what, if anything, each part has earned.*

*What this is not: a summary of `core/`. Core today is larger and finer-grained than this, and you have said why that is a fault. This note is what I think the model is at its real size. If you agree with it, core should be cut back to it.*

---

## Part 1. What a verisectorium is for

A **verisectorium** is a place where material is cut up until each piece can be right or wrong on its own, the pieces are adjudicated, and they are put back together into results that other people read and build on. It is worked on by many minds who each arrive knowing nothing about it.[^1]

The work goes like this, over and over:

1. **Bring in.** Material arrives from outside what is settled: a paper, an audit, a spike, an old file, a mind's note. This is **influx**.
2. **Cut and place.** The material is cut into pieces, all of it, and each piece is put somewhere: into something that exists, into something new, or set aside with a reason.
3. **Adjudicate.** Questions are asked of each piece, and each answer is either found out or decided.
4. **Stabilize.** Anything new, and anything found wrong, leaves some things inconsistent with others. Work goes on, by whatever route, until everything is consistent again.
5. **Build on.** What is consistent is what others read, cite and build further results on. Then something new arrives.

Three things the October sprint showed that the model has to make impossible or at least visible[^2]: nobody could tell "found everything" from "found something"; checks and fixes fed each other; and no source was ever retired. And one rule[^3]: nobody edits a verisectorium by hand. Where the tool cannot express a change, that is how we learn what it lacks.

One example runs through the rest: a derived result with a formal claim, its derivation, a description, and an "explain it to an eight-year-old" paragraph.[^4]

---

## Part 2. What exists

### 2.1 Pieces of content

The smallest thing is a **veritoid**: one piece of content of a declared **kind**. A formal statement, a step of a derivation, a paragraph of explanation, a question, the wording of a design choice. A kind says what form the content takes and which questions may be asked of it.[^5]

### 2.2 Assemblies and slots

A veritoid almost never makes sense alone. An **assembly** gathers pieces: its kind declares **slots**, each saying what kind of thing fills it, how many, and whether it is required.

```
assembly kind  derived-result
  slots, in order:
    formal-claim   one         claim
    derivation     any number  proof-step
    description    one         explanation
    eli8           at most 1   explanation
```

A **segment** is either a veritoid or an assembly. So one thing does the work at every depth: a result is an assembly of veritoids, a chapter is an assembly of results, a theory is an assembly of chapters.[^6] In practice a verisectorium uses a few depths.

A slot is filled in one of two ways. An assembly **holds** a segment that lives in it and is written with it, as a result holds its claim. Or it **points at** a segment that lives elsewhere, as a chapter points at a result. An assembly that mostly points is a **projection**: a chapter, a volume, a reading path, a paper. One projection is **canonical**: it says "this is the work, in this order".

A slot that is not filled is in one of three states[^7]:
- **suggested**: someone thinks something might go here. It commits nobody.
- **promised**: someone in the work has said this will exist.
- a **gap**: something is missing and it is not yet known what.

Kinds also declare **inner dependencies** between slots: the eli8 depends on the description, which depends on the claim. They are why the pieces of a result have to be looked at together when one of them moves.[^8]

### 2.3 References

A veritoid points at other pieces. A **reference** is written by an author and can be wrong. The main one is **predicated-on**: this claim needs that one. Others exist only where something treats them differently: **narrates** (this talks about that), **restates** (these must agree).[^9]

One piece **rests on** another when it is predicated on it, or names it as a hypothesis. Holding and pointing are not resting: a chapter does not become doubtful because one of its results is being repaired. It shows the result's state.[^10]

### 2.4 Identity and versions

Every segment has an **id**, made once and never reused. A freestanding segment also has a **name**, which may change. When a piece is split, merged or replaced, the old id is retired and the new ones record which they descend from, so nothing that pointed at the old one is silently redirected.[^11]

A **version** is one written state of one id. Versions are never changed. Rewriting a piece makes a new version of the same id; the old version is still there, and still exactly what it was.

---

## Part 3. Questions and answers

### 3.1 Dimensions

A **dimension** is one question that can be asked of a piece and answered independently of the others. Does it follow from its premises? Do the numbers reproduce? Is it faithful to its source? Does a reader come away with it? Who stands behind this choice? Two things that can move independently never share a dimension.[^12]

The ontology marks some dimensions as **determinants**: the ones that say what being right consists of for this verisectorium.[^13]

### 3.2 Two kinds of answer

Every answer is one of two kinds, and everything else is built from them.[^14]

A dimension is **found out** when its answer is a truth claim about the piece. It stands by **evidence**.

A dimension is **decided** when its answer is a choice someone made. It stands because that someone stands behind it.

They rest on each other. A decision's grounds are truth claims. Every piece of evidence is at bottom something someone or something attested, and where the chain of "and what supports that?" stops is a decision. A measurement is an instrument attesting a truth claim. An automated action is a decision made in advance.[^15]

### 3.3 Evidence is about a version

A piece of **evidence** says: this piece, at this version, asked this question by this criterion, was found to hold, or to fail, or to hold in part. It also says what else was read to find that out (the derivation; the premises).

Because a version never changes, evidence about it never stops being true. What can change is whether it has anything to say about the piece as it is now. If the claim has been rewritten, evidence about the old wording says nothing about the new one, unless someone has found that the two wordings are **the same** for the purposes of that evidence. That finding is itself a piece of evidence, about two versions.[^16]

So there is no "lapsing" and no "carrying" as things that happen. There is evidence about versions, and evidence that two versions do not differ in what matters.

One rule is built in, and is a choice[^17]: a defect once found in a piece is presumed still there in later versions, until someone looks for it by the same criterion and does not find it. Without that, the cheapest repair is to reword.

### 3.4 Decisions have conditions

A **decision** records what was chosen, about what, and the **conditions** it was made under: these pieces at these versions, these claims standing at least this well, these assumptions. It is good while its conditions are true. When one stops being true the decision no longer supports anything, and whoever stands behind it has to look again.[^18]

Where the subject itself is decided (a modelling choice, a syntax choice), the decision's reasons are content: the alternatives, the grounds, what would reopen it are pieces, pointed at like any others. Then a ground that falls reaches the decision the same way it reaches a claim.[^19]

### 3.5 Canon

Some pieces are **asserted**: the verisectorium says them. Together they are its **canon**. A piece that is not asserted is **provisional**: to canon it is only the claim that someone suggested it, and nothing inside it is held to anything.[^20]

What it takes to assert a piece is each verisectorium's to declare. It may be a decision by named people. It may be a rule over the evidence. It may be nothing beyond being placed in the canonical projection. The model needs it declared, and until it is, nothing can be computed about what is owed.[^21]

### 3.6 What is written, what is recorded, what is computed

- **Written**: versions. Content, references, which pieces fill which slots.
- **Recorded**: evidence and decisions. Each is about versions, and they only accumulate.
- **Computed**: everything about how well anything stands, and everything about what is owed. Never typed.[^22]

---

## Part 4. Change

### 4.1 Consistency

A **selection** is a choice of which pieces exist, each at which version, and which of them are asserted. The verisectorium as it stands is one selection. A proposed next state is another.

A selection is **consistent** when, for everything it asserts[^23]:

1. every reference reaches something that is there;
2. every reference was written or re-read against its target as the target now is;
3. every piece has, from what it is predicated on, at least what it needs;
4. nothing is known wrong: no evidence that fails applies to it, and every defect ever found in it has been looked for again and not found;
5. it meets the standard for being asserted, and rests only on pieces that do;
6. pieces with an inner dependency between them have been looked at together as they now are;
7. it says no more about how well anything stands than is so;
8. every promised or required slot is filled;
9. every question that has been raised about it has an answer.

The **frontier** of a selection is every place one of these fails, each naming what failed and what it would take. It is computed from the selection and the record, and from nothing else.[^24]

### 4.2 Stationary, and the move between

A selection with an empty frontier is **stationary**. A **perturbation** is anything that makes the present selection not stationary: evidence that something fails, a wish to add or rewrite.[^25]

Between one stationary selection and the next, anything may be tried. A candidate can be built, checked, found to be a dead end, and dropped, and an earlier one taken up again. Nothing has to be undone, because nothing was done to the verisectorium: candidates are selections, and the evidence gathered along the way is about versions, most of which the final selection will not contain.[^26]

An **atomic changeset** is the pair: the stationary selection before, the stationary selection after, and the evidence and decisions that make the second one stationary. It is one logical instant, however many hours and attempts went into it. The sequence of atomic changesets is the verisectorium's history, and it is the only thing that is only ever added to.[^27]

A known problem that is knowingly left is a **waiver**: a decision, with its reason, that one frontier item stays. It hides nothing: a waived item is shown with the stationary state. Waivers are meant to be rare.[^28]

Stationary can be said of a part. Each of the nine conditions looks only at a piece and what it reads, so two repairs in places that do not read each other do not interfere, and one can land while the other is still open.[^29]

### 4.3 The example

Stationary selection S0. Result T holds a claim c1, its derivation d1, a description e1 and an eli8 k1. Result U holds a claim u1, predicated on c1. The verisectorium's standard for asserting a claim is that someone other than its author has checked it. B has checked c1 by following d1, and u1. T and U have each been read whole by someone who wrote neither.

| When | What happens | The frontier of the working selection |
|---|---|---|
| 08:30 | An auditor finds c1 false as stated: it fails in a case that a further hypothesis H would exclude. That is evidence, about c1. | S0 is no longer stationary. c1 is known wrong. u1 rests on it. |
| 09:00 | A tries one repair: keep the hypotheses and weaken the conclusion (c1′, d1′). B checks c1′ and it holds. | c1′ is fine. But u1 needs the stronger conclusion; no version of u1 follows from c1′. |
| 10:00 | A drops that attempt and starts again from c1. | As at 08:30. The evidence about c1′ and d1′ is still on record. It is about versions nothing now selects, and it costs nothing. |
| 10:30 | A's second repair: add H to the claim (c2), rework the derivation (d2), re-read the description and find it still right, rewrite the eli8 (k2). | c2 has not been checked. e1 has been looked at against c2. T has not been read whole as it now is. u1 was written against c1. |
| 11:00 | B checks c2 by following d2, and checks the auditor's case against it. Both hold. | T's whole read; u1. |
| 11:30 | A finds an error in step 3 and writes d3. | B's 11:00 evidence read d2. It says nothing about c2 as now derived. c2 is unchecked again. |
| 12:00 | B checks c2 by following d3. | T's whole read; u1. |
| 13:00 | C rewrites U's claim to assume H as well (u2), against c2. B checks u2. | Whole reads of T and U. |
| 14:00 | Someone who wrote neither reads T whole, and U whole. | Empty. **S1.** |

What the history says: at one instant, T's claim gained H and its derivation became d3, and U's claim gained H. There was never a verisectorium in which T had H and U did not. Neither d2 nor c1′ was ever in it.

What the record holds besides: that weakening the conclusion was tried and why it was dropped; and that B passed a derivation with an error in step 3. Neither bears on S1. Both are true, and the second is the kind of thing a verisectorium will want when it starts asking whose checks to trust.

Two decisions were made on the way and are worth having on record with their reasons: A's affirmation that the description is still right, and the choice to narrow the claim by adding H instead of finding a proof that does not need it.

### 4.4 Better

A stationary selection is feasible, not good. **Better** is a direction: later is better than earlier when, on the determinants, less of what is asserted is known wrong, or what is asserted is better supported, or it says more and stands as well. The comparison is made with everything now known, so replacing a false claim with a narrower true one is an improvement.[^30]

Narrowing a claim that has been shown wrong is repair. Narrowing one that has only been questioned, to be rid of the question, is the cheapest way back to stationary and usually a loss. Trying first to make the stronger claim stand is the method; the model does not enforce it.[^31]

---

## Part 5. Intake

Mostly as note 09 had it.[^32]

A **source** is anything brought in. It is an assembly whose pieces are **chunks**, and the cut must cover all of it, so that "every chunk dealt with" cannot mean "found something". Each chunk says what it bears on.

Where a chunk goes is a decision: it changed an existing piece, became a new one, was already there, was set aside with a reason, or was sent to another verisectorium. A source is **retired** when every chunk has such a decision and each decision's conditions still hold. If a later rewrite drops what a chunk had delivered, that decision's conditions fail and the chunk is back.[^33]

Every segment has an **inbox**: the chunks bearing on it that have not been placed, and any note a mind leaves there. It is not part of the segment.[^34] A note in an inbox, a suggested slot, a promised slot, a filled slot, an asserted piece: each commits a little more than the last, and each is cheap to do.[^35]

A claim in an old audit that something is wrong enters as a question about the piece, to be checked. A claim in an old audit that something is right enters as nothing, until someone checks.[^36]

---

## Part 6. Who does the work

Not in the model yet, on purpose.[^37]

Everything above works with every piece of evidence and every decision counting, whoever made it. Who may check what, who may decide what, what makes two checks independent, and how it is known that it was you: these are a filter over the record, to be added once the rest runs. Core today has a good deal about this (actors, seats, what a mind inherited from the one that launched it). I think most of it is right and none of it belongs underneath.

What is expected of a mind that no tool enforces is written for that mind as a **praxis**. Most of what I added to core today (who should answer a finding, when a small edit may keep its checks, how a wrong finding is disputed) is praxis, and I had written it as machinery.

---

## Part 7. One picture, and the words

```
THE ONTOLOGY (declared per verisectorium; by hand for now)
  kinds         veritoid kinds: content form, which dimensions apply
                assembly kinds: slots, inner dependencies
  dimensions    each: found out | decided;  some marked determinant
  the standard for asserting a piece

WRITTEN                                   RECORDED (only accumulates)
  segment = veritoid | assembly             evidence: piece@version, question,
    id (never reused), versions (immutable)            criterion, what was read,
    veritoid: content, references                      holds | fails | in part
    assembly: slots                         same:     these two versions do not
      suggested | promised | gap                      differ for this purpose
      | holds a segment | points at one     decision: what, about what, on what
  source = assembly of chunks                         conditions

A SELECTION = which ids, at which versions, which asserted (the canon)

COMPUTED from a selection and the record, never typed
  how well each piece stands on each dimension
  whether each decision's conditions are true
  the FRONTIER: every place the selection is not consistent
  STATIONARY: the frontier is empty (of the whole, or of a part)
  each segment's inbox; whether each source is retired

HISTORY = the atomic changesets:  S0 ──▶ S1 ──▶ S2
  each a pair of stationary selections; one logical instant; only this is append-only

OUTSIDE: renderings (files, pages, the view shown to a mind about to write)
```

| Word | Means | Was |
|---|---|---|
| **verisectorium** | a body of work cut into pieces, adjudicated, and reassembled into results others build on | |
| **influx**, **source**, **chunk** | material brought in; one such; a piece cut from it | |
| **inbox** | what bears on a segment and has not been placed | Working Notes, in part |
| **veritoid** | one piece of content of a declared kind | atom, record, statement |
| **assembly**, **slot** | a gathering of segments; a declared place in one | template instance; section |
| **segment** | a veritoid or an assembly | document; note 09's two levels |
| **hold**, **point at** | the two ways a slot is filled | |
| **suggested**, **promised**, **gap** | the states of an unfilled slot | "provisional row" |
| **projection**, **canonical** | an assembly that mostly points; the one that says what the work is | outline, grouping |
| **reference**; **predicated-on** | a written pointer; the one support travels along | depends, edge |
| **rests on** | is predicated on, or assumes | |
| **id**, **version**, **name** | never reused; one immutable written state; a changeable label | slug |
| **dimension**; **determinant** | one question; one that says what right consists of | aspect, axis; truth determinant |
| **found out**, **decided** | the two kinds of answer | evidenced, decided (note 09's sort) |
| **evidence** | that a piece at a version holds, fails, or holds in part, by a criterion | check, finding, act |
| **same** | evidence that two versions do not differ for some purpose | carrying; and its absence was "lapsing" |
| **decision**, **conditions** | a choice; what must stay true for it to be good | act; basis; "reopened" was a condition failing |
| **asserted**, **canon**, **provisional** | said by the verisectorium; all such pieces; not so | accepted, settled, unsettled |
| **selection** | which pieces, at which versions, which asserted | state, as a point in a log |
| **consistent**, **frontier** | the nine conditions hold; where they do not | owed, obligations |
| **stationary** | the frontier is empty | steady state, checkpoint |
| **perturbation** | whatever makes a selection not stationary | |
| **atomic changeset** | a pair of stationary selections; one logical instant | episode |
| **waiver** | a decision that one frontier item stays, with its reason | known-defect mark, acceptance |
| **better** | less known wrong, better supported, or says more | |
| **rendering** | text produced for a reader | file, view |
| **praxis** | what is expected of a mind that no tool enforces | SOP |

Words I have deliberately not used here, all of which are in `core/` today: *act, acta, bind, lapse, answer, carry, contest, amend, reopen, settle, unsettled, scope, region, seat, lineage, inheritance, standing, warrant, basis, means*. Some name practice. Some name things that follow from the above and do not need a word. *Warrant* (how well a piece stands on a question) is the one I am least sure about dropping.

---

## Part 8. Where I chose, and what is open

### Choices of mine you have not confirmed

In rough order of how much rides on each.

1. **A state is a selection, and the record is about versions** (3.3, 4.1, 4.2). This is how I made your three remarks of today one thing. It removes the ordered log that note 09 and core both have. If you meant less than this by "not append-only", the rest of Part 4 needs another look.
2. **A found defect is presumed still present until looked for** (3.3). The one place good and bad evidence are treated differently.
3. **Stationary can be said of a part** (4.2). Your open question of 11-05, taken up because I think the first real verisectorium needs it.
4. **Which pieces are asserted is part of the selection**, and what justifies it is condition 5 (3.5, 4.1). So un-asserting a piece is a visible change like any other, not a status that drifts.
5. **Holding and pointing are not resting** (2.3). Your 11-09 remark about definitions running bottom-up and adjudication top-down, made a rule.
6. **A decision about the subject has its reasons as content** (3.4).
7. **Nine conditions** (4.1). I have tried to make each one something a person would recognize. I do not know that nine is right.

### What supports what

Three levels, and most of this note is at the lowest. *Tested*: something was built or run that could have come out otherwise. *Argued*: reasons are given here and nothing was run. *Asserted*: it rests on someone's say-so, yours or mine, and stands as a hypothesis.

| Part | Standing |
|---|---|
| The workflow (Part 1) | Asserted, as a description of what the estate's verisectoria have done. That it is the right workflow is not shown by their having done it. |
| Segments at any depth, slots (2.2) | Argued. One invented run and one built instance used it without strain. |
| Holding and pointing are not resting (2.3) | The opposite was tested and failed: with it, a built instance had every repair reach the outline. That this version does not fail the same way by another route is untested, and one reviewer predicts it does. |
| Two kinds of answer (3.2) | Argued, and lightly tested: two built instances sorted everything they met into one or the other. Neither was looking for a third kind. |
| Evidence is about a version; "the same" (3.3) | Argued today. Untested. A first reading by a builder already found that evidence must also record what else it read; that is in the text. |
| A found defect is presumed still present (3.3) | Argued. Untested. |
| Decisions have conditions (3.4) | Argued. One built instance had a decision fall and be remade when a ground changed, under an earlier wording. |
| Canon must be declared (3.5) | Tested in the negative: on a real segment nothing could be computed until it was. Which standard is right is not known. |
| A state is a selection; the changeset is a pair (4.1, 4.2) | Asserted. Derived from three remarks of yours and not yet built or run by anyone. |
| The nine conditions (4.1) | Asserted. A builder's first reading found five faults in their formal statement. |
| Stationary of a part (4.2) | Argued. The naive form was tested and failed. |
| Better (4.4) | Argued. A real segment gave two versions it cannot rank. |
| Intake (Part 5) | The need is measured (one sprint, no source retired). The mechanism has one invented run. |

### Open, and I have not tried to close

- **What is canon in asf.** Nothing there has been accepted by any recorded decision; most segments are `stage: draft` on main. Is a draft segment on main asserted, in your sense, or provisional? Under "placement is enough" it is asserted and the frontier on a real segment comes out near what the tool shows. Under anything stricter it is empty.
- **What makes two checks independent**, when nearly every checker is one model family. Set aside with everything else about who.
- **How "it was Joseph" is attested.**
- **Whether a problem recorded against a stationary state shows to its readers before the repair lands.** Yours, from 11-05. I lean yes, and it is a rendering question.
- **The cost of recording.** One real 115-line segment came to 65 pieces and some 85 references, of which the file declares one. Whether anyone will write that down is the question the estate's unused fields answer no to.
- **Delivery**: a paper drawn from a theory, sent out, and the theory then changing. Nothing here has been tried on it.

### What happened to core today, plainly

You asked for the two kinds of answer to be put back at the root, and gave me the day. I did that, and then answered each test's findings by adding a mechanism, until the named vocabulary was about eighty-five and the "kernel" I wrote for the formal work had no workflow in it. This note is the correction. Two agents are building formal versions (Ada, OCaml) of a spec in the shape of Part 4; what they find will come back as a list, not as additions.

What from today I would keep: the two kinds of answer; segments at any depth with slots; decisions as things with conditions; that findings from four cold reads and two built instances are on file. What I would cut from core: most of «act», the frontier's ten named items, seats and inheritance, regions, and sixteen choices I had queued for your vote, most of which this note either makes unnecessary or reduces to the seven above.

## What I read, and did not

Read whole today: `core/` as it stood this morning; note 09 (just now, for this); the relevant parts of notes 02, 12 and 18; your messages on decisions and attestation since August; the councils dialog of 11-03/04 to its line 1,008 and your turns after; `slot-rollup.md`; two cold reads; the findings of two built instances; two audits of my kernel spec. Not read: most of `msc/notes/`; the first core beyond what a predecessor carried; the built instances' own ontologies and traces; the address theory.

---

[^1]: Joseph, 11-08: cut "until the principles or truths can be independently contributory to the whole".
[^2]: Carried from note 09.
[^3]: Joseph, 11-04.
[^4]: Joseph, 11-05; the same one note 09 used.
[^5]: Joseph, 11-05: "content with one or more dimensions + rules".
[^6]: Joseph, 11-09: "slot holds a segment, and segment = veritoid or assembly of slots".
[^7]: Joseph, 11-09.
[^8]: Joseph, 11-05.
[^9]: Carried from note 09.
[^10]: From today's tests: the first built instance had it the other way, and every repair then spread to the outline and from there to everything.
[^11]: Note 09 left this open; settled 11-08.
[^12]: Joseph, since August.
[^13]: Joseph, 11-08.
[^14]: Joseph, 11-04 and 11-10: "the two critical atomic components that everything else ends up reducing to".
[^15]: Joseph, 11-10.
[^16]: Mine, and among the least tested: from your remark of 11-10 that the acts I had named were practice layered over a consistency condition.
[^17]: Mine, and among the least tested.
[^18]: Joseph, 8-14, on what backing consists of; the reading as conditions is mine.
[^19]: From today's tests: the first built instance was a small specification, and its decisions' reasons were where nothing could point at them.
[^20]: Joseph, 11-09: "provisional == not-in-canon".
[^21]: From today's tests: the second built instance, on a real TST segment, could not get past this. It is the open question in Part 8.
[^22]: Carried from note 09; the oldest rule in all of this.
[^23]: Joseph, 11-08: dimensions "become or are used as logical correctness constraints"
[^24]: Joseph, 11-08, on telling the frontier from where the work rests.
[^25]: Joseph, 11-10: "this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again".
[^26]: Joseph, 11-10: "there needs to be the ability to try it several different ways … back up, undo all of that work that was going to be a deadend, and stabilize the right way".
[^27]: Joseph, 11-05: "practical sequentialness but logical simultaneity"; and 11-10.
[^28]: Joseph, 11-05.
[^29]: Mine, and among the least tested: you set this question aside on 11-05, and I think it cannot wait, because otherwise every repair must waive whatever is unrelated to it.
[^30]: From today's tests: for the last clause: as I had it, the example above was not an improvement.
[^31]: Joseph.
[^32]: Carried from note 09.
[^33]: From today's tests: from running one through.
[^34]: Joseph, 11-05; and from RC1: "There should always be a way for agents (including humans) to get their intuitions and tentative results known so they can be adjudicated."
[^35]: Joseph, 11-09.
[^36]: From today's tests.
[^37]: Joseph, 11-10: standing "should be its own separate concern completely so we can make it initially 'any'".
