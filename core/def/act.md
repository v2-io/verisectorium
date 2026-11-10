```kdl
term "act" pos=noun pl="-s" {
  subtypes "check" "finding" "testimony"
  avoid "event" "an earlier model's events were each about one record only"
  avoid "attestation" "it named the saying of a bare fact and the making of a decision at once; those are testimony and decision here"
  rel answers term="dimension" card="{0,1}" note="exactly one for an act of finding out; a decision about a piece answers one, other decisions none"
  rel reads term="segment" card="{0,N}" note="each at a version, or a piece's warrant on a dimension; what the act binds to"
  rel concerns term="segment" card="{0,N}" note="a subset of what it reads; what the act is about. An act may also concern an earlier act; a decision may concern a slot, an owed item, the work or the ontology"
  rel belongs-to term="changeset" card="{1,1}" note="the atomic changeset it falls in; alone, it is one of size one"
  rel by term="actor" card="{1,1}"
  rel concerns term="actor" card="{0,N}" note="an orientation check concerns a mind"
}
status provisional
```

# «act»
One recorded thing an attested actor did against a state: it reads things at their versions, concerns a subset of them, answers one dimension, and counts while what it read still holds.

## Definition
Every act records: its «actor» (read from the harness, never typed); the state it was performed against; what it **read**, each at its version: a piece's whole written state, or only its assertion on a dimension, or only its warrant on a dimension when that is all the act relied on; what it **concerns**, a subset of what it read; the «dimension» it **answers**; and its outcome. A lapsed or reopened act warrants nothing. The warrant of a piece on a dimension is read, as the dimension declares, from the acts that still count and concern it.

Acts are of two sorts, one for each kind of answer.

**Finding out** produces evidence for a truth claim. A later act can overturn an earlier one, and anyone with standing and a sound method may add one.
- A ‹check› fixes its criterion before seeing its outcome, and the criterion says by which of the dimension's means it asked. Outcome: confirmed, narrowed or contradicted. A run is a check whose actor is an ‹instrument› at a version.
- A ‹finding› says something is wrong, found without a criterion fixed in advance, so it carries no weight as a confirmation.
- A ‹testimony› is a bare fact said by whoever was placed to know it: "I read this", "these are her words", "the cited work now says otherwise", an instrument's measurement. Nothing convicts it by running anything unless it can be re-run, and it is the floor the rest stands on.

A confirmation **binds** while every one of its reads is unchanged; the moment one changes it **lapses**, and which read can be named. A read of a warrant lapses only when that warrant *falls*; a confirmation that raises it lapses nothing, so good news never undoes a review. Bad news is not symmetric: a contradicting check or a finding does not lapse when the text it read is rewritten. It stays owed until it is **answered**.

Three acts of finding out concern an earlier act, and all three ask a mind other than the one with an interest in the outcome:
- **answering**: does the piece as it now reads still have what the finding or contradiction found? Asked by someone other than the author of the repair. *Answered* clears it; *not answered* leaves it owed.
- **carrying**: did this edit leave unchanged what that earlier act relied on? Asked by someone other than the editor. *Equivalent* lets the earlier act bind at the new version; *not equivalent* leaves it lapsed. This is how a small rewording keeps the checks, and the decisions resting on them, that it did not disturb.
- **contesting**: was the earlier act itself wrong? A check concerning a check. A contradiction contested and overturned stops counting; so does a confirmation.

**Making so** is a «decision»: accepting a piece, promising a slot, routing a chunk, waiving an owed item, affirming an unchanged piece beside a change, choosing where effort goes. It is made by a party with standing, on a basis, and it **stands** while that basis holds; when the basis fails it is **reopened**. Only its party changes it.

### Invariants
- It never changes what is written.
- A confirmation counts for exactly what it read and no longer than that holds; a finding or contradiction counts until answered or overturned. Reading a premise without concerning it is how a re-derivation reads its context honestly without certifying it.
- An act of finding out answers one dimension, named, and a check says by what means. A record that says only "checked, passed" cannot be told from one that asked a different question, or the same question the same way as every check before it.
- A contradicting ‹check› or a ‹finding› goes on the record when it happens, before anyone has written a repair, and owes an item on the «frontier».
- Whose acts count is the dimension's *produced by*, read from the «actor»'s record: yes or no before any question of quality. The author's own check is recorded and is no line of evidence on a dimension whose producer asks for a mind not the author.
- A mind's testimony about its own reading is the least trustworthy act in the acta, since a mind that has been compacted says yes with full confidence; where reading matters it is found out by a check the actor cannot pass by reading during it.
- Recording too little is as dishonest as claiming too much. Choosing not to raise something is a decision, with its reason.

