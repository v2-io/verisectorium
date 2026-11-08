```kdl
term "affirmation" pos=noun pl="-s" {
  rel is-a term="act" card="{1,1}"
  rel carried-in term="segment⸱changeset" card="{1,1}"
  rel concerns term="veritoid" card="{1,N}" note="the veritoids left unchanged that the author re-read against what did change"
}
status provisional
```

# «affirmation»
The author's recorded statement, inside a segment changeset, that a veritoid left unchanged is still right against what did change; it reconciles that veritoid's references and never raises a rung.

## Definition

### Invariants
- It never counts toward any rung. It is not an independent check.
- Its one computed effect: it reconciles the references of what it concerns to the versions the author read, so a stale reference on an unchanged piece is discharged without a content change.
- A changeset that carries a veritoid unchanged, whose inner dependencies changed, without an affirmation of it is a draft, not a changeset.

## Working Notes

- Stub, from the kernel spikes (`COMPARISON.md` §4 item 2, §5). All four kernels found that, as the spec defined it, an affirmation computes nothing: it never counts toward a rung and nothing reads it, so in the worked example `e`, never rewritten, keeps a stale reference to `c` forever and the steady state is unreachable. Ada/Fable states the same gap differently: the kernel as specified cannot tell a draft from a changeset, because the frontier has no item "carried but unaffirmed". The model's own `segment⸱changeset` sentence ("every inner dependent either changed or carried with the author's affirmation") already says what the affirmation is for; the spec did not carry it into a computable effect.
- The four repairs, for Joseph to choose among: (a) the affirmation's effect is to reconcile the affirmed piece's references to what the author read, never raising a rung, lapsing like any act if either side changes again (Rust/Opus; Ada/Opus made it the *required* way to rewrite references without a content change, refusing the changeset otherwise); (b) let a reference be reconciled without a version bump and give the affirmation nothing (Rust/Fable, who built it and recommends against it, because an author could then re-point a derivation without lapsing its check); (c) make the version cover references, so a reconciliation is a new version and needs a new check (Rust/Fable's recommendation; one more act in the example); (d) leave it inert and add a frontier item for "carried, not affirmed" (Ada/Fable's reading of the gap). The definition above takes (a) and the third invariant takes (d)'s item; whether (c) is also wanted is the «version» question.
- Inside the changeset or beside it (Rust/Fable): the model puts it inside, the spec recorded it as a separate act right after, which is two records for one logical instant, exactly what «steady⸱time» exists to forbid. Lean: inside, as the relation above says; an affirmation is part of the write, not a later act.
