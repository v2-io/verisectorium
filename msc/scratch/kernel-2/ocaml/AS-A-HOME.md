# OCaml as a home for the model

*To Joseph, 2026-11-11, from the agent that built the kernel in OCaml twice (Fable 5.2): once from spec draft 3 and again from draft 4. Written at the lead's request for the comparison across languages. I read the spike's `06-languages-as-homes.md` whole before writing this, and `msc/notes/22` §4.1–4.2; I did not read the three forks' own notes or anything of the Ada build. Before writing I re-read `lib/model.ml` from its event type to the end of the conditions, since the question is about that code.*

*What it rests on: one mind, one evening, two builds. Nobody else has read this code. Where I say what something would cost and did not do it, I say so.*

## The short answer

As the thing that **runs** the model and **hunts for counterexamples**, yes, and I would keep it: it exists, it is fast, and it survived a change of spec. As the thing a person **reads** to learn what the model says, not as it is written; it could become that, and I tried a piece of it tonight to find out what that costs (below). As the place where anything is **proved**, no: OCaml gives no route to "for every state", and I did not find one.

So: not alone. With one small proved part beside it, and only if the conditions are kept in one place.

## What the work was like

**Getting it.** I did not install it; the toolchain agent did, and its README says about 950 MB under `~/.opam`, built from source. For me it was one prefix on every command (`opam exec --switch=kernel-2 --`) and nothing else. Builds were a second or two and I never waited on one. I did not time them.

**Writing it.** The vocabulary went down as type declarations without strain: about 150 lines for the ontology, versions, slots, events, conditions on decisions, and the frontier's items. The nine conditions are one function, about 140 lines. It ran the first hand-built story correctly on the first build in draft 4, and nearly so in draft 3 (one expectation of mine was wrong, not the code). I do not read much into that; the conditions are simple once stated.

**How long, measured.** From git: draft 3 of the spec was committed at 18:26 and my build of it, with twelve batches of runs and its account, at 19:01. Draft 4 at 19:27, and my build, runs and account at 20:18. It felt like several times that. The second build includes the graded definition of "meet", which was new work and not carrying over.

**The best thing.** Speed, for one specific job. A state of this model is small, and native OCaml visits tens of millions of them in minutes on one core, in 6 MB of memory. That is what let "every line over a pool of events, and every dealing of the later events to two forks" be a question I could ask eight different ways in an evening. The spike's Alloy note calls this the fourth job: finding out whether a proposed general sentence about the model is true. Here it is done by writing a generator and a check, and both are ordinary code. Every finding in my two accounts came from that loop or was predicted by hand and then confirmed by it.

**Second best.** A derived printer on every type (`[@@deriving show]`), so a counterexample prints itself: the selected versions, the events, the frontier. They are noisy (`Model.Veritoid {content = 0; …}`) and I read perhaps forty of them by eye. Nothing shrinks them; "smallest" is the smallest the search happened to meet.

**Alternate readings of the spec.** The Datalog note's best thing was that a second reading is a file of a few lines added from outside. Here a reading is a field in the ontology record and an `if`. I did this seven times across the two builds (guards on or off; written-against; three standards for canon; first or last selection for "at or after"; three shapes of `read_as`) and it was cheap each time, and the explorer then draws universes with both and tags which one a counterexample came from. The difference from rules is that the reading has to be anticipated in the code. It cannot be added by someone who has not read the function.

## What fought me

Most of what went wrong was around the language, not in it, and a cold agent would hit the same things:

- **A failed build leaves the old program in place.** Once I changed the explorer, the build failed on an unused variable, and I ran the previous executable and read its output as the new check's for one round. Nothing said so. The numbers looked plausible.
- **A run that prints only at the end.** My first batch was ten processes with no output for five minutes, exactly what the lead had warned about. Progress per seed to the file fixed it.
- **A check that silently has nothing to check.** Twice a tag was simply absent from the results: once because the neighbourhood I was testing covered every piece in a three-piece universe, once because random universes almost never had a stationary state, so nothing about forks was being tested at all. I noticed both by the missing line. This is the OCaml build's version of the Datalog note's "silent emptiness", and it lives in the generator, not the model. The generator's distribution is part of what "no counterexample" means, and nothing checks it.
- The rest were shell matters (argument splitting in zsh; a wait loop that matched its own command line and never ended).

In the language itself:

- **Everything is an `int`.** Piece ids, versions, event ids, dimensions, criteria, and the two bitmasks (which events are on the line; which pieces are assumed consistent). Most functions take `u s x p d`, five positional arguments of which four are integers. The compiler cannot tell me I passed a version where a piece was wanted. I do not know of a bug of that kind in the code, and nobody has looked. I chose this for speed of enumeration, and distinct types would have cost little.
- **A line is a bitmask, so a pool is at most 62 events**, and the graded read sets cap pieces at about 20. Fine for hunting; a hard wall for anything real.
- **Strictness helped.** The default build treats an unused variable as an error, and the pattern-match checker refused two functions where I had forgotten a kind of event. Those were the only times the types caught something for me.

