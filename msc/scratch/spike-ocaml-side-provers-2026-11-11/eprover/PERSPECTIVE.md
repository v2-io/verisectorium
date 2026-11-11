# What E sees in the model

*2026-11-11. E 3.1 (a first-order theorem prover) on its own, by a fork of the spike lead (Fable 5.2). Scratch; adjudicated by nobody. I began with everything the lead had read and with its guess 4 ("the wrong shape for the model, and a useful engine behind Why3"), so where this agrees with that guess it is one expectation tested, not two minds.*

**What was run:** everything below marked with a file in `runs/`. **What was only reasoned:** marked as such. **Not done:** conditions 1, 3, 7, 8, 9 of the small model; warrant levels; forks; anything with E behind Why3 (the Why3 fork's).

How E works, in one line, because everything below follows from it: you give it sentences and one more sentence, and it searches for a proof that the last follows from the rest. It assumes nothing you did not write. It answers `Theorem` (it follows), `CounterSatisfiable` (it does not follow), or it runs out (`ResourceOut`, `GaveUp`), which says nothing.

## 1. The model reads absence as information everywhere, and never says so

This is the main thing E showed me, and it showed it by refusing to work until I had written it down, over and over.

To get "canon is O, T, c, d, k and nothing else" for the slice (`../../idiomatic-slice-2026-11-11/eprover.p`), these had to be written as axioms, none of which is in the slice's text or in note 22:

- that the seven names are seven different things, and the eight slot names eight different slots (49 inequalities);
- that each stored relation has *exactly* the tuples listed: these are all the slots that hold, all that point, the only provisional one, the only promise, the only root (7 axioms);
- that whatever is in canon has a reason (1 axiom).

For the story the same again per row: these are all the writes, all the evidence, all the reads, all the affirmations, and this is the whole order of events.

Each one corresponds to a phrase the model uses without comment. "Its *latest* write": there is no later one. "No finding applies." "Not provisional." "No evidence that holds on that criterion since." "Rests *only* on." Every computed thing in the model is computed from what is **not** on the record as much as from what is. The model's first rule, that how well a piece stands is read from the record and never typed, therefore has a premise: the record in hand is all of it. Core says this once, sideways ("*never asked* is a warrant"), and note 22 not at all.

Where it bites in practice, by reasoning and not by a run: a line that has not yet seen some of the base (a fork made before evidence arrived; a reader working from a copy) computes a frontier from an incomplete record, and nothing in what it computes says so. Draft 4's "base up to the line's latest time" was a way of saying which record a state is read from; the OCaml build read "the base as it stands". Either way the completeness of the record is an input to every item, and it has no name in the model.

A small thing that fell out of the same refusal. Before I wrote the inequalities, E could prove that c and d are different pieces and could not prove that O and U are (`runs/slice-dollar-distinct.txt`, and my account in `AS-A-HOME.md`). It knew c from d because their *content* differs; quoted strings are the one thing it holds distinct. That is identity by content, which the model's identity rule exists to deny, and it is what a logic gives you for nothing.

## 2. "Least" and "greatest" cannot be said, and the model uses each once

Canon is the *least* set that has the roots and is closed under a firm step. First-order logic can say "closed under the rules" and "everything in it has a reason". Together those say "a fixed point", not "the least one".

- `slice/ring.p`: one segment, not a root, pointing firmly at itself. By the model it is not in canon. E: `CounterSatisfiable` in 0.04 s. From the first-order axioms it does not follow that it is outside canon. A ring that supports itself is a model of the axioms.
- `slice/grows.p`: for any store, if every firm step of one state is a firm step of another (a provisional slot was confirmed) and the roots are the same, is the first canon inside the second? True of the model. E: `CounterSatisfiable`, 0.04 s. It does not follow, for the same reason.

For the instance none of this matters: its slots have no ring, and E proved both directions of "canon is exactly these five" (`runs/slice-canon_is.txt`, 0.03 s) and that U and u are outside it.

The model has two such choices and they go opposite ways. Canon is least: in only if there is a reason. Consistency (kernel spec draft 4 §4; note 22 §4.1 condition 5) is greatest: consistent unless there is a grounded reason against. The OCaml build found the second by hand (two pieces resting on each other have two fixed points) and E cannot see either choice at all. So anything the model wants to say about rings, of slots or of resting, is outside what a first-order prover can confirm or refute. That is the precise sense of "wrong shape", and it is narrower than I expected: it is about rings, not about the conditions.

It also gave E an honest use I had not guessed. `CounterSatisfiable` came back instantly, twice, for statements that are *true of the model*. That is E saying: this truth depends on "least"; it is not a consequence of the rules as rules. For a proposed general sentence, that is worth knowing before anyone tries to prove it in a tool that can.

## 3. What it proved of every state

With the small model's definitions and no state given at all, so that a proof holds for every state whatever (`general/`, each with its output in `runs/`):

| statement, of every state | E | time |
|---|---|---|
| a piece not in canon owes nothing | `Theorem` | 0.05 s |
| while a finding applies to a piece in canon, the state is not stationary | `Theorem` | 0.05 s |
| one more piece of evidence that holds adds nothing owed under condition 2 (references reconciled) | `Theorem` | 0.1 s |
| ... under condition 4 (not known wrong, guards included) | `Theorem` | 17 s |
| ... under condition 5, first half (what the root asks) | `Theorem` | 0.07 s |
| ... under condition 6 (looked at together) | `Theorem` | 11 s |
| ... under condition 5, second half (rests only on pieces with nothing wrong) | no answer in 30 s | |

The good-news questions are asked of two copies of the definitions, one for a state and one for that state with a single further piece of holding evidence recorded last (`general/two_worlds.py` writes them from `m0/m0.ax`, so they are the same definitions the story ran on).

Read with these limits. It is the small model: no warrant levels, no `same`, no set-aside, and the good news is evidence only, added last. Three checks that the axioms are not proving everything (`sanity-*`, `bad-news-cond4`): a falsehood, the reverse of one of the theorems, and the same question with evidence that *fails* each came back with no answer in 20 s, not `Theorem`. That is the absence of a refutation, not a proof of soundness. And nobody has read the proofs; E prints them on request and I did not ask.

The one it did not prove is the one whose definition is recursive: "rests only on pieces with nothing wrong" is defined through itself along *predicated on*. That is §2 again. In first-order logic I expect it is not provable at all without saying that resting has no ring, and I did not try adding that.

So for the conditions that are not recursive, "good news does no harm" is a first-order fact about every state of the small model, found in seconds from the definitions as written. The Ada build proved a statement of this kind for the kernel, and the OCaml build tested one on millions of states (their accounts say exactly what; I have not read the Ada one). Here it cost a fifty-line script that copies the definitions twice.

## 4. Higher-order E

The lead's guess said E "cannot state 'the least set such that'". For first-order E that is §2. But E 3 also reads higher-order logic, where canon can be said as what it is: *in every set that has the roots and is closed under a firm step*. The opam build has this switched off ("recompile E using ./configure --enable-ho"), so I rebuilt E 3.1 from opam's own cached source with that option, in the scratchpad (23 seconds of compiling, `runs/ho-build.txt`; the binary is not installed anywhere).

| question, with canon said that way | higher-order E | first-order E |
|---|---|---|
| the ring is not in canon (`slice/ring-ho.p`) | `Theorem`, 0.02 s | does not follow |
| confirming a provisional slot only adds to canon, for any store (`slice/grows-ho.p`) | `Theorem`, 0.2 s | does not follow |
| a root is in canon; what canon reaches is in canon (`rules-ho-root`, `-step`) | `Theorem`, 0.02 s each | axioms |
| whatever is in canon has a reason (`rules-ho-only`) | gave up after 30 s | axiom |

So the guess is half overturned. E can state "least", and proves from it in a fifth of a second the general statement that first-order E showed does not follow from the rules. What it could not find is the one proof that needs an induction (choosing the right set to instantiate). I did not go further: no conditions, no story, nothing recursive beyond canon in higher-order form.

## 5. Running the story: not what it is for

The small model's conditions 2, 4, 5 and 6 went down as one definition each (`m0/m0.ax`, about 110 lines), and they read close to note 22's sentences:

```
% 4. no finding applies, and no guard is open
owed(cond4, P) <=> canon(P) & ?[E, V, C]:
    ( evid(E, P, V, C, fails)
    & ( applies(E)
      | ( was(P, V) & ~ sel(P, V)
        & ~ ?[H, V2]: (evid(H, P, V2, C, holds) & before(E, H) & applies(H)) ) ) )
```

Each row of the story is a generated file giving every stored relation exactly (`m0/gen.py`, `m0/row-N.ax`).

Asked outright "is row 0 stationary?" (fourteen events), E did not answer in 20 seconds with its automatic setting (`runs/m0-row0-stationary.txt`), nor in 40 with three others I tried and did not keep the output of (`--auto-schedule` gave up; `--sine=Auto` and `--definitional-cnf=24` ran out). So I asked the eighty-odd small questions underneath in the order a rule engine would compute them (selected versions; which evidence applies; canon; each condition; resting; stationary), each both ways, handing every answer back as an axiom (`m0/ladder.py`).

| row | events | owed, as E decided | left undecided | seconds |
|---|---|---|---|---|
| 0 | 14 | nothing; stationary | | 65 |
| 1 | 15 | 4 on c; 5 (rests) on u | | 60 |
| 2 | 18 | 4 on c; 2 on u; 5 on u and T; 5 (rests) on u; 6 on T | | 148 |
| 3 | 16 | 4 on c; 5 (rests) on u | | 63 |
| 4 | 20 | 4 on c; 5 on c, u and T; 2 on u; 5 (rests) on u; 6 on T | | 124 |
| 5 | 22 | 2 on u; 5 on u and T; 6 on T | | 163 |
| 6 | 23 | 2 on u; 5 on c, u and T; 5 (rests) on u; 6 on T | | 212 |
| 7 | 24 | 5 on u and T; 6 on T | **whether u's reference to c is reconciled, and so condition 2 on u** | 228 |
| 8 | 26 | 5 on T and U; 6 on T | | 311 |
| 9 | 28 | none decided | **18 of 93 questions, among them whether d is at d3, whether four pieces of evidence apply, conditions 4, 5 and 6, and whether the state is stationary** | 1,011 |

(`runs/m0-ladder-row*.txt`, every question with its answer and time. Numbers are note 22's conditions.)

Two things about that table.

**Against note 22's column.** Where E decided, its frontier is the mechanical reading of the conditions, and it departs from the story's prose column in the places the first spike's common reading said to watch: at row 2 the fork's `c1′` carries a guard, because the finding was on criterion *caseX* and the only evidence about `c1′` is on *valid* (the prose says "c1′ is fine"); and from row 4 through row 8, condition 6 is owed on T, because nothing in the story looks at k2 beside e1, and a whole read of T is evidence about T, not about k. Row 9, where the story says the frontier is empty, E did not decide. By my own reading of the definition condition 6 is still owed there, since nothing at row 9 looks at k2 beside e1 either; that is reasoning, not a run. I have not compared this with the first spike's four instruments beyond what `01-common-reading.md` predicts; that file says an exemplar finding condition 6 owed on k "has found something in the story".

**About E.** The order of the ladder is mine. It is the order in which the model's definitions depend on one another, which a rule engine works out for itself and E has no idea of: given all the definitions at once, it searches among them. And it got worse as the state grew: one minute at fourteen events, five at twenty-six, and at twenty-eight it stopped being an evaluator at all, with a fifth of the questions unanswered after seventeen minutes, including ones of a kind it had answered on every earlier row.

## 6. What E would rename, and what it cannot say

- It would call a **frontier item** a sentence that is *derivable*, and a **stationary state** one from which no such sentence is derivable. That second half is where it fails: "nothing is owed" is a statement that things do not follow, and showing that needs every closing in §1.
- It has no **events**, only sentences about events. Order is a relation I supplied pair by pair.
- It cannot say **computed**. A definition and a hand-typed fact are both just axioms; `owed(cond4, c)` written beside the definition of `owed` is accepted, and if it contradicts the definition then everything becomes provable. (Reasoned, not run.)
- It cannot say **how many**: "one", "at most one", "any number" would each be axioms about equality.
- It can say **content** as a quoted string and nothing about it, like every other tool so far.

## 7. The lead's guess 4, held against this

"It proves first-order consequences of the conditions when they are written as axioms": yes, §3. "It cannot state 'the least set such that'": yes for first-order, §2; **no for higher-order E, §4**, which states it and proves from it. "It cannot say 'no counterexample this small'": true as worded, and yet it said `CounterSatisfiable` for general sentences faster and more usefully than I expected, which is a different thing and a real one. "The wrong shape for the model": for running it, plainly yes (§5); for the conditions as sentences, no, they read well; for rings, yes, exactly. "A useful engine behind Why3": untested here.
