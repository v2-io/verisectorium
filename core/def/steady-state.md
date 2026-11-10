```kdl
term "steady·state" pos=noun pl="steady·states" {
  synonyms "stationary"
  avoid "checkpoint" "a place passed through on the way somewhere else, and a moment of verification; a verisectorium at a steady state is not on the way anywhere, and the state is not the moment it was reached"
  avoid "stable" "suggests nothing is moving; a verisectorium at a steady state may be under heavy work in work time"
  avoid "main" "a branch name, one way of holding one"
  avoid "fixed point" "right as mathematics, wrong as a word for readers"
  rel reached-by term="changeset" card="{0,1}" note="the atomic changeset that closed on it; none for the first"
  rel conditions term="decision" card="{0,N}" note="the waivers that cover what is still owed"
}
status provisional
```

# «steady·state»
A state, of the whole or of the part outside every open changeset, in which nothing is owed, or every owed item is covered by a waiver with a reason; the waivers, and the determinant dimensions never asked of accepted pieces, are its stated conditions. A verisectorium at a steady state is *stationary*: the adjective for the noun.

## Definition
There are two kinds of time. In **steady time** a part of the verisectorium moves from settled to settled, each move at one logical instant; nothing exists in between, and at each one the verisectorium is good or true, with stated conditions. In **work time** minds assemble that move over hours and days; while they do there is a working state, the last steady state plus what has been staged, and it is never the verisectorium. A steady state is reached when an ‹atomic·changeset› closes: its «frontier» is empty, or what remains on it is covered by waivers. A **waiver** is a «decision», by a party the ontology gives standing, that an owed item is knowingly left owed, with its reason.

Steadiness is said of a place. Each atomic changeset has a scope, the segments its disturbance reaches, and several may be open at once. The verisectorium is steady **outside** the open scopes: nothing there is owed, and nothing there rests on anything that is. A steady state of the whole is the case where none is open, and with several minds at work it may be uncommon; nothing needs it. What a reader or a builder is promised is about the segments they are using.

The steady state's **stated conditions** are: every waiver covering an owed item, with its reason and its party; for the ‹determinant› dimensions, every piece in canon whose warrant is *never asked*, by dimension and by declared means; the gaps its canonical projection shows; the questions left open in canon; and every provisional piece the canonical projection reaches, with whatever has been recorded against it. That last keeps a strict standard for canon from making a steady state look cleaner than the work is. A rendering of a steady state carries them; a reader who sees a steady state sees what it is not yet claiming.

### Invariants
- At a steady state nothing in canon outruns the record: no accepted piece is contradicted or overclaimed, every decision canon rests on stands, every reference from canon holds, and no promise is unkept, except by recorded waiver.
- Closed atomic changesets are ordered only where one read what another wrote; unrelated ones have no order and need none. Within one, nothing exists between its opening and its close: only the last write to each segment is in what it reaches.
- A waiver is visible in the conditions of every steady state while its item stays owed, and it ends with the repair that clears the item.
- A confirming check on a steady state reaches a new steady state at once, since nothing becomes owed.
- A rendering of a steady state made while a later move is under way shows every contradiction and finding recorded since against a piece in it. The steady state is still what the verisectorium says; a reader about to build on a piece is told what is already known against it.
- A waiver is about the owed item it covers and says nothing about any piece's content; a decision covering a changeset is not an acceptance of what the changeset says. Silence is neither.

## Discussion
- Why "good or true, with stated conditions" needs the conditions. A verisectorium that only promised consistency could be consistent and silent about a known defect. The waivers are where honesty about the not-yet lives; they are Joseph's known-defect mark. A steady state promises two things, consistent and honestly current, and the conditions are what makes the second true.
- Why the never-asked determinants are conditions. A claim asserting nothing and never checked violates no constraint; it is simply unknown. For a determinant that unknown is part of what the steady state is not claiming, and a reader should see it beside the waivers.
- Why two kinds of time. Without them, "the claim changed" and "the description was brought into line" are two records with a gap between them in which the corpus held something nobody meant. Steady time is where logical simultaneity lives; work time is where the honest record of how the move was assembled lives.

## Examples
- A scope segment after its eighth round of checks: validity confirmed on every item at the current version; one narrowed check and two findings still owed. A steady state there needs three waivers or three repairs, and its conditions would name them.
- A theory's derivation that stood for six months with one proposition asserted and several times confirmed, by one means. It was false. A steady state promises that nothing in canon outruns the record, and does not promise that the record was enough.

## Historical Context
### Etymology
From dynamical systems: a state that persists until something perturbs it, whatever activity goes on around it. Joseph's own "steady-state stability as a self-consistency check" and "stable checkpoints / states" (2026-11-05). *Checkpoint* was the term for a day (2026-11-08/09) and was dropped at his worry that it names a place passed through on the way somewhere else, and a moment of verification rather than a state; a verisectorium at a steady state is not on the way anywhere. *Stable* was declined because it suggests nothing is moving, while the acta may be busy in work time; *fixed point* is right as mathematics and wrong for readers; *main* is a branch name; the Latin stops on a road (*statio*, *mansio*) carry the connotation being left.

### The known-defect mark, in his words
Joseph, 2026-11-05, weighing a marker on a value: "There is now a known defect that likely downgrades this dimension's assertion-- but the work is not yet done to integrate the soften or adjudicate a strengthen-- do not rely in the meantime" with a sort of "known honesty" orthogonal to internal-consistency/stability factor on main...  I would support that if it was pretty rare and is almost always the thing being worked on right away-- so they don't accumulate-- maybe even dissallow more than one or two flags like that without reconciling one.... but that doesn't make sense to disallow a known correction... still pondering...

### Adjudication
- The two kinds of time were Joseph's correction of 2026-11-05 ("practical sequentialness but logical simultaneity") to a draft whose acta were a flat list of single-piece acts; `msc/notes/08/10` carries the correction and its worked table. The known-defect mark he weighed that day became the waiver here once the frontier was computed; it was called an acceptance until 2026-11-10, when that word was kept for admitting a piece to canon.
- Adjudicated against msc/notes 05 (22:53Z), 08/10, 09 §3.1 and §4.4, 14, 19 §5 and §7, and Joseph's 11-08 words on frontier versus stable steady states.

## Working Notes
- Open. Whether a working state is held as a branch, a separate corpus, or otherwise. The requirements are: steady states along the way, a diff against the last steady state, the frontier, a merge only when the frontier is empty or waived, and detection of overlapping changesets before merge.
- Open. Whether a verisectorium may want a graded fall in warrant on a small rewording where nobody has carried the checks. Lean: no; carrying is the mechanism, and an uncarried check has lapsed.
- Waivers are meant to be rare: for a known defect knowingly left, never for work that is merely elsewhere. Scopes are what keep them so, and so is the fact that nothing obliges a changeset to close: one that waits on something outside (a tool to be fixed in another project) stays open and says so, and the verisectorium is steady around it.
- Open. Whether suggested slots are shown with a steady state's conditions or only counted.
