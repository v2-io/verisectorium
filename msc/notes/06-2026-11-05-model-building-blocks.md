# The building blocks: where the model stands (2026-11-05)

*councils-46, from a day's discussion with Joseph. The discussion itself, verbatim, is in `building-blocks-dialog-2026-11-05.md`; read it for the reasoning and Joseph's words. This file states where it landed.*

*Status: **working model, not yet provisional.** Not merged into `PLAN.md` or `PLAN-appendix-A.md`. Those, and `research/appendix-A-feedback-1.md`, are to be reconciled into this by a fresh pass, under this file's terminology, not the reverse.*

***The terminology here is locally scoped only.*** *"Atom", "template", "instance", "slot" and "instance-isolated changeset" are working names chosen for carrying less baggage. They aren't settled. Joseph expects to rename some soon. "Template" may become "kind", once that word no longer evokes something else.*

*It supersedes the "core terms" table and diagram I gave earlier in the same discussion, which used "record" for two different things and "kind" for two different things.*

---

## 1. What was wrong before, in one paragraph

Earlier models used one word for the unit of **fate** (what can fail on its own) and for the unit of **identity** (what has a name and a file), and one word for the type of an atom and for the type of what atoms are assembled into. In ASF these are different. The fate unit is usually a `##` section, and the identity unit is the segment, which holds a family of such sections. ASF's own failure ran the other way: its frontmatter treated a segment as one fate, as if the segment were one kind. And a model whose "kind" didn't say what content pieces it has couldn't describe a segment at all.

## 2. The declared level

- **Atom kind.** It declares:
  - a content schema;
  - 1..N **dimensions**, each with a **scale**;
  - write rules;
  - the moves that change its dimensions.

  Examples: formal-claim, description, eli8, derivation, discussion.
- **Scale.** The values a dimension can take. It is one of:
  - ordered: a **ladder** of rungs;
  - unordered;
  - numeric;
  - **reference:** an array of references to atoms of declared kinds. For example, `formal-claim.predicated-on → [formal-claim, …]`.
- **Template** (the type of an instance; possibly "kind" later). It declares:
  - **ordered slots,** each an atom kind *or* a template, marked required or optional, with a cardinality (1, 0..1, 0..N);
  - **intra-instance edges** between its slots. Joseph's example: within one instance, eli8 depends on description, which depends on formal-claim;
  - **the instance's own dimensions,** of three sorts:
    - *aliased* to one atom's dimension, e.g. `instance.truth := formal-claim.credence`;
    - *derived* from its atoms, e.g. `instance.freshness := min over its atoms`;
    - *own* to the whole: coherence, teachability, importance-for-X.

  Examples: derived-result, definition, introduction, chapter.

## 3. The instance level

- **Instance.** Exactly one template. Exactly one **identity**, with 1..N **names** over time: one current, plus aliases, and a rename is an event.
  - It fills its template's slots with atoms (content slots), or with references to other instances (containment slots: a chapter's segments).
  - It has values on its own, aliased and derived dimensions.
  - It renders as 0..N **manifestations** (a file, a section), which are never its identity.
  - ASF's "segment" is its everyday name for instances of several templates.
- **Atom.** Fills exactly one slot of exactly one instance.
  - Its address is `instance-name#slot`, or `slot[i]` where the slot is 0..N.
  - **It is the unit of fate:** it can be refuted, superseded or ratified while its siblings stand.
  - It has its own versions, its values on its kind's dimensions, and its trail.
  - Atoms don't mean much alone; they matter in relation to the other atoms in their instance.
- **Where truth propagates: on atoms, through reference dimensions.**
  - `derived-result#formal-claim.predicated-on → [other#formal-claim, …]`.
  - An introduction can rest on another instance's `#eli8` atom specifically, instead of or in addition to its formal claim.
  - ASF's frontmatter `depends:` is a roll-up of this to instance level: a convenience that hid the real graph.
- **Coherence** is an instance's own dimension. A whole-instance review moves it, and that review's basis is the instance's atoms at their versions. "One change forces a look at the whole" is then a lapse on the instance, while each atom keeps its own fate.

## 4. Changes: the instance-isolated changeset and the atomic changeset

