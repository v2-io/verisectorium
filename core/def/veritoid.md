```kdl
term "veritoid" pos=noun pl="-s" {
  avoid "atom" "used for this before, and sounds related to the atomic changeset, which it is not"
  avoid "record" "used for this and for the whole document at once"
  avoid "statement" "too narrow; a question, a chunk or a guard is a veritoid too"
  avoid "unit of fate" "how a piece fails is one dimension among several; what makes it one piece is that questions attach to it"
  rel is term="segment" card="{1,1}" note="the leaf: content and no slots"
  rel of term="kind" card="{1,1}" note="a veritoid kind"
  rel holds term="reference" card="{0,N}"
}
status provisional
```

# «veritoid»
A «segment» with content and no slots: one piece of content of a declared kind, the smallest thing a question is asked of.

## Intro
The corpus is made of pieces of content: a formal statement, a step of a derivation, a paragraph of explanation, a question, the wording of a design choice, a chunk cut from a source. Each is a veritoid, of a declared ‹veritoid·kind› that says what form its content takes, which «dimensions|def/dimension» may be asked of it, and which «references|def/reference» it may hold. It almost never makes sense alone: it is held in an assembly with others it depends on, and that is where it is written and reviewed.

## Definition
### Invariants
- It holds content and no segment. Where an act confirms part of it and contradicts the rest, it is split: its id is retired and new ids are minted with recorded descent.
- It has no name of its own unless it is freestanding; a rendering reaches a held veritoid through what holds it.
- Its content and references are written. Its version is the hash of its content, normalized as its kind declares, and of its references as written (kind, target id, what each needs); a reflow mints nothing, and restoring earlier content restores the earlier version and every act that read it.
- Its warrants are computed and never written.

## Discussion
- Why the piece is defined by what attaches to it and not by how it fails. The questions asked of content attach to parts of a document, while a file with frontmatter gives one place to attach anything: the file. The veritoid is the smallest thing questions attach to. "One fate" is a quality target: a well-cut veritoid is one whose warrants move together, and a check that narrows part of it is the evidence that it wants splitting. Grain is discovered by adjudication and recorded as a split, not declared up front.
- Why identity is minted. Every split, merge, move and drain hits the question of what a reference still points at. If a veritoid's identity were its place, a split would shift every later position and references would land on the wrong step. A minted id survives a move; a split retires it and names its descendants, so a reference to it is owed and never silently redirected.
- Why the version leaves out what a reference last saw. An honest check reads its premises and lapses when one changes anyway. If the versions seen were hashed in, clearing one stale reference would mint a version, lapse every act that read the piece and stale every reference to it, on through the graph, with no content changed.

## Examples
- In a scope segment of a theory: each intro paragraph; the definition; the predicate; each lettered consequence, a claim; each "not claimed" sentence; each open question with its closer; each bullet lifted from an audit, a chunk.
- A proposition as one veritoid and the steps of its proof as others, so that a check of a step is seen to concern the step and a check of the statement the statement.
- The one-line definition of a plain word, held directly in an outline's slot.

## Historical Context
### Etymology
*Veri-* for truth and *-oid* for "shaped like, held to": a veritoid is a thing held to truth, not truth itself, which is the right scope for a piece that may be a claim, a question, a guard or a chunk. Joseph offered it half in jest on 2026-11-05 because it carried no history; it stayed because every ancient candidate collided or fell short: *atom* (vsect 0.1, and the atomic changeset), *record* (two things in the August model), *statement* (excludes what does not assert), *dictum* (legal, and the same exclusion), *locus* (address theory), *membrum* (a projection's members). It means exactly what this def says and nothing else anywhere in the estate.

### Adjudication
- Joseph's first description of it, 2026-11-05: "content with one or more dimensions + rules".
- Adjudicated against msc/notes 05 (21:52Z), 08/06–08, 09 §2.1, 09 §2.4, 10 §1.5, 19 §2. That a veritoid is the leaf segment is Joseph's suggestion of 2026-11-09, quoted in «segment»'s Historical Context; what its version covers was decided here on 2026-11-10 from three notes that had each leaned the same way.

## Working Notes
- Open. What normalization is for prose with mathematics in it, and who checks that two normalizations agree. Lean: the kind's content shape declares it; untested.
- The kernel spikes took the safe rule that an id belongs to the segment that introduced it; minted identity with recorded descent is stronger and simpler, and was reached from the notes' five recuts.