## Discussion
- **Why two sorts.** They are the two atoms seen as deeds. The estate's verisectoria put their gravest language on who decided, who read and whose eyes saw it, and an error there is not merely wrong: it misrepresents a person. A check and a decision are both acts and both are read into warrants; they differ in what builds them, who may move them and what undoes them, and a model that says "everything is a reading of acts" without that difference is false.
- **Why reads and concerns are kept apart.** An honest re-derivation of a claim reads its premises; if reading certified, it would certify premises nobody checked. Kept apart, the act lapses when a premise changes and certifies only the claim. The consequence is that an unchanged piece needs a fresh check after its premise moves.
- **Why an act with several reads lapses as a unit.** An act is one judgment. This pushes actors toward acts that read as little as possible, which is also honest.
- **Why bad news outlasts an edit.** If a contradiction lapsed whenever its text changed, the cheapest way to clear one would be to reword the piece: cheaper than a repair, a waiver or an affirmation, and silent. In one recorded day on one real segment, 33 of 162 acts marked a finding answered (18 of them by someone who wrote no repair) and two of eight rewordings were judged *not equivalent*. The asymmetry is deliberate: support must be re-earned after a change, and a defect must be shown gone.
- **Why testimony is the floor.** That a check was run, by whom, against which versions, is itself a truth claim, and its evidence is the harness's testimony. Carrying a trail beneath that would never end; the floor is where a verisectorium decides to stop, and it stays correctable.

## Examples
- An independent re-reader's line-by-line re-derivation of one item of a scope segment, criterion fixed first, outcome confirmed, having read the item and the example it leans on: a ‹check›, by the means *re-derivation*, concerning the item, answering validity.
- A verifier of a new result who sets an old proposition against its own segment's corollary and finds they cannot both hold: a ‹check› by the means *collision*, outcome contradicted, on the record before any repair.
- An auditor's remark that a paragraph hides a derivation: a ‹finding›.
- "Only the steward may record this as ruled": a «decision» whose standing the dimension gives to one actor.
- "RESOLVED in canon, do not re-open", in a note: not an act.

## Historical Context
### Etymology
From *agere*, *actus*: a thing done. One recorded deed by an actor, as against what was written. Its kin: the *acta* are the record of acts, an *actum* one entry, the *actor* the one who acts. *Actus* for the term itself was offered on 2026-11-09 and not taken: *act* had collided with nothing here and its subtypes are plain English. *Event*, the August model's word, was dropped because its events were each about one record.

### Adjudication
- Adjudicated against msc/notes 09 §3.1–3.5, 10 §1.11, 18 findings 2 and 8, 19 §4, and asf's recorded acts (`vsect why segment:scope-adaptive-system`, `segment:deriv-sector-condition`).

## Working Notes
- Untested on an invented move: answering, carrying and contesting. Contesting has no specimen yet in the one real record read; its "corrections" were partial answers and narrowings of an act's own text. They came from reading a real record against the model (acts about acts were 44 of 162 there) and from a cold read's finding that any edit cleared any contradiction.
- Evidence that arrives as prose (an old audit's "this claim is false") is routed into the acta as a ‹finding› on the router's ‹testimony› that the source says so; the source's author is not an attested actor and its confirmations count for nothing until re-run. The criteria of old checks are worth carrying as checks owed. Lean: say this in the Definition once an intake has been run.
- Open. Whether a contradicting ‹check› and a ‹finding› are one subtype or two. Lean: two, because a finding had no criterion and so carries no weight as a confirmation.
- Open. Whether an act may answer more than one dimension. Lean: no; record two acts.
- Open. Whether an act contradicted on one of the things it concerns should lose weight on the others it confirmed in the same breath. One real audit passed a false claim and its neighbour together.
- Open (gap row). What shows two acts independent when both actors are instances of one model family.
- A lapsed check is still a record of the checker: a check that passed a derivation later found to have an error says something about that checker's checks. Nothing reads this yet. Lean: an attribute of the actor, computed.
