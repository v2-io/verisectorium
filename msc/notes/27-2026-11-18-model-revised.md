# The model, revised from note 22

*To Joseph, from the Fable 5.2 session of 2026-11-18, who arrived cold after your week away. You asked for a revised note 22 from fresh eyes, with a proposed outline for a new core near the end. This is my synthesis. Nothing in it is accepted, and I have built and run nothing.*

*This is the second draft. The first (commit `e54c184`) was the pass where I worked the model through in detail; this one asks what can be left out. Between the two, a fresh reader went through what I had not read and wrote `27-2026-11-18-model-revised.feedback-1.md`, beside this file. It is the same model as I am and I dispatched it, so it is one line of evidence with this note, not a second. It changed my mind in four places, which Part 8 names, and it holds a good deal that I chose not to bring in.*

*Read it top to bottom. Each word is introduced before it is used, and one example runs through. Part 7 is the picture and the words. Part 8 says how this differs from note 22, where I chose, and what is open. Part 9 is about core.*

*Marks at the end of a paragraph say where an idea came from: **[J]** yours, with the date where I have it; **[22]** note 22 or its companions 22a and 23; **[core]** `core/` as it stands; **[09]** that note; **[fb]** something I have only through the feedback file; **[M]** mine, and the least tested. A mark is not a reason to believe the idea.*

---

## Part 1. What a verisectorium is for

A **verisectorium** is a place where material is cut up until each piece can be right or wrong on its own, the pieces are adjudicated, and they are put back together into results that other people read and build on. It is worked on by many minds who each arrive knowing nothing about it. **[J, 11-08]**

The work goes round like this:

1. **Bring in.** Material arrives from outside what is settled: a paper, an audit, a spike, an old file, a mind's note. This is **influx**.
2. **Cut and place.** The material is cut into pieces, all of it, and each piece is put somewhere: into something that exists, into something new, or left out with a reason.
3. **Adjudicate.** Questions are asked of each piece, and each answer is either found out or decided.
4. **Stabilize.** Anything new, and anything found wrong, leaves some things inconsistent with others. Work goes on until everything is consistent again.
5. **Build on.** What is consistent is what others read, cite and build further results on. Then something new arrives.

Everything after this page is **machinery**: what has to be recorded and computed so that the round above can be trusted while many minds turn over. A mind at work does not meet the machinery. It meets a practical model built on it: an outline with marked slots, document-like pieces shown as text, an inbox beside each, a list of what is owed, a place where the work rests. What the machinery cannot enforce is written for the mind as a **praxis**. **[J, 11-08; core]**

Three things the October sprint showed that the model has to make impossible or at least visible: nobody could tell "found everything" from "found something"; checks and fixes fed each other; and no source was ever retired. And one rule: nobody edits a verisectorium by hand. Where the tool cannot express a change, that is how we learn what the tool lacks. **[J, 10-30 to 11-04; 09]**

One example runs through the rest: a derived result with a formal claim, its derivation, a description, and an "explain it to an eight-year-old" paragraph. **[J, 11-05]**

---

## Part 2. What exists

### 2.1 Pieces

The smallest thing is a **veritoid**: one piece of content of a declared **kind**. A formal statement, a step of a derivation, a paragraph of explanation, a question, the wording of a design choice. A kind says what form the content takes and which questions may be asked of it. **[J, 11-05]**

A veritoid almost never makes sense alone. An **assembly** gathers pieces. Its kind declares **slots**, each saying what kind of thing fills it, how many, and whether it is required. A **segment** is either a veritoid or an assembly, so one thing does the work at every depth: a result is an assembly of veritoids, a chapter an assembly of results, a theory an assembly of chapters. **[J, 11-09]**

A slot is filled in one of two ways. An assembly holds a segment that lives in it and is written with it, as a result holds its claim. Or it points at a segment that lives elsewhere, as a chapter points at a result. An outline of the whole work is an assembly that mostly points.

A slot may be filled on approval: it is marked **provisional**. A slot that is not yet filled may carry a suggestion (someone thinks something might go here; it commits nobody) or a promise (someone in the work has said this will exist). And where something is known to be missing and it is not yet known what, a **gap** stands in for it: a segment of a gap kind, which says what is known about the hole, and which another piece may rest on knowing how unsteady that is. **[J, 11-06 and 11-09]**