Joseph's definitions, in his words:
- **instance-isolated changeset:** *"an atomic set of simultaneous changes to atoms in a single instance. That's the sort of thing where inner-dependencies and so forth would have to be fully coherent and reconciled and correct and could be checked in some cases automatically or it isn't a valid instance-change."*
- **atomic changeset:** *"the entire set of changes that keeps everything in an isolated graph internally-consistent — usually multiple instance-isolated-changesets that happen 'simultaneously' logically speaking."*

What follows from those:
- **An atom never changes alone,** only within an instance-isolated changeset. That is the basic write. There are two families of event:
  - **changes:** instance-isolated changesets, carrying their per-atom diffs;
  - **acts on atoms at a version:** checks, decisions, crossings.
- **An instance-isolated changeset can do any of these:**
  - change atom content;
  - change dependency dimensions;
  - mint new instances.
- **Validity and coherence are different.** A changeset is *valid* if the template's rules hold, and that can sometimes be checked mechanically. The instance's *coherence* may still lapse until someone re-reads the whole. Validity gates the change; coherence goes on the frontier.
- **The process.**
  - The graph starts self-consistent, usually at a fixed point.
  - A **motivating perturbation** arrives: one instance-isolated changeset.
  - The full ripple may be bigger than one agent can assemble in one pass, so further instance-isolated changesets are **staged**, often several at a time.
  - After each stage, **what is still inconsistent** is computable. This is the **frontier**:
    - references whose basis no longer matches the referenced atom's staged version;
    - violated template rules;
    - open obligations, the questions rules raise that a mind must answer.
  - The atomic changeset is complete when the frontier is empty, or when what remains is explicitly accepted (§6). Frontier growth per stage is what a breaker watches.
- **Leaves and roots.** Leaf instances can change and advance with a lot of freedom. Root instances, in a large graph like ASF's, have very large impacts when they change. Hence Joseph's *"natural incentive to get the early stuff as solid as possible roughly in proportion to their age and downstream graph-size."*

## 5. Steady state and intermediate state: the need, and one sample implementation

**The need:** to tell a steady state (self-consistent, committed) from an intermediate state (an atomic changeset in progress), and to see exactly what the intermediate state still owes.

**The mechanism is an architectural decision, still open.** What follows is one relevant sample implementation that meets the need, not a choice:
- **A merge to main (or a "deploy") is an atomic changeset.** Within a branch, intermediate checkpoints are free.
- **The "current atomic changeset" should be a single view,** much easier to read than git:
  - the staged instance-isolated changesets;
  - their diff against the branch's starting point;
  - the frontier;
  - the open obligations.
- **Requirements, whatever the storage:**
  - checkpoints;
  - a diff against the starting point;
  - the frontier;
  - merge only when the frontier is empty or its remainder is accepted;
  - overlapping branches detected before merge.

  Git gives the first two for files. The rest are v2's work under any storage.

**Whether the store lives in the repo has a larger factor,** which Joseph named and deliberately punts, since he is solely in charge of workflow for now. When independent parties work on the same store in parallel, the way groups do with code, and two repos each merge non-conflicting atomic changesets into their main, *is the union also known to be stable and internally coherent?* The store sits on the boundary between something with well-understood collaboration tooling (code in git) and something more like an app with a centralized store.

## 6. The honest intermediate, and the choice that follows a defect

