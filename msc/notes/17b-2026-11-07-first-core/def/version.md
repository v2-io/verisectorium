```kdl
term "version" pos=noun pl="-s" {
  avoid "revision" "suggests a sequence; a version here is a name for one content, not a place in an order"
  rel of term="content" card="{1,1}"
}
status provisional
```

# «version»
The name a piece of content carries, such that two contents with the same name are the same content; what an act binds to.

## Definition

### Invariants
- Where an act binds to content it binds to `(veritoid, version)` pairs, so a version must name one content for the life of the store. A version that could be reused for different content would let an old check bind again to content it never saw.

## Working Notes

- Stub, from the kernel spikes (`msc/scratch/kernel-spikes/COMPARISON.md` §4 item 3). All four kernels found that whether a version is a content hash or a counter is kernel-visible: binding is a function of current versions, so a changeset that restores an earlier version makes every act that read it bind again. Under content hashes that is right (the content is byte-identical to what was checked); under counters it is a hole (remove, re-add at an old number with different content, and old checks revive). Rust/Opus's kernel had this hole for references, found by a property test, and now refuses version reuse log-wide (`Refusal::VersionReused`); Ada/Opus pinned it as `Test_Resurrection` (491 re-binds in a random run). Lean: a version is a content hash, so that "one version, one content" is a fact rather than a promise the writer keeps.
- Open (Rust/Fable, Ada/Fable). What the version covers. The worked example in `KERNEL-SPEC.md` needs a reference's "version seen" to change while the piece's content version does not, so that field is written state that is not content. Rust/Fable recommends the version cover references, since a «predicated·on» reference is a «use» and a use is part of the derivation; Ada/Opus instead had the affirmation be what reconciles references without a version change. The claimed level can plausibly stay outside the version either way (it is compared against the ceiling, not attested by a check). Lean: the version covers references. That does not collide with «affirmation», whose job is inner dependencies and not references. And if a check honestly reads the premises it relied on (see «act»), it lapses when a premise changes anyway, so covering references mainly closes the case where a reference is re-pointed with no change of content.
- The outline previously had no row for this term; "at a version" appeared in «content» as if the word were ordinary. It is not.