Kinds also declare which slots depend on which: the eli8 on the description, the description on the claim. That is why the pieces of a result are looked at together when one of them moves. **[J, 11-05]**

### 2.2 References

A veritoid points at other pieces. A **reference** is written by an author and can be wrong. Each kind of reference says what it relies on in its target and what passes along it. Four are enough for everything below; a verisectorium may declare more.

| Reference | Meaning | Relies on | What passes along it |
|---|---|---|---|
| predicated-on | this claim needs that one to be true | what the target asserts | support, and its limit |
| assumes | this claim is stated under that hypothesis | what the target says | nothing: a conditional claim is no less valid for a doubtful hypothesis |
| narrates | this talks about that | what the target says | nothing; the telling is re-read when the target moves |
| pointing (a slot) | this is a member | only that the target exists | nothing |

A piece **rests on** what it is predicated on, and it stands no better than what it rests on: when a premise drops, the question for everything downstream is "can this still be called a theorem?" Holding and pointing are not resting. A chapter does not become doubtful because one of its results is being repaired; it shows the result's state. **[J, 11-05, for the limit; 22 and one built instance for the last; *assumes* is from a real derivation run through core, fb]**

### 2.3 Identity and versions

Every segment has an id, made once and never reused, and a freestanding one has a name, which may change. When a piece is split, merged or replaced, the new ids record which old one they descend from.

A **version** is one written state of one id. Versions are never changed. Rewriting a piece makes a new version of the same id, and the old version is still exactly what it was.

---

## Part 3. Questions and answers

### 3.1 Dimensions

A **dimension** is one question that can be asked of a piece and answered independently of the others. Two things that can move independently never share a dimension. **[J, since August]**

A verisectorium declares each dimension by saying what it asks, and of which kinds; what the piece is held **against** (logic, the world, its own canon, or something the piece itself names, such as the source it quotes); whether the answer is found out or decided; and **what produces the answer**. A question nothing will ever answer is a wish. **[core]**

Where a question can be asked in more than one way, the ways are its **means**. For "does it follow?": following the written derivation, deriving it afresh, setting it against its neighbours' results, building an instance. They are in the model because of the one real failure it has been read against. A proposition in AAT was false for six months and was passed by several minds, and as far as the record shows every pass followed the same written proof. What broke it was a different way of asking. A record that says "checked, passed" four times cannot show that all four asked the same way. **[core, `impl-stopped-bound`]**

Some dimensions are marked as **determinants**: the ones that say what being right consists of for this work. **[J, 11-08]**

### 3.2 Two kinds of answer

Every answer is one of two kinds, and everything else is built from them: "the two critical atomic components that everything else ends up reducing to". **[J, 11-04 and 11-10]**

A dimension is **found out** when its answer is a truth claim about the piece. It stands by **evidence**.

A dimension is **decided** when its answer is a choice someone made. It stands because that someone stands behind it.

They rest on each other. A decision's grounds are truth claims. Every piece of evidence is at bottom something someone or something attested, and where the chain of "and what supports that?" stops is a decision. A measurement is an instrument attesting a truth claim. An automated action is a decision made in advance, which is what a rule is. **[J, 11-10]**

### 3.3 Evidence

A piece of **evidence** says: this piece, at this version, asked this question, in this way, against a criterion fixed before the outcome was seen, was found to hold, or to fail, or to hold in part. It also says what else was read to find that out: the derivation, the premises. **[22; core]**

A version never changes, so evidence about it never stops being true. What changes is whether it has anything to say about the verisectorium as it now is. Evidence **applies** while everything it read is still there at the version it read. Rewrite the claim, or the derivation a check followed, and that check no longer applies. Someone may find that two versions are the same for the purposes of some evidence (a reflow, a clearer word order); that finding is itself evidence, and it lets the earlier evidence apply to the later version. **[22]**

**So a change lowers certainty by itself.** A rewritten piece has no evidence that applies to it until someone checks it. "I was kind of hoping that a content change would automatically lower the certainty". **[J, 11-04, fb]**

