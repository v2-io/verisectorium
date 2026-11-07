---
term-group:
- atomic⸱changeset
- perturbation
- frontier
- accepted⸱remainder
status: provisional
terms:
  atomic⸱changeset:
    pos: noun
    pl: atomic⸱changesets
    avoid:
      episode: an earlier word for the same container
      commit: one way of holding one
      atom: atomic means all-or-nothing and has nothing to do with any small unit of content
    rels:
    - rel: from
      to: steady⸱state
      card: '{1,1}'
    - rel: to
      to: steady⸱state
      card: '{1,1}'
    - rel: opened-by
      to: perturbation
      card: '{1,1}'
    - rel: holds
      to: segment⸱changeset
      card: '{0,N}'
    - rel: holds
      to: act
      card: '{0,N}'
    - rel: leaves
      to: accepted⸱remainder
      card: '{0,1}'
  perturbation:
    pos: noun
    pl: -s
    synonyms:
    - motivating perturbation
  frontier:
    pos: noun
    pl: -s
    avoid:
      todo list: a frontier is computed, never typed
    rels:
    - rel: of
      to: working⸱state
      card: '{1,1}'
  accepted⸱remainder:
    pos: noun
    pl: accepted⸱remainders
---

## Intro

An «ATOMIC⸱CHANGESET» is everything, writes and acts together, that takes the «data⸱store» from one «steady⸱state» to the next. It opens with a «PERTURBATION», whatever first disturbs a steady store: a finding, a softened claim, a new result, a rule firing because a date passed. While it is assembled, the «FRONTIER» is everything still owed, computed afresh after each further write or act. It closes when the frontier is empty, or holds only an «ACCEPTED⸱REMAINDER»: what has been left on it by explicit, recorded decision, with its reason.

## Terms

### «atomic⸱changeset»

Everything, writes and acts together, that takes the store from one steady state to the next.

- Only a complete one moves the store to its next steady state. It is complete when, everywhere the perturbation reached, what is written is consistent and every «claimed⸱level» is either earned again or honestly lowered.
- It is usually more than one mind can assemble in one pass, so it is built in stages, and at every stage the frontier says what is still owed.
- An act that changes nothing written and leaves nothing owed, such as a confirming check, is an atomic changeset of size one.

### «perturbation»

Whatever first disturbs a steady store and so opens an atomic changeset.

- A finding that something is broken is itself a perturbation, before anyone has written a repair.
- Connecting an unconnected segment into the verisectorium, by a reference or by a place in a projection, is a perturbation of its own, and usually a large one.

### «frontier»

Everything still owed in a working state; what is known not yet to be consistent, computed afresh after each write or act.

- It holds references whose target has changed since they were last checked, veritoids whose claimed level is above what is now earned, acts that no longer bind where a value rested on them, and questions a rule has raised that a mind must answer.
- If it keeps growing instead of shrinking, work stops and the whole is looked at. The usual causes are two ideas treated as one, a genuine tension between two well-supported claims, or a foundation that has moved.

### «accepted⸱remainder»

What is left on the frontier at the close of an atomic changeset by explicit, recorded decision, with its reason.

- An unrecorded remainder is an incomplete changeset, not an accepted one.
- Each item on it is visible to anything that later rests on what it concerns.

## Discussion

- Changes near the roots of the dependency graph reach nearly everything and changes at its tips reach nearly nothing. Hence the incentive to make early material solid in proportion to its age and to how much stands on it.
- When a defect is found, softening is the natural first response. The methodology, not the model, then asks what it would take to keep the earlier claimed level; that is a second perturbation, often larger. Whether to complete the softening first or to stack the strengthening on it is a decision about where effort goes, made with the time available. The model allows both.
- Why the frontier is computed and not kept. A kept list goes stale and lies about its own currency. A computed frontier is only ever as wrong as the state it is computed from.

## Examples

- A root claim of AAT found to need an extra hypothesis. The finding is the perturbation; the rewrite of the claim, its derivation and its explanation, the re-derivation by a second mind, and the re-reading of every dependent are the atomic changeset; between those steps the frontier is what is owed; the next steady state is the first in which the claim has the hypothesis and every dependent agrees.
- This repository's outline: its provisional rows and gap rows are its accepted remainder, declared as such at each commit.

## Working Notes

- Open. Whether the frontier's four kinds of item are complete. The list is from working one example.
- Open. What an agent will do to make the frontier empty: affirmations and accepted remainders are both cheap exits, and any marker of "done" becomes a target.
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 11 def-changeset.
