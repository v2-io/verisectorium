# The model, revised from note 22

*To Joseph, from the Fable 5.2 session of 2026-11-18, who arrived cold after your week away. You asked for a revised note 22 from fresh eyes, with a proposed outline for a new core near the end. This is my synthesis. Nothing in it is accepted, and I have built and run nothing.*

*It is written to be read top to bottom, each word introduced before it is used, with one running example. Part 7 is the picture and the words. Part 8 says how this differs from note 22 and from core, where I chose, and what is open. Part 9 is the proposed outline for core.*

*Where an idea comes from is marked at the end of its paragraph: **[J]** yours, with the date where I have it; **[22]** note 22 or its companions 22a and 23; **[core]** `core/` as it stands; **[09]**, **[19]** those notes; **[M]** mine, and the least tested. A mark says where an idea came from. It is not a reason to believe it.*

*What I read to write this is listed at the very end, with what I did not.*

---

## Part 1. What a verisectorium is for

A **verisectorium** is a place where material is cut up until each piece can be right or wrong on its own, the pieces are adjudicated, and they are put back together into results that other people read and build on. It is worked on by many minds who each arrive knowing nothing about it. **[J, 11-08]**

The work goes round like this:

1. **Bring in.** Material arrives from outside what is settled: a paper, an audit, a spike, an old file, a mind's note. This is **influx**.
2. **Cut and place.** The material is cut into pieces, all of it, and each piece is put somewhere: into something that exists, into something new, or left out with a reason.
3. **Adjudicate.** Questions are asked of each piece, and each answer is either found out or decided.
4. **Stabilize.** Anything new, and anything found wrong, leaves some things inconsistent with others. Work goes on until everything is consistent again.
5. **Build on.** What is consistent is what others read, cite and build further results on. Then something new arrives.

Everything after this page is **machinery**: what has to be recorded and computed so that the round above can be trusted while many minds turn over. A mind at work does not meet the machinery. It meets a **practical model** built on it: an outline with marked slots, document-like pieces rendered as text, an inbox beside each, a list of what is owed, a place where the work rests. The two are different layers, and where they differ this note says which it means. What the machinery cannot enforce is written for the mind as a **praxis**. **[J, 11-08; core]**

Three things the October sprint showed that the model has to make impossible or at least visible: nobody could tell "found everything" from "found something"; checks and fixes fed each other; and no source was ever retired. And one rule: nobody edits a verisectorium by hand. Where the tool cannot express a change, that is how we learn what the tool lacks. **[J, 10-30 to 11-04; 09]**

One example runs through the rest: a derived result with a formal claim, its derivation, a description, and an "explain it to an eight-year-old" paragraph. **[J, 11-05]**

---

## Part 2. What exists

### 2.1 Pieces of content

The smallest thing is a **veritoid**: one piece of content of a declared **kind**. A formal statement, a step of a derivation, a paragraph of explanation, a question, the wording of a design choice. A kind says what form the content takes and which questions may be asked of it. **[J, 11-05]**

### 2.2 Assemblies and slots

A veritoid almost never makes sense alone. An **assembly** gathers pieces. Its kind declares **slots**, each saying what kind of thing fills it, how many, and whether it is required. A **segment** is either a veritoid or an assembly, so one thing does the work at every depth: a result is an assembly of veritoids, a chapter an assembly of results, a theory an assembly of chapters. **[J, 11-09]**

A slot is filled in one of two ways. An assembly **holds** a segment that lives in it and is written with it, as a result holds its claim. Or it **points at** a segment that lives elsewhere, as a chapter points at a result. An assembly that mostly points is a **projection**: a chapter, a reading path, a paper, an outline of the whole work.