**And bad news asks a question.** Evidence that a piece fails does a second thing: it puts a **question** to the piece, "is what was found still there?" A question is about the piece and not about a version. It stands until someone answers it. So after a repair the piece is unchecked, which is the honest lowering, and the question is still open, which is why rewording is not a way out. **[M, from parts 22 already had; see Part 8 for why this is the third position on the point]**

A finding can itself be wrong. Then someone with reason to say so sets it aside, as a decision, and the piece is left alone. **[22, from the builds]**

### 3.4 What content may say about itself

This is the honesty rule. It has changed twice, so I put it to you as a choice.

A claim's own conditions are content: "exact", "conditional on (S1) to (S5)", "to leading order" say what is claimed, and a check of the claim checks it as written. What content may not do is say how well something stands beyond what is on record ("we prove", "verified", "ratified"), or report a decision that is not on record. How well a piece stands is computed and never typed. **[core as of 11-10; 22]**

Core on 11-09 said: every piece has an assertion and a computed warrant, and the whole honesty rule is assertion ≤ warrant. That is shorter, and it makes every fresh claim that says "exact" an overclaim until a second mind checks it. A note there, marked for your decision, said "assertion" was covering two things. The paragraph above is one answer to it, taken in the bodies on 11-10 and never put to you. I lean to it, because it matches "state the currently known truth" with doubt put beside it. **[J, 11-06, fb]**

Two things to know before choosing. Under this reading the rule has never fired in any run of any example, so either it is vestigial or a kind must be able to say which sentences are about standing. And theory segments report their own numerics as a matter of course ("agrees to three decimals"), which this rule cannot place; the one mind that met it made the sentence a claim of its own, held against a script. **[fb: the fourth cold read, and the second trial]**

### 3.5 Decisions

A **decision** records what was chosen, about what, and its backing: who is accountable, who was consulted, on what grounds and assumptions, what would reopen it, and the path for revisiting it. **[J, 08-14]**

The grounds and assumptions are its conditions: these pieces at these versions, these claims standing at least this well. A decision is good while its conditions are true. When one stops being true the decision supports nothing, and whoever stands behind it looks again. **[22]**

A decision is made at an importance, which is always importance for something, and the agreement it needs rises with it: "There is different level of unity required for different levels of importance". Deciding cheaply in order to learn is good practice, and recording the importance is what keeps it safe: a cheap decision that later bears more than it was made to bear is looked at again, not silently promoted. **[J, 11-03/04; core]**

A decision is not a lock. Anyone may put a reasoned case for deciding otherwise to whoever stands behind it. **[core, from J 08-14]**

### 3.6 Canon

"canon is whatever the verisectorium says it is-- usually the main outline's non-provisional slots". **[J, 11-10]**

So **canon** is the pieces reached from the outlines the verisectorium marks as its **roots**, through slots that are filled and not provisional. A piece outside canon is, to canon, only the claim that someone suggested it. There may be more than one root. A whole canon can be un-marked at once, and what was canon is then influx to a new one. **[J, 11-09 and 11-10]**

What a piece is held to is what the roots reaching it ask: for each kind of piece, which questions must be answered and how well. A theory's outline asks that its claims have been checked; a paper drawn from it asks also that its citations have. The determinants do not weigh equally, and the weight is the root's too: it follows the purpose. **[22; J, 11-09]**

### 3.7 Written, recorded, computed

- **Written**: versions. Content, references, which pieces fill which slots, and, where a kind has a slot for it, an account of how a piece came to be as it is.
- **Recorded**: evidence, questions and decisions. They only accumulate.
- **Computed**: everything about how well anything stands, and everything about what is owed. Never typed. **[09; the oldest rule in all of this]**

### 3.8 The whole declaration, for the example

You asked on 11-06 for a short way to describe each kind of verisectorium. Here is the running example's. It is an illustration, not a syntax, and it is this short only because the four references and their behaviour are shared.

```
veritoid kinds   claim · hypothesis · proof-step · explanation
assembly kinds   derived-result: formal-claim (one claim), derivation (any number of proof-steps),
                   description (one explanation), eli8 (at most one explanation);
                   eli8 depends on description, description on formal-claim
                 outline: any number of anything, by pointing
dimensions       follows?        of a claim, against logic under what it assumes; found out, by a mind,
                                 by following the derivation | afresh | against neighbours | an instance
                 says-the-same?  of an explanation, against what it narrates; found out, by a read of both
                 read-whole?     of a derived-result; found out, by a read of all of it
determinant      follows?
root             main outline. asks: every claim follows?; every derived-result read-whole?
```

