```kdl
term "affirmation" pos=noun pl="-s" {
  rel is-a term="act" card="{1,1}"
  rel carried-in term="segment·changeset" card="{1,1}"
  rel concerns term="veritoid" card="{1,N}" note="the veritoids left unchanged that the author re-read against what did change"
}
status provisional
```

# «affirmation»
The author's recorded statement, inside a segment changeset, that a veritoid left unchanged is still right against what did change; it never raises a rung.

## Definition

### Invariants
- It never counts toward any rung. It is not an independent check.
- Its job is only that nothing is left as it was without someone having looked.
- A changeset that carries a veritoid unchanged, when an «inner·dependency» of it changed, must carry an affirmation of it; otherwise the segment state is a draft, not a changeset.
- Like any act it binds to what the author read, and lapses when that changes.

## Working Notes

- From the kernel spikes (`COMPARISON.md` §4 item 2, §5). All four kernels found that in `KERNEL-SPEC.md` an affirmation computes nothing, so that file's worked example cannot reach its last steady state: `e`, never rewritten, keeps a stale reference to `c`. The cause is in that file's encoding. `e` and `c` are in one segment, and it wrote `e`'s dependence on `c` as a «reference» with a version seen. In this model that dependence is an «inner·dependency», declared once for the kind and carrying no version seen (msc/notes 09 §2.3 and §4.1, 11 def-segment), and references reaching out of a segment are not the changeset's to reconcile (09 §4.1). Ada/Fable named what remains in the model's own terms: a kernel that cannot tell a draft from a changeset.
- The repairs the kernels offered: (a) the affirmation reconciles the affirmed piece's references to what the author read, never raising a rung, lapsing like any act (Rust/Opus; Ada/Opus made it the *required* way to rewrite references without a content change); (b) a reference can be reconciled without a version bump and the affirmation does nothing (Rust/Fable, who built it and recommends against it, because an author could then re-point a derivation without lapsing its check); (c) the version covers references, so a reconciliation is a new version and needs a new check (Rust/Fable's recommendation); (d) a rule that a carried piece must be affirmed (Ada/Fable's reading of the gap). The definition above takes (d), stated on the changeset. It does not take (a), whose job goes away once the dependence is not a reference. This is a lean, for Joseph to adjudicate; it comes from reading the notes and has not been run in a kernel.
- What (a), (b) and (c) were really answering is how a cross-segment «reference» is reconciled when nothing on its own side changed. That is the «version» question.
- Inside the changeset or beside it (Rust/Fable): the model puts it inside, `KERNEL-SPEC.md` recorded it as a separate act right after, which is two records for one logical instant, exactly what «steady·time» exists to forbid. Lean: inside, as the relation above says; an affirmation is part of the write, not a later act.
