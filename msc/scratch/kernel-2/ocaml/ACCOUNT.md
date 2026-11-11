# kernel-2 in OCaml, draft 4: what was done and found

*2026-11-10/11, by the OCaml-side agent (Fable 5.2). Against `../KERNEL-SPEC.md` draft 4 at `5e2cffd`. The account of the draft-3 build is `ACCOUNT-draft3.md`, unchanged. Nothing under `core/` and nothing in the spec was changed. I have not read the Ada accounts. Nothing here is a fact about the model until it has been adjudicated in core.*

## 1. What this is

`lib/model.ml` is draft 4 as an executable model: a pool of events in time order; a line, with the base it sees, as a set of those events; the state read from it (selection, each id's order of versions, decisions in force, roots, canon); C1–C9; consistency; the frontier. `lib/explore.ml` visits, inside a small universe, **every** subset of the pool as a line, and for R9 every way of dealing the later events to two forks. `test/test_kernel.ml` is thirteen hand-built universes that pin the findings and run the invented moves. The draft-3 build is kept beside it as `model3.ml`, `explore3.ml`, `test_kernel3.ml` and still builds and passes.

**What "tested" means.** A universe is an ontology, 4 or 5 ids with 2 versions each (the last id a root outline; in half the batches a second assembly), and a pool of 21 to 23 events. The first 8 to 10 events are fixed (every id written once, each veritoid checked once, the root marked), and every state visited includes them, so that something is always in canon; the remaining 12 to 14 are drawn at random, and every subset of them is visited. Universes whose opening state is stationary are preferred. So "no counterexample" means none in the universes visited, and "smallest" means the smallest met. Nothing is proved by a tool. Arguments are marked as arguments.

**What the generator does not reach:** more than one found-out dimension; warrants that are not a total order; assemblies nested more than one deep; more than one reference per version; descent longer than one step; a fork that rewinds (tested by hand only); more than two forks.

Full output of every run cited is in `runs/` (draft-3 runs in `runs/draft3/`). `runs/queue.sh` runs batches two at a time.

## 2. The table

| | property | result | to what bound | where |
|---|---|---|---|---|
| R1 | a state is a function of its line and the base | **holds by construction**, with the base read as it now stands (§4.1) | not a test | `model.ml` |
| R2 | abandoned work is inert except for what was learned | **holds for evidence about versions a line never selected.** But "what was learned" is not the same on every line: whether a check meets a guard depends on when the line's write was made (§3.2) | 3.9M removals, zero failures | `add-ms`, `add-ams`; tests `R2 R3` |
| R3 | going back | **a stationary state is broken afterwards only by a finding or by a same event for a finding** (and by good evidence if `read_as` is not monotone). **Going back and forward again loses an answer** (§3.2) | 0.95M stationary states each with one base event added (1.48M with the unrestricted batch) | `add-x`, `add-ms`, `add-ams`; test `a rewind forgets an answer` |
| R4 | answered once | **holds**, with a price: fix, be answered, put the defect back, touch it, and no guard remains, under one of the two readings of "at or after v" (§3.3) | hand-built | tests `a small move`, `R4` |
| R5 | a wrong finding has a way out | **holds.** A set aside removes any finding and its guard, true or not, and whatever followed from them; set aside of good evidence adds items | roughly 190k set-aside events added to a state | `add-*`; test `a wrong finding` |
| R6 | good news does no harm | **holds under the two conditions that are still conditions** (`read_as` monotone; a same event is good only if what it is for is good). **Neither can be dropped.** A promise adds its own item and makes what rests on its assembly inconsistent, unless waived | 1.67M additions of good news, zero failures | `add-ms`, `add-ams`; unrestricted failures in `add-x`; test `R6` |
| R7 | consistency well defined | **the greatest fixed point exists in every state visited; it is not always the only fixed point** (pieces resting on each other in a ring) | 9.0M states; ring by hand | `add-*`; test `R7` |
| R8 | a defect survives recorded recuts | **holds through recorded descent; three ways out remain**: unrecorded replacement, the R4 round trip, a set aside | hand-built | test `R8` |
| R9 | forks compose | **see §3.1.** With "meet" defined on what each fork changes and what each piece reads, in three respects: forks that do not meet both close (form a); when they cannot both close, every item is on a piece that reads something each fork changed (form b). The draft-3 sentence is not the whole of it | 8.1M pairs of forks at 4 ids, 3.8M at 5: 690k non-meeting pairs all close; 78k pairs that cannot both close all meet; 87k items all placed | `fp-*`, `r9-*`; tests `R9` |
| R10 | canon by roots | **two parts hold, one fails.** A piece under two roots is held to both. A piece provisional everywhere has no items and its bad news is computed as shown. **Unmarking a root can add items** | 80k unmarks of a marked root; 4 add an item | `add-ams`, `add-a`; test `an outline fills in; roots` |
| R11 | checkpoints | **holds at the moment of closing, by definition; not afterwards** (R3: the base grows under a checkpoint) | — | — |
| R12 | locality | **not narrower as a set of pieces** (canon by reach makes every piece read what is above it). **Narrower when what is read is graded**: an outline reads of its fillers only that they exist | bare sets: 0.56M checks; graded: 19.8M checks, zero failures | `loc-a`, `locL-a`, `locg-*` |

## 3. Findings

### 3.1 R9: when two forks can both close

**What was tested.** For every checkpoint (a stationary set of earlier events), every set of base events recorded since, and every way of dealing the later line events to fork A, fork B or neither: when A alone and B alone are each stationary, is the line with both? Closing is modelled as the union of the events, in time order; the order of closing therefore cannot matter, and the question is only whether the merged state is stationary.

**The draft-3 sentence is not the whole of it.** "They fail to compose only where they select different versions of one id, or one's evidence read what the other rewrote." Forks that write different ids and involve no such evidence still fail to both close, in these ways (smallest witnesses in `runs/r9-ms.txt`; the first is the test `two forks`):

1. One fork writes a piece that **refers** to something the other rewrote (C4: the reference was reconciled against the old version), or whose warrant comes from evidence that read it. This is the draft-3 clause, widened from evidence to anything read.
2. **Canon moved under it.** One fork raises a question about a piece, or sets aside the check that carries its warrant, while the piece is outside canon, where nothing is owed; the other fork's write to the outline brings the piece into canon. Neither touched what the other wrote. Canon by placement makes every write to an assembly a change to what is owed below it.
3. **Root marks, set asides and withdrawals** act on whatever they reach, whoever wrote it.

**A definition of "meet" under which form (a) held everywhere it was tried.** Say that an event *changes* a piece in one of three respects, and that the items about a piece *read* other pieces in the same three:

- **existence**: whether it is selected at all;
- **version**: which version is selected (for an assembly, its slots; for a root, its mark);
- **facts**: the evidence and decisions about it.

A write changes its id's version (and existence, if it was not there). A retirement changes existence and version, and the facts of what it descends to. A decision, a set aside or a withdrawal changes the facts of its subject. A root mark changes the root's version. What a piece reads is in `explore.ml`, `reads_graded`, and in words: its own three; the existence of what it references, and the version too where the reference kind relies on more than existence; the warrant-bearing facts and version of what it needs, caps along or makes claims about; everything read by what it rests on; what its applying evidence read; the conditions of decisions about it; the facts of what it descends from; and, for whether it is in canon at all, the version of every assembly that can reach it. An **assembly reads of its fillers only that they exist and whether they are in canon**, unless its kind declares an inner dependency on that slot.

A fork's **footprint** is everything its events change. Two forks **meet** when some piece reads something in each footprint.

- **(a)** 689,792 pairs of forks whose footprints do not meet: all both close. 78,172 pairs that cannot both close: all meet. (`fp-ms`: 250 universes of 4 ids; `fp-ams`: 120 of 5 ids. `fp-a` is the same 120 universes with `read_as` and same events unrestricted and gave the same answer; it is not an independent sample.)
- **(b)** In every pair that cannot both close, every item on the merged frontier (86,728 items) is on a piece that reads something each fork changed. No item was found on a piece that read only one fork's changes, or neither's.
- For comparison, on the same pairs: the bare-set neighbourhoods also had no failure of (a) at the wider and static levels, and were far more conservative. Of the 4-id pairs that both close, the graded definition calls 508k non-meeting, the wider set 111k, the static set 57k. The spec-level set (references and fillers only) fails (a) in 12 pairs and misplaces items in (b).
- Under this definition **two repairs in different documents under one outline do not meet**: the outline reads that its fillers exist, and neither repair changes that (test `what meeting is`). With neighbourhoods taken as bare sets of pieces, which is what draft 3's Q7 and both draft-3 builds used, every pair meets at the outline and (a) says nothing; that is the trial-instance collapse seen from this side.
- It is the read-set and write-set condition: forks meet when one's write set intersects the other's read set or write set, with a piece's read set closed under what it rests on. I have not checked the wording against a text either.

*Argument for why (a) and (b) follow from locality:* if adding an event changes nothing that the items about p read, what is owed on p is unchanged (R12 graded, below: 19.8M checks, zero failures). Add fork B's events to fork A's line one at a time. A piece that reads nothing B changed is owed what it was owed on A's line, which is nothing uncovered. Symmetrically for A. So anything owed in the merged state is on a piece that reads something of each. This is an argument, and the check of (b) is its test, not its proof.

**What (b) does not say.** It places the items; it does not say a repair confined to those pieces exists. And "a piece that reads both" can be far downstream: everything resting, through any chain, on a piece where the forks met reads it. The items are inside the cone above the meeting, not at the meeting.

**The other direction fails, and one case of it matters.** Forks that meet often can both close anyway (most do, in these universes: random universes are densely connected). One way this happens is wrong: with the C4 switch on ("a write of p counts as affirming p's references as they then stood"), fork A rewrites c and fork B rewrites d, which refers to c, without ever seeing A's c. Whether the merged line is stationary turns on which of the two writes has the later time. If B's is later, d's write "then stood" against A's c in the merged order, and counts as having affirmed something its writer never saw (test `a shared dependent, and the clock`). The forks meet by the definition above, so a rule "forks that meet must be reworked on the new checkpoint" (§6 of the spec) catches it; a rule "forks may close if the merged state is stationary" does not. Either the switch has to record what a write was written against (draft 3 had this as a field), or meeting, not stationarity of the merge, has to be the test.

**Meeting through decisions is harmless; meeting through writes is not.** As in draft 3: two forks that each reconcile a shared dependent by an affirm decision both close, since decisions accumulate (test `a shared dependent, affirmed`). They do meet by the definition, which is therefore conservative there.

### 3.2 R2, R3: evidence in the base and writes on lines is not quite a clean split

The split itself works: evidence about a version a line never selected changed nothing on that line in 3.9M removals. The clause that leaks is in §4's guards: a finding is met by evidence that holds "provided that evidence applied **when recorded**". Evidence is in the base, and has one time. Whether it applied at that time is a question about a line. So:

- **A check made before the write does not count.** A finding stands against c@0. The repaired c@1 is checked on the finding's criterion while this line still has c@0: on another fork, or as a draft looked at ahead of time, which is the order `impl-an-outline-fills-in` step 3 recommends ("a piece is checked before it is accepted, not after"). The line then selects c@1. The check applies now. The guard is unmet, because the check did not apply when recorded. The same check, recorded again after the write, meets it (test `checked before selected`).
- **Going back and forward again loses the answer.** A fork writes c@1, the check is recorded, the fork is rewound past the write, and the same write is made again. Same version selected, same evidence in the base, and the state is not stationary: on the line as it now is, the check precedes the write (test `a rewind forgets an answer`). R3 says the state after a rewind differs only by evidence recorded since; that is true of the rewound state and false of the next step from it.

The proviso seems to be there so that evidence which had lapsed (a read had changed) cannot meet a guard. "Applies now, or applied at some time while the line had that version" would do that without making the base's evidence line-relative in time.

**A contradiction inside the spec that this turned up.** §3 says a line's state includes the base "up to the line's latest time". Then a rewound line sees none of the evidence recorded since the point it went back to, and R3 ("differs only by evidence and same events recorded since") cannot be true. Built with the base read as it stands when the state is asked for; a checkpoint's state is then its events with the base as of its closing.

### 3.3 R4, R8: answered once, and what it costs

R4 holds as stated: once evidence that holds on the finding's criterion is recorded at a later version, no later version carries the guard, and re-selecting the bad version brings the finding back (test `a small move`). Draft 3 needed a fact per finding per edit; that is gone.

The price is a second way to shed a defect. Fix c, have the fix answered, put c back as it was (the finding applies again, since it is about that version), then make any edit. "At any version the line selected **at or after v**" has two readings when v was selected twice. Counted from the first selection of v, the old answer still meets the guard and the reintroduced defect is clean after one edit. Counted from the last, the guard is back (test `R4`, both readings; `guard_from_last` in the ontology). The spec should say "after the line last selected v".

With that, R8's ways out are three: a replacement that does not record descent (unchanged from draft 3, test `R8`); a set aside, which is a decision on the line and visible; and nothing else that I found.

### 3.4 R5: what a set aside can and cannot remove

From the runs, by what the set-aside event did to the frontier:

- Set aside of a **finding** removes: the finding (C6); its guard; and what followed from them through the warrant (the root's ask of the piece, C5; a need on it, C8; a claim about it, C7) and through resting (C5).
- Set aside of **evidence that holds** adds: the root's ask (C5), a need (C8), a claim (C7), what rested on it (C5), and a guard that the evidence had met (C6).
- Set aside of a **same** event does what setting aside the carried fact at that version would do.
- It was never seen to remove or add C1, C2, C3, C4 or a slot's C8. (C2 can in principle be met by evidence that read the other filler, so a set aside of that evidence should add C2; the generator's root kind has no inner dependency in most universes and this was not met.)

It cannot tell a wrong finding from a right one. It is the general exit of this draft: any finding leaves by one unconditioned decision. It is on the line, it can be withdrawn, and R10's "shown" does not list set-aside findings. I would list them: a steady state's stated conditions in core include every waiver, and a set aside is a stronger thing than a waiver, since the item is gone and not merely covered.

### 3.5 R10: unmarking a root adds items

"Unmarking a root removes its items and nothing else." It can add. A piece in canon through root P only, and (a) another root's piece rests on it: C5 appears on that piece, since what it rests on is no longer in canon (`runs/add-ams.txt`, 4 states; smallest witness there); or (b) another root's outline has a promised slot filled by it under a provisional flag: the promise was kept because the filler was in canon by P's path, and is owed again (test `an outline fills in; roots`, last two lines). The second is odd on its face: a slot flagged provisional in O counts as filled-by-canon because some other root reaches the filler.

### 3.6 R6, R7

R6: with `read_as` monotone and no same event for a finding, 1.67M additions of good news added nothing. Without the first, good evidence breaks a root's ask, a claim and a need (`runs/add-x.txt`). Without the second, a same event for a finding breaks a stationary state (same file, under R3). So neither can be dropped; the third draft-3 condition is now a rule and is gone. The conflict exception is gone with C6's conflict clause. The promise exception is smaller and not gone: §2 says a promised slot needs a filler in canon, not a consistent one, which stops the spread *into* the assembly; the assembly with an unkept promise is still inconsistent, and what rests on the assembly gets C5 (test `R6`). Waiving the promise stops it, by §5's rule that a waived instance does not spread.

R7: the step is monotone now by inspection (nothing owed comes to be owed because a piece is consistent), so the greatest fixed point exists; it existed, and iteration from the top reached it, in all 9.0M states. It is unique as a greatest fixed point by definition. It is not the only fixed point: two pieces that rest on each other by a kind nothing caps along are consistent together (greatest) or inconsistent together (least), with nothing else wrong (test `R7`). So "consistent" depends on the choice of greatest, as draft 3 chose and for the reason core gives (terms that define one another are accepted together). No random universe produced this; it needs the ring.

### 3.7 R12

As bare sets of pieces the reading is not narrower than draft 3's wider one. Redirect through descent is gone, and C1 is the assembly's; but canon by reach means the items about a piece exist or not according to every assembly above it and every root mark, so a write to an outline, or a mark, far above a piece changes what is owed on it. Zero failures for the static neighbourhood: 261k checks with the event added at the end, 298k with it added at any time. The selection-based one fails only for a write that makes some other id into a holder of the piece.

Graded as in §3.1, an event added **at any time** that changes nothing the piece reads left what is owed on the piece unchanged in all 19.8M checks (15.4M at 4 ids, 4.4M at 5). That graded relation is the one thing in this account I would most like proved, since (a) and (b) rest on it.

## 4. Where draft 4 had to be read one way to be built

1. **§3 "the base up to the line's latest time"** against R3. Read as: the base as it stands. (§3.2.)
2. **§6 "appended to the main line"** against "a line is a sequence in time order". Read as: closing merges by time. With appending instead, the clock case of §3.1 still arises (the later-closed fork's writes all come after), and "applied when recorded" would need a meaning for events whose position and time disagree.
3. **§4 "at or after v"** when v was selected more than once. Both readings built (§3.3).
4. **§4 "provided that evidence applied when recorded"**: on which line. Read as: on this line as it stood at the evidence's time. (§3.2.) Also read as: and not set aside since.
5. **§2 "a decided dimension is asked for the same way"**: nothing says how accept decisions give a warrant. Read as: warrant 1 while some accept decision about the piece, naming that dimension, holds. An accept decision therefore needed a dimension.
6. **C4's switch** needs "as they then stood" computed from the line at the time of p's latest write. No field on the reference was needed, which is better than draft 3; and it is what makes the clock case possible.
7. **C5 "every root that reaches p and every dimension that root asks of p's kind"**: built with one veritoid kind, asks applying to veritoids only.
8. **C9 "later than the raise"**: by time, any outcome. A failing answer answers the question and then is a finding.
9. **C2 "evidence about one filler that read the other"**: either direction, and the evidence must apply.
10. **Withdraw**: takes effect only if later in time than what it withdraws; a root's mark is its latest mark or unmark.
11. **Stationary "for every root"**: every piece in canon is reached by some root, so this is "nothing uncovered anywhere"; "stationary for one root" is not exercised.

## 5. The five invented moves

| move | as a fork that closes? | notes |
|---|---|---|
| `impl-a-small-move` | **Yes** (test `a small move, with whole reads`). | The whole reads are now sayable: a check of the outline that read c and u lapses when c is rewritten, and u's check, which read c, lapses with it, as at 09:25. The later edit of c carries no guard. Draft 3's observation still holds: the answer to the finding is evidence that holds, and counts toward the root's ask. |
| `impl-two-moves-at-once` | **Yes**, as two forks (tests `two forks`, `what meeting is`). The two repairs do not meet and both close; when x comes to rest on c, they meet and cannot both close. | In the move the second half ends with the two closing as one changeset. Here that is "rework fork B on the checkpoint A made". |
| `impl-a-finding-is-answered` | **Yes**, step 4 included (test `a wrong finding, set aside`): the piece stays at its version. | Carrying (step 2) is a same event; it is in the base, so a carry made on one fork carries everywhere. |
| `impl-an-outline-fills-in` | **Steps 1–4 yes** (test `an outline fills in; roots`): promised and empty is owed; filled by a draft under a provisional flag, the promise is still owed, the draft has no items and its bad news is shown; checked and placed, the promise is kept. Steps 5–8 not built. | "Suggested" and "gap" are not in draft 4's slot (empty, holds, points, provisional). Step 7's named assumption needs a decision with a condition; C5 no longer reads accept decisions unless the root asks a decided dimension, so this would go through `asks`, untested. |
| `impl-intake` | **Not built.** Routing and retirement of a source are still outside. | |

## 6. What carried over from the draft-3 build, and what was rebuilt

**Carried over nearly as it was:** the constraints as a function of an assumption about which pieces are consistent; the step, the brute-force fixed points and iteration from the top; warrant, effective warrant, the cycle check; the instrument (a pool, every subset, tags with a smallest witness each); the hand-built style of test. About half of `model.ml` by line.

**Rebuilt:** everything the function is applied *to*. A state is derived from events (selection, per-id history, decisions in force, marks, canon by reach) where draft 3 was handed a selection and a fact set. Guards (order, met-for-good, applied-when-recorded). Evidence applying (reads; set aside). C5 (asks of roots in place of three standards). C1, C3, C8 (restated). Instances are keyed by event where draft 3 keyed by criterion. The explorer's checks are all new: "one more event" replaces "one more fact", forks replace pairs of changes to a selection, and the graded read/change relation is new.

## 7. What I think is the model's to decide, not the spec's

1. Whether two forks may close **because the merged state is stationary** or only **because they do not meet** (§3.1). The first is cheaper and has the clock hole. The second needs "meet" to be part of the model, in three respects or something like them.
2. Whether an outline's reading of its parts is a **declared** property of the assembly kind (existence only; assertions; everything). Draft 4 fixed slot pointing at existence only, and that is the whole reason two repairs under one outline do not meet. `def/segment.md` has it as "what the kind says such a read relies on", for a review; here it does more work than that.
3. Whether evidence gathered ahead of a write counts (§3.2). Core's own advice is to check before accepting.
4. Whether a set-aside finding is shown at a steady state (§3.4).
5. Whether a slot flagged provisional can be "filled by a piece in canon" on the strength of another root (§3.5).

## 8. What was not done

- Nothing is proved by a tool. The statement most worth proving is graded locality (§3.7), then (a) and (b) from it.
- The graded read relation was written by hand to be safe and was loosened once (to consult only events present, and only evidence about versions the line has selected). It is an over-approximation, not a least relation: it may call forks meeting that need not. I did not try to find the least one.
- Bounds: 4 or 5 ids, 2 versions, 12 to 14 free events, two forks, one checkpoint position per universe (the middle of the free events).
- Rewind is tested by hand, not by the explorer. Three or more forks, and a fork closing onto a main line that two others have closed onto, are untested.
- Two of the five moves are partly or wholly unbuilt (§5).
- The Ada accounts were not read, by arrangement.
