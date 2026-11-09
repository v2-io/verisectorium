```kdl
term "act" pos=noun pl="-s" {
  subtypes "check" "finding" "attestation" "crossing" "rule·firing" "outside·change"
  avoid "event" "an earlier model's events were each about one record only"
  rel answers term="dimension" card="{1,1}"
  rel reads term="veritoid" card="{0,N}" note="each at a version, or a piece's warrant on a dimension; what the act binds to"
  rel concerns term="veritoid" card="{0,N}" note="a subset of what it reads; what the act attests"
  rel belongs-to term="changeset" card="{1,1}" note="the atomic changeset it falls in; alone, it is one of size one"
  rel by term="actor" card="{1,1}"
  rel concerns term="actor" card="{0,N}" note="an orientation check concerns a mind"
}
status provisional
```

# «act»
One recorded thing an attested actor did against a state: it reads things at their versions, concerns a subset of them, answers one dimension, and binds while what it read is unchanged.

## Definition
Every act records: its «actor» (read from the harness, never typed; a new actor at every discontinuity, compaction included); the state it was performed against; what it **read**, each at its version: a veritoid's whole written state, or only its assertion on a dimension, or only its warrant on a dimension when that is all the act relied on (a review of a chapter that read each member's headline and assertion, not its proof steps); what it **concerns**, a subset of what it read; the «dimension» it **answers**; and its outcome. A read of a warrant lapses only when that warrant *falls*; a confirming check that raises it lapses nothing, so good news never undoes a review. A ‹check› also records the criterion fixed before its outcome was seen. An act **binds** while every one of its reads is unchanged; the moment any read changes it lapses, and which read can be named. A lapsed act warrants nothing. The warrant of a piece on a dimension is read, as the dimension declares, from the acts that still bind and concern it.

Acts are of two sorts:

- **Finding out**: a ‹check› (criterion first; outcome confirmed, narrowed or broken), a ‹finding› (something is broken, found without a criterion fixed in advance, so it carries no weight as a confirmation), a run, a review. A later act can overturn an earlier one.
- **Making so**: an ‹attestation›. "I decided this." "I read this." "I affirm this unchanged piece against what changed" (an affirmation, carried inside a segment changeset). "I accept this owed item, for this reason" (an acceptance). "I ruled." Nothing convicts these by running anything; only the attesting party can correct one, or someone can show it never happened.

A run is a ‹check› whose actor is an instrument at a version. Reading is recorded as the dimension's producer declares: a reader's own word ("I read this") is an ‹attestation›, and for a ‹mind› that may have been compacted it is the least trustworthy act in the acta, so an orientation dimension's producer is a ‹check› the actor cannot pass by reading during the check (a sealed, sampled, closed-book completion), concerning the actor. Two more sorts exist so that nothing moves a warrant silently: a ‹rule·firing› (a declared rule over attributes raised a question or moved a reading, at a definite moment) and an ‹outside·change› (something neither corpus nor acta hold moved: a simulator's version, a cited work, a date a rule cares about; recorded at a moment). A ‹crossing› is the act that records where a chunk went; its outcome is one of: changed an existing piece, became a new piece, already present, one more independent arrival (evidence, not a duplicate), superseded or rejected with a reason, delivered to another verisectorium, or passed to a segment's inbox, which is not final.

### Invariants
- It never changes what is written.
- It binds to exactly what it read, and lapses when any of it changes (a warrant read: when it falls). Reading a premise without concerning it is how a re-derivation reads its context honestly without certifying it.
- It answers one dimension, named. A record that says only "checked, passed" cannot be told from one that answered a different question, and that is how the stopped bound survived fourteen passes.
- A broken ‹check› or a ‹finding› goes on the record when it happens, before anyone has written a repair, and owes an item on the «frontier».
- Whose acts count is the dimension's *produced by*, read from the «actor»'s record (its orientations, its kind, whether it authored what it concerns): yes or no before any question of quality. The author's check has standing as a check and no weight as an independent one.
- Recording too little is as dishonest as claiming too much. A deliberate decision not to raise something is itself an attestation, with its reason.