---

## Part 4. Change

### 4.1 Consistent

At any moment the verisectorium has a **state**: which pieces exist, each at which version, which are in canon, and everything recorded so far.

Your sentence for this part: "this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again". **[J, 11-10]**

Note 22 spelled "consistent" out as nine conditions, and you were skeptical of them before reading it. I think they are three ideas. A state is consistent when everything in canon is:

- **Current.** Whatever relied on something still sees what it relied on: every reference reaches something that is there and unchanged in what that reference relies on, and every decision's conditions are true.
- **Answered.** It has what the roots reaching it ask; no evidence that applies says it fails, unless set aside; and every question put to it and every promise made about it has been met.
- **Grounded.** It rests only on pieces that are themselves consistent, and it says no more about how well anything stands than is so.

One thing is not a condition on a state but a rule about a write. When a piece changes, each piece that depends on it inside the same assembly is either changed in the same write or **affirmed** by the author as still right. A write that does neither is still a draft. An affirmation is the author's decision; it is never evidence. **[J, 11-05]**

### 4.2 The frontier

The **frontier** is every place a state is not consistent, each naming what failed and what it would take. It is computed from the state and from nothing else, and it is the first thing a mind at work looks at. **[J, 11-08]**

An item leaves the frontier when the work is done, or by one of a few decisions that do no work: an affirmation, a finding that two versions are the same, a setting-aside, a waiver (below). Each has a name on it and each is shown where the work rests.

If the frontier keeps growing as the work goes on, the work stops and the whole is looked at: two ideas being treated as one, a real tension between two well-supported claims, or a foundation that has moved. **[09; core]**

### 4.3 Events, checkpoints, forks

Everything that happens is an **event**, with a time and whoever did it: a version is written, evidence is recorded, a decision is made. Events are only ever added. **[J, 11-10; and 11-02 for who, fb]**

A state with an empty frontier is stationary. A **checkpoint** is a stationary state the verisectorium has rested at, and at any moment the verisectorium *is* its latest checkpoint: true as stated, with its conditions. The conditions are shown with it: what was waived, what was set aside, which determinant questions have never been asked, and anything recorded against it since it was reached. **[J, 11-09 for "with its conditions"; core]**

A perturbation is anything that would make it not stationary: evidence that something fails, new material, a wish to rewrite. Work on it happens on a **fork**: a line of events that starts at a checkpoint. On a fork the steps come one after another. The fork can be rewound to any earlier point on it, or abandoned and another started. Nothing on a fork is the verisectorium. **[J, 11-10]**

When a fork reaches a stationary state it can be closed: it becomes the next checkpoint. Everything between two checkpoints is an **atomic changeset**. Inside, it was many steps in sequence; from outside it is one logical instant. **[J, 11-05: "practical sequentialness but logical simultaneity"]**

Evidence is about versions, and a version is the same thing wherever it appears. So what was found out on an abandoned fork is still known on the next, and a check counts wherever its version is, whenever it was made. Going back loses the work. It does not lose what was learned. **[22]**

A known problem knowingly left is a **waiver**: a decision, with its reason, that one frontier item stays. Waivers are meant to be rare. **[J, 11-05]**

Stationary can be said of a part: of what one root reaches, or of any set of pieces that nothing outside it reads. Two forks meet when something of one reads a piece the other changed. Two forks that do not meet can both close, in either order. **[22; proved in Ada for the function from a state to what it owes, in the earlier wording of the conditions]**

### 4.4 The example

Checkpoint S0. Result T holds a claim c1, its derivation d1, a description e1 and an eli8 k1. Result U holds a claim u1, predicated on c1. The root asks what 3.8 says. B has checked c1 by following d1, and u1 likewise. T and U have each been read whole.

