```kdl
term "segment" pos=noun pl="-s" {
  subtypes "projection" "source"
  synonyms "document"
  avoid "instance" "the dialog's local word; in the verisectorium plan an instance is a whole verisectorium made from a template"
  avoid "file" "a file is a rendering of a segment, never the segment"
  avoid "composite" "did not say where membership, order or coherence lived"
  rel of term="kind" card="{1,1}" note="a segment kind"
  rel holds term="veritoid" card="{0,N}" note="each in one of its kind's slots, in order"
  rel written-by term="changeset" card="{1,N}" note="segment changesets; its whole written history"
}
status provisional
```

# «segment»
Veritoids written and judged together under a name: the unit of writing, of naming, and of whole review.

## Intro
A «veritoid» almost never makes sense alone. Its fate is intertwined with its neighbours', usually so that if a core one fails the others go down with it, and adjudicating a change to any one of them means looking at the rest. A segment is the set of veritoids kept together for that reason. Its ‹segment·kind› declares its slots, the inner dependencies between them, and how the segment's own «dimensions|def/dimension» are read from its veritoids. Two subtypes are needed from the start: a ‹projection› is a segment whose slots hold «references|def/reference» to other segments in a chosen order, for a purpose (a chapter, a part, a volume, the canonical outline, a reading path, a report); a ‹source› is a segment whose veritoids are chunks cut from material brought in.

## Definition
### Invariants
- It has a minted id and one current name; old names keep resolving.
- It is the unit of writing: its veritoids change only together, in one ‹segment·changeset›.
- It is not one fate. Each veritoid has its own warrants; the segment has its own dimensions, chiefly coherence (does it hold together read as one thing), read from a review of the whole.
- A ‹projection› may declare, over segment kind × determinant, the weight each pair carries for its purpose, with reach within it as a multiplier; that declaration is what makes the projection's sense of better, and the canonical projection's is the verisectorium's default.
- A ‹projection›'s rows carry two states kept apart, commitment (provisional, or promised by a decision) and existence (absent, or present), and a projection is true as stated at every «steady·state» because a provisional row claims only that the suggestion exists; its coherence lapses only on what its kind says a review of it reads of each member (headline and assertion, not every proof step), so one edit does not lapse the whole theory.
- At least one projection in every verisectorium is canonical. A segment reached by no canonical projection and by no predicated-on reference in or out is an orphan; orphans are allowed and counted.
- A ‹source› is cut completely into chunks; it is retired, computed, when every chunk has a final crossing.
- Its inbox (the chunks bearing on it with no final crossing) is computed and is not part of its written state. Adding to or draining it never changes the segment.

## Discussion
- Why a segment is not one kind and not one fate. ASF's frontmatter made a whole segment look like one fate and one kind; its `status:` word was five questions' worth of assertions on heterogeneous veritoids, typed once. Many ASF segments are also coarser than they should be, holding independent claims that should each have their own name; promotion is the recut for that.
- Why Working Notes were three things. Inbox chunks (uncrossed material bearing on the segment); standing content mis-shelved (regression guards, open questions with closers, dead ends with reasons, each a veritoid of its own kind in a slot of its own); and in-place fate markers written as prose, which are crossings that never became acts. The first is the inbox; the second is content; the third is the acta.
- Four places a record can go, and which the segment owns. The acta (what was done; the verisectorium's, not the segment's), the history of renderings (outside the verisectorium), the inbox (influx bearing on the segment, outside its written state), and history (written prose kept with the segment about how it came to be as it is: a slot of account veritoids, revisable, faithful to the acta, and the one place a segment may point outward as breadcrumbs). A body states present truth and stands alone; history says how it got there; the inbox holds what is not yet adjudicated; the acta hold what was done. A sentence of history inside a claim is a claim that has stopped standing on its own.
- Why projections nest without a third level. A chapter is a segment whose slots hold references to segments; a part holds chapters; the theory holds parts. That is gathering, not content inside content, so the two-level rule stands.

## Examples
- `scope-adaptive-system`: one segment of kind *scope*, with slots for intro, definition, predicate, membership consequences (any number of claims), housing result, non-claims, discussion paragraphs, questions, guards.
- `01-aat-core/OUTLINE.md`: a canonical projection with nine `--GAP--` rows and six `missing` cells, which are provisional rows and make the outline no less true.
- `audits/AUDIT-WORKING-193847/`: a source, cut into chunks by the 2026-05-30 lift, most of which bear on one segment each.

## Historical Context
### Etymology
English, from *segmentum*, a piece cut off (*secare* again, the same root as the *-sect-* in verisectorium): what the cutting produces. It has been the estate's everyday word for the unit a mind writes and reviews since ASF's first files, and the model keeps it with that sense sharpened: the unit of writing and of naming, not of fate.

### Adjudication
- Adjudicated against msc/notes 05 (21:52Z), 09 §2.3 and §2.6, 10 §1.4, 14, 19 §2 and §6.

## Working Notes
- Open. Whether a projection's members may also be veritoids (a chapter preface written inline) or only references to segments. Lean: a projection kind may declare content slots of its own beside its member slot; the preface is then its veritoid.
- A ‹source› and its chunks are written once and never changed; a ‹crossing› concerns a chunk and writes nothing in it; so the changeset that lands a source has no inner dependents to affirm, and a changeset touching a source's chunks is refused. Stated here so the first real intake does not meet it as a surprise.
- Churn is a second grain detector beside adjudication: a segment whose history is long and whose change notes are about different things is carrying two claims. Cheap, and computed.
- A restates reference means agreement with the piece that owns the claim; two pieces restating a third that disagree with each other are repaired by ceasing to restate (a reference to the owner), never by reconciling the two copies.
- Open. Whether "source" and "projection" are subtypes of segment or kinds declared by every ontology. Lean: subtypes, because every verisectorium has both and the engine treats them specially (the inbox; the canonical projection).