## Discussion
- Why two sorts. The census found that the estate's verisectoria put their gravest language on attestations (who decided, who read, whose eyes saw it) and that nothing can convict them by running anything; an error there is not merely wrong, it is a misrepresentation of a person. A check and an attestation are both acts, both bind, both are read into warrants; they differ in how they are corrected, and the model must say so or "everything is a reading of acts" is false.
- Why reads and concerns are kept apart. An honest re-derivation of a claim reads its premises; if reading certified, it would certify premises nobody checked. Kept apart, the act lapses when a premise changes (right: the derivation used it) and certifies only the claim (right: that is what was checked). The consequence is that an unchanged piece needs a fresh check after its premise moves.
- Why a multi-read act lapses as a unit. An act is one judgment. This pushes actors toward acts that read as little as possible, which is also honest, and a verisectorium may want *reads* to distinguish "relied on at a warrant" from "read the text" so that a review of a chapter need not lapse when a proof step inside a member is reworded.

## Examples
- `review:scope-adaptive-system-reread-1#C1`: a ‹check›, actor an Opus 5.5 independent re-reader, line derivation, criterion "Item (b): … iff $C A^j P_t \neq 0$ …", outcome confirmed, read the segment at `12ea0186` and (by its recheck note) `example-kalman`; under this model it concerns item (b) and answers validity.
- `review:c1-exit-time-verify-1#C1`: a ‹check› whose outcome was broken, on Prop A.1S(i), recorded before any repair; it is the perturbation of the atomic changeset that landed `33cfb14c`.
- "RESOLVED in canon — do not re-open", in a Working Note: not an act. Closure is an attestation with an actor and a way to reopen, and a sentence in prose closes nothing.
- "Only Joseph may record a decision as ruled": an attestation whose standing the dimension restricts to one actor, and which the harness cannot yet attest (a gap).

## Historical Context
### Etymology
From *agere*, *actus*: a thing done. One recorded deed by an actor, as against what was written. Its kin: the *acta* are the record of acts, an *actum* one entry, the *actor* the one who acts. *Actus* for the term itself was offered on 2026-11-09 and not taken: *act* had collided with nothing here and its subtypes (check, finding, attestation) are plain English. *Event*, the August model's word, was dropped because its events were each about one record.

### Adjudication
- Adjudicated against msc/notes 09 §3.1–3.5, 10 §1.11, 18 findings 2 and 8, 19 §4, and asf's recorded acts (`vsect why segment:scope-adaptive-system`, `segment:deriv-sector-condition`).

## Working Notes
- Open. Whether a broken ‹check› and a ‹finding› are one subtype or two. Lean: two, as above, because a finding may have had no criterion and so carries no weight as a confirmation.
- On the gap "independence of acts": the default is missing from the model, and it is Joseph's. Two lines of evidence add only to the degree they can be shown not to share a source, and the default assumption is that they do: same author, same method, same seed is one line said twice. A dimension's *read as* that counts confirming acts therefore counts lines of descent, and a seeded-by reference is how descent is written. Lean: an invariant here ("agreement adds only where descent is shown cut"), leaving open what shows it cut between two instances of one model family.
- "Decision" is used throughout core and placed nowhere. Joseph's four, by what a decision is about (2026-11-04): the subject itself (a modelling choice) is a veritoid of a decision kind, with its own dimensions (on what grounds; who was consulted; who stands behind it and how firmly; what would reopen it); the inside of the verisectorium (keeping an assertion after a rewording; where a chunk goes) is an act; where effort goes ("concentrate on this scope for now") is an act with an expiry; how the verisectorium works is a change to the ontology. He added that the line between the first two is not always sharp when the project is the verisectorium. Lean: no new term; a sentence in this def's Definition saying which of the four are acts, since "where effort goes next is a decision" appears in five places.
- Open. Whether an act may answer more than one dimension. Lean: no; record two acts.
- From the vivarium research read (2026-11-09): reading moved from attestation-only to attested-or-checked per producer, with the check the default for a possibly-compacted mind; an orientation pass is an act in the acta, not a token outside it. See «actor» and `disc-actor`.
- Open. What makes two acts independent when both actors are instances of one model family. The dimension's producer can require a different actor; it cannot yet require a different failure mode.
- From the first cold read (`msc/scratch/core-2-denovo-1.md` §2.3, §2.6, §2.9): warrant reads lapsing only on a fall, run and reader event placed, and reads of an assertion alone, all adopted above; the projection-review invariant in «segment» now rests on something this def states rather than leaves open.
