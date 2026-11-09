---
slug: disc-pieces-and-identity
form: disc
status: provisional
narrates: [veritoid, segment, kind, reference, changeset]
---

# The pieces, and why identity is minted

*Moved from the first-iteration overview (`MODEL.md`, Fable 5.1, 2026-11-08) into a segment of its own on Joseph's suggestion, so that it narrates the defs it rests on and lapses when they change. Provisional. Where a thing is Joseph's it says so; [M] marks the least tested.*

A **veritoid** is one piece of **content** of a declared kind, together with what it asserts about itself and what the acts warrant for it. Yours: "content with one or more dimensions + rules". In ASF's files it is usually a `##` section or something smaller: one lettered item under a statement, one step of a derivation, one entry of a claim record. It almost never makes sense alone and is never changed alone.

A «segment» is veritoids written and judged together, under a **name**. It exists because keeping its veritoids together when adjudicating any one of them is crucial; a change to one forces a look at its neighbours. It is the unit of writing and of whole review. Two subtypes need naming at once: a ‹projection› is a segment whose places hold references to other segments in a chosen order (a chapter, a volume, the canonical outline, a report), and a ‹source› is a segment whose veritoids are **chunks** cut from material brought in (the intake segment, `impl-intake`, works this through). At least one projection is **canonical**: it says "this is the work, in this order", and each of its rows carries two states kept apart, commitment (**provisional**, a suggestion; or **promised**, by a decision) and existence (**absent** or **present**), so that an outline full of unwritten rows is still true at every checkpoint. Its review lapses only on what its kind says a review reads of each member, and a member may be a segment that does not yet exist; that reference is owed, not forbidden.

A «kind» says what a veritoid or segment holds and which dimensions apply to it. A ‹veritoid·kind› declares a content shape, the dimensions it opens, which assertions its content may carry, and which reference kinds it may hold. A ‹segment·kind› declares **slots** (which veritoid kind goes in each, required or not, how many, in order), **inner dependencies** between slots (the eli8 rests on the description, which rests on the formal claim), and how the segment's own dimensions are read from its veritoids: aliased to one, derived from several, or asked of the whole (coherence).

**Identity, names, versions.** Every veritoid and every segment has an **id** minted at creation and never reused. A segment also has a **name**: a label bound to its id, with history; a rename is recorded and old names keep resolving; two segments under one name is a failure that is surfaced, never assumed away. A veritoid has no name; a rendering addresses it through its segment. A veritoid's **version** is the hash of its written state: content, assertions, and references with the versions they were last reconciled against. So re-pointing a reference is a write and mints a version, which is right, because a derivation that now uses a different premise is a different derivation. A segment's version is the hash of its assembly and its veritoids' versions.

**Recutting.** A *split* retires one id and mints several, recording descent; a *merge* retires several and mints one; a *promote* or *fold-back* moves veritoids between segments and keeps their ids. A reference to a retired id is owed (re-point to a descendant, or drop) and is never silently redirected. Grain is discovered by adjudication: when an act confirms part of a veritoid and breaks the rest, the veritoid wants splitting. [M for the id rule; the gap it closes has been open since 11-05.]

**Two levels only.** Content has veritoids and segments. Projections gather segments to any depth, but that is gathering, not content inside content. The decomposition could continue as mathematics; two levels is where practice stops, and every rule here is stated at one of them.