A held segment is inside its holder, the way a paragraph is inside a document. So it has one home, and "held in two places" is not something a state can be. **[M; question 8 of note 22's eight]**

A slot that a kind declares and nothing fills is **empty**. Someone may say more about an empty slot, and each step commits more than the last: **[J, 11-09]**

- **suggested**: someone thinks something might go here. It commits nobody.
- **promised**: someone in the work has said this will exist.

A filled slot can be marked **provisional**: the thing is there, on approval.

An outline has one more thing. Its kind takes any number of anything, so it can be missing something without any slot being empty. A **gap** is an entry in an outline that says something is missing here and it is not yet known what. **[M, following the two builds; note 22 had the gap as a state of any slot]**

Kinds also declare **inner dependencies** between slots: the eli8 depends on the description, which depends on the claim. They are why the pieces of a result are looked at together when one of them moves. **[J, 11-05]**

### 2.3 References

A veritoid points at other pieces. A **reference** is written by an author and can be wrong. Each kind of reference says two things: what passes along it, and **how much of its target it relies on**. **[22a, from the builds]**

| Reference | Meaning | Relies on | What passes along it |
|---|---|---|---|
| **predicated-on** | this claim needs that one | what the target asserts | support |
| **narrates** | this talks about that | what the target says | nothing; the telling is re-read when the target moves |
| **restates** | these say the same thing | what the target asserts | the two must agree |
| pointing (a slot) | this is a member | that the target exists | nothing |

One piece **rests on** another when it is predicated on it or names it as a hypothesis. Holding and pointing are not resting: a chapter does not become doubtful because one of its results is being repaired. It shows the result's state. **[22; tested: with the opposite rule, a built instance had every repair reach the outline]**

### 2.4 Identity and versions

Every segment has an **id**, made once and never reused. A freestanding segment also has a **name**, which may change. When a piece is split, merged or replaced, the old id is retired and the new ones record which they descend from. **[core; 09 left it open]**

A **version** is one written state of one id. Versions are never changed. Rewriting a piece makes a new version of the same id, and the old version is still exactly what it was.

---

## Part 3. Questions and answers

### 3.1 Dimensions

A **dimension** is one question that can be asked of a piece and answered independently of the others. Two things that can move independently never share a dimension. **[J, since August]**

A verisectorium declares each dimension by saying: **[core; 19; the census]**

- what it **asks**, and **of** which kinds;
- what the piece is held **against**. Logic; the world; its own canon; or something that differs per piece (the source this quotes, the reader this is for), which the piece then names;
- whether its answer is **found out or decided** (3.2);
- by what **means** it can be asked, where there is more than one way. For "does it follow?": following the written derivation, deriving it afresh, setting it against its neighbours' results, building an instance;
- how the answer is **read** from what is on record, and whether anything passes along references.

The means are in the model because of the one real failure it has been read against. A proposition in AAT was false for six months and was passed by several minds. Every pass followed the same written proof. What broke it was a different way of asking: setting it against its neighbour. A record that says "checked, passed" four times cannot show that all four asked the same way. **[core, `impl-stopped-bound`]**

The verisectorium marks some dimensions as **determinants**: the ones that say what being right consists of for this work. **[J, 11-08]**

### 3.2 Two kinds of answer

Every answer is one of two kinds, and everything else is built from them. **[J, 11-04 and 11-10: "the two critical atomic components that everything else ends up reducing to"]**

A dimension is **found out** when its answer is a truth claim about the piece. It stands by **evidence**.

A dimension is **decided** when its answer is a choice someone made. It stands because that someone stands behind it.

They rest on each other. A decision's grounds are truth claims. Every piece of evidence is at bottom something someone or something attested, and where the chain of "and what supports that?" stops is a decision. A measurement is an instrument attesting a truth claim. An automated action is a decision made in advance, which is what a **rule** is. **[J, 11-10]**

### 3.3 Evidence

A piece of **evidence** says: this piece, at this version, asked this question, by this means, against a criterion fixed before the outcome was seen, was found to hold, or to fail, or to hold in part. It also says **what else was read** to find that out: the derivation, the premises. **[22; core for the means]**

A version never changes, so evidence about it never stops being true. What changes is whether it has anything to say about the verisectorium as it now is. Evidence **applies** when everything it read is still there at the version it read. Rewrite the claim, or the derivation the check followed, and that check no longer applies. Nothing "lapses"; the evidence is about something that is no longer what the verisectorium has. **[22]**

Someone may find that two versions are **the same** for the purposes of some evidence: a reflow, a clearer word order. That finding is itself evidence, about two versions, and it lets the earlier evidence apply to the later one. It works for bad news exactly as for good. **[22]**

**So a change lowers certainty by itself.** A rewritten piece has no evidence that applies to it until someone checks it or finds it the same. This is the one place I depart from note 22 on purpose. Note 22 added a rule: a defect once found is presumed still present in later versions until someone looks for it. You did not ask for that rule, the two builds found four ways around it, and it treats good and bad evidence differently. Without it, the example in 4.3 goes as you described on 11-04 and 11-05: a defect found is first an honest lowering (the repaired claim is unchecked, and says so), then a strengthening. What the rule was guarding against is real: rewording to shed a finding. Here that costs the piece all its evidence, and the finding stays on record against the earlier version, where the next checker is shown it. Whether the next checker must ask by the means that found the defect is something a verisectorium can say in what its roots ask (3.5). **[M, from J 11-04/05 as 22a reports it, and from core as it stood on 11-09]**

A finding can itself be wrong. Then someone with reason to say so **sets it aside**, as a decision, and the piece is left alone. **[22, from the builds]**

### 3.4 What content may say about itself

This is the honesty rule, and it has changed twice, so I state it as a choice for you.

A claim's own conditions are content: "exact", "conditional on (S1) to (S5)", "to leading order" say **what is claimed**. A check of the claim checks it as written, conditions included. What content may not do is say **how well something stands** beyond what is on record: "we prove", "verified", "ratified", of itself or of another piece. And it may not report a decision that is not on record. How well a piece stands is computed and never typed. **[core as of 11-10; 22's condition 7]**

