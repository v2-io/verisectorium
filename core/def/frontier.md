```kdl
term "frontier" pos=noun pl="-s" {
  avoid "todo list" "a frontier is computed, never typed"
  rel of term="working⸱state" card="{1,1}"
}
status provisional
```

# «frontier»
Everything still owed in a working state; what is known not yet to be consistent, computed afresh after each write or act.

## Intro

An «atomic⸱changeset» is everything, writes and acts together, that takes the «data⸱store» from one «steady⸱state» to the next. It opens with a «perturbation», whatever first disturbs a steady store: a finding, a softened claim, a new result, a rule firing because a date passed. While it is assembled, the «frontier» is everything still owed, computed afresh after each further write or act. It closes when the frontier is empty, or holds only an «accepted⸱remainder»: what has been left on it by explicit, recorded decision, with its reason.

## Definition

### Invariants
- It holds references whose target has changed since they were last checked, veritoids whose claimed level is above what is now earned, what a ‹finding› or a broken ‹check› has said is broken, acts that no longer bind where a value rested on them, and questions a rule has raised that a mind must answer.
- If it keeps growing instead of shrinking, work stops and the whole is looked at. The usual causes are two ideas treated as one, a genuine tension between two well-supported claims, or a foundation that has moved.

## Discussion

- Changes near the roots of the dependency graph reach nearly everything and changes at its tips reach nearly nothing. Hence the incentive to make early material solid in proportion to its age and to how much stands on it.
- When a defect is found, softening is the natural first response. The methodology, not the model, then asks what it would take to keep the earlier claimed level; that is a second perturbation, often larger. Whether to complete the softening first or to stack the strengthening on it is a decision about where effort goes, made with the time available. The model allows both.
- Why the frontier is computed and not kept. A kept list goes stale and lies about its own currency. A computed frontier is only ever as wrong as the state it is computed from.

## Examples

- A root claim of AAT found to need an extra hypothesis. The finding is the perturbation; the rewrite of the claim, its derivation and its explanation, the re-derivation by a second mind, and the re-reading of every dependent are the atomic changeset; between those steps the frontier is what is owed; the next steady state is the first in which the claim has the hypothesis and every dependent agrees.

## Working Notes

- Intro, discussion and examples shared verbatim with former group-mates (atomic⸱changeset, perturbation, accepted⸱remainder); to be rewritten for this term alone when adjudicated.
- From the kernel spikes (`msc/scratch/kernel-spikes/COMPARISON.md` §4). Four independent kernels computed the frontier from the definitions and all four found the worked example in `KERNEL-SPEC.md` under-counted it (three owed items missing, all of the same kind: the fall of a root reaching what rests on it). Three further facts, each tested or proved in at least one kernel, and each true of those kernels' log of changesets and positive checks: (i) only a write adds an owed item, which does not carry over to this model (see «act»); (ii) the kinds of item the kernels needed were three, `overclaim(v)`, `stale-reference(v, r)`, `unmet-need(v, r)`; a lapsed act is not an item of its own, it shows only through the overclaim it causes, and Rust/Fable reads that narrowing as right, since a lapsed act nothing rested on is not owed; (iii) **"steady means honest" has no content beyond the frontier's definition** (Ada/Fable); the fact worth asking for, and proved there, is that the computed frontier list is exactly the set the predicates define.
- Open, from the spikes. **One cause, many items.** One changed root produced nine or ten owed items with one cause (Ada/Opus, Rust/Fable). The kernel should keep the raw set, since that is what a stranger can recompute; grouping by cause is porcelain, and the model may want a word for "owed because of" so the porcelain has something to compute.
- Open. Whether the kinds of item above are complete. The four kernels needed three, but their log had no ‹finding›, no rule and no narrowing. msc/notes 11's `owed_reason` also has the question a narrowed premise puts to each dependent.
- Open. What an agent will do to make the frontier empty: affirmations and accepted remainders are both cheap exits, and any marker of "done" becomes a target.
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 11 def-changeset.