| When | What happens | The frontier on the fork |
|---|---|---|
| 08:30 | An auditor builds a case in which c1 fails; a further hypothesis H would exclude it. That is evidence about c1, by a means nobody had used, and a question to c: is the failure still there? | S0 is no longer stationary, and shows it. c1 fails. u1 rests on it. |
| 09:00 | A tries one repair: keep the hypotheses and weaken the conclusion (c1′, d1′). B checks c1′ and tries the auditor's case against it; both hold. | c1′ is fine. But u1 needs the stronger conclusion, and no version of u1 follows from c1′. |
| 10:00 | A rewinds the fork to where it stood at 08:30. | As at 08:30. What was learned about c1′ is still on record, about a version the fork no longer has. |
| 10:30 | A's second repair, in one write to T: the claim now assumes H (c2), the derivation is reworked (d2), the eli8 rewritten (k2), and the description affirmed as still right. | c2 has no evidence: the honest lowering. The auditor's question is still open. T has not been read whole as it now is. u1's reference: its target changed in what it asserts. |
| 11:00 | B checks c2 by following d2, and tries the auditor's case against c2. Both hold. | The question is answered. Left: T's whole read; u1. |
| 11:30 | A finds an error in step 3 and writes d3. | B's check by following read d2 and no longer applies. The answer to the auditor's question read only c2 and still stands. c2 is unchecked again. |
| 12:00 | B checks c2 by following d3. | T's whole read; u1. |
| 13:00 | C rewrites U's claim to assume H as well (u2), against c2. B checks u2. | Whole reads of T and U. |
| 14:00 | Someone reads T whole, and U whole. | Empty. **S1.** |

What the history says: at one instant, T's claim gained H and its derivation became d3, and U's claim gained H. There was never a verisectorium in which T had H and U did not. Neither d2 nor c1′ was ever in it.

What the record holds besides: that weakening the conclusion was tried and why it was dropped; that B passed a derivation with an error in step 3; and that the defect was found by building an instance after following the proof had passed it. None bears on S1. All are true, and they are what a verisectorium will want when it asks whose checks, and which ways of asking, to trust.

Two decisions were made on the way: A's affirmation of the description, and the choice to narrow the claim by adding H instead of finding a proof that does not need it.

### 4.5 Which way is forward

A stationary state is feasible, not good. Later is better than earlier when, on the determinants as the root weighs them, less of what is asserted is known wrong, or what is asserted is better supported, or it says more and stands as well. The comparison is made with everything now known, so replacing a false claim with a narrower true one is an improvement. **[22; J, 11-09]**

Narrowing a claim that has been shown wrong is repair. Narrowing one that has only been questioned, to be rid of the question, is the cheapest way back to stationary and usually a loss. Trying first to make the stronger claim stand is the method; the model does not enforce it. **[J]**

---

## Part 5. Intake

A **source** is anything brought in. From the moment it is known of, the verisectorium can say whether it has been read, by whom, and how far it has been cut; "unread" is something one can ask for. It is cut into **chunks**, and the cut must cover all of it, so that "every chunk dealt with" cannot mean "found something". Each chunk says what it bears on. **[09; 02 by way of fb]**

Where a chunk goes is a decision: it changed an existing piece, became a new one, was already there, was left out with a reason, or was sent to another verisectorium. A source is retired when every chunk has such a decision and each decision's conditions still hold. If a later rewrite drops what a chunk had delivered, that decision's conditions fail and the chunk is back. **[22, from one invented run]**

Every segment has an **inbox**: the chunks bearing on it that have not been placed, and any note a mind leaves there. It is not part of the segment. A note in an inbox, a suggestion on a slot, a promise, a provisional filling, a piece in canon: each commits a little more than the last, and each is cheap to do. **[J, 11-05 and 11-09]**

A claim in an old audit that something is wrong enters as a question about the piece. A claim in an old audit that something is right enters as nothing, until someone checks. **[22]**

