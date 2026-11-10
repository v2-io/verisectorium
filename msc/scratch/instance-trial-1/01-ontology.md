# kvl: the ontology

*kvl* is an invented verisectorium: the specification of a tiny line-based config format (`key = value`, `#` comments), written so that parser implementers can build from it. I chose a specification because the core has been run mostly on theory, and a specification's main content is decisions. Everything below was written from `core/` alone. Where I had to invent something the model doesn't give, I mark it **[invented]** and give it a number in `05-findings.md`.

## Seats and who holds them

| seat | held by (at S0) | what it may do |
|---|---|---|
| steward | Ines (a person) | back any rule; answer any question; waive anything |
| implementer | Tomas (a person; maintains the reference parser) | assent to *major* choices together with the steward |
| editor | agent A1 (later A2, after a compaction) | write changesets; route chunks; affirm |
| reviewer | any mind dispatched with a bare brief (inheriting nothing about what it checks) | checks on *consistent* and *conforms* |

Assignment to a seat is a decision by the steward (actor def). The gap row *steward attestation* applies directly: Ines's assents go through some harness, and the model has no mechanism yet for showing that an assent was hers.

## Veritoid kinds

| kind | content shape | opens | may hold references |
|---|---|---|---|
| **rule** | one normative sentence (MUST/MAY), normalized by collapsing whitespace | backed, consistent, accepted | predicated-on (to rules whose terms it uses) |
| **example** | an input text block and the expected parse as a JSON object | conforms, accepted | predicated-on (to the rules it exercises), at least one **[invented: an expected-reference declaration, from kind's Working Note]** |
| **premise** | a sentence about the world that a choice was made on | holds, accepted | none |
| **rationale** | prose on why a rule is as it is | faithful, accepted | narrates (to rules; and see finding 1) |
| **question** | a question and its declared closer (a seat) | answered, accepted | bears-on |
| **chunk** | a span of a source | where-did-it-go | bears-on (exactly one) |

A rule is the "wording of the choice" that the «decision» def calls a veritoid of a decision kind. I did not make a separate *choice* kind beside *rule*: in a specification the rule *is* the choice.

## Segment kinds

| kind | slots (in order) | inner dependencies | own dimensions |
|---|---|---|---|
| **section** | rules (1..N, rule, held, required); rationale (0..N, held); examples (0..N, held); questions (0..N, held) | rationale → rules; examples → rules | coherent (own: a whole read); accepted (own) |
| **grounds** | premises (1..N, premise, held) | none | accepted (derived: all premises accepted) |
| **spec** (‹projection›, canonical) | sections (1..N, section, pointed at, required); grounds (1, grounds, pointed at, required) | none | coherent (own); accepted (own) |
| **issue** (‹source›) | chunks (1..N) | none | none (retired is computed) |

The *grounds* slot in the spec exists only because of finding 6: without it the grounds segment counts as an orphan.

## Dimensions

Every dimension is declared with the six things «dimension» lists, plus *passes along*.

### backed ‹determinant›, decided
- **asks**: who stands behind this rule, and how revisably?
- **of**: rule.
- **against**: the accountable seat(s).
- **produced by**: an assent by the steward. If the decision is *major* **[invented: a two-level importance scale; the model says agreement "may rise with importance" and gives no scale]**, the implementer must also assent on the same basis. Its basis must name at least one premise when the choice had alternatives **[invented]**.
- **read as**: the standing decision: *unbacked*, *backed (steward)*, or *backed (steward + implementer)*. Reopened means backed by nothing.
- **passes along**: nothing.

### consistent ‹determinant›, found out
- **asks**: does this rule, read together with every other rule in canon, ever require two different parses of the same input?
- **of**: rule.
- **against**: every other rule in canon. That set varies, so an act answering this must **read the section and spec assemblies** as well as the rules. Otherwise a newly added rule would not lapse it (finding 5).
- **produced by**: a ‹check› by a reviewer. Means: *pairwise reading* (a mind reads every pair) and *grammar construction* (a mind writes the rules as a grammar and looks for ambiguity).
- **read as**: confirmed while one check by either means binds; contradicted wins. A contradiction concerns two or more rules and owes on each.
- **passes along**: nothing.

### conforms ‹determinant›, found out
- **asks**: is the expected parse what the rules in canon produce from the input?
- **of**: example.
- **against**: the rules the example is predicated on.
- **produced by**: a ‹check› by a reviewer, means *hand derivation*; or a run by the instrument `kvlp` at a version, means *reference parser*. The parser has standing only while no contest of any of its runs at that version stands **[invented; see finding 8]**.
- **read as**: confirmed when both means bind; contradicted wins.
- **passes along**: nothing.

### holds, found out (fitness)
- **asks**: is this true of the people and tools that will write kvl?
- **of**: premise.
- **against**: the world.
- **produced by**: ‹testimony› by anyone placed to know (the router's testimony stands in for an unattested source); a check by survey.
- **read as**: *supported* (two or more independent lines, none against), *thin* (one line), *disputed* (any unanswered finding or contradiction) **[invented: the model does not say what an unanswered finding does to a warrant; finding 4]**.
- **passes along**: nothing. A premise reaches the rules only through the bases of the decisions that read it.

### faithful, found out (fitness)
- **asks**: does this rationale say what the rule it narrates says, and why it was chosen?
- **of**: rationale.
- **against**: the rules it narrates. ("And why it was chosen" has nothing to be held against; finding 1.)
- **produced by**: a reviewer's read. **read as**: latest outcome. **passes along**: stales along narrates.

### answered, decided (fitness)
- **of**: question. **against**: its declared closer. **produced by**: the closer seat. **read as**: open / answered (with the answer as a rule or a non-change) / dissolved.

### where-did-it-go, decided
- **of**: chunk. **produced by**: the editor seat. Rejection needs the steward (following impl-intake's lean).

### accepted, decided
- **of**: everything except chunks.
- **produced by**: rules, applied by an instrument (the steward may also accept by assent):
  - a rule is accepted while *backed* stands, *consistent* is confirmed, and nothing unanswered stands against it;
  - an example while *conforms* is confirmed and the rules it rests on are accepted;
  - a premise while *holds* is at least *thin*; a rationale while *faithful* is confirmed; a question when it is written (an open question is legitimate canon);
  - a section while every piece in its required slots is accepted and a reviewer's whole read (*coherent*) binds;
  - the spec by the steward's assent, basis: its slots, and every section and the grounds being accepted.
- **read as**: the standing decision.

Whether applying a rule is an actum is not clear to me from the model (finding 3). I treat applications as **computed**: an acceptance by rule is a reading of the record, not an entry in it.

## Reference kinds
predicated-on (example → rule; rule → rule), narrates (rationale → rule), bears-on (chunk → anything), slot pointing. I added none. A decision's basis is not a reference: it is part of the decision act's record (what it read).

## Rules besides acceptance
- Anyone may record a ‹finding›. Only reviewer-seat acts count on *consistent* and *conforms*.
- A carrying check on a *backed* decision is not allowed. The default from «decision», that a party's decision is not carried without the party, is kept.
