---
term-group:
- data⸱store
- log
- state
status: provisional
terms:
  data⸱store:
    pos: noun
    pl: -s
    avoid:
      repository: not a git repository and not a directory of files, though it may be held in one
      database: how it is held is undecided
    rels:
    - rel: holds
      to: verisectorium
      card: '{1,1}'
    - rel: governed-by
      to: ontology
      card: '{1,1}'
    - rel: recorded-in
      to: log
      card: '{1,1}'
  log:
    pos: noun
    pl: -s
    avoid:
      trail: an earlier word for one piece's part of the log, which left no place for an act that spans several pieces
      history: read from the log, not kept beside it
  state:
    pos: noun
    pl: -s
    rels:
    - rel: at-a-point-in
      to: log
      card: '{1,1}'
---

## Intro

A «DATA⸱STORE» is a «verisectorium»'s contents as held, whether by an engine or by hand. Everything that happens to it is recorded in its «LOG», which is only ever added to. A «STATE» is the store as of one point in the log: what every piece says, how the pieces are assembled, which version of the «ontology» is in force, and what has been recorded as done.

## Terms

### «data⸱store»

A verisectorium's contents as held, by an engine or by hand.

- Nothing in it is changed by hand. Where the store cannot express a change, that is how we learn what it lacks.

### «log»

Everything recorded about a store, in order, only ever added to.

- Nothing is removed or overwritten. A mistake is corrected by a further record that says so.
- When something outside the store changes (a tool's version, a date a rule cares about), that is recorded at a definite moment, and that record is what moves any answer.

### «state»

The store as of one point in its log.

- It is more than which content is current. It includes how segments are assembled, which version of the definition is in force, and what has been recorded as done.
- Every computed answer is computed as of a state. There is no untimed answer.
- The same recorded things, read in any order, give the same state.

## Discussion

- Why "store" and "verisectorium" are two words. The verisectorium is the body of work; the store is how it is held. The same verisectorium could be held by hand in files today and by an engine tomorrow without becoming a different verisectorium.
- Why the log is primary. If early iterations of an engine sometimes delete the backing store, the durable thing is the log, replayed under the new definition with a migration wherever the shape changed. Nothing adjudicated is redone because the engine changed shape.

## Examples

- This repository: its core/ is a store held by hand, its commits are its log.
- A store held by an engine under the OS's data convention, with the repository carrying only renderings.

## Working Notes

- To adjudicate. "state" is a weak word; whether it stays bare or becomes `store⸱state` is decided with this group. Lean: bare, since the guillemets already mark it and nothing else in the lexicon is called state.
- Open. Whether a store is needed as a word while no engine exists. Lean: yes, because this repository is one, and because "the store cannot express this change" is how the model learns what it lacks.
- Adjudicated against msc/notes 01 §2, 09 §3.1, 11 def-verisectorium and def-state.