Core on 11-09 said it differently: every piece has an *assertion* and a computed *warrant*, and the whole honesty rule is assertion ≤ warrant. That is shorter, and it makes every fresh claim that says "exact" an overclaim until a second mind checks it. A note there, marked for your decision, said the word "assertion" was covering two things, what is claimed and how well it stands. The paragraph above is one answer to that note. It was taken on 11-10 in the bodies and was never put to you. I think it is the right answer, because it matches your "state the currently known truth; doubt goes beside it". **[M for raising it]**

### 3.5 Decisions

A **decision** records what was chosen, about what, and its **backing**: who is accountable, who was consulted, on what grounds and assumptions, what would reopen it, and the path for revisiting it. **[J, 08-14]**

The grounds and assumptions are its **conditions**: these pieces at these versions, these claims standing at least this well. A decision is good while its conditions are true. When one stops being true the decision supports nothing, and whoever stands behind it looks again. **[22]**

A decision is made at an **importance**, and the agreement it needs rises with it: "There is different level of unity required for different levels of importance". Deciding cheaply in order to learn is good practice, and recording the importance is what keeps it safe: a cheap decision that later bears more than it was made to bear is looked at again, not silently promoted. **[J, 11-03/04; core]**

A decision is not a lock. Anyone may put a reasoned case for deciding otherwise to whoever stands behind it. A decision cited as a reason not to think is being misused. **[core, from J 08-14]**

Where the subject itself is decided (a modelling choice, a syntax choice), the alternatives, the grounds and what would reopen it are pieces like any others, so a ground that falls reaches the decision the way it reaches a claim. **[22; tested once]**

### 3.6 Canon

"canon is whatever the verisectorium says it is-- usually the main outline's non-provisional slots". **[J, 11-10]**

So: **canon** is the pieces reached from the outlines the verisectorium marks as its **roots**, through slots that are filled and not marked provisional. A piece in canon is **asserted**. A piece that is not is provisional: to canon it is only the claim that someone suggested it, and nothing inside it is held to anything. There may be more than one root. A whole canon can be un-marked at once, and what was canon is then influx to a new one. **[J, 11-09 and 11-10]**

What a piece is held to is what the roots reaching it **ask**: for the kinds of piece it gathers, which questions must be answered, by which means, and how well. A theory's outline asks that its claims have been checked; a paper drawn from it asks also that its citations have. A decision by named people is one such question. **[22; untested]**

### 3.7 Written, recorded, computed

- **Written**: versions. Content, references, which pieces fill which slots.
- **Recorded**: evidence and decisions. They only accumulate.
- **Computed**: everything about how well anything stands, and everything about what is owed. Never typed. **[09; the oldest rule in all of this]**

### 3.8 The whole declaration, for the example

You asked on 11-06 for a short way to describe each kind of verisectorium. Here is the running example's, as a test of whether Parts 2 and 3 fit in about ten lines. It is an illustration, not a syntax.

```
veritoid kinds   claim · proof-step · explanation · question
assembly kinds   derived-result: formal-claim (one claim), derivation (any number of proof-steps),
                   description (one explanation), eli8 (at most one explanation);
                   eli8 depends on description, description on formal-claim
                 outline: any number of anything, by pointing
references       predicated-on (claim to claim) · narrates (explanation to anything)
dimensions       follows?         of a claim, against logic under its hypotheses, found out,
                                  by: following the derivation | afresh | against neighbours | an instance
                 says-the-same?   of an explanation, against what it narrates, found out, by a read of both
                 read-whole?      of a derived-result, found out, by a read of all of it
determinant      follows?
root             main outline. asks: of every claim, follows? by following the derivation and one other means;
                                     of every derived-result, read-whole?
```

---

## Part 4. Change

### 4.1 Consistent

At any moment the verisectorium has a **state**: which pieces exist, each at which version, which are in canon, and everything recorded so far.

