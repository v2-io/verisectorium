```kdl
term "act" pos=noun pl="-s" {
  subtypes "check" "review" "finding" "decision" "crossing" "acceptance" "rule⸱firing" "outside⸱change"
  avoid "event" "an earlier model's events were each about one record only"
  rel by term="actor" card="{1,1}"
  rel against term="state" card="{1,1}"
  rel reads term="veritoid" card="{0,N}" note="each at a version; what the act binds to"
  rel reads term="value" card="{0,N}" note="a value it relied on, read at a level; also what the act binds to"
  rel concerns term="veritoid" card="{0,N}" note="what the act attests; a subset of what it reads"
  rel under term="criterion" card="{0,1}"
}
status provisional
```

# «act»
One recorded thing an attested actor did against a state, binding to exactly what it read and attesting only what it concerns.

## Definition

### Invariants
- It never changes what is written.
- It binds to exactly what it read, and lapses the moment any of that changes. That is usually content at a version, and sometimes a value it relied on ("at least re-derived"), which is what lets a review of a «projection» survive changes beneath it that it did not read.
- What it attests (a rung, a reconciliation) is attested only of what it concerns, and what it concerns is among what it read.
- A ‹check› has an outcome, and the outcome can be that something is broken. A ‹finding› says something is broken without a criterion fixed beforehand. Either goes on the record when it happens, before anyone has written a repair, and adds to the «frontier».
- Recording too little is as dishonest as claiming too much. A deliberate decision not to raise something is itself an act, with its reason.

## Working Notes

- Stub, from the kernel spikes. The term was promised by the outline and had no file; the spikes made two things about it precise.
- **`concerns ⊆ reads`** (Rust/Opus, pinned by `reading_as_context_does_not_attest`; Ada/Opus saw the same shape as finding 8). The act in `KERNEL-SPEC.md` had only `reads`, and raised the position of everything read. A re-derivation of `u` must read `u`'s premise `c`; recorded honestly, that would certify `c`, which nobody checked, so that file's own example recorded the check as reading only `u`. The cost is quiet: `c`'s change then does not lapse `u`'s check, and `u` keeps "rederived" on work done against a premise that no longer exists. Keeping reads (binding) apart from concerns (attestation) lets an act read its context honestly without certifying it. Lean: adopt, as the relation above. A consequence not yet run in any kernel: an honest check reads the premises it relied on, so it lapses when one of them changes, and an unchanged piece then needs a fresh check after its premise moves. Rust/Opus kept concerns = reads throughout the worked example, so its numbers do not show this. msc/notes 10 §1.11 said the same of fidelity checks on an affirmed piece.
- **Acts read only introduced ids** (Ada/Fable, needed to prove P3 exactly as written; Ada/Opus found the matching qualifier). Without it an act can *start* binding when a version it read appears later, which with counters is "a guess dressed as a check" (Rust/Opus, who allowed it and flagged it). Lean: adopt.
- **Multi-read acts lapse as a unit** (all four, as a consequence of binding). B's re-derivation of `(c@2, d@2)` stops counting for `c` when only `d` moves. Honest (an act is one judgement), but it pushes actors toward acts that read as little as possible (Ada/Opus finding 8). Whether an act should declare which reads it is about and which it merely relied on is the same question as `concerns`.
- **Acts are never refused** (Rust/Fable): an act whose reads are already stale when recorded simply does not bind; the log records what happened, whether it was useful is computed. Rust/Opus refuses an act that concerns something it did not read. Both consistent with the relations above if `concerns ⊆ reads` is checked at the seam.
- "Only writing ever adds an owed item; acts only remove" was tested (Rust/Opus) and in part proved (Ada/Opus, an affirmation moves no position) of a log holding only changesets and positive checks, which is all `KERNEL-SPEC.md` gave them. Position there is the greatest binding rung, so nothing could record a failure. It is not true of this model, where a ‹finding›, a ‹rule⸱firing› and an ‹outside⸱change› can each add something owed (msc/notes 09 §3.1, §4.2 at 08:30, §4.3; 11 def-act and `act_type`). The four kernels agreeing here is one spec's omission four times, not independent evidence.
- Open. Whether a broken ‹check› and a ‹finding› are one subtype or two. Lean: two, since a ‹finding› may have had no criterion fixed in advance and so carries no weight as a check. vsect 0.1 has only the first (`--outcome broken`), and that is how the stopped-bound error was recorded (`~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md`).
- Open. Whether a refuted premise, a premise dropped in level and a narrowed premise («premise⸱change») need different records or only different computation.
- The subtypes above are the sorts of act the model has named so far, restored from msc/notes 09 and 11; «affirmation» has its own working notes because the spikes found it under-defined.