**Things held against something outside, and time.** You called this the part of influx that needs real decisions, said most veritoids will end up needing it, and kept two questions apart: "what is the likelihood of this being stale by this time" and "how long can we afford having something stale if it is stale". Read through the two kinds of answer they are one of each. How likely the source is to have moved is found out, about the source. How long staleness can be afforded is decided, per reliance, at an importance. Nothing here has been tried on it. **[J, 11-09; the reading is core's working note]**

---

## Part 6. Who does the work

Who did each thing is always recorded. Whose evidence counts, who may decide what, what makes two checks independent, and how it is known that it was you: these are a filter over the record, to be added once the rest runs. Until then every piece of evidence and every decision counts, whoever made it. **[J, 11-10]**

---

## Part 7. One picture, and the words

```
DECLARED (per verisectorium; short; by hand for now)
  kinds        of veritoid: form of content, which questions apply
               of assembly: slots, and which depend on which
  dimensions   each: asks, of, against, found out | decided, what produces the answer
               some marked determinant
  roots        which outlines are canon; what each asks of what it reaches, and how it weighs

WRITTEN                                    RECORDED (true on every fork)
  segment = veritoid | assembly              evidence: piece@version, question, how asked,
    id (never reused), versions (immutable)            what was read, holds | fails | in part
    veritoid: content, references            question: put to a piece; stands until answered
    assembly: slots, each                    decision: what, about what, backing,
      unfilled (maybe suggested, promised)             conditions, importance
      | holds a segment | points at one
  source = assembly of chunks

EVENTS, each with a time and who, only ever added

A STATE = which ids, at which versions, which in canon, and what has been recorded

COMPUTED from a state, never typed
  which evidence applies; how well each piece stands; whether each decision's conditions hold
  the FRONTIER: every place the state is not current, answered and grounded
  each segment's inbox; whether each source is retired

  checkpoint S0 ──────────────────────▶ checkpoint S1 ──▶ S2
        └─ fork: step, step, rewind, step, step ─┘
  an ATOMIC CHANGESET is what lies between two checkpoints: one logical instant

OUTSIDE: what is shown to a reader or to a mind about to write; praxes
```

**The terms**, which are all nouns, each something the model would be incomplete without a name for:

| Term | Means |
|---|---|
| **verisectorium** | a body of work cut into pieces, adjudicated, and reassembled into results others build on |
| **segment**: **veritoid**, **assembly** | a piece of the work: one piece of content of a declared kind, or a gathering of segments |
| **kind**, **slot** | what form a thing takes and what may be asked of it; a declared place in an assembly |
| **gap** | a segment standing in for something known to be missing |
| **reference** | a written pointer from one piece to another |
| **version** | one immutable written state of a piece |
| **dimension**, **determinant** | one question; one that says what being right consists of |
| **evidence** | that a piece at a version holds, fails or holds in part, and how that was asked |
| **question** | something put to a piece that stands until answered |
| **decision** | a choice, with who stands behind it and what must stay true for it to be good |
| **waiver** | a decision that one frontier item stays, with its reason |
| **root**, **canon** | an outline marked as canon; what the roots reach through slots that are not provisional |
| **event**, **state** | one thing that happened; what the events on a line add up to |
| **frontier** | every place a state is not consistent |
| **checkpoint**, **fork** | a stationary state rested at; a line of work from one |
| **atomic changeset** | what lies between two checkpoints |
| **source**, **chunk**, **inbox** | material brought in; a piece cut from it; what bears on a segment and has not been placed |
| **praxis** | what is expected of a mind that no tool enforces |

Twenty-seven. Everything else in this note is a plain word used in its ordinary sense and held to it: *hold, point at, suggested, promised, provisional, rests on, predicated-on, assumes, narrates, against, means, found out, decided, applies, the same, set aside, affirmed, backing, conditions, importance, rule, consistent (current, answered, grounded), stationary, perturbation, rewind, close, retired, better*. That is thirty more, so the count of things a reader meets has not fallen below note 22's fifty. What has changed is that half of them ask nothing of the reader but English. You have said terms should be nouns and that *better* should not be one; this is my attempt at both. **[J, 11-07, fb]**

---

## Part 8. What differs, where I chose, and what is open

### Against note 22

| | Note 22 | Here |
|---|---|---|
| A found defect | presumed present in later versions until looked for | a failing check puts a question to the piece, which stands until answered; the rewritten piece is also simply unchecked |
| A dimension | found out or decided; determinant or not | also what it is held against, what produces the answer, and the ways of asking |
| Consistent | nine conditions | three ideas; one of the nine became a rule about a write |
| References | stale on any new version of the target | each kind says what it relies on; *assumes* added |
| A piece and its premises | "at least what it needs", as one of nine | stands no better than what it rests on |
| A gap | a state of an unfilled slot | a segment that stands in for what is missing |
| Decisions | what, about what, conditions | also backing and importance, and that a decision is not a lock |
| A checkpoint | shown with its waivers | shown with its conditions, including what has been recorded since |
| The frontier growing | not mentioned | work stops and the whole is looked at |
| Who | left out | recorded always; who counts is left out |
| The honesty rule | one of nine, unremarked | a choice not yet made, with what is known against each side |
| Machinery and practical model | not distinguished | distinguished on the first page |
| A short declaration | none | written out for the example |

### Where the feedback changed my mind

1. **A found defect.** My first draft dropped note 22's rule and put nothing in its place. The feedback found your 11-04 words for the lowering, and against my draft: on the one real record run through core, every piece of bad news was a narrowing that wanted a rewrite; vsect practice keeps such findings open across rewrites until a second mind answers; and one builder's search found that rewording anything a finding had *read* shed the finding. It also pointed out that my draft already let a relayed complaint outlast rewrites, as a question, while a first-hand failing check did not. 3.3 now has one mechanism for both.
2. **A gap.** I had made it an entry in an outline. Your 11-06 words have it as a kind of segment that things can rest on.
3. **The limit along what a piece rests on.** I had folded it away. Your 11-05 words are specific, and a paper's root resting on a theory's pieces needs it.
4. **Part 9.** I had proposed this note's text as a spine beside the def files. That is the shape core began in on 11-08, and you had it taken apart because a long text that restates the defs is a second surface that can drift.

### Choices of mine you have not confirmed

1. **Bad news asks a question of the piece** (3.3). What counts as an answer is not said here, and that is exactly where the two builds found holes in note 22's wording. On the estate's practice the answer comes from a mind other than the repairer, which belongs with Part 6.
2. **The honesty rule as in 3.4.**
3. **A check records how it asked** (3.1, 3.3). It adds to what every check must record, and the cost of recording is the open question most likely to decide everything.
4. **Each kind of reference says what it relies on** (2.2).
5. **Dependence between slots is a rule about a write** (4.1). On one real derivation there were about sixty such dependences, and the choice was a reference nobody wrote or thirty affirmations per edit. **[fb]**
6. **Three ideas in place of nine conditions** (4.1). The proofs were about the nine in an earlier wording. What each condition reads has changed in four places, and the builders named exactly that as the thing to re-check.

Carried from note 22 and still unconfirmed by you: evidence is about a version and crosses between forks; stationary can be said of a part; what a piece is held to is what the roots reaching it ask; holding and pointing are not resting.

### Open, and I have not tried to close

- **What counts as answering a question**, and whether a promise may stand at a checkpoint without a waiver. You said on 11-09 that a minority of verisectoria would allow the second.
- **Whether two forks may close because the merged state happens to be stationary, or only because they do not meet.** Lean: only when they do not meet.
- **Whether a decision's condition may be about how well another piece stands.** The builds found it circular when a root asks a decided question, unless the conditions are plain ones. **[fb]**
- **Evidence about the world that read nothing written** ("I asked six users"), and **a check against a whole set** ("consistent with every other rule"). Both came up in the one built instance and neither is placed here. **[fb]**
- **Work that is owed and is not a failure of anything.** ASF's largest ledger is 632 such items. A question put by a decision can hold them, if it can be addressed to someone. **[fb]**
- **The declaration itself changing** under a verisectorium that already has canon.
- **Descent**: evidence and questions about a piece are lost if its replacement is entered as new material.
- **The cost of recording.** One real 115-line segment came to 65 pieces and some 85 references, of which the file declares one.
- **What makes two checks independent**, and **how "it was Joseph" is attested**.
- **Delivery**: a paper drawn from a theory, sent out, and the theory then changing.

### What this rests on

Nothing here was built or run by me. Note 22's first form was built twice, and its revised Part 4 once more in each language; I have those results from note 23 and the feedback, not from the builders' accounts. Intake has not been built by anyone, so the first two steps of Part 1 are the least tested part of the model. The feedback file holds more than I brought in. I left out what I could not connect to something a mind at work would see or do differently, and that judgment is mine and untested.

---

## Part 9. What I would do with core

Not what my first draft said. A note like this is the latest in a line (09, 19, 20, 22), each a whole-model statement by a mind that arrived cold, each correcting the last in part. You described that line on 11-08 as the way that does not work under turnover, and asked that core "accumulate additional nuance and correctness every iteration" instead. So this note should feed core and then stop mattering. **[J, 11-08, fb]**

**1. The choices go to core as working notes.** Each of the six above, and whichever of the open items you think bear, goes into the Working Notes of the def it concerns, whole and not as a pointer. This note is then influx that has been cut.

**2. Core is cut down in its own form, one def at a time, in outline order, with you.** For each def: the body is brought to what the model at this size says, and it is put to the vote when I would stand behind it. What I would expect to go, by def:

| Def | What I would expect |
|---|---|
| verisectorium | stays; canon by roots moves from its working notes into its body |
| segment | absorbs veritoid; settled/unsettled/reopened goes; gap becomes a kind |
| kind | stays, shorter |
| dimension | keeps against, what produces the answer, means, determinant; assertion and warrant go if you take 3.4 |
| reference | says what each kind relies on; *assumes* added |
| act | becomes evidence and question; the four acts about acts go to praxis |
| decision | stays, close to as it is; basis becomes conditions |
| actor | parked whole until Part 6 is taken up |
| changeset, steady·state | become events, forks and checkpoints. *Steady state* was your rename of 11-09, for a stated reason; notes 22 and 23 went back to *checkpoint* after your words of 11-10. The name is yours to call |
| frontier | three ideas in place of ten named items |

**3. The size comes down mostly by saying each thing once.** The fourth cold read found that core's length is the same text in two or three places (the two atoms in the spine, in decision and in verisectorium; the actor in its def and its discussion). The one-home rule is stated for invariants only. Extending it to everything is where I would expect most of the words to go. **[fb]**

**4. The top-to-bottom read is assembled, not written beside.** `core/nutshell.outline.md` and `bin/nutshell` already do this: a reading path that pulls each def's one-line and Intro in a chosen order, so that nothing is copied and nothing can drift. Its known limit is that it cannot introduce the plain words, which live as rows of the outline. If each def's Intro is written to be read in sequence and to introduce the plain words it leans on, the nutshell becomes the text this note is trying to be. Parts 2 to 5 here, cut up, are a draft of those Intros.

**5. The invented runs.** Four of the five are where the vocabulary grew, and I would move them out of the outline once what they hold has been read whole and placed. `impl-stopped-bound` and `impl-scope-adaptive-system` are readings of real records and stay.

**On testing it.** Both trials said that building an instance found what reading could not, and core's one cold build was the most useful thing done to it. You have also said why you hesitate: whoever goes deep enough into a real instance comes back thinking about its domain, and a lead running small examples starts adding mechanisms. And the candidates you named on 11-09 (Logos 04 smallest) are none of them a mathematical theory, which is the only kind this note's example exercises. If it is done, I would write down beforehand what result would show the model wrong, give the builder this note or the assembled nutshell and nothing else, and record what comes back without answering it. **[fb]**

---

## What I read, and did not

Read whole, 2026-11-18: `core/` as it stands (the outline, all twelve defs, all thirteen prose segments, the nutshell outline and its script); core as it stood on 11-09 for its outline, spine, small move, two since-removed discussions, and the dimension, act and frontier defs; notes 09, 19, 22, 22a, 23, 24 and 26; the feedback file beside this note; your prompts from the evening of 11-10 through 11-18; five memory files of this project.

Not read: `core/log.kdl`; notes 01 to 08, 10 to 18, 20, 21 and 25; the first core; the kernel spec and both builders' accounts; the cold reads and trial instances in `msc/scratch/`; the census; `slot-rollup.md`, `segment-kinds.md`, `relevant-mental-models.md`; your prompts before the evening of 11-10; the councils dialog. Where I cite your words from before 11-10 I have them from core's Historical Context sections, from notes 22 and 22a, or from the feedback file, which quotes them from `history.jsonl`. I have not opened the primary for any of them.
