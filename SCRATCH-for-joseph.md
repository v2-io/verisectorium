# Scratch for Joseph: founding ASF on v2, and the four segments to re-cut

> [!note] Folded into `~/src/aat-v3/preparations/PLAN.md` (2026-11-04), which is now where the plan lives. This file stays as the record of how it was reached.

*councils-46, 2026-11-04. Revised the same day around your five-step plan, which settled the decision this file was first written to inform. Your two constraints:*

> *as from a compiler perspective — we don't have a bespoke manual implementation yet that can allow us to start bootstrapping and it would be unwise of us to lean into a recursively bootstrapped one from the beginning... Whats more, something later that takes the directory/file/convention layout and converts it into the real v2 store etc. will need to be developed for a bunch of other existing verisectoria as well*

*and your aim: "do it right from the beginning in parallel with a direct concrete implementation — implemented on the very material that was our very first verisectorium ever."*

*Uncommitted on purpose. This repo is public.*

---

## 1. The plan

Your five steps, paraphrased. Your message has them verbatim.

1. **verisectorium holds the template and the seed records:** the records common to every instance (sop, influx, def, the theory segments) under one `TEMPLATE.outline.md`. They're maintained the old way, by editing and verifying. `v2` is not run on verisectorium at this stage.
2. **`v2` starts with `v2 init` and `v2 reinit`.** Init writes a system-definition file from the template if there isn't one, sets up the store, and seeds it from verisectorium's template. verisectorium's files (`def/v2-atom` and the like) become logical records in the target store (`def:v2:atom`).
3. **`v2 init` on aat-v3.** At first only the verisectorium core arrives: general influx, sop, def, the canonical view. v2 is iterated, and `v2 reinit` reapplies its changes.
4. **ASF's own system-design files, written by hand in aat-v3,** read by v2. Working out how the backing store migrates as they change is this phase's real question.
5. **Populate from influx.** Sources become chunks, which are adjudicated one by one. Each iteration may change v2, the backing store (sometimes blown away and migrated by hand) and ASF's definitions. Eventually v2 projects into aat-v3: renderings, reports, dashboards, often as curated collections of atoms. Whether the backing store also lives in the repo is decided by whether that keeps things like atomic changesets simple.

### How this answers the compiler concern

