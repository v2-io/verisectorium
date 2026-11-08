```kdl
term "accepted⸱remainder" pos=noun pl="accepted⸱remainders"
status provisional
```

# «accepted⸱remainder»
What is left on the frontier at the close of an atomic changeset by explicit, recorded decision, with its reason.

## Intro

An «atomic⸱changeset» is everything, writes and acts together, that takes the «data⸱store» from one «steady⸱state» to the next. It opens with a «perturbation», whatever first disturbs a steady store: a finding, a softened claim, a new result, a rule firing because a date passed. While it is assembled, the «frontier» is everything still owed, computed afresh after each further write or act. It closes when the frontier is empty, or holds only an «accepted⸱remainder»: what has been left on it by explicit, recorded decision, with its reason.

## Definition

### Invariants
- An unrecorded remainder is an incomplete changeset, not an accepted one.
- Each item on it is visible to anything that later rests on what it concerns.

## Discussion

- Changes near the roots of the dependency graph reach nearly everything and changes at its tips reach nearly nothing. Hence the incentive to make early material solid in proportion to its age and to how much stands on it.
- When a defect is found, softening is the natural first response. The methodology, not the model, then asks what it would take to keep the earlier claimed level; that is a second perturbation, often larger. Whether to complete the softening first or to stack the strengthening on it is a decision about where effort goes, made with the time available. The model allows both.
- Why the frontier is computed and not kept. A kept list goes stale and lies about its own currency. A computed frontier is only ever as wrong as the state it is computed from.

## Examples

- A root claim of AAT found to need an extra hypothesis. The finding is the perturbation; the rewrite of the claim, its derivation and its explanation, the re-derivation by a second mind, and the re-reading of every dependent are the atomic changeset; between those steps the frontier is what is owed; the next steady state is the first in which the claim has the hypothesis and every dependent agrees.

## Working Notes

- Intro, discussion and examples shared verbatim with former group-mates (atomic⸱changeset, perturbation, frontier); to be rewritten for this term alone when adjudicated.
- Open. Whether the frontier's four kinds of item are complete. The list is from working one example.
- Open. What an agent will do to make the frontier empty: affirmations and accepted remainders are both cheap exits, and any marker of "done" becomes a target.
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 11 def-changeset.