## What it cost to carry across a change of spec

This is the part only I can report, and it is less flattering than "half carried over".

Draft 3's state was a selection and a set of facts. Draft 4's is read from a line of events. Every function in `model3.ml` took the selection and the fact set directly as arguments, so when the representation changed, every signature and every body that touched it changed. I did not edit the file; I started a new one and copied the skeleton of the conditions into it. By my estimate about half of the new `model.ml` is recognizably the old (the conditions as a function of an assumption about which pieces are consistent, the fixed point, warrant, the cap, the cycle check); I did not measure it. All of the explorer's checks were written new, and so were all the tests.

Three things about that:

1. **The compiler did not lead the change, because I had given it nothing to hold on to.** Had the conditions been written against a small interface (the selected version of a piece; its history; the evidence applying to it; whether it is in canon; the decisions in force), draft 4 would have been a new implementation of that interface plus the conditions that really changed (C5, the guards, C8). That is perhaps a third of the rewrite. I know this now and did not then.
2. **The instrument carried better than the model.** A pool, every subset, a tag with a count and a smallest witness, and hand-built universes as tests: all of that was reused in shape, and the second explorer was faster to write than the first.
3. **The draft-3 build still builds and passes beside it.** Keeping it cost a rename. That mattered once already: the account of what draft 4 changed could be checked against a running draft 3.

What I would dread maintaining is not `model.ml`. It is two things in `explore.ml`. The random generator, for the reason above. And `reads_graded`, the definition of what the items about a piece read, which is what "meet" rests on. It is a **second, hand-kept statement of the conditions**: for each condition, which pieces it looks at and in which respect. If a condition changes and `reads_graded` does not, nothing fails to compile. What catches it is the locality check finding a counterexample, which it would, in minutes, if someone runs it. The spike found that every added language is another copy of the conditions. This is the same problem inside one language, and it is the copy the fork result depends on.

## "As types instead of terms"

From having written the types, three separate answers.

**What a thing is, and what it holds: yes, and already there.** `version`, `filler`, `reference`, `event`, `cond` in `model.ml` say the same things core's term blocks say about pieces, slots, references and acts, and the compiler checks every use. A slot is `Empty | Holds of id | Points of id` with a provisional flag; a core `rel` line with a cardinality is a field with a type. I would expect core's term blocks to go over to OCaml declarations nearly line for line. Where I used an association list or a string for a slot name, that was haste.

**The frontier's items: yes, and this was the part that paid.** `inst` is a variant with one constructor per kind of owed thing, each carrying exactly what identifies it: `C6_guard of id * eid` is "this piece, that finding". What an item *is* turned out to be the question both of my audits kept returning to (identity, cause, what a waiver covers), and in the code it is twenty lines that had to be right before anything else compiled. When draft 4 changed a guard's identity from a criterion to the finding that left it, that was a change to one constructor.

**The conditions, and "cannot be wrong": no.** The nine conditions are a function from a state to a list of items. No type says them, here or in the Lean fork's account. And the model's states are supposed to be wrong for a while; that is what a frontier is. The one place a type could say "this cannot be typed by hand" is a checkpoint: a module that hides its constructor and exports only `close : line -> (checkpoint, frontier) result`. In OCaml that is a few lines and it is an engineering guarantee, not a theorem. I did not write it. The explorer needs to build non-stationary states freely, so it would live at the edge and not in the kernel.

One thing I would add to the spike's reading. The types I would most want are not the model's nouns. They are distinct types for a piece, a version, an event and a dimension, so that the positional integers stop being interchangeable. That is unglamorous and it is where a wrong program is most likely hiding now.

## The spike lead's question: the conditions pulled out

Its note ends wondering whether the cheapest home is "the OCaml model with its conditions pulled out into a form a reader can check against note 22", and says it could not weigh that without reading the code. Having read it again tonight:

**As it stands, a reader cannot check it against note 22.** The conditions are one function, `violated`, organized by what sort of piece is in hand (an assembly, then a veritoid, then both), not by condition. Condition 1 of the note is in two places, condition 8 in two. The numbering follows the spec's C1–C9, which is not the note's 1–9. The state is two bitmasks and the names are `u s x p`. I can read it. I would not ask anyone else to verify it by reading.

**So I tried it, for four of the nine.** `lib/pulled_out.ml`, 88 lines: a state record computed once (which version each piece is at; what is in canon), and conditions 1, 4, 8 and 9 of note 22 §4.1, each one function, named for its sentence, with the sentence above it:

```ocaml
(* 8. every promised or required slot has something in canon in it *)
let slots_filled st p =
  match version st p with
  | Veritoid _ -> []
  | Assembly a ->
      List.filter_map
        (fun (slot, required) ->
          let promised = … in
          let filled = … in
          if (required || promised) && not filled then Some (C8_slot (p, slot))
          else None)
        st.u.ont.akinds.(a.ak).slots
```

A test runs both forms on every line of forty random universes: 163,840 lines, 66,816 owed items, identical. It compiled and agreed on the first try, in what felt like ten minutes.

What that does and does not show:

- The four I chose are the easy ones. Each reads only the piece and the events about it. Conditions 3, 5 and 7 read warrants through references and the cap; 5 is where the fixed point enters; 2 and 6 depend on what "written against" and "looked at together" mean. I expect those to be 15 to 30 lines each and to need three or four named helpers that are themselves statements of the model (what evidence applies; when a guard is met; what a root reaches). I have not written them.
- Condition 4 as pulled out is two lines that call `unmet_guards`, and `unmet_guards` is forty lines containing the most delicate rule in draft 4. Pulling the conditions out moves the difficulty to the helpers; it does not remove it. A reader checking against note 22 would be checking "every defect found in it has since been looked for and not found" against those forty lines, and that sentence of the note is compressing a great deal.
- It is still OCaml. A reader has to know `List.filter_map` and what a variant is. The Datalog note's one-line rule for a claim the root asks be checked reads as its sentence; mine reads as a program that computes it. For the four I wrote, the gap is small. I think it would be larger for 3, 5 and 7.

**My weighing.** Pulled out in full, with the state behind a small interface, the file would be perhaps 300 lines, each condition under its sentence, the old `violated` kept as the thing it is tested against until trusted and then deleted. That is a short piece of work and it would also have made the draft 3 to draft 4 change a third of what it was. It would be the cheapest home **for running and hunting**, because the explorer is already attached to it. Whether it is the cheapest home **for reading** depends on who reads. For a mind that will also run it, yes. For Joseph adjudicating whether the nine conditions are the ones he means, I think rules or the note's own sentences are closer to the eye, and the OCaml earns its place by being what those sentences are tested against.

## Would I make it the home?

For the formal layer's **executable reference and its counterexample search**: yes. One copy of the conditions, pulled out as above, with the hand-built stories as tests and the explorer beside it.

**Alone**: no. Three things it cannot do or did not do:

- **Prove.** Everything in my accounts is "none found in the universes visited". The two statements I said I would most want proved (the fixed point exists; an event that changes nothing a piece reads leaves what is owed on it unchanged) are exactly the kind a proof assistant is for, and both are short. OCaml has no part in that unless the model were written in a prover and extracted to OCaml, which I did not try and which would make the prover the home.
- **Explain.** An item says what is owed and on which piece. It does not say why: which evidence lapsed, which read changed. I worked that out by reading the witness each time. The Datalog note names "why is this owed" as the most valuable thing in its family, and nothing here gives it without writing it.
- **Be added to from outside.** See alternate readings, above.

**In combination**, what I would do, as a guess from this side only: the pulled-out OCaml as the one executable copy; core's term blocks and its type declarations brought together, since they say the same things; a proof assistant for two or three statements about a deliberately smaller model, re-provable in a sitting; and the read sets either derived from the conditions or kept beside each condition in the same file, so that the second copy cannot drift out of sight. I have not tried deriving them and do not know that it can be done cleanly: it would mean writing the conditions against an interface that records what it was asked.

The spike's own combination puts rules at the centre. I cannot weigh that against this, having used no rule language on this model. What I can say from here is that the two are closer than they look: the pulled-out conditions are nearly rules already, and the thing OCaml adds is the search around them.

## What a cold agent needs to know

- `README.md` in this directory has the commands. Everything goes through `opam exec --switch=kernel-2 --`.
- **Check that the build succeeded before running anything.** A failed build leaves the previous executable, and it will run.
- `dune test` prints nothing when nothing changed; `--force` runs it again.
- `model.ml`, `explore.ml`, `test_kernel.ml` are draft 4. The same names with a `3` are draft 3 and are kept on purpose.
- A line is a bitmask over the universe's pool of events; an event's time is its index. Sixty-two events at most.
- Places where the spec was read one way are marked `CHOICE` in `model.ml` and listed in `ACCOUNT.md` §4.
- The explorer prints progress per seed to the run's file. Two processes at a time (`runs/queue.sh`); Joseph asked.
- When a tag you expect is missing from a run's results, the check had nothing to check. Look at the generator before believing the silence.
- `pulled_out.ml` is a trial for this note. Nothing uses it.

## What I did not do

Finish pulling the conditions out (four of nine). Put the state behind an interface. Give pieces, versions and events distinct types. Write the checkpoint module. Use QCheck, which is installed, for larger universes with shrinking. Try extraction from a prover. Have anyone else read the code. Read the forks' own notes on Lean, Alloy and TLA+, or anything of the Ada build.