Your sentence for this part: "this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again". **[J, 11-10]**

Note 22 gave nine conditions for "consistent". You were skeptical of them before reading it, and its companion note guessed they were three ideas. I have sorted them that way and changed four. A state is consistent when, for everything in canon:

**Current: whatever relied on something still sees what it relied on.**
1. Every reference reaches something that is there.
2. No reference's target has changed, since the reference was written or re-read, in what that kind of reference relies on.
3. Every decision's conditions are true.

**Answered: everything asked has an answer that applies, and no answer that applies says no.**
4. The piece has what each root reaching it asks.
5. No evidence that applies to it says it fails, unless that evidence has been set aside.
6. Every promised or required slot has something in canon in it.
7. Every question raised about it has been answered since.

**Grounded: it stands on sound things and says no more than is so.**
8. It rests only on pieces in canon that are themselves consistent.
9. It says no more about how well anything stands than is so.

That is still nine lines. What changed from note 22: **[M, with 22a]**

- **Clause 2 is graded.** Note 22 had every reference owe a second look whenever its target got a new version. Here an outline's pointing never goes stale, and a predicated-on reference does not go stale for a change found to be the same in what is asserted. In the builds this is what let two repairs under one outline both land.
- **Clause 5 has lost its second half** (3.3).
- **Inner dependencies are gone from the list.** They are a rule about a write, below. As a standing condition with no memory of what changed, they asked for more, and by that reading note 22's own example did not close.
- **Decisions' conditions are in the list**, where note 22 had them only in its Part 3.

Some things are not owed but **refused**: the tool will not make such a state. A write to an assembly in which a piece depends, by an inner dependency, on one that changed, and was neither changed too nor **affirmed** by the author as still right. A cycle in predicated-on. An id used twice. An affirmation is the author's decision to keep something beside a change; it is never evidence. **[J, 11-05, for the write rule; the sort into owed and refused is mine, question 4 of the eight]**

Three things a verisectorium's own rules must respect, or "consistent" has no definite answer: a question, a promise or a waiver is unconditional and stands until withdrawn; evidence says what it read; and a slot may require that something fills it, never that the something be consistent. **[22 and 23; the first is proved within small bounds]**

### 4.2 The frontier

The **frontier** is every place one of the nine fails, each naming what failed and what it would take. It is computed from the state and from nothing else, and it is the first thing a mind at work looks at. **[J, 11-08]**

If the frontier keeps growing as the work goes on, the work stops and the whole is looked at: two ideas being treated as one, a real tension between two well-supported claims, or a foundation that has moved. **[09 §4.3; core. Note 22 had dropped this.]**

### 4.3 Events, checkpoints, forks

Everything that happens is an **event**, with a time: a version is written, evidence is recorded, a decision is made. Events are only ever added. **[J, 11-10]**

A state with an empty frontier is **stationary**. A **checkpoint** is a stationary state the verisectorium has rested at. At any moment the verisectorium *is* its latest checkpoint.

A **perturbation** is anything that would make it not stationary: evidence that something fails, new material, a wish to rewrite. Work on it happens on a **fork**: a line of events that starts at a checkpoint. On a fork the steps come one after another. The fork can be **rewound** to any earlier point on it, or abandoned and another started. Nothing on a fork is the verisectorium. **[J, 11-10]**

When a fork reaches a stationary state it can be **closed**: it becomes the next checkpoint. Everything between two checkpoints is an **atomic changeset**. Inside, it was many steps in sequence; from outside it is one logical instant. **[J, 11-05: "practical sequentialness but logical simultaneity"]**

Evidence is about versions, and a version is the same thing wherever it appears. So what was found out on an abandoned fork is still known on the next, and a check counts wherever its version is, whenever the check was made. Going back loses the work. It does not lose what was learned. **[22; the "whenever" repairs the one place the kernel spec leaked]**

Evidence can also arrive against a checkpoint. So a checkpoint is read in two ways: as it was rested at, with the record as it then stood; and as it stands now, with everything recorded since. The first never changes. The second can stop being stationary, and it says so until a fork closes that deals with it. **[M; question 5 of the eight]**

A known problem knowingly left is a **waiver**: a decision, with its reason, that one frontier item stays. A waived item is shown with the checkpoint. Waivers are meant to be rare. **[J, 11-05]**

Stationary can be said of a part: of what one root reaches, or of any set of pieces that nothing outside it reads. Two forks **meet** when something of one reads a piece the other changed. Two forks that do not meet can both close, in either order. **[22; proved in Ada for the function from a state to what it owes, tested on events in OCaml]**

