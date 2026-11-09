```kdl
term "veritoid" pos=noun pl="-s" {
  avoid "atom" "used for this before, and sounds related to the atomic changeset, which it is not"
  avoid "record" "used for this and for the whole segment at once"
  avoid "statement" "too narrow; a question, a chunk or a guard is a veritoid too"
  avoid "unit of fate" "how a piece fails is one dimension among several; what makes it one piece is that questions attach to it"
  rel of term="kind" card="{1,1}" note="a veritoid kind"
  rel sits-in term="segment" card="{1,1}" note="in one slot, at a position"
  rel holds term="reference" card="{0,N}"
  rel concerned-by term="act" card="{0,N}"
}
status provisional
```

# «veritoid»
One piece of content of a declared kind, together with what it asserts about itself and what the acts that still bind warrant for it.

## Intro
The corpus holds pieces of content: a formal statement, a step of a derivation, a paragraph of explanation, a caption, a question, an auditor's note, a chunk cut from a source. Every piece is of a declared ‹veritoid·kind›, which says what form its content takes, which «dimensions|def/dimension» may be asked of it, which assertions it may carry, and which «references|def/reference» it may hold. A veritoid is one such piece with its assertions and its warrants. It almost never makes sense alone: it sits in a «segment» with others it depends on, and the segment is where it is written and reviewed. Joseph's words: "content with one or more dimensions + rules".

## Definition
### Invariants
- It has an id minted at creation and never reused, and no name; a rendering reaches it through its segment.
- It is never changed alone. It changes only inside a ‹segment·changeset›.
- It contains no veritoid. Where an act confirms part of it and breaks the rest, it is split: its id is retired and new ids are minted with recorded descent.
- Its content, assertions and references are written; its warrants are computed. Its version is the hash of its written state.
- On every dimension its kind opens, its assertion (if any) may not exceed its warrant. That failure is an overclaim, owed on the «frontier».

## Discussion
- Why the piece is defined by what attaches to it and not by how it fails. The months-long dissonance was that the questions asked of content attach to parts of a segment, while markdown with frontmatter gives one place to attach anything: the file. The veritoid is the smallest thing questions attach to. "One fate" is a quality target: a well-cut veritoid is one whose warrants move together, and a check that narrows part of it is the evidence that it wants splitting. Grain is discovered by adjudication and recorded as a split, not declared up front.
- Why identity is minted. Every split, merge, promotion and inbox drain hits the question of what a reference still points at. If a veritoid's identity were its place, a split would shift every later position and references would land on the wrong step. A minted id survives a move; a split retires it and names its descendants, so a reference to it is owed and never silently redirected.

## Examples
- In `scope-adaptive-system`: the intro paragraphs (explanation); the law definition; the scope predicate; each lettered item (a)–(h′) of the membership result, each a claim; the housing result; each "Not claimed" sentence of the Epistemic Status (a non-claim); each named Discussion paragraph; each open item of the integration record (a question with a closer); each gold-lift bullet (a chunk of the source "audit gold lift 2026-05-30", bearing on this segment).
- In `deriv-sector-condition`: Prop A.1S(i) as a claim, and the steps of its proof as separate veritoids in the derivation slot. That separation is what lets the model show (i) was never asked.

## Historical Context
### Etymology
*Veri-* for truth and *-oid* for "shaped like, held to": a veritoid is a thing held to truth, not truth itself, which is the right scope for a piece that may be a claim, a question, a guard or a chunk. Joseph offered it half in jest on 2026-11-05 because it carried no history; it stayed because every ancient candidate collided or fell short: *atom* (vsect 0.1, and the atomic changeset), *record* (two things in the August model), *statement* (excludes what does not assert), *dictum* (legal, and the same exclusion), *locus* (address theory), *membrum* (a projection's members). It means exactly what this def says and nothing else anywhere in the estate.

### Adjudication
- Adjudicated against msc/notes 05 (21:52Z), 08/06–08, 09 §2.1, 09 §2.4, 10 §1.5, 19 §2.

## Working Notes
- Not yet confirmed by Joseph: exactly two levels (veritoid, segment). He said on 11-05 he was still not sure; the lean is the reading of his "practical granularity".
- [M] Minted identity with recorded descent. The kernel spikes took the safe rule that an id belongs to the segment that introduced it; this is stronger and simpler, and was reached from the notes (09 §2.4's five recuts, 10 §1.5) rather than from the spikes.
