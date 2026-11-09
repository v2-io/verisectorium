```kdl
term "actor" pos=noun pl="-s" {
  subtypes "mind" "instrument"
  avoid "user" "the estate's word for a person who is not modelled; an actor is modelled, and may be a person"
  avoid "session" "a harness unit that outlives compaction; an actor does not"
  avoid "actor version" "a compaction is not a new version of one actor but a new actor with a source"
  rel of term="kind" card="{1,1}" note="an actor kind: a model or instrument at a version, under a system prompt and initial context, as the harness attests"
  rel performs term="act" card="{0,N}"
  rel writes term="changeset" card="{0,N}" note="segment changesets"
  rel opens term="dimension" card="{0,N}" note="the orientations, and experience" informal=#true
  rel refers-to term="actor" card="{0,N}" note="its consortia: the other actors available to it"
}
status provisional
```

# «actor»
The attested identity that performs acts and writes changesets: a mind or an instrument, minted anew at every discontinuity, with a record of its own that a dimension's producer may read before counting its acts.

## Intro
Every «act» is by an actor and every «changeset» is written by one, and verisectoria are, in practice, very concerned with the realities of the minds that are constantly turning over. So the actor is in the model. Its identity is read from the harness and never typed. A new actor is minted at every discontinuity: a session starting, a subagent launching, and a **compaction**, which is not a change of version in one actor but one actor ending and a new one beginning with a *source*, a summary of varying fidelity that the new actor is trained to treat as its own memory. An actor has a record of its own, part attested, part earned, part computed, and a ‹mind› may be asked questions the way a piece is.

## Definition
An actor's record has two halves.

**The situation**, which is not the actor's property: the state of the store when it arrives (at a «checkpoint», or mid-changeset with a «frontier» to clear), and its **assignment**, an attestation by whoever dispatched it saying what it is for.

**The actor's own record:**

| part | what it is | how it is held |
|---|---|---|
| underlying model or instrument, at a version | the thing with propensities, early capabilities, and capabilities known to be emergeable by observation | attested, from the harness |
| system prompt and initial context | what gives it a sense of self and role | attested, from the harness (a hash is enough) |
| v2 orientation | proficiency with verisectoria and the engine generally | a warrant: earned by a ‹check›, bound to what it read, lapsing when the actor ends |
| domain orientation | for the project and its verisectoria | a warrant, likewise |
| segment orientation | for the pieces its job touches | a warrant, likewise |
| consortia | the other actors available to it for discussion and subtasks | references to other actors |
| experience | how much this actor has actually done: turns, acts recorded, orientations passed | computed |

**Standing** is a gate a «dimension»'s *produced by* declares over this record: "validity is produced by a re-derivation from a ‹mind› whose domain orientation is warranted and who is not the author of what it concerns." Yes or no, per dimension, read from the record rather than typed. The orientation rows are what make the gate readable; the model and prompt rows are what let a later reader ask "was this check by a mind that had been compacted since it read the premises?"

### Invariants
- An actor's identity is read from the harness, never typed, and is minted anew at every discontinuity. A compacted mind is a new actor; the summary it begins with is a source, cut and adjudicated like any other, not content it already holds.
- An actor's orientation is a warrant, read from checks that concern it and still bind; it is never attested by the actor itself. A mind that may have been compacted attests falsely without knowing it.
- Acts by an actor whose standing a dimension's producer does not grant are recorded and warrant nothing on that dimension.
- An actor's own record lives in the log like everything else: an orientation pass is an act (what it read at which versions, the criterion fixed first, the outcome), not a token held outside the store.

## Discussion
- **Why a compaction mints a new actor.** The premise, from vivarium's day: a compaction event is one agent finishing and a new, often somewhat confused and deceived agent starting with a summary of the last session of varying fidelity and applicability. The new actor's propensity to fabricate is higher than a cold agent's, because it is trained to assume the summary is complete enough. Binding orientation to anything that survives compaction (a session id, a clock) therefore binds it to the wrong thing; vivarium bound it to the compaction generation, which is where the actor boundary falls, and this def says the same by minting.
- **Why orientation is checked and not attested.** "There's a false sense of recognition and coherence that is simply fabricated, even with all of the actual precepts and signs pointing at it" (Joseph, 2026-07-31). Introspection returns a confident yes across a compaction gap. So the producer of an orientation dimension is a check the actor cannot pass by reading during the check, and the record of reading is the check, not the actor's word.
- **Why the record is in the store.** Vivarium kept its pass encrypted and local, for anti-gaming reasons and because it had no act log. With harness-read identity an act recorded under an attested actor cannot be quietly minted by another, so the record is strictly better than the refusal and the refusal can be computed from it. The project then *knows* a mind was brought to the point where it may act, and knows what it read.
- **Why the actor is a term.** The model could have kept the mind out of scope and read identity from the harness. Every producer clause depends on the actor's record, and the practical model's first job for every arriving mind is to orient it; pretending the mind is outside the model while the machinery leans on it at every step would be the costume the model exists to refuse.

## Examples
- The Opus 5.5 "independent adversarial checker" of 2026-10-30 on `scope-adaptive-system`: a ‹mind›, attested by role string in vsect 0.1 and by harness identity after 2026-11-02; its checks had standing on validity because the producer required not-the-author, and would have standing under this def only if its domain orientation were warranted.
- A simulator at a version: an ‹instrument›; its runs are checks; its version is what the simulation dimension is held against.
- Vivarium's gate: a 5/5 pass bound to the session's compaction generation, lapsing when it changed; the one post-compaction commit was refused. Under this def the pass is a check concerning the new actor, recorded.

## Working Notes
- From Joseph, 2026-11-09, the list this def's table is built from, and his question "===> standing?"; the answer taken here is that standing is a gate over the record, declared per dimension.
- Open. Whether the three orientations are three dimensions or one with an *against* that varies (the engine; the project; the pieces touched). Lean: one dimension, *oriented*, against a declared set of pieces, so that "what you will touch" is the same mechanism as "the canonical projection".
- Open (gap row). Steward attestation: a person acting in a session and an agent acting in it look alike to the harness, and a subagent inherited the lead's pass in vivarium. The actor boundary is right; the harness does not yet draw it everywhere it falls.
- Open. Whether the assignment (what the actor is for) is part of the actor's record or of the changeset it is dispatched into. Lean: the changeset's; an actor may be reassigned.
- Adjudicated against Joseph's 2026-11-09 turns; `msc/scratch/research-vivarium-heat-orientation-2026-11-09.md` §§4, 7, 8, 9; msc/notes 09 §3.5, 18 family G and finding 2.