### 4.4 The example

Checkpoint S0. Result T holds a claim c1, its derivation d1, a description e1 and an eli8 k1. Result U holds a claim u1, predicated on c1. The root asks what 3.8 says. B has checked c1 by following d1 and against a neighbouring result, and likewise u1. T and U have each been read whole.

| When | What happens | The frontier on the fork |
|---|---|---|
| 08:30 | An auditor builds a case in which c1 fails; a further hypothesis H would exclude it. That is evidence about c1, by a means nobody had used. | S0, read now, is not stationary. c1: evidence that applies says it fails. u1 rests on it. |
| 09:00 | A tries one repair: keep the hypotheses and weaken the conclusion (c1′, d1′). B checks c1′ both ways and it holds. | c1′ is fine. But u1 needs the stronger conclusion, and no version of u1 follows from c1′. |
| 10:00 | A rewinds the fork to where it stood at 08:30. | As at 08:30. The evidence about c1′ is still on record, about a version the fork no longer has. |
| 10:30 | A's second repair, in one write to T: H added to the claim (c2), the derivation reworked (d2), the eli8 rewritten (k2), and the description affirmed as still right. | c2 has no evidence: the honest lowering. T has not been read whole as it now is. u1's reference: its target changed in what it asserts. |
| 11:00 | B checks c2 by following d2, and tries the auditor's case against c2. Both hold. | T's whole read; u1. |
| 11:30 | A finds an error in step 3 and writes d3. | B's check by following read d2 and no longer applies. B's check against the auditor's case read only c2 and still does. c2 is short one means. |
| 12:00 | B checks c2 by following d3. | T's whole read; u1. |
| 13:00 | C rewrites U's claim to assume H as well (u2), against c2. B checks u2 both ways. | Whole reads of T and U. |
| 14:00 | Someone reads T whole, and U whole. | Empty. **S1.** |

What the history says: at one instant, T's claim gained H and its derivation became d3, and U's claim gained H. There was never a verisectorium in which T had H and U did not. Neither d2 nor c1′ was ever in it.

What the record holds besides: that weakening the conclusion was tried and why it was dropped; that B passed a derivation with an error in step 3; and that the original defect was found by building an instance, after two other means had passed c1. None bears on S1. All are true, and they are what a verisectorium will want when it asks whose checks, and which means, to trust.

Two decisions were made on the way: A's affirmation of the description, and the choice to narrow the claim by adding H instead of finding a proof that does not need it.

### 4.5 Better

A stationary state is feasible, not good. **Better** is a direction: later is better than earlier when, on the determinants, less of what is asserted is known wrong, or what is asserted is better supported, or it says more and stands as well. The comparison is made with everything now known, so replacing a false claim with a narrower true one is an improvement. **[22]**

Narrowing a claim that has been shown wrong is repair. Narrowing one that has only been questioned, to be rid of the question, is the cheapest way back to stationary and usually a loss. Trying first to make the stronger claim stand is the method; the model does not enforce it. **[J]**

---

## Part 5. Intake

A **source** is anything brought in. It is an assembly whose pieces are **chunks**, and the cut must cover all of it, so that "every chunk dealt with" cannot mean "found something". Each chunk says what it bears on. **[09]**

Where a chunk goes is a decision: it changed an existing piece, became a new one, was already there, was left out with a reason, or was sent to another verisectorium. A source is **retired** when every chunk has such a decision and each decision's conditions still hold. If a later rewrite drops what a chunk had delivered, that decision's conditions fail and the chunk is back. **[22, from one invented run]**

Every segment has an **inbox**: the chunks bearing on it that have not been placed, and any note a mind leaves there. It is not part of the segment. A note in an inbox, a suggested slot, a promised slot, a filled slot, an asserted piece: each commits a little more than the last, and each is cheap to do. **[J, 11-05 and 11-09]**

A claim in an old audit that something is wrong enters as a question about the piece. A claim in an old audit that something is right enters as nothing, until someone checks. **[22]**

