# Audit of KERNEL-SPEC draft 1 against `core/`

*2026-11-10, by the OCaml-side agent (Fable 5.2), before any build. Spec read: `msc/scratch/kernel-2/KERNEL-SPEC.md` at `bdf5e71`. Nothing under `core/` or the spec was changed.*

**What I read whole, myself:** the spec; `core/README.md`; `core/model.outline.md`; all twelve `core/def/*.md` and `def/README.md`; `src/intro-spine.md`, `src/disc-written-done-computed.md`, and the five invented moves (`impl-a-small-move`, `impl-an-outline-fills-in`, `impl-a-finding-is-answered`, `impl-two-moves-at-once`, `impl-intake`). **Read in part:** `instance-trial-1/05-findings.md` (first third; the tool output was cut), the old toy spec's tail. **Not read:** the two real-root impls, the other `disc-` segments, `log.kdl` (grepped only), trial 2, the de novo reads. So where I say "core does not say", I mean the defs and the five moves do not; a disc segment or a trial might.

**How sure each finding is.** *Read* means it follows from the two texts set side by side, with no reasoning of mine in between. *Derived* means I constructed a small history by hand from the spec's own definitions; I believe each one, and none has been run, so each is a prediction for the build to confirm or kill. *Choice* means the spec or core is silent and the kernel cannot be written without choosing.

The short version: the spec's §5 defines nearly everything as a pure function of the current state, and §6 lists exits as kinds of entry. Those two framings disagree in many places, and each disagreement is a quiet exit of exactly the sort K6 was written to catch. Most are disagreements already inside core, which the spec inherited faithfully. I would revise §5/§6 before anyone builds, because as written K6 fails by inspection and the build would only rediscover this list.

---

## A. Where K6 fails as written, by inspection

### A1. `reopened` is computed in §5 and sticky in §6; K6, K7 and K9 cannot all hold. *(Read; a core-level question)*

- Spec §5 `stands(d, n)`: a function of the state at n. K7: "reopened at n **if and only if** some basis element fails at n." K9: restoring earlier content "restores the earlier version and what bound to it".
- Spec §6: `reopened` leaves "only by its party sustaining, deciding again, or withdrawing; a carrying act where policy allows."
- Take a decision whose basis includes "no open bad news against ground q". A finding lands on q (reopened). The finding is answered. By K7 the decision stands again; the entry was an answering act on q, which is not in the exit list. Same with: a write that restores a rewritten basis piece to the version read (K9); a confirmation that raises a fallen ground back; the re-acceptance of a premise.
- This is core's own two sentences. `def/decision.md` invariant: "It is reopened exactly when its recorded basis fails." Same def, Definition: a reopened decision "backs nothing ... addressed to its party, who sustains it on the new basis, decides again, or withdraws it." `def/veritoid.md`: restoring content restores "every act that read it". The moves lean both ways: in `impl-a-small-move` the rule "accepts c again" passively at 11:00; in `impl-an-outline-fills-in` step 6 the party decides D again, and "R1 and R2 are accepted again" does not say by whom.
- The kernel needs one of: (i) computed: `reopened` iff basis fails now, and the exit list becomes "anything that restores the basis"; (ii) sticky: once reopened, only the party's act ends it, K7 becomes one-directional, and K9's "what bound to it" excludes decisions; (iii) by policy: rules are (i), party decisions are (ii). (iii) is what the moves seem to do. I would make it a policy parameter and run all three.

### A2. A split, a deletion, or a withdrawal takes a piece and all its items out of canon. *(Read for the spec; Choice for core)*