- **The honest intermediate** (softening an atom's claim when a defect is found) **is the motivating perturbation** in the simplest case. It is the low-energy change that keeps the system stable, and it *is* a gain in honesty given the new evidence.
- **It often appears to settle the graph quickly. That is often an illusion,** wherever things depend on the softened atom *at* some ladder level.
- **Latent dependencies.** Even where no dependent states the level it relies on, a dependent can't rise above its premise's level. So after a softening, the system should ask: *"now that it's at this claim-support level — which no dependent claim can rise above now — can this other instance downstream here be a theorem anymore?"* One way to make this mechanical: ceilings propagate along `predicated-on` by rule (RC1: transmitted ceilings cap at the source's tier), and any dependent claiming above its new ceiling goes onto the frontier.
- **The methodology, not the core mechanisms, is to try to keep the earlier level.** Softening is what is easiest for an agent, and often what an auditor asks for. So the next step is a spike asking what it would take to change the content and *retain* the prior ladder levels. That is a **second perturbation**. It often mints a new instance, and often ripples farther than the softening would have. It is pursued instead of settling for the soften, **if there is time.** Then a choice, which is a work decision:
  - **(a) settle the soften, merge it, integrate the spike afterward.** The softened instance carries a note: changed from ___ to ___ when such-and-such flaw was found; spike a389 has shown promise in restoring it and needs several more passes. The risks are oscillation (soften and ripple, then strengthen and ripple), or treating the soften as the end of the work because everything looks stable.
  - **(b) integrate the spike on top of the soften,** in the same branch, and merge once. This works when the integration will come quickly enough to avoid that oscillation.
  - **(c) a known-defect mark on a dimension's value**, stated in Joseph's words: *"There is now a known defect that likely downgrades this dimension's assertion — but the work is not yet done to integrate the soften or adjudicate a strengthen — do not rely in the meantime."* This is a kind of "known honesty", orthogonal to internal consistency and stability, held on main. Joseph would support it if it's rare and nearly always the thing being worked on right away. He considered capping how many there can be, but disallowing a known correction makes no sense. Still being pondered.
    - *My suggestion, not yet answered:* keep marks rare through pressure, not a cap.
      - *Inhibit:* nothing new may bind to a marked atom at its current level without acknowledging the mark, and guards that read it fail or warn.
      - *Excite:* marks surface at session start and close, weighted by importance and age.
- **The dependency predicates themselves** (what level a dependent relies on, how ceilings compose) probably depend on the ladder's type. That is open, and is being moved along separately. The math so far is in `research/knowledge-graphs.md`, `research/plan-review-1.md`, and PLAN A2.

## 7. Minting, connecting, orphans, the canonical grouping

- **Minting an instance alone is allowed.** Exploratory hypotheses often don't know where they belong in the graph when minted, and that freedom is a feature: a subgraph or a single instance can get a lot of work done independently, in parallel with canon.
- **Connecting** (a dependency link into the graph, or membership in a group that must then cohere) **is its own motivating perturbation,** and usually where the big work lands.
- **Every verisectorium so far has had at least one canonical grouping:** an ordered group whose instance carries a coherence claim, not always a dependency graph. In the theory canon this is `form-canon-view`.
- **An orphan** is an instance not reachable from the canonical grouping or from the dependency graph. That's an attribute, and the orphan count, and what orphans contain, is a fitness need every instance has had.

## 8. Words, for now

| Category | Words |
|---|---|
| **In use, locally scoped** | atom, atom kind, template, slot, instance, identity, name, version, dimension, scale (ladder, rung, reference), value, manifestation, instance-isolated changeset, atomic changeset, motivating perturbation, frontier, known-defect mark, orphan, canonical grouping |
| **Retired as technical terms** | **record** (RC1 used it for the fate unit and the archived design for the file, so either meaning now collides); **group** and **composite** (an instance of a template that has containment slots); **cluster** (an instance and its atoms) |
| **Not to be redefined** | **projection**, which has long meant the view-side selection of what appears, and RC1's computed summaries. My recent stretching of it is withdrawn |
| **Dialect only** (meaning what old ASF files said, not the model) | status, epistemic status, stage cell, claim cell, slug prefix, tag, frontmatter `depends:`, Working Notes |

## 9. Open questions carried forward

1. **An atom's identity:** derived from `instance#slot`, or minted? Derived is simple until an atom moves between instances, as when a segment is split.
2. **Slots holding many atoms:** several claims in one instance, or `scope-adaptive-system`'s lettered items (a)–(h′). Is each an atom in a 0..N slot, or are atoms nested inside atoms?
3. **Templates containing templates up to the top.** Does that cover chapters, parts, volumes and the theory, or does something above need a different mechanism?
4. **Dependency predicates and ceiling propagation by ladder type** (§6).
5. **Known-defect marks:** how they're kept rare (§6).
6. **Merging the parallel work of independent parties** (§5): is a union of stable states stable? Punted.
7. **Storage:** where the store lives, and how atomic changesets are carried (§5). An architectural decision.
8. **Names:** "template" → "kind", and the rest, once the concepts settle.

## 10. What should happen next

A fresh agent reconciles `PLAN.md`, `PLAN-appendix-A.md` and `research/appendix-A-feedback-1.md` *into* this model, under its terminology, and says what each contributes, what each contradicts, and what each lacks. That produces the next iteration of the plan, rather than piling the new model onto the old frame. The feedback report's specimens and measurements (the five label surfaces, Working Notes as three things, the missing write-back, the station table, the missing kinds) are the richest material to pull in. Joseph's caution about it still applies: *"it's not as well informed as it seems at first glance."*