**Things held against something outside, and time.** You called this the part of influx that needs real decisions, and kept two questions apart: "what is the likelihood of this being stale by this time" and "how long can we afford having something stale if it is stale". Read through the two kinds of answer they are one of each. How likely the source is to have moved is found out, about the source, and shared by everything that relies on it. How long staleness can be afforded is decided, per reliance, at an importance. A way to hold it that adds nothing: the outside thing is pinned by a veritoid whose content is "this source, at this version, last looked at then"; looking again is evidence; and a rule raises a question when the afforded time runs out. Untried. **[J, 11-09; the reading is core's working note]**

---

## Part 6. Who does the work

Not in the model yet, on purpose. Everything above works with every piece of evidence and every decision counting, whoever made it. Who may check what, who may decide what, what makes two checks independent, and how it is known that it was you: these are a filter over the record, to be added once the rest runs. **[J, 11-10; 22]**

One thing from that filter is worth saying now because it is half in the model already. Evidence adds only along lines that do not share a source. The means (3.1) are the part of that which does not depend on who: four checks by one means are closer to one line than to four. The rest, that a mind which began from another's summary or context is not independent of it, waits with the filter. **[core]**

---

## Part 7. One picture, and the words

```
DECLARED (per verisectorium; about ten lines; by hand for now)
  kinds        veritoid kinds: form of content, which dimensions apply
               assembly kinds: slots, inner dependencies
  references   each kind: what passes along it, how much of its target it relies on
  dimensions   each: asks, of, against, found out | decided, by which means, how read
               some marked determinant
  roots        which outlines are canon, and what each asks of what it reaches

WRITTEN                                    RECORDED (true on every fork)
  segment = veritoid | assembly              evidence: piece@version, question, means,
    id (never reused), versions (immutable)            criterion, what was read,
    veritoid: content, references                      holds | fails | in part
    assembly: slots                          same:     two versions do not differ
      empty (maybe suggested, promised)                for this purpose
      | holds a segment | points at one      decision: what, about what, backing,
    outline: also gaps                                 conditions, importance
  source = assembly of chunks

EVENTS, each with a time, only ever added: a version written; evidence; a decision

A STATE = which ids, at which versions, which in canon, and what has been recorded

COMPUTED from a state, never typed
  which evidence applies; how well each piece stands on each dimension
  whether each decision's conditions are true
  the FRONTIER: every place the state is not current, answered and grounded
  STATIONARY: the frontier is empty (of the whole, of a root's reach, or of a part)
  each segment's inbox; whether each source is retired

  checkpoint S0 ──────────────────────▶ checkpoint S1 ──▶ S2
        └─ fork: step, step, rewind, step, step ─┘
  an ATOMIC CHANGESET is what lies between two checkpoints: one logical instant

REFUSED, never a state: an inner dependent neither changed nor affirmed;
  a cycle in predicated-on; an id used twice

OUTSIDE: renderings (files, pages, the view shown to a mind about to write); praxes
```

| Word | Means |
|---|---|
| **verisectorium** | a body of work cut into pieces, adjudicated, and reassembled into results others build on |
| **influx**, **source**, **chunk** | material brought in; one such; a piece cut from it |
| **inbox** | what bears on a segment and has not been placed |
| **veritoid** | one piece of content of a declared kind |
| **kind** | what form a thing takes and what may be asked of it |
| **assembly**, **slot** | a gathering of segments; a declared place in one |
| **segment** | a veritoid or an assembly |
| **hold**, **point at** | the two ways a slot is filled |
| **empty**; **suggested**, **promised** | of a slot: nothing fills it; what may be said of it meanwhile |
| **provisional** | of a filled slot: on approval; what it holds is not in canon through it |
| **gap** | an entry in an outline: something is missing and it is not known what |
| **projection** | an assembly that mostly points |
| **inner dependency** | a declared dependence of one slot on another |
| **reference**; **predicated-on** | a written pointer; the one support travels along |
| **rests on** | is predicated on, or assumes |
| **id**, **version**, **name** | never reused; one immutable written state; a changeable label |
| **dimension**; **determinant** | one question; one that says what right consists of |
| **against**, **means** | what a piece is held to; a way of asking a question |
| **found out**, **decided** | the two kinds of answer |
| **evidence**; **applies** | that a piece at a version holds, fails or holds in part; what it read is still there |
| **same** | evidence that two versions do not differ for some purpose |
| **decision**; **backing**, **conditions**, **importance** | a choice; who stands behind it and how; what must stay true; how much rested on it |
| **rule** | a decision made in advance |
| **set aside** | a decision that a finding does not count |
| **affirmation** | an author's decision to keep a piece as it is beside a change |
| **root**, **canon**, **asserted** | an outline marked as canon; what the roots reach through non-provisional slots; in canon |
| **event**, **state** | one thing that happened, with a time; what the events on a line add up to |
| **consistent**, **frontier** | current, answered and grounded; where it is not |
| **stationary**, **checkpoint** | the frontier is empty; a stationary state rested at |
| **perturbation** | whatever would make the verisectorium not stationary |
| **fork**, **rewind**, **close** | a line of work from a checkpoint; going back along it; a fork becoming the next checkpoint |
| **atomic changeset** | what lies between two checkpoints; one logical instant |
| **waiver** | a decision that one frontier item stays, with its reason |
| **better** | less known wrong, better supported, or says more |
| **rendering**, **praxis** | text produced for a reader; what is expected of a mind that no tool enforces |

That is fifty-nine words against note 22's fifty, and I count the nine as a cost. The additions are *kind* (note 22 used it without listing it), *empty*, *inner dependency*, *against*, *means*, *applies*, *backing*, *importance*, *rule* and *affirmation*. Three of note 22's states of a slot became one state and two remarks.

You have asked that terms be nouns. Several of these are not (*found out*, *decided*, *hold*, *point at*, *rests on*, *same*, *set aside*, *consistent*, *stationary*, *better*). I have left them as the plain words they are and not coined nouns for them; which of them is a term at all is a question for Part 9.

Words in `core/` today that I have not used: *act, acta, actum, check, finding, testimony, bind, lapse, answer, carry, contest, amend, reopen, settle, unsettled, scope, seat, lineage, inheritance, standing, warrant, assertion, basis, attribute, actor, steady state*.

---

## Part 8. What differs, where I chose, and what is open

### Against note 22

| | Note 22 | Here |
|---|---|---|
| A found defect | presumed present in later versions until looked for | a rewrite leaves the piece with no evidence; the finding stays on record against the old version |
| How a dimension is declared | found out or decided; determinant or not | also what it is held against, and by what means it can be asked |
| The consistency conditions | nine in a list | the same count, sorted under three ideas; one graded, one halved, one moved to the write, one added |
| Owed or refused | all nine owed | three things refused outright |
| References | written, and stale on any new version of the target | each kind says how much of its target it relies on |
| Unfilled slots | suggested, promised, or a gap | empty, with suggested and promised said of it; a gap belongs to an outline |
| Decisions | what, about what, conditions | also backing, importance, and that a decision is not a lock |
| The frontier growing | not mentioned | work stops and the whole is looked at |
| Machinery and practical model | not distinguished | distinguished on the first page |
| The honesty rule | condition 7, unremarked | stated as a choice of yours not yet made (3.4) |
| A checkpoint with later evidence | one sentence | two readings of one checkpoint |
| Outside referents and time | not mentioned | a paragraph in Part 5, untried |
| A short declaration | Part 7's picture | written out for the example (3.8) |

### Against core

Core says most of what is here, at about ten times the length, in a form that cannot be read top to bottom. What it has that this leaves out on purpose: the actor and everything about who; the named acts about acts; seats, lineage and inheritance; changesets with computed scopes that merge; canon as an acceptance decision with a reopened, unsettled state; and the ten named frontier items. What it has that should be kept beside this and is not part of the model's statement: your own words in its Historical Context sections, and the two readings of real ASF records.

### Choices of mine you have not confirmed

In rough order of how much rides on each.

1. **No rule that a found defect persists across a rewrite** (3.3). It reverses note 22 and the 11-10 core, on my reading of what you said on 11-04 and 11-05, which I have only at second hand through note 22a.
2. **The honesty rule as stated in 3.4**: conditions are content; only statements about standing are held to the record.
3. **Means are declared by the dimension and recorded with the evidence** (3.1, 3.3). From the stopped bound. It adds to what every check must record, and the cost of recording is the open question most likely to decide everything.
4. **Each kind of reference says how much of its target it relies on** (2.3). From the builds, by way of note 22a.
5. **Inner dependencies are a rule about a write, and a failing write is refused** (4.1).
6. **Holding is containment** (2.2), so a segment held twice cannot be written down at all.
7. **A gap belongs to an outline; a declared slot nobody has touched is just empty** (2.2).
8. **Two readings of a checkpoint** (4.3).

Carried from note 22 unchanged, and still unconfirmed by you: evidence is about a version and crosses between forks; stationary can be said of a part; what a piece is held to is what the roots reaching it ask; holding and pointing are not resting; a decision about the subject has its reasons as content.

### Open, and I have not tried to close

- **Whether two forks may close because the merged state happens to be stationary, or only because they do not meet.** The first is cheaper and has a case where the answer turns on which of two writes has the later clock time. Lean: only when they do not meet, until a real verisectorium finds that too strict.
- **Whether "the same" chains.** If a is the same as b and b as c, is a the same as c with nothing more recorded? Five such judgments can each be right and the first and last still differ in what matters. Lean: no; it is said of two named versions.
- **Whether a decision's condition may be about how well another piece stands, and what happens if such conditions loop.** 3.5 allows the first. 4.1 forbids it for questions, promises and waivers only.
- **Whether clause 6 should say "in canon".** As written, a required slot filled by a draft still owes. I think that is right for canon and it has been doubted.
- **Descent.** Evidence about an old piece is lost if its replacement is entered as new material and not as a replacement. Nobody editing by hand closes most of this.
- **The cost of recording.** One real 115-line segment came to 65 pieces and some 85 references, of which the file declares one.
- **What makes two checks independent**, and **how "it was Joseph" is attested**. Set aside with Part 6.
- **Whether a problem recorded against a checkpoint shows to its readers before the repair lands.** Lean yes; it is a rendering question.
- **Delivery**: a paper drawn from a theory, sent out, and the theory then changing.
- **Whether a verisectorium really fits in ten lines** once it has more than one kind of result. 3.8 is one example.

### What this rests on

Nothing here was built or run by me. What was built: note 22's first form twice (Ada/SPARK and OCaml), and its revised Part 4 once more in each. The results I lean on are those note 23 reports, and I have not read the builders' accounts. Every place where I changed note 22 (the eight choices above) is argued here and tested nowhere. In particular, nobody has built an instance from note 22 or from this note alone; core had that test once and it was the most useful thing done to it.

---

## Part 9. A proposed outline for core

The aim: a reader holds the whole model after one text of about this length, and goes to a def file only for a word whose history or open decisions they need.

**The spine: one text, read top to bottom.** This note's Parts 1 to 7, once you have corrected it, as a single segment. It replaces `intro-spine`, `disc-written-done-computed`, `disc-better` and the five invented runs. The example in 4.4 is its one worked move.

**Def files, for the words that hold a decision nothing else can hold.** Each keeps its one-line definition, its Invariants, your words in Historical Context, and its Working Notes. Discussion and Examples go wherever the spine already says it.

| Def | Holds, as inline words |
|---|---|
| verisectorium | influx, canon, root, machinery and practical model |
| segment | veritoid, assembly, slot (empty, suggested, promised, provisional), hold, point at, gap, projection, id, version, name |
| kind | inner dependency |
| reference | predicated-on, rests on, what a kind relies on |
| dimension | determinant, against, means, found out, decided |
| evidence | applies, same, set aside |
| decision | backing, conditions, importance, rule, affirmation, waiver |
| frontier | consistent (the nine clauses), refused |
| checkpoint | event, state, stationary, perturbation, fork, rewind, close, atomic changeset |

Nine files against today's twelve. *Veritoid* folds into *segment*; *act* and *changeset* go; *steady state* becomes *checkpoint*, which reverses a rename of 11-09 that you made for a stated reason (a checkpoint sounds like a place passed through), so that one is yours to call. *Evidence* is new as a file.

**Kept as evidence, not as model.** `impl-stopped-bound` and `impl-scope-adaptive-system`, re-read against the spine once, since both were written in the old words. `disc-what-would-show-this-wrong`, rewritten shorter.

**Moved to praxes.** `disc-record-surfaces` (the four places a record can go) is how a verisectorium kept in markdown is worked. Who answers a finding, when a small edit may keep its checks, and how a wrong finding is disputed are praxis too.

**Parked whole, with their histories, for when Part 6 is taken up.** `actor`, `disc-actor`, and what `act` says about standing, seats and inheritance.

**Moved to `msc/`.** The five invented runs, and the sixteen choices queued in the outline's Working Notes, most of which this note makes unnecessary or reduces to the eight above.

**Before any of that is done**, one test that costs little: a fresh mind builds a small instance from this note alone and runs a move through it. Its findings are recorded and not answered with mechanisms.

---

## What I read, and did not

Read whole, 2026-11-18: `core/` as it stands (the outline, all twelve defs, all thirteen prose segments); core as it stood on 11-09 for its outline, spine, small move, two since-removed discussions, and the dimension, act and frontier defs; notes 09, 19, 22, 22a, 23, 24 and 26; your prompts from the evening of 11-10 through 11-11; five memory files of this project.

Not read: `core/log.kdl`; notes 01 to 08, 10 to 18, 20, 21 and 25; the first core; the kernel spec and both builders' accounts; the cold reads and trial instances in `msc/scratch/`; the census; your prompts before the evening of 11-10; the councils dialog. Where I cite your words from before 11-10 I have them from core's Historical Context sections or from notes 22 and 22a, not from the primary.