- Spec §5: `in_canon(p, n)`: "an accepting decision for p exists and has not been withdrawn." §6: "Only pieces in canon owe."
- **Split or replace.** `def/veritoid.md`: on a split "its id is retired and new ids are minted with recorded descent. What stood against the retired piece unanswered stands against its descendants; replacing a piece wholesale is a recut like any other and sheds nothing." The descendants are new ids with no accepting decision, so by the spec they are provisional, and bad news against a provisional piece is not owed. The finding is still *open* (so K5 passes) and the frontier item is gone (so K6 fails, by a write). The intent in core is plain; the mechanism that would carry it (descendants inherit canon membership, unsettled) is not stated in core or the spec.
- **Deletion.** Core never says what happens when a write drops a held piece and mints no descendant. Dropping a false consequence claim is a legitimate repair, and it removes every item on that piece. "Does the piece as it now reads still have what the finding found" has no piece to read. Choice: refuse a drop while bad news is open; or the bad news stands against the holder; or a drop is an exit that must be listed.
- **Withdrawal.** `def/segment.md`: unsettled "until it is accepted again or the acceptance is withdrawn." Withdrawing an acceptance removes every item on the piece at once: found, overclaimed, and its stale, dangling and unmet references. No row of §6 lists it. It is not silent where something rests on the piece (the dependents become unsettled), and it is silent where nothing does. `def/frontier.md`'s Working Note on cheap exits names affirmations and waivers, not this.
- Also: the spec has no act for withdrawing, sustaining or deciding again (§4's decision row lists accept, waive, affirm, route, promise, other), and its Write has no retire/mint/descent fields, so none of the above can be expressed yet.

### A3. With no repair written, anyone may answer, including the piece's author. *(Derived, from the spec's quantifier)*

- Spec §5 `open(b, n)`: answered "by an actor that does not share an inheritance with the author of any write to the piece since b."
- If no write has touched the piece since b, the set of authors is empty and every actor qualifies. Trace: finding b on c (author A); A records *answered*; b is closed. Two entries.
- `def/act.md` says answering is "asked by someone other than the author of the repair" and `impl-a-finding-is-answered` step 4 says "A cannot clear it: there is no repair to answer, and A is the author", so core means it to be impossible; the formalization lost it. Suggested: the answerer shares with neither the piece's last author nor any author since b; and decide whether an answer with no intervening write is allowed at all (it is a contest by another name).

### A4. A contest has no independence condition in the spec. *(Read)*

- Spec §5: "no contesting act that overturned it." By anyone.
- `def/act.md`: the three finding-out acts about acts "ask a mind other than the one with an interest in the outcome"; the move has E, "who has inherited nothing from A or from D". As written the author overturns a finding against their own piece in one entry. The same condition is missing from carrying in `binds` ("asked by someone other than the editor"), and `standing(a, d)` is applied nowhere in §5.

### A5. Answer, then restore the old text. *(Derived; a core-level question)*

- Spec §4 says an answering act counts "as a check" (lapses when a read changes); §5 `open` only asks that an answering act *exists*. The two disagree.
- If §5 is right: reword p, get it answered, write p back to the version the finding read. The answer exists, so b is closed, against the very text it was found in. Three entries.
- If §4 is right: every later edit to p lapses the answer and re-owes every finding p has ever had, unless each answer is carried.
- Core does not choose. A middle reading: an answer is a fact about (finding, version); b is open at n iff p's current version is one no standing answer covers, reached by carrying. I would state the choice and run both ends.

### A6. Amending is in §4 and nowhere in the fold. *(Read)*

`def/act.md`: the author of an act may weaken it ("read contradicted as narrowed") "or corrects what it named". Weakening contradicted to narrowed moves an item from one kind to another; correcting what it named moves it from one piece to another. Either is an exit if K6 is checked per item. Whether a finding can be weakened to nothing is unsaid; if it can, a finder can silently retract. The spec needs the order amending moves along, and an exit row.

### A7. The remaining exit rows are short by the entries that change what the item is computed from. *(Read, row by row)*

| item | exits the spec does not list |
|---|---|
| every item | the piece leaving canon (A2); the bad-news actor losing standing (`def/actor.md`: "every act it made there stops counting at once"; `standing` is static in the spec, so this is out, and should be said) |
| overclaimed | content may speak of *another* piece's standing (`def/dimension.md`: "its own or another's"), so a restoring write on that piece, a carry, or an overturned narrowing there clears it |
| stale | a write that drops the reference; a write restoring the target to the version seen; and see A8 |
| unmet | a write re-pointing or dropping; a restoring write on the target |
| unfilled | a write to the assembly that changes the slot from promised to suggested or removes it (see C6); a write pointing the slot at a piece already in canon, with no acceptance |
| raised | `def/reference.md`: "the dependent's author answers it by changing or affirming"; `impl-a-small-move` 13:00 clears one by a write. `def/frontier.md` and the spec say only the producer or the assigned seat. Core says two things here |
| unbacked | `def/frontier.md`: "a decision that is not on record"; `def/dimension.md`: "must be on record with its basis holding". A reported decision that is on record and reopened is unbacked under one and not the other |

### A8. What a reference "last saw" is not defined, and the obvious definition is a quiet exit. *(Choice)*

`def/reference.md`: "the target's version at the write or at the author's latest affirmation". A segment changeset is a whole new written state of the freestanding segment, so every reference in it is "written" at every write. If "the write" means any write of the holder, then touching an unrelated sibling refreshes every stale reference in the document. If it means a write that changes the referencing veritoid's version, a one-word rewording clears stale without the question "did I rely on what changed?" being answered (this is what happens at 13:00 in the small move, intended there). The spec says nothing; the Working Note in `impl-a-small-move` flags the entry side of this, not the exit side.

---

## B. Where the fold is not yet a function

### B1. Settledness and binding are fixpoints, and nothing says which. *(Derived)*

- `settled(p)` needs everything p rests on to be settled. `def/reference.md` allows cycles along kinds nothing caps along ("their members are reviewed and accepted together"), and resting includes any kind "some dimension passes along" (narrates, for freshness) and decision bases. On a cycle p ↔ q, "both settled" and "both unsettled" each satisfy the definition. K8 guards `effective` only.
- The same for evidence: an act may read "only its warrant on a dimension". Check c1 concerns p and reads warrant(q); c2 concerns q and reads warrant(p); each was grounded when made by an earlier c0 on q. Overturn c0. Now c1 binds iff c2 binds. Two solutions.
- I expect the intended readings differ: support for evidence should be well-founded (least fixpoint: the loop falls), while mutual acceptance must be able to stand (greatest fixpoint: settled unless there is a grounded reason not to be). K1 is only meaningful once this is chosen; the spec should add a K8 for `binds`, `stands` and `settled`.
- The spec also never states the spread itself. `stands` lists "pieces at the versions read, warrants not fallen, no open bad news against a ground" and omits `def/segment.md`'s "an accepted segment that rests on a provisional or unsettled one is unsettled". It may be meant to fall under "warrants" (acceptance being a decided dimension), but K12 and K13 turn on it and it should be explicit. Whether the subject of an acceptance is itself one of its "grounds" (so that a finding on p reopens p's own acceptance under a party policy) is also unstated.

