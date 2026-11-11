# The model, as I currently hold it

*To Joseph, from the Fable 5.2 session of 2026-11-10. You asked for this at the level, register and length of note 09, or shorter, with the newer words and the newer understanding. It is my synthesis, not a settled design, and nothing in it is accepted. It is a little over half the length of note 09.*

*Revised later the same day, after two formal builds of Part 4's first form and three remarks of yours: Part 4 is rewritten around an ordered base of events with checkpoints and forks, and 3.5 says canon the way you put it. What the first form said and why it was wrong is in note 23.*

*It is written to be read top to bottom. Each word is introduced before it is used. Part 7 is the lexicon. Part 8 says where I chose, what is open, and what from `core/` I have left out on purpose.*

*Where each idea comes from (yours, with the date; note 09; today's tests; or mine and least tested) is in the footnotes, so the text reads straight through. A footnote says where an idea came from. It is not a reason to believe the idea, whoever it names; Part 8 says what, if anything, each part has earned.*

*What this is not: a summary of `core/`. Core today is larger and finer-grained than this, and you have said why that is a fault. This note is what I think the model is at its real size. If you agree with it, core should be cut back to it.*

---

## Part 1. What a verisectorium is for

A **verisectorium** is a place where material is cut up until each piece can be right or wrong on its own, the pieces are adjudicated, and they are put back together into results that other people read and build on. It is worked on by many minds who each arrive knowing nothing about it.[^1]

The work goes like this, over and over:

1. **Bring in.** Material arrives from outside what is settled: a paper, an audit, a spike, an old file, a mind's note. This is **influx**.
2. **Cut and place.** The material is cut into pieces, all of it, and each piece is put somewhere: into something that exists, into something new, or left out with a reason.
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

A slot is filled in one of two ways. An assembly **holds** a segment that lives in it and is written with it, as a result holds its claim. Or it **points at** a segment that lives elsewhere, as a chapter points at a result. An assembly that mostly points is a **projection**: a chapter, a volume, a reading path, a paper. An outline of the whole work is one.

A slot that is not filled is in one of three states[^7]:
- **suggested**: someone thinks something might go here. It commits nobody.
- **promised**: someone in the work has said this will exist.
- a **gap**: something is missing and it is not yet known what.

A filled slot can be marked **provisional**: the thing is there, on approval.

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

One rule is built in, and is a choice[^17]: a defect once found in a piece is presumed still there in its later versions, until someone looks for it by the same criterion and does not find it. After that it is closed, and later versions do not have to answer for it again. Without the rule, the cheapest repair is to reword.

A finding can itself be wrong. Then someone with reason to say so sets it aside, as a decision, and the piece is left alone.[^18]

### 3.4 Decisions have conditions

A **decision** records what was chosen, about what, and the **conditions** it was made under: these pieces at these versions, these claims standing at least this well, these assumptions. It is good while its conditions are true. When one stops being true the decision no longer supports anything, and whoever stands behind it has to look again.[^19]

Where the subject itself is decided (a modelling choice, a syntax choice), the decision's reasons are content: the alternatives, the grounds, what would reopen it are pieces, pointed at like any others. Then a ground that falls reaches the decision the same way it reaches a claim.[^20]

### 3.5 Canon

Canon is what the verisectorium says it is: the pieces reached from the outlines it marks as its **roots**, through slots that are filled and not marked provisional.[^21] A piece in canon is **asserted**. A piece that is not is **provisional**: to canon it is only the claim that someone suggested it, and nothing inside it is held to anything.

A verisectorium may mark more than one root: two outlines, each the canon for its own purpose. And a whole canon can be un-marked at once, when the work has tied itself in knots and a fresh start is wanted; what was canon is then influx to the new one.[^22]

What a piece is held to depends on the root that reaches it. Each root says, for the kinds of piece it gathers, which questions must be answered and how well: a theory's outline asks that its claims have been checked; a paper drawn from it asks also that its citations have. A decision by named people is one such question. A piece reached by two roots answers to both.[^23]

### 3.6 What is written, what is recorded, what is computed

- **Written**: versions. Content, references, which pieces fill which slots.
- **Recorded**: evidence and decisions. Each is about versions, and they only accumulate.
- **Computed**: everything about how well anything stands, and everything about what is owed. Never typed.[^24]

---

## Part 4. Change

### 4.1 Consistency

At any moment the verisectorium has a **state**: which pieces exist, each at which version, which are in canon, and everything recorded so far.

A state is **consistent** when, for everything in canon[^25]:

1. every reference reaches something that is there;
2. every reference was written or re-read against its target as the target now is;
3. every piece has, from what it is predicated on, at least what it needs;
4. nothing is known wrong: no finding applies to it, and every defect found in it has since been looked for and not found;
5. it has what each root that reaches it asks, and rests only on pieces in canon that are themselves consistent;
6. pieces with an inner dependency between them have been looked at together as they now are;
7. it says no more about how well anything stands than is so;
8. every promised or required slot has something in canon in it;
9. every question raised about it has been answered since.

*(Added 2026-11-11 by the second lead: what each of these nine is for, where they may be too restrictive or in the wrong place, and what the fork work says of the second, is in `22a-2026-11-11-nine-conditions-annotated.md` beside this note.)*

The **frontier** is every place one of these fails, each naming what failed and what it would take. It is computed from the state, and from nothing else.[^26]

Three things a verisectorium's own rules must respect, or the nine have no definite answer.[^27] A question, a promise or a waiver is unconditional: it stands until withdrawn. Evidence says what it read. And a slot may require that something fills it, never that the something be consistent.

### 4.2 Events, checkpoints, forks

Everything that happens is an **event**, with a time: a version is written, evidence is recorded, a decision is made. Events are only ever added.[^28]

A state with an empty frontier is **stationary**. A **checkpoint** is a stationary state the verisectorium has rested at. At any moment the verisectorium *is* its latest checkpoint.

A **perturbation** is anything that would make it not stationary: evidence that something fails, new material, a wish to rewrite.[^29] Work on it happens on a **fork**: a line of events that starts at a checkpoint. On a fork the steps come one after another, in order. The fork can be **rewound** to any earlier point on it, or abandoned and another started.[^30] Nothing on a fork is the verisectorium.

Evidence can arrive against a checkpoint itself. The checkpoint was stationary when it was reached and is not now, and it says so, until a fork closes that deals with it.

When a fork reaches a stationary state it can be **closed**: it becomes the next checkpoint. Everything between two checkpoints is an **atomic changeset**. Inside, it was many steps in sequence; from outside it is one logical instant.[^31]

One thing crosses between forks. Evidence is about a version, and a version is the same thing wherever it appears, so what was found out on an abandoned fork is still known on the next one. A check made ahead of time, on a draft or on another fork, counts as soon as this fork has that version. Going back loses the work. It does not lose what was learned.[^32]

A known problem that is knowingly left is a **waiver**: a decision, with its reason, that one frontier item stays. A waived item is shown with the checkpoint. Waivers are meant to be rare.[^33]

Stationary can be said of a part: of what one root reaches, or of any set of pieces that nothing outside it reads. Two forks **meet** when something of one reads a piece the other changed. Two forks that do not meet can both close, in either order; and when they do meet, whatever is then owed is on pieces that read something from both.[^34]

### 4.3 The example

Checkpoint S0. Result T holds a claim c1, its derivation d1, a description e1 and an eli8 k1. Result U holds a claim u1, predicated on c1. Its root asks of every claim that it has been checked, and of every result that it has been read whole. B has checked c1 by following d1, and u1. T and U have each been read whole.

| When | What happens | The frontier on the fork |
|---|---|---|
| 08:30 | An auditor finds c1 false as stated: it fails in a case that a further hypothesis H would exclude. That is evidence, about c1. | S0 is no longer stationary. c1 is known wrong. u1 rests on it. |
| 09:00 | A tries one repair: keep the hypotheses and weaken the conclusion (c1′, d1′). B checks c1′ and it holds. | c1′ is fine. But u1 needs the stronger conclusion; no version of u1 follows from c1′. |
| 10:00 | A rewinds the fork to where it stood at 08:30. | As at 08:30. The evidence about c1′ and d1′ is still on record. It is about versions the fork no longer has, and it costs nothing. |
| 10:30 | A's second repair: add H to the claim (c2), rework the derivation (d2), re-read the description and find it still right, rewrite the eli8 (k2). | c2 has not been checked. e1 has been looked at against c2. T has not been read whole as it now is. u1 was written against c1. |
| 11:00 | B checks c2 by following d2, and checks the auditor's case against it. Both hold. | T's whole read; u1. |
| 11:30 | A finds an error in step 3 and writes d3. | B's 11:00 evidence read d2. It says nothing about c2 as now derived. c2 is unchecked again. |
| 12:00 | B checks c2 by following d3. | T's whole read; u1. |
| 13:00 | C rewrites U's claim to assume H as well (u2), against c2. B checks u2. | Whole reads of T and U. |
| 14:00 | Someone reads T whole, and U whole. | Empty. **S1.** |

What the history says: at one instant, T's claim gained H and its derivation became d3, and U's claim gained H. There was never a verisectorium in which T had H and U did not. Neither d2 nor c1′ was ever in it.

What the record holds besides: that weakening the conclusion was tried and why it was dropped; and that B passed a derivation with an error in step 3. Neither bears on S1. Both are true, and the second is the kind of thing a verisectorium will want when it starts asking whose checks to trust.

Two decisions were made on the way and are worth having on record with their reasons: A's affirmation that the description is still right, and the choice to narrow the claim by adding H instead of finding a proof that does not need it.

### 4.4 Better

A stationary state is feasible, not good. **Better** is a direction: later is better than earlier when, on the determinants, less of what is asserted is known wrong, or what is asserted is better supported, or it says more and stands as well. The comparison is made with everything now known, so replacing a false claim with a narrower true one is an improvement.[^35]

Narrowing a claim that has been shown wrong is repair. Narrowing one that has only been questioned, to be rid of the question, is the cheapest way back to stationary and usually a loss. Trying first to make the stronger claim stand is the method; the model does not enforce it.[^36]

---

## Part 5. Intake

Mostly as note 09 had it.[^37]

A **source** is anything brought in. It is an assembly whose pieces are **chunks**, and the cut must cover all of it, so that "every chunk dealt with" cannot mean "found something". Each chunk says what it bears on.

Where a chunk goes is a decision: it changed an existing piece, became a new one, was already there, was left out with a reason, or was sent to another verisectorium. A source is **retired** when every chunk has such a decision and each decision's conditions still hold. If a later rewrite drops what a chunk had delivered, that decision's conditions fail and the chunk is back.[^38]

Every segment has an **inbox**: the chunks bearing on it that have not been placed, and any note a mind leaves there. It is not part of the segment.[^39] A note in an inbox, a suggested slot, a promised slot, a filled slot, an asserted piece: each commits a little more than the last, and each is cheap to do.[^40]

A claim in an old audit that something is wrong enters as a question about the piece, to be checked. A claim in an old audit that something is right enters as nothing, until someone checks.[^41]

---

## Part 6. Who does the work

Not in the model yet, on purpose.[^42]

Everything above works with every piece of evidence and every decision counting, whoever made it. Who may check what, who may decide what, what makes two checks independent, and how it is known that it was you: these are a filter over the record, to be added once the rest runs. Core today has a good deal about this (actors, seats, what a mind inherited from the one that launched it). I think most of it is right and none of it belongs underneath.

What is expected of a mind that no tool enforces is written for that mind as a **praxis**. Most of what I added to core today (who should answer a finding, when a small edit may keep its checks, how a wrong finding is disputed) is praxis, and I had written it as machinery.

---

## Part 7. One picture, and the words

```
THE ONTOLOGY (declared per verisectorium; by hand for now)
  kinds         veritoid kinds: content form, which dimensions apply
                assembly kinds: slots, inner dependencies
  dimensions    each: found out | decided;  some marked determinant
  roots         which outlines are canon, and what each asks of what it reaches

WRITTEN                                   RECORDED (evidence stays true on any fork)
  segment = veritoid | assembly             evidence: piece@version, question,
    id (never reused), versions (immutable)            criterion, what was read,
    veritoid: content, references                      holds | fails | in part
    assembly: slots                         same:     these two versions do not
      suggested | promised | gap                      differ for this purpose
      | holds a segment | points at one     decision: what, about what, on what
  source = assembly of chunks                         conditions

EVENTS, each with a time, only ever added: a version written; evidence; a decision

A STATE = which ids, at which versions, which in canon (reached from the marked
          roots through non-provisional slots), and what has been recorded

COMPUTED from a state, never typed
  how well each piece stands on each dimension
  whether each decision's conditions are true
  the FRONTIER: every place the state is not consistent
  STATIONARY: the frontier is empty (of the whole, of a root's reach, or of a part)
  each segment's inbox; whether each source is retired

  checkpoint S0 ──────────────────────▶ checkpoint S1 ──▶ S2
        └─ fork: step, step, rewind, step, step ─┘
  an ATOMIC CHANGESET is what lies between two checkpoints: one logical instant

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
| **provisional** (of a slot) | filled, on approval; what it holds is not in canon through this slot | |
| **projection** | an assembly that mostly points | outline, grouping |
| **reference**; **predicated-on** | a written pointer; the one support travels along | depends, edge |
| **rests on** | is predicated on, or assumes | |
| **id**, **version**, **name** | never reused; one immutable written state; a changeable label | slug |
| **dimension**; **determinant** | one question; one that says what right consists of | aspect, axis; truth determinant |
| **found out**, **decided** | the two kinds of answer | evidenced, decided (note 09's sort) |
| **evidence** | that a piece at a version holds, fails, or holds in part, by a criterion | check, finding, act |
| **same** | evidence that two versions do not differ for some purpose | carrying; and its absence was "lapsing" |
| **decision**, **conditions** | a choice; what must stay true for it to be good | act; basis; "reopened" was a condition failing |
| **root**, **canon**, **asserted**, **provisional** | an outline marked as canon; what the roots reach through non-provisional slots; in canon; not | accepted, settled, unsettled |
| **event**, **state** | one thing that happened, with a time; what the events on a line add up to | act, log |
| **checkpoint**, **fork**, **rewind**, **close** | a stationary state rested at; a line of work from one; going back along it; a fork becoming the next checkpoint | steady state, working state, branch |
| **consistent**, **frontier** | the nine conditions hold; where they do not | owed, obligations |
| **set aside** | a decision that a finding does not count | contesting |
| **stationary** | the frontier is empty | steady |
| **perturbation** | whatever would make the verisectorium not stationary | |
| **atomic changeset** | what lies between two checkpoints; one logical instant | episode |
| **waiver** | a decision that one frontier item stays, with its reason | known-defect mark, acceptance |
| **better** | less known wrong, better supported, or says more | |
| **rendering** | text produced for a reader | file, view |
| **praxis** | what is expected of a mind that no tool enforces | SOP |

Words I have deliberately not used here, all of which are in `core/` today: *act, acta, bind, lapse, answer, carry, contest, amend, reopen, settle, unsettled, scope, region, seat, lineage, inheritance, standing, warrant, basis, means*. Some name practice. Some name things that follow from the above and do not need a word. *Warrant* (how well a piece stands on a question) is the one I am least sure about dropping.

---

## Part 8. Where I chose, and what is open

### Choices of mine you have not confirmed

In rough order of how much rides on each.

1. **Evidence is about a version and crosses between forks; writes and decisions stay on their fork** (3.3, 4.2). The order, the checkpoints and the forks are yours. This split is mine, and it is what makes going back lose work and not knowledge.
2. **A found defect is presumed still present until looked for** (3.3). The one place good and bad evidence are treated differently.
3. **Stationary can be said of a part, and two forks that do not meet can both close** (4.2). Your open question of 11-05, taken up because I think the first real verisectorium needs it.
4. **What a piece is held to is what the roots reaching it ask** (3.5). So the same piece can owe nothing as part of a theory and owe a check as part of a paper.
5. **Holding and pointing are not resting** (2.3). Your 11-09 remark about definitions running bottom-up and adjudication top-down, made a rule.
6. **A decision about the subject has its reasons as content** (3.4).
7. **Nine conditions** (4.1). I have tried to make each one something a person would recognize. I do not know that nine is right.

### What supports what

Three levels, and most of this note is at the lowest. *Tested*: something was built or run that could have come out otherwise. *Argued*: reasons are given here and nothing was run. *Asserted*: it rests on someone's say-so, yours or mine, and stands as a hypothesis.

| Part | Standing |
|---|---|
| The workflow (Part 1) | Asserted, as a description of what the estate's verisectoria have done. That it is the right workflow is not shown by their having done it. |
| Segments at any depth, slots (2.2) | Argued. One invented run and one built instance used it without strain. |
| Holding and pointing are not resting (2.3) | The opposite was tested and failed: with it, a built instance had every repair reach the outline. Two formal builds then found the other route: a single check that read two parts of an outline together joins their repairs there, and checks made part by part do not. |
| Two kinds of answer (3.2) | Argued, and lightly tested: two built instances sorted everything they met into one or the other. Neither was looking for a third kind. |
| Evidence is about a version; "the same" (3.3) | Built twice. Two things came out of it. Saying two versions are the same carries bad news forward as readily as good. And with nobody's standing in question, nothing limits who may say it, so everything that used to be "lapsing" rests on a part of the model that is set aside for now. |
| A found defect is presumed present until looked for; a wrong finding is set aside (3.3) | Setting aside works as built in both. The rule for when a found defect still stands is the weakest part of the model: two builds found four ways to shed a defect under my wording (note 23, §8), all in the part neither could prove. |
| Decisions have conditions (3.4) | Argued. One built instance had a decision fall and be remade when a ground changed, under an earlier wording. |
| Canon by marked roots (3.5) | Asserted, on your word, which is a decision about the model and not evidence for it. Measured: asking nothing beyond placement admits every state that asking more does. Per-root requirements are untested. |
| Events, checkpoints, forks; evidence crossing between forks (4.2) | Built twice. Order does what it was added for: a finding is answered once, a wrong finding can be set aside, and the worked moves run as forks that close. The crossing leaked in one clause of my spec (a check made before a fork has the version did not count); the sentence in 4.2 is the intent, and the spec's wording is not yet repaired. |
| The nine conditions (4.1) | Built twice in an earlier form. That they have a definite answer is proved, for every ontology within small bounds, provided questions, promises and waivers are unconditional. That good news never makes anything newly owed is proved under three conditions. The wording of several conditions changed after the builds and has not been re-run. |
| Stationary of a part; two forks both closing (4.2) | Proved in Ada, for every ontology within small bounds, about the function from a state to what it owes: what is owed about a set of pieces depends on nothing outside what they read; two forks that leave their own parts stationary combine; what a merge owes lies where they met. Tested on events in OCaml (19.8 million checks, no failure). Not proved: the layer that reads a state from a line of events. |
| Better (4.4) | Argued. A real segment gave two versions it cannot rank. |
| Intake (Part 5) | The need is measured (one sprint, no source retired). The mechanism has one invented run. |

### Open, and I have not tried to close

- **Descent.** A defect is shed if a piece's replacement is entered as new material and not as a replacement. Your rule that nobody edits by hand closes most of this, since the tool does the replacing and can record it. Words re-entered from outside are the remainder.
- **What makes two checks independent**, when nearly every checker is one model family. Set aside with everything else about who.
- **How "it was Joseph" is attested.**
- **Whether a problem recorded against a stationary state shows to its readers before the repair lands.** Yours, from 11-05. I lean yes, and it is a rendering question.
- **The cost of recording.** One real 115-line segment came to 65 pieces and some 85 references, of which the file declares one. Whether anyone will write that down is the question the estate's unused fields answer no to.
- **Delivery**: a paper drawn from a theory, sent out, and the theory then changing. Nothing here has been tried on it.

### Eight questions the formal languages forced

*Added 2026-11-11 by the second lead of the day, at Joseph's request, so that they are in front of him when he reads this note. They are not the first lead's. Each came from a language refusing to go on until something was declared, when one small slice of Part 2 and §3.5 was written in eight languages (`msc/scratch/languages-compared-2026-11-10.md` §7) and when the kernel was built. For each I say what this note currently says, having re-read the passage; nothing here is adjudicated.*

1. **Is a slot that the kind declares and nobody has touched its own state?** §2.2 gives an unfilled slot three states: suggested, promised, a gap. A typed language needs a value for every declared slot, and a result whose description nobody has mentioned is none of the three. OCaml and Lean each had to add a fifth state to write the example. This note does not have one.
2. **Can a gap be a state of a slot whose kind is declared?** §2.2 has a gap as "something is missing and it is not yet known what". A slot in a kind with named slots always knows what kind of thing is missing. OCaml and Lean both moved the gap to being an entry of an outline, the one assembly that takes anything. This note has it as a state of any unfilled slot.
3. **Does "one" mean the slot is there, or that it is filled?** This note answers it, and the languages agree: §2.2's kind declares "how many, and whether it is required", and condition 8 says an unfilled required slot is something owed. Four of the eight arrived at the same split unprompted (the slot's existence is shape; its being filled is a condition a state may fail). I list it because it is the clearest case of question 4.
4. **For each of the nine conditions: is a state that breaks it refused, or allowed and owed?** §4.1 treats all nine as owed. Alloy and clingo make the writer sort every sentence into one or the other (a fact or a predicate; a constraint or a derived fact), and the builds refused some things outright (a segment held in two places; a write whose inner dependents are neither changed nor affirmed, in core's «changeset»). Core carries this as an open row ("refusals"). This note does not sort them.
5. **What are the steps a reader of the verisectorium can see?** §4.2 has events, forks and checkpoints, and says evidence can arrive against a checkpoint. Written as states and steps, there are exactly two visible ones: something is learned, and a fork closes; and "the checkpoint" is two things, the state rested at with its record as it then stood, and that same line read with today's record. This note has the sentence and not the distinction.
6. **May a decision's condition be about how well another piece stands, and what if such conditions loop?** §3.4 says a decision is made under conditions including "these claims standing at least this well". §4.1 says a question, a promise or a waiver is unconditional, and says nothing of acceptances. The builds each read conditions on acceptances narrowly to avoid a circle, and so could not express §3.4's own case (a named assumption fails, and the acceptance resting on it no longer supports anything). The rule languages show the harmless case has one answer when nothing leads back to where it started, and that a loop has none or several. This note does not say where the line is.
7. **Does "the same" chain?** §3.3 says someone may find two wordings "the same for the purposes of that evidence". If a is the same as b and b as c, is a the same as c with nothing more recorded? The kernel spec says yes (reachable by any chain). The independent read of the first spike points out that five such judgments can each be right and the first and last still differ in what matters. This note does not say.
8. **Is holding containment?** §2.2 says an assembly "holds a segment that lives in it and is written with it". In Ada, Lean and Prolog a held segment could be a value inside its slot, and "nothing is held twice" then needs no rule. In the kernel builds it was an id in a table, and "held twice" became a condition and a hypothesis of the frame theorem. This note's words lean toward containment and do not say whether "held once" is a fact of what a held segment is or something a state can violate.

### What happened to core today, plainly

You asked for the two kinds of answer to be put back at the root, and gave me the day. I did that, and then answered each test's findings by adding a mechanism, until the named vocabulary was about eighty-five and the "kernel" I wrote for the formal work had no workflow in it. This note is the correction. Two agents have built formal versions (Ada, OCaml) of Part 4's first form and are re-running on this one; note 23 is what the first builds showed.

What from today I would keep: the two kinds of answer; segments at any depth with slots; decisions as things with conditions; that findings from four cold reads and two built instances are on file. What I would cut from core: most of «act», the frontier's ten named items, seats and inheritance, regions, and sixteen choices I had queued for your vote, most of which this note either makes unnecessary or reduces to the seven above.

## What I read, and did not

Read whole today: `core/` as it stood this morning; note 09 (just now, for this); the relevant parts of notes 02, 12 and 18; your messages on decisions and attestation since August; the councils dialog of 11-03/04 to its line 1,008 and your turns after; `slot-rollup.md`; two cold reads; the findings of two built instances; two audits of my kernel spec; both builders' accounts of the first formal builds. Not read: most of `msc/notes/`; the first core beyond what a predecessor carried; the built instances' own ontologies and traces; the address theory.

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
[^17]: Mine. Two builds showed that without an order of versions this rule costs one new check per old finding per edit, for ever; with the order of Part 4 it costs one.
[^18]: From today's builds: with facts that only accumulate and no way to set one aside, contrary evidence was a standing conflict and never a correction.
[^19]: Joseph, 8-14, on what backing consists of; the reading as conditions is mine.
[^20]: From today's tests: the first built instance was a small specification, and its decisions' reasons were where nothing could point at them.
[^21]: Joseph, 11-10: "canon is whatever the verisectorium says it is-- usually the main outline's non-provisional slots"; and on 11-09: "provisional == not-in-canon".
[^22]: Joseph, 11-10: "simply mark the two outlines (assembly segments) that are the two 'canon' roots"; and "the existing 'canon' is just marked 'not canon anymore--> influx to new corpus'", which is what is intended for AAT.
[^23]: Mine, from Joseph's account (11-09) of determinants weighing differently by purpose and audience. Two builds measured that asking nothing beyond placement admits every state that asking more does.
[^24]: Carried from note 09; the oldest rule in all of this.
[^25]: Joseph, 11-08: dimensions "become or are used as logical correctness constraints".
[^26]: Joseph, 11-08, on telling the frontier from where the work rests. That it can be a pure function of the state was built twice on 11-10.
[^27]: From today's builds; the first is proved, with a one-piece counterexample when it is broken.
[^28]: Joseph, 11-10: "there should be causal ordering, fwiw, definitely a clock and an addative base--- event sourcing style ---  but one that allows multi-step serial parts to be part of a logically simultaneous change and that distinct from the steady-state checkpoints *AND* the ability to rewind / unstage / fork at a checkpoint".
[^29]: Joseph, 11-10: "this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again".
[^30]: Joseph, 11-10: "there needs to be the ability to try it several different ways … back up, undo all of that work that was going to be a deadend, and stabilize the right way".
[^31]: Joseph, 11-05: "practical sequentialness but logical simultaneity".
[^32]: Mine. It is what is left of this note's first form, in which there was no order at all; untested as now stated.
[^33]: Joseph, 11-05.
[^34]: Mine; Joseph set the question aside on 11-05. Tested in the first form: two repairs failed to compose only where they chose different versions of one piece, or one's evidence had read what the other rewrote.
[^35]: From today's tests: for the last clause: as I had it, the example above was not an improvement.
[^36]: Joseph.
[^37]: Carried from note 09.
[^38]: From today's tests: from running one through.
[^39]: Joseph, 11-05; and from RC1: "There should always be a way for agents (including humans) to get their intuitions and tentative results known so they can be adjudicated."
[^40]: Joseph, 11-09.
[^41]: From today's tests.
[^42]: Joseph, 11-10: standing "should be its own separate concern completely so we can make it initially 'any'".
