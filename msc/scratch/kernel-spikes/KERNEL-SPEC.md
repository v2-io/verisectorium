# The v2 kernel, as a spike target

*One spec, shared by four spikes: the same kernel written in Rust and in Ada 2022 + SPARK, each by two different minds (Opus 5.5 and Fable 5.1). Written 2026-11-07 by the Fable session working with Joseph in `~/src/verisectorium/`. The question the four spikes answer is not "which language is better"; it is "under total turnover, which language lets minds like ours build and keep correct the thing this model says an engine must be".*

*Everything below is stated at the tier it holds. The model itself is provisional (`core/model.outline.md`; the only decided term is «verisectorium»). The kernel described here is the smallest piece of that model that has a precise meaning today. Where this spec and the model disagree, the model is being corrected by your finding, so say so.*

## 1. What the kernel is for

A verisectorium's engine holds a data store whose every answer about a piece of content is **computed from recorded acts, never typed**. The one status a stranger can trust is one they can recompute. So the kernel is: an append-only log of what happened, a way to compute the store's state as of any point in it, and a way to compute what is still owed (the frontier) in that state. Nothing else. Parsing, rendering, CLI ergonomics and storage are porcelain and are out of scope except as needed to exercise the kernel.

## 2. The objects (the smallest honest model)

- A **veritoid** is one piece of content with: an id; a **segment** id (the whole it belongs to); a **content version** (an opaque hash or counter; changes when the content changes); a **claimed level**, a rung on the one ladder below; and a list of **references**, each `(target veritoid id, needed rung, target version seen)` meaning "this piece is predicated on that one, needs it at least at that rung, and was last reconciled against that version of it".
- One **dimension** with one **ladder** of rungs, ordered: `sketch < drafted < checked < rederived`. (The real model has many dimensions; one suffices to exercise everything below.)
- An **act**: `(actor, criterion, kind, reads, rung)` where `reads` is a set of `(veritoid id, content version)` the act read, `kind` is `check` or `affirmation`, and `rung` is the rung the act attests for the veritoid(s) it concerns. An act **binds** exactly while every `(id, version)` it read is still the current version of that veritoid. An affirmation is an act by a segment's author saying an unchanged veritoid is still right against changed siblings; it never counts toward a rung.
- A **segment changeset**: a new written state for one segment: the full set of veritoids it now holds, with their content versions, claimed levels and references. It replaces the old set at one logical instant. It may add, remove, split or merge veritoids within the segment.
- The **log** is the ordered sequence of records; each record is either a segment changeset or an act. Append-only.
- A **state** is the result of folding the log up to a point: the current veritoids (by id) and the acts recorded so far.

## 3. What is computed (these are the contracts)

For a state:

1. **binds(act)**: every `(id, version)` in `act.reads` has `version == current version of id` (and the id still exists).
2. **position(v)**: the greatest rung among `check` acts that bind and whose reads include `v`; `sketch` if none.
3. **ceiling(v)**: `min(position(v), min over references r of v of ceiling(r.target))`; the reference graph among veritoids is acyclic, so this is well-founded. (A piece can be no better supported than what it rests on: the latent level.)
4. **frontier(state)**: the set of owed items, each one of:
   - `overclaim(v)`: `claimed level of v > ceiling(v)`;
   - `stale-reference(v, r)`: `r.target version seen != current version of r.target`, or the target no longer exists;
   - `unmet-need(v, r)`: `ceiling(r.target) < r.needed rung`.
5. **steady(state)** iff `frontier(state)` is empty.

## 4. Properties the kernel must have (prove in SPARK where you can; test in Rust; say which)

- **P1 Determinism.** The state is a function of the log prefix. Folding the same records in the same order twice gives equal states; `position`, `ceiling`, `frontier` are functions of the state.
- **P2 Append-only.** No operation removes or alters a recorded record. The only way a value changes is a new record.
- **P3 Lapse is exact.** A segment changeset causes an act to stop binding iff the act read a `(id, version)` the changeset changed or removed. Acts that read nothing in that segment are unaffected.
- **P4 Monotone under acts.** Appending a `check` act never lowers `position` of any veritoid; it raises at most the positions of veritoids it reads.
- **P5 Acyclicity.** A segment changeset that would create a cycle in the reference graph is refused (and the refusal is itself recorded, or at least reported; say which you chose and why).
- **P6 Ceiling bound.** For every `v` and every reference `r` of `v`: `ceiling(v) <= ceiling(r.target)` and `ceiling(v) <= position(v)`.
- **P7 Steady means honest.** In a steady state, no veritoid's claimed level exceeds its ceiling.
- **P8 Replay.** Writing the log to a file and folding it back yields the same state (whatever serialization you choose).

## 5. What to deliver

In your spike directory only:

- the kernel as a library, with the operations: append record; state as of index; `position`, `ceiling`, `frontier`, `steady`; a serialization of the log; and a small CLI (or test harness) that loads a log, prints the state and the frontier, and exercises the worked example below;
- tests, and for Ada the SPARK contracts with the `gnatprove` level reached; be exact about what was proven, what was tested, and what was neither;
- **`account.md`**: the account we actually want. What the language made easy; where you fought the tool; what you could not express or prove and why; what you'd want in the model that this spec lacks; how much of the time went to the language versus the kernel. Felt time is fine marked as such; `git log` carries measured time;
- **`debrief.md`** for Joseph, as the spike template describes.

Commit to your worktree branch at every clean checkpoint (the base commit already builds, tests and proves a hello-world in your language, so your first commit can be the kernel's first real contract).

## 6. The worked example (use it as a test)

Steady state S0. Segment T holds claim `c` (claimed `rederived`, references none), derivation `d` (claimed `rederived`, references `c` needed `drafted`) and description `e` (claimed `drafted`, references `c` needed `drafted`). Segment U holds claim `u` (claimed `rederived`, references `c` needed `rederived`). Agent B has recorded a `check` at `rederived` reading `c@1` and `d@1`; A has recorded checks at `drafted` on `e@1`, and B at `rederived` on `u@1`. Frontier empty.

Then: an auditor finds `c` needs an extra hypothesis. A submits a segment changeset on T: `c@2`, `d@2`, `e@1` affirmed. Expected after it: B's check no longer binds; `position(c) = sketch`; `ceiling(d) = ceiling(e) = sketch`; frontier holds `overclaim(c)`, `overclaim(d)`, `stale-reference(d, c)`, `stale-reference(e, c)`, `stale-reference(u, c)`, `overclaim(u)`, `unmet-need(u, c)`. Then B re-derives `c@2, d@2` at `rederived`; A fixes step 3 (`d@3`); B re-derives again; C changes U (`u@2` referencing `c@2`); B re-derives `u@2`. Expected: frontier empty, S1. The log still holds B's first re-derivation of `d@2`, binding to nothing.

## 7. What we are not asking

Not performance. Not a storage decision (a JSON lines file is fine). Not the real multi-dimension model, segment kinds, projections, intake or the inbox. Not porcelain. If the spec is wrong somewhere, the right landing is "the spec as posed is ill-formed here; here is the well-formed version and what I built against it".