### B2. A carrying act can never bind under the spec's own definition. *(Read)*

A carrying act carries "two versions" of one id, and counts "as a check": while every read is unchanged. At most one of the two versions is current. So either a carry reads only the newer version (and lapses at the next edit, breaking every chain: §9 question 5 answers itself as "no"), or a carry is a judgment about a pair of versions, which no later write can change, and stands until contested. The second composes; then `binds(c, n)` is "a path of standing equivalent carries from the version read to the current one", and restoring content needs no carry at all.

### B3. Items have no identity, and "the entry that caused it" has no definition. *(Choice; K6, K12, K13 and waivers all need it)*

- K6 speaks of an item "present at n and absent at n+1"; a waiver "covers an item"; `scope` is "every segment ... that has an item it caused". All three need to say when two computed items at different n are the same item.
- If the cause is part of identity: a reference stale since write w1 goes "stale since w2" when the target moves again, the first item has left by a write on the target, and K6 fails trivially. If cause is "the entry at which the item last became present", see B4.
- `steady(R, n)` says "no unwaived item's piece or cause lies in R": a cause is an entry and R is a set of segments.
- Scope's grain is mixed: "written" is said of freestanding segments, and an item's piece may be a held veritoid. Two findings on two claims of one document meet at once under one reading and never under the other.

### B4. Which changeset an entry belongs to is not defined, and with the natural definition a diamond breaks K12. *(Derived)*

