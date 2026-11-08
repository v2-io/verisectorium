```kdl
term "reference" pos=noun pl="-s" {
  synonyms "pointer"
  avoid "edge" "suggests an object apart from the veritoid that wrote it"
  avoid "depends" "ASF's frontmatter word pointed whole segments at whole segments"
  rel from term="veritoid" card="{1,1}"
  rel of-kind term="reference⸱kind" card="{1,1}"
  rel to term="veritoid" card="{0,N}" note="how many it expects is written with it"
  rel needs term="rung" card="{0,1}" note="the level it needs its target at, when it says"
  rel seen term="version" card="{0,1}" note="the target's version it was last reconciled against"
}
status provisional
```

# «reference»
A written pointer from a veritoid to others, of a declared kind, carrying the target version it was last reconciled against; someone declared it and it can be wrong, and the store computes only whether it still holds.

## Definition

### Invariants
- It points at the specific veritoid relied on, not at that veritoid's whole segment.
- It says how many targets it expects; that gives a miss its meaning.
- It is written; whether it holds is computed: does the target exist, has the target changed since this was reconciled against it, is the target at the level needed.
- A reference to a piece that does not yet exist, or no longer exists, is allowed; it is owed, not refused.

## Working Notes

- Stub, from the kernel spikes. Four things made precise, one open.
- **"Version seen"** is part of the reference and is written state that is not content (all four built it; Ada/Fable names it). It is what makes `stale-reference` computable. Whether changing it mints a new version of the piece is the «version» question.
- **Ceiling of a missing target is `sketch`**: what rests on nothing is supported by nothing (all four chose it; the spec left it undefined). Consequence (Rust/Fable, Ada/Opus): a dangling reference is owed twice, as stale and as unmet, unless `unmet-need` presupposes an existing target. Lean: owed twice is right; they are different repairs (re-point, or re-earn).
- **`needed` mostly duplicates the ceiling** (Rust/Opus, tested as `unmet_need_is_subsumed_unless_needed_exceeds_claim`): if `needed ≤` the piece's own claim, an unmet need already implies an overclaim, and the ceiling ignores `needed` entirely. So `needed` says something of its own only when it exceeds the piece's claim, and either the ceiling should consult it or it is a separate assertion (a lower bound the author asserts) whose job the model hasn't stated. Open; lean: keep it as the author's assertion, and say so.
- **References to not-yet-written pieces are edges only once the target exists** (Rust/Fable): otherwise a reference to a planned segment would have to be refused, which contradicts dangling references being owed rather than forbidden. Consistent with «planned⸱segment».
- **Acyclicity** of `predicated⸱on` is what makes the ceiling *unique*, not what makes it exist (Ada/Opus proved the equation has one solution on an acyclic graph and that all-`sketch` also solves it otherwise). Both Ada kernels carry a rank per piece as the acyclicity witness and note it is computed, canonical, and so within "never typed".