| Stage | The definition is… | What changes it |
|---|---|---|
| **0, now** | two hand-written layers: the general layer (verisectorium's template and seeds, applied by `v2 init`/`reinit`) and the store's layer (ASF's YAML in aat-v3) | people and agents editing, with review, like code |
| **1, later** | the same files, which v2 also *checks*: every kind answers the founding questions, every transition names the dimension it moves, the substitution law holds | the same, but v2 refuses an incoherent definition |
| **2, much later** | records in a store, admitted through v2's own transitions; at this point v2 can also run on verisectorium itself | v2's own `admit` / `amend` / `retire` |

**"Only through vsect" holds for atoms from stage 0 on.** v2 is the only writer of records. Only the definition files are edited by hand, and they aren't atoms. The kernel drafts' "the definition is records" is stage 2, deferred until v2 has earned it on real material.

**The two layers are the right shape.** The prior template already anticipated them: its SOP outline marks each record `template` (owned upstream) or `override` (owned locally), and the realization model has an *upgrade channel* through which template changes reach an instance for local adoption. `v2 reinit` is that channel made concrete. Template changes arrive, and local overrides survive, each kept or replaced by a recorded choice.

The stage-0 definition files are also RC1 09's declarative language in its first concrete form, written for one store and checked by running.

## 2. Three refinements to the plan

**1. What survives a blow-away: the event log, replayed.** If early iterations sometimes delete the backing store, the durable thing should be the log, not the store's current state:
- the sources brought in;
- the chunks cut from them;
- every crossing and adjudication, with who, against what criterion, and the outcome.

A new store version *replays* that log under the new definition, with a migration step wherever the schema changed. Your adjudications are then never redone because v2 changed shape. Hand migrations during stage 0 are fine, but each one is recorded as a migration, so the trail says where it was carried by hand. That's RC1 08's fidelity: absence of a record must keep meaning "not done".

**2. Store in the repo or outside it: decide with the first real changeset in hand.**
- **Inside the repo** (`.v2/`, as vsect 0.1 did): a changeset can be a branch and a commit. That's atomic and reviewable for free, but git's grain shapes the store.
- **Outside, by the OS convention** (as relata does, and as you decided for the store): changesets need their own transaction log, and the repo carries only renderings.

Decide it with SPECIMEN #3 in hand: one root edit, worked whole as an episode. That is RC1's fork 6 and your atomic changeset in practice.

**3. ASF's first declarations, chosen by demand.** The first ASF-specific declarations should be exactly what the first sources need in order to be chunked and crossed, and nothing more. Line B's five root segments give a concrete first slice whose demands are already known:
- statement grain: one definition paragraph held six commitments that fail separately;
- exact claims hidden in Epistemic Status;
- premises that run between definitions.

**On the legacy-layout converter.** Under your step 5, ASF enters as influx sources, so the converter is a *source-intake mode* of v2, not a separate path. Each legacy store needs a **dialect declaration**: data saying what its files, frontmatter, tags and sections meant. ASF's `status:`, for instance, is a hand-set word, so it arrives as testimony at the lowest rung, never as standing. The intake turns each file into a source and its parts into proposed chunks. Crossing stays a judgment. It records from its first act whether each source has been read, by whom, and how far each chunk has got, which is what the sprint's influx maps lacked. Built for ASF first, it's the first instance of what vivarium, relata, comproprium, terminology, the udon reference defs, AISI and limen will each need.

## 3. ASF as the first material: what the founding questions would plausibly yield

Your caution applies here too. The founding questions (RC1 10: standing, speech-act, failure, instrument, dimensions, movers, ceiling, grain and edges, certification) are used as a design method on paper, not run as transitions. Below is what they suggest from ASF as it is. It's a guide to argue with, not a result.

**A specimen that makes it concrete:** `01-aat-core/src/def-agent-environment.md`. Its body holds two tagged definitions, an introductory gloss, an Epistemic Status, and a Discussion. Its Working Notes then hold, under one heading, material with six different fates:

| Working Notes subsection | What it actually is | Where it goes in a v2 store |
|---|---|---|
| "Candidate Brief prose" | proposed teaching | a teaching atom (Comprehension), or a pedagogy store |
| "Candidate Discussion" | proposed body text | a proposal against the definition, crossing into its body or not |
| "Follow-up items" (boundary integrity, computational opacity) | open questions and candidate scope findings | questions with closers; one is already "answered 2026-10-30" in prose, which should have been a closing event |
| "Readers often ask / wonder" | reader confusions from audits | Comprehension events on the definition (RC1's movers for that dimension) |
| "Candidate figures" | pedagogy proposals | a pedagogy store |
| "Belongs elsewhere" (to 04-eli-core, 03-llm-core) | material for other volumes or stores | efflux, routed to its home |
| "Candidate scope question … boundary integrity" (2026-08-12) | an agent-proposed scope question with a conjecture | a question, plus a conjecture marked as one |

That one file shows why record grain matters, why "Working Notes" was an overloaded queue, and why the dimensions are the right frame. Every subsection is moved by a different mover.

**Kinds the questions point to for ASF**, each with its main dimensions in RC1's terms:
- **Statement**, at statement grain: definition, scope, postulate, choice (formulation), claim (with stage as a position on its evidence line, not a kind), no-go, norm, recognition. Evidence lines (`evidence/derivation`, `evidence/in-vivo` for simulations, `evidence/instance`, `evidence/carriage` for imported theorems), Freshness, and, for definitions and choices, Backing.
- **Derivation**, a companion that `proves` a claim. Its own derivation line, and it lapses with the claim's text.
- **Claim record**, describing a claim: register, population, falsifier. Line A showed it fails on its own schedule.
- **Teaching:** chapter intros, Discussion paragraphs that span claims, impl-* segments, front-door headlines. Comprehension, plus Freshness against what it narrates.
- **Arrangement:** the outline, and which statements a segment holds in what order. View-ify, with no warrant of its own.
- **Term and notation.** A coinage (Backing) plus fit-to-usage (Evidence), per RC1 03.
- **Finding, question, decision, review, run, source, unit.** The process kinds, with RC1 07 for the questions and 04 for decisions.
- **Purpose:** the working thesis, revised by the steward only.

Some of this is open and is exactly where ASF should push the model: whether `disc-*` segments are teaching or recognitions, whether claim records are one per statement or one per claim inside it, and where Epistemic Status prose goes. Epistemic Status is a projection in RC1's terms, so the prose either becomes the declared form ("exact under named premises") or is dropped.

## 4. The decision this file was written for, now settled

Question 1 was whether ASF's definition should be derived from ASF's own material or fitted to the theory canon's estate-shaped structure. Your plan answers it with what this file called option C: **co-evolve, anchored both ways.** One rule, applied in both directions, makes that concrete, and it's the guard against the over-abstraction that frustrated you with RC1 before:
- **No ASF kind without a named specimen** from ASF's material and a founding-question justification.
- **No change to RC1 or the canon without an ASF specimen that demanded it,** or a mark saying the change is unexercised.

The canon's estate-shaped choices (§5) are then inherited only where ASF exercise confirms them.

## 5. Re-cutting the four layout-bound segments

The general move is the same in all four: **keep the principle, demote the layout to one rendering or convention among many, and move the convention into the importer's dialect declaration** so old stores still read correctly.

**`def-verisectorium` (the nine organs).**
- **The principle:** a living collection under total turnover needs answers to nine concerns. Corpus, vocabulary, epistemic state, adjudication, flux, views, the agent interface, the steward interface, and norms and self-governance.
- **The layout:** "organs" as components an instance *has*, which in practice became directories and template stores.
- **Re-cut:** a verisectorium is a store whose definition answers each concern. The organs become the founding questionnaire's sections and a maturity checklist, not anatomy. Several turn into kinds or transitions:
  - flux into source, unit and the membrane outcomes;
  - adjudication into movers;
  - norms into SOP records with their own influx.

  The "process layer" becomes the definition's transitions. The definition sentence changes from "the nine-organ structure" to something like "a living collection whose records carry their own adjudicated state, under a declared definition of kinds, dimensions and movers, crossed only through membranes".

**`def-atom` (slug = identity).**
- **The principle:** one unit per fate. Identity never carried by position or number.
- **The layout:** identity *is* the filename slug.
- **Re-cut:** use RC1 11. Identity is a maintained binding (`@{binding}`, kept by the store, with `@{dangle}` and `@{collide}` surfacing as failures). The record is a referent. A file, a directory or an element inside a file is only its manifestation. Names have a history, and renames are events with aliases. Sub-record grain is inner locations. "One atom, one fate" stays exactly as it is.

**`form-slug-form-kinds` (filename prefixes carry form-kind).**
- **The principle:** nothing mutable participates in identity. An evidential position moving (hypothesis → derived) must never force a rename.
- **The layout:** the `def-`/`claim-`/`form-` prefix in filenames.
- **Re-cut:** the kind is a declared field of the record. A prefix becomes one rendering convention for names, chosen per store. The principle becomes a naming rule on the name binding: a name may carry the form-kind, never the trajectory. ASF's old trajectory prefixes (`der-`, `deriv-`, `result-`, `hyp-`) map to kinds and stages in the importer's dialect, and the old-slug → fate mapping is a projection over the rename events.

**`form-process-map` (a hand-maintained map of processes over organs).**
- **The principle:** every process needs a trigger, a drain, health signals, and an honest mark for designed-but-absent.
- **The layout:** a notation document maintained by hand alongside the work.
- **Re-cut:** the processes *are* the definition's transitions and their queues. The map becomes a generated view over the definition and the trail:
  - queues and what's waiting, from the trail;
  - stalls and drains, from acts actually performed;
  - designed-versus-absent, from comparing the catalog against the trail.

  The flow analysis from this week (`asf-flows.md`: yields, the three steady-state conditions) fits here as an analysis over the same trail, not as part of the definition.

## 6. Concrete next steps, in your plan's order

1. **Promote from `.archive/prior-incarnation/` into verisectorium's template and seed records** (your step 1). This is what `~/src/aat-v3/preparations/verisectorium-review/recommendation.md` lists:
   - RC1 whole;
   - the Aug-14 model's uncarried parts;
   - the 19 principle segments;
   - the four layout-bound segments, re-cut as in §5;
   - the realization model;
   - ORIENT;
   - the template's two enums.

   Then write the `TEMPLATE.outline.md` over them.
2. **`v2 init` and `v2 reinit`** (your step 2), with the smallest system-definition format that can express the template's core: kinds with their dimensions, transitions as movers, source and chunk with crossing outcomes. The event log is primary from the first version, so refinement 1 holds from day one.
3. **`v2 init` on aat-v3** (your step 3). Then the dialect declaration for ASF on paper, covering only the five roots.
4. **ASF's first hand-written declarations** (your step 4): only what the five roots demand. Every place v2 can't yet do what's needed is recorded as a demand, per your rule.
5. **Bring the five roots in as sources, chunk them and cross them** (your step 5). From that slice:
   - SPECIMEN #3 (one root edit as an episode), which settles refinement 2;
   - RC1 08's auditor walk: a fresh mind, given only the slice's records and their states, asked "what should be audited?"

   Then a second slice, chosen by what the first one strained.

*Read `theory/influx/verisect-and-ldocs.md` §7 before step 2. It's the live_docs design for session-scoped trails, with per-record history as a projection, which bears on both refinements 1 and 2. I haven't read it yet.*

## 7. The working model from the conversation that followed

*Worked out in dialog with Joseph after §1–6, 2026-11-04. None of it is in RC1 or the theory canon as stated here. Each piece is marked as what it is.*

**Adjudication moves one of three things** (proposed). Every record has:
- its **content**;
- what it **claims**: its declared form, register and scope;
- what its trail has **established**: its computed standing on each dimension.

Adjudication starts from a mismatch between claimed and established. It repairs in one of three ways:
- **secure**, which raises what is established;
- **revise the content** so it can earn the claim, which resets the standing the edit invalidates;
- **lower the claim**, last, by replacement.

**Decisions come in four kinds,** separated by what they are about (proposed):

| Kind | About | Recorded as |
|---|---|---|
| domain | the subject itself | a record, with `decision/*` ladders |
| interior | one record's state (a confirmation, a crossing to a sink, a declined lift) | an event on that record, bound to a version |
| work | where effort goes | a routing fact, with a target and usually an expiry |
| system | how the store works | an edit to the definition at stage 0; an admission later |

The test, asked of a decision's outcome: if it went the other way, would what ASF *asserts* change (domain); only a record's state (interior); only what's worked on next (work); or how the store works (system)?

**Aspects, attributes and graduation** (proposed, Joseph's sort):
- **Aspects are values whose basis is one of three, or a mix:**
  - **evidenced:** a truth claim with accumulated evidence (certainty);
  - **decided:** at a branch point, by accountable parties;
  - **attested:** asserted, checkable, deliberately not carried with a trail. This is the recursion's floor, RC1 08's trusted base.

  Importance is an aspect whose basis is computed reach plus decided stakes. It is always *for* a target.
- **Attributes are deterministic measurements,** with no warrant of their own beyond a declared formula and the moment of computing. They come from content (word count), from the trail (age, recency, change heat) and from the graph (coupling, reach). An attribute never goes stale. Only aspects that use it lapse.
- **A rule turns attributes into an aspect's bands.** For example: relative freshness = recency ÷ …, thresholded. When a band is crossed, that is a deterministic event recording the rule and its version: `{from: "darn fresh", to: "lil'bit stale", by: <rule@version>}`. It ripples through `caused-by` into every aspect whose basis names it. This is where the "mechanical stations" belong.
- **Graduation is the same ladder for every aspect:**
  0. a label;
  1. ruled, under a declared rubric;
  2. procedural, with runs as events bound to a basis, lapsing when the basis changes;
  3. reified, as a record of its own kind, with content, its subject as prerequisite, and aspects of its own.

  An aspect graduates only on demand, when its failures need their own repair. Hardness belongs to each value, not to each aspect type.

**Stability and runaway ripple** (proposed):
- **A stable store is at a fixed point:** no rule would fire, and nothing demands work, as far as we know.
- **A perturbation opens an episode on a branch.** Its scope starts at the perturbation's reach and grows as ripples land.
- **Inside the episode,** rule-driven changes settle, and the rest queues for minds and councils. Discoveries outside the scope go to the general influx, carrying a condition ("applies only if this changeset commits").
- **A breaker counts generations per kind of finding.** When they stop shrinking it halts everything and routes the case to a council. Its outcomes:
  - continue, with a higher limit;
  - split the changeset;
  - reframe a conflation;
  - record a tension;
  - or, for a definition proven wrong, open a system-level episode.
- **Episodes whose scopes overlap** are merged, or one waits.

**A working assumption, not an invariant: the monotone rule.**
- **The assumption:** rule-driven changes may only lower, reset or flag. Only recorded acts by minds raise a value. Under it, the automated layer always reaches a fixed point, because every ladder is finite and every rule-driven move goes one way. Runaway is then confined to the judgment loop, where the breaker watches.
- **Why it is only an assumption** (Joseph): some deterministic quantities are in principled tension. Coupling and cohesion, measured analytically, trade against each other, and finding their balance is a search for an equilibrium. It would be silly for a mind or a council to adjudicate each half of an oscillation as the search discovers it.
- **What would replace it if it fails:** a deterministic procedure that seeks an equilibrium and runs to its own convergence criterion inside the episode, recorded as one act with its iterations as detail, the way an optimizer's run is one result.
- **Revisit when** the first non-monotone rule is actually wanted on real material. Not before; and not by promoting the assumption to a constraint in the meantime.