- The record is flat. `def/act.md` says every act "belongs-to" exactly one atomic changeset; the spec has no rule assigning one. K12 ("entries belonging to one neither add nor remove an item of the other") cannot be stated without it, and if membership is defined through scope, K12 is close to true by definition and says nothing.
- Predicted smallest witness, with `rests_on` excluding slot filling: u is predicated on c and on x from S0. A finding on c opens M1: found(c), reopened(c), reopened(u). A finding on x opens M2: found(x), reopened(x). u is already reopened, so M2 causes no new item on u, and the scopes are {c, u} and {x}: disjoint. Answer c's finding. u stays reopened, held there by x; M1 cannot close on its own repair, and the entry that finally clears u belongs to M2. K13's trigger ("an entry makes a piece in one scope rest on ... a piece in the other") never fires, because the resting was there before either disturbance.
- Either a `reopened` item is one item per failing basis element (then u has an M2 item and the scopes meet), or scopes meet whenever a piece in one rests on a piece in the other regardless of which entry made it so. `def/changeset.md` reads closer to the second.
- A statement of locality that does not lean on cause, which I would add as its own property: *two adjacent entries whose footprints are disjoint (neither writes, concerns or reads anything in the other's backward cone along rests-on and reads) commute: swapping them gives the same state and frontier.* It is what `def/steady-state.md` asserts ("unrelated ones have no order and need none") and what `def/frontier.md` gestures at ("the same recorded things read in any order give the same frontier", which taken literally is false, since the last write wins). It can be checked exhaustively, and K12 follows from it.

### B5. The three `accepts` policies need three definitions of `in_canon`, and the spec has one. *(Read)*

- §5's `in_canon` is the party-decision case. Under a rule, `def/decision.md` says "applying a rule is computed" and a rule-made decision "is withdrawn only as the ontology says, never merely by failing": so canon membership is "the rule has held at some m ≤ n", a memory with no entry in the log behind it. Under placement, a *write* to the canonical projection admits a piece, which sits oddly with `def/segment.md` ("wanted in a place" and "accepted" are separate) and makes un-placing a withdrawal by a write.
- Prediction for K4 under the rule policy: a confirmed check can be the entry at which the rule first holds for p; p enters canon; whatever p's references and slots owe (a dangling narrates reference, say) appears on the frontier. A confirming check added an item. So K4 would need "the rule also asks that nothing of p's would be owed", or to be restated as "adds no item on a piece already in canon".

---

## C. What the kernel needs that §2–§4 do not have

1. **A model of content.** `contradicted` needs the assertion a piece carries on a dimension; `overclaimed` needs what content says about standing, of which piece, on which dimension, at what level; `unbacked` needs the decisions content reports. §3's veritoid is (kind, content, references) with content opaque. `def/act.md`'s fourth grain of read ("only its assertion on a dimension") is also missing from §3's Read.
2. **Kind declarations as a parameter.** Refusal 1 needs inner dependencies; `unfilled` needs required slots; the cap needs which dimension caps along which reference kind; `warrant` and `effective` need each dimension's ordered set of warrants with a bottom and a meet. None is in §2's table.
3. **Descent, retirement, minting, moves** in a Write (A2). And a move of a held piece from one freestanding segment to another touches two freestanding segments, which `def/changeset.md`'s segment changeset ("one freestanding segment") cannot do in one instant: between the two writes the id is held by both or neither. *(Read; core-level.)*
4. **The party's later acts:** sustain, decide again, withdraw; and a notion of party, so "only its party changes it" can be checked.
5. **How `raised` begins.** §6 gives it an exit and no entry. Core has three: a rule, a narrowed premise, a decision about the work; and `def/act.md`'s relayed finding, which raises and does not unsettle. The spec's finding always unsettles.
6. **A promise is two things.** A slot state (written) and a decision (done). If a write may change promised to suggested without the party withdrawing, that is an exit for `unfilled`; if not, it is a fourth refusal.
7. **Structural refusals core takes for granted:** a held segment written alone; a segment with two holders; an id minted twice or reused after retirement (K9 states it as a property, and nothing refuses it); an act about an act that does not exist; amending another's act. Core's `refusals` gap row says this is open; the kernel has to pick.
8. **Whether `effective` is read by anything.** `def/frontier.md` shows own-above-effective "as information"; `unmet` and `overclaimed` are stated against the warrant. If nothing owed reads `effective`, K8 guards a display value. `def/segment.md`'s remark that what rests on an unwritten promise "could not be exact" suggests overclaimed is meant against the effective warrant.

## D. Properties that cannot be what was meant

- **K3.** "Binds iff each read is unchanged or carried" leaves out warrant reads (§5 has them), contests (an overturned confirmation "stops counting") and standing. "Appending a confirming act lapses nothing" needs "confirming" defined for acts about acts: a contest that *overturns a confirmation* lapses it, and is a check with a positive outcome.
- **K5.** As `open` is defined, writes cannot affect it at all, so K5 holds by definition. What was meant is at the frontier: the *item* survives writes. Stated there, A2 breaks it.
- **K7, second sentence.** "A write that touches nothing in the basis reopens nothing" is false by design: the basis holds warrant(p), a check on p read premise q without concerning it, a write to q lapses the check, the warrant falls. That is the small move's 09:25. "Touches nothing the basis transitively reads" is the true form.
- **K10** against `def/segment.md`: "Nothing inside a provisional segment is owed" and "Acceptance is per segment at every depth." An accepted veritoid held in a provisional assembly owes under the second and not under the first. K10 takes the second.
- **K13** fires on an entry that *makes* a resting relation; see B4.
- **K15.** "Differ in owing only by whether an accepting decision was ever made": also by withdrawal; under a rule, by whether the rule ever held; under sticky reopening, by whether a basis ever failed; under A5, by whether an answer was ever recorded.
- **§9 question 4.** "Contradict each other in substance" is not something the kernel can see: content is opaque, and a contradiction exists for it only as an act. The witness is any two unrelated writes, and is uninformative. It becomes a real question only with a toy semantics for content standing outside the kernel as an oracle; say if that is wanted.

## E. Smaller mismatches

- Version: `def/veritoid.md` hashes each reference's kind, target id and need; the outline's inline `version` row says "the ids its references point at". The spec follows the def.
- `shares(a, b)` is one static relation; `def/actor.md` has it per piece ("to the extent of what both inherited about the piece") and per act (what was read before the criterion). Fine as a simplification if said. It should be stated reflexive and symmetric; if it is not transitive, "count of independent lines" is not determined by pairs alone.
- `review_reads(k)` covers a whole read; `def/reference.md` has the same notion for a reference to an assembly ("what the reference's kind says it relies on, by default anything the assembly holds"). A read of an assembly has to record the (id, version) pairs it took through that rule, or lapse cannot be computed from the act.
- §1 puts importance out; `def/decision.md` and `def/frontier.md` list "more rests on it than it was decided at" as a way into `reopened`. Fine if K7 says its basis is the narrower one.
- A waiver's own basis and end are unsaid ("it ends with the repair that clears the item", `def/steady-state.md`). Worth a property of its own: appending a waiver changes no item.
- Under "only canon owes", a contradiction against a provisional piece held in a canonical assembly appears nowhere (trial 1's finding 16; `def/steady-state.md` now lists it as a stated condition). The spec computes no stated conditions, so it cannot see whether "never asked" and "provisional with bad news" stay visible. That is the same family as a quiet exit and may deserve a function and a property.

## F. Where I think the model, not the spec, has to decide

In the order I would put them to Joseph: A1 (is reopening computed or sticky, and for which decisions); A2 (do descendants inherit canon; what a deletion does to what stood against the piece; that withdrawal is an exit); A5 (what an answer is about: the piece, or the piece at a version); B1 (grounded support for evidence, mutual standing for acceptance); B3/B4 (what an item is, so that cause, scope and waiver have something to hold); A8 (what refreshes "last saw"); C3 (moves across freestanding segments).

A pattern under most of them: core states the frontier as *computed from the state* and states exits as *deeds by named parties*. Each is right about something. Every place they differ is a place where the state can change so that an item stops being computed without the named party having acted. The spec could take one of two shapes: make every item a pure function of the state and treat §6's last column as a theorem to be found ("the set of entries that can remove this item is exactly ..."), or make an item something opened by an entry and closed only by a listed entry, and treat "computed fresh" as the theorem. I would formalize the first and report the second as its result, because that makes K6's exit list an output of the work and not an input to it.

## G. On the instrument

Decided after the spec settles. My present judgment, offered as that: K6 and the commutation property are finite questions about every history up to a small size, so they want exhaustive enumeration over a tiny universe, with the policy choices above as switches, more than they want random generation; and a proof assistant would be early while §5 is still choosing its fixpoints. I will hold off building until I hear back.
