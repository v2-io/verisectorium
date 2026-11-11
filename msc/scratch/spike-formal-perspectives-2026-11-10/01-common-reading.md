# The common reading every exemplar starts from

*2026-11-10/11, by the spike lead (Fable 5.2). Written before any exemplar, so that four languages look at one thing. It is my reduction of `msc/notes/22` Part 2–4 and `msc/scratch/kernel-2/KERNEL-SPEC.md` draft 4 to the smallest model that can run note 22's own example (§4.3). It is a reading for exemplar purposes, adjudicated by nobody; where it departs from the spec it says so. An exemplar may cut it further or widen it, and says which.*

## What I read before writing this

Whole, myself: notes 22 and 23; KERNEL-SPEC draft 4 and draft 3 (from git `9305775`); `ada/ACCOUNT.md` and `ocaml/ACCOUNT.md` as they stood at about 20:20 local (both draft-4 accounts); `core/README.md`, `model.outline.md`, `nutshell.outline.md`, `praxes/working-on-core.md` from disk; all twelve `core/def/*.md`; eleven of thirteen `core/src/*.md`; every file in the project memory directory. Grepped only: the two draft-3 accounts (for the well-definedness counterexample). Not read: `core/src/impl-scope-adaptive-system.md`, `impl-stopped-bound.md`; `core/log.kdl`; the builders' code; both SPEC-AUDITs; the rest of `msc/notes/`.

## The workflow the exemplars serve

Bring in, cut and place, adjudicate, stabilize, build on (note 22 Part 1). Every exemplar runs the *stabilize* part of one concrete story, because that is where the kernel is and where the formal builds have been. None of them touches intake or "better". That is a limit of this spike, stated here once.

## M0: the small model

**Pieces.** Ids. A piece is a veritoid (here always claim-like: it may be *predicated on* other pieces) or an assembly (slots, each holding or pointing at a piece, each with a provisional flag). Versions are immutable; a veritoid's version fixes its content and what it is predicated on; an assembly's version fixes its slots and not its fillers' versions.

**Events**, each with a time.

| event | lives | says |
|---|---|---|
| write(p, v) | on a line | v becomes p's selected version. It records what each of v's references pointed at when written (the Ada build's G10). |
| evidence(e; p@v, criterion, holds or fails; reads q@w, …) | in the base | p at v, asked by this criterion, held or failed, having read these |
| same(e; p, v, w) | in the base | for evidence e, versions v and w of p do not differ |
| affirm(p@v, q@w) | on a line | p at v was looked at beside q at w and kept |
| raise(p, criterion), promise(slot), waive(item), set-aside(e), mark-root(a) | on a line | unconditional |

A **line** is a set of line events; its **state**, as of now, is: each piece's selected version (its latest write on the line), the order in which the line selected each piece's versions, the decisions on the line, and all of the base. A **fork** shares a checkpoint's events and adds its own. **Rewind** drops line events after a point; base events stay. **Close** makes a stationary fork the next checkpoint.

**Computed.**

- *Canon*: reached from marked roots through filled, non-provisional slots.
- Evidence *applies* when its subject is selected at the version it is about (or one **same** for it), every read is selected as it was read (or **same**), and it is not set aside.
- The conditions, numbered as in note 22 §4.1, for each piece in canon. The exemplars implement at least 2, 4, 5 and 6, which is what the example needs.
  1. every reference reaches a selected piece;
  2. every reference was written, or affirmed, against its target as the target now is;
  4. no finding applies; and no *guard* is open: a finding against a version the line selected earlier, with no evidence that holds on the same criterion, later than the finding, applying now;
  5. what its root asks: a claim has applying evidence that holds on criterion *valid*; a result (an assembly) has an applying whole read, which is evidence about the assembly that read every filler. And it rests (is predicated, transitively) only on canon pieces with no violation of their own;
  6. for each inner dependency a → b of its kind: an affirm, or evidence about a's filler that read b's filler, at the selected versions;
  8. a promised slot is filled by a canon piece;
  9. a raised question has later applying evidence.
- The **frontier** is every (condition, piece) that fails and is not waived. **Stationary**: the frontier is empty.

Left out of M0, knowingly: warrant levels and caps (a claim is checked or not); `read_as`; condition 3's needed warrants and 7's overclaims; descent and retirement; several roots asking different things; who did anything.

## The story: note 22 §4.3

Pieces: outline **O** (root; points at T and U); result **T** (holds claim **c**, derivation **d**, description **e**, eli8 **k**; inner dependencies e → c and k → e); result **U** (holds claim **u**, predicated on c). The root asks of every claim that it has been checked and of every result that it has been read whole.

| # | time | event | note 22's frontier column |
|---|---|---|---|
| 0 | S0 | writes c1 d1 e1 k1 u1 (u1 predicated on c, written against c1), T, U, O; mark-root O; E1 = valid(c@c1) holds, read d@d1; E2 = valid(u@u1) holds, read c@c1; E3 = whole(T) holds, read c1 d1 e1 k1; E4 = whole(U) holds, read u1; affirm(e1, c1); affirm(k1, e1) | empty: checkpoint S0 |
| 1 | 08:30 | E5 = caseX(c@c1) **fails** | S0 no longer stationary. c1 known wrong. u1 rests on it. |
| 2 | 09:00 | fork F from S0: write c1′, d1′; E6 = valid(c@c1′) holds, read d@d1′ | c1′ is fine. But u1 needs the stronger conclusion. |
| 3 | 10:00 | rewind F to its start | as at 08:30; E6 is on record, about versions the fork no longer has |
| 4 | 10:30 | write c2, d2, k2; affirm(e1, c2) | c2 unchecked; e1 looked at against c2; T not read whole as it now is; u1 was written against c1 |
| 5 | 11:00 | E7 = valid(c@c2) holds, read d@d2; E8 = caseX(c@c2) holds | T's whole read; u1 |
| 6 | 11:30 | write d3 | E7 read d2: c2 unchecked again |
| 7 | 12:00 | E9 = valid(c@c2) holds, read d@d3 | T's whole read; u1 |
| 8 | 13:00 | write u2 (against c2); E10 = valid(u@u2) holds, read c@c2 | whole reads of T and U |
| 9 | 14:00 | E11 = whole(T) holds, read c2 d3 e1 k2; E12 = whole(U) holds, read u2 | empty: close, checkpoint S1 |

Two things about this table are themselves a test. The right-hand column is prose written by a mind; the conditions are a definition. Whether a mechanical reading of the conditions gives that column at every row could come out otherwise, and each exemplar reports where it does. And row 4 leaves open whether k2 was looked at beside e1 (the story does not say), so an exemplar that finds condition 6 owed on k there has found something in the story, not made an error.

## Conventions for this directory

- One subdirectory per instrument (`datalog/`, `lean/`, `alloy/`, `tla/`), each with a `PERSPECTIVE.md`: what the language's own way of seeing showed about the model, in the model's words; what it made obvious, refused, could not say, would rename; and what was run, what was only read, what is a guess. Tool output goes whole into that subdirectory's `runs/`.
- Guesses going in (mine, unverified, to be tested and not confirmed): written in `02-guesses-before-running.md` so that afterwards it can be seen which the tools overturned.
- Nothing here is a fact about the model until adjudicated in core, and nothing here proposes a mechanism for it.
