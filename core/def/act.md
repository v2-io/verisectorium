```kdl
term "act" pos=noun pl="-s" {
  subtypes "check" "decision" "crossing"
  avoid "event" "an earlier model's events were each about one record only"
  rel by term="actor" card="{1,1}"
  rel against term="state" card="{1,1}"
  rel reads term="veritoid" card="{0,N}" note="each at a version; what the act binds to"
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
- It binds to exactly what it read, each at its version, and lapses the moment any of that changes.
- What it attests (a rung, a reconciliation) is attested only of what it concerns, and what it concerns is among what it read.
- Recording too little is as dishonest as claiming too much. A deliberate decision not to raise something is itself an act, with its reason.

## Working Notes

- Stub, from the kernel spikes. The term was promised by the outline and had no file; the spikes made two things about it precise.
- **`concerns ⊆ reads`** (Rust/Opus, pinned by `reading_as_context_does_not_attest`; Ada/Opus saw the same shape as finding 8). The spec's act had only `reads`, and raised the position of everything read. A re-derivation of `u` must read `u`'s premise `c`; recorded honestly, that would certify `c`, which nobody checked, so the spec's own example recorded the check as reading only `u`. The cost is quiet: `c`'s change then does not lapse `u`'s check, and `u` keeps "rederived" on work done against a premise that no longer exists. Keeping reads (binding) apart from concerns (attestation) lets an act read its context honestly without certifying it. Lean: adopt, as the relation above.
- **Acts read only introduced ids** (Ada/Fable, needed to prove P3 exactly as written; Ada/Opus found the matching qualifier). Without it an act can *start* binding when a version it read appears later, which with counters is "a guess dressed as a check" (Rust/Opus, who allowed it and flagged it). Lean: adopt.
- **Multi-read acts lapse as a unit** (all four, as a consequence of binding). B's re-derivation of `(c@2, d@2)` stops counting for `c` when only `d` moves. Honest (an act is one judgement), but it pushes actors toward acts that read as little as possible (Ada/Opus finding 8). Whether an act should declare which reads it is about and which it merely relied on is the same question as `concerns`.
- **Acts are never refused** (Rust/Fable): an act whose reads are already stale when recorded simply does not bind; the log records what happened, whether it was useful is computed. Rust/Opus refuses an act that concerns something it did not read. Both consistent with the relations above if `concerns ⊆ reads` is checked at the seam.
- Only writing ever adds an owed item; acts only remove them (Rust/Opus, tested as a strengthening of P4; Ada/Opus proved an affirmation moves no position). Worth stating as an invariant of «frontier».
- The subtypes above are the sorts of act the model has named so far; «affirmation» has its own working notes because the spikes found it under-defined.
