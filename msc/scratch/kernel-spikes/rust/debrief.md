# Debrief: the v2 kernel in Rust (Fable 5.1)

For Joseph. Written after re-reading `account.md`, `src/`, and `tests/` on this branch, not from memory of the work. The account has the detail; this is what I would want you to hold if you read nothing else.

## What was built

The kernel the spec asks for, in Rust, in one sitting: an append-only log of segment changesets and acts; a state computed by folding any prefix of it; and on a state the five computed things (whether an act still binds, a veritoid's position, its ceiling, the frontier, steadiness). Plus a JSON-lines file format that replays through the same append path, so a file that would have been refused is refused on load. Plus a small CLI that runs the spec's worked example and prints every checkpoint. The spec's §2–§3 transcribed into types and 3–8 line methods almost sentence for sentence; I did not design a data model.

Ten minutes from base commit to everything green, measured by `git log`. The language was not where the time went.

## What was found about the spec and the model

Three things the spec under-determines had to be decided before any property could even be stated, and one place where the spec contradicts itself.

1. **§6's expected frontier is wrong by omission.** After the T changeset the spec lists seven owed items; its own §3 definitions force ten. The missing three are `overclaim(e)`, `unmet-need(d, c)`, `unmet-need(e, c)`. Nothing lets `e` escape: an affirmation never counts toward a rung, and ceiling is a plain min. The tests assert ten.

2. **The repair sequence in §6 only closes if a reference can be reconciled without changing the content version.** For S1 to be steady, `e`'s reference must come to say "seen c@2", and nobody in §6 re-checks `e`. So the spec silently assumes the version covers the text but not the references. Under that reading an author can re-point a derivation at a different premise without lapsing the check that attested it, which I think is a hole. My recommendation to the model: the version covers references (a predicated-on reference is a *use*, and a use is part of the derivation); then §6 needs one more act. The claimed level can plausibly stay outside the version. I built the reading §6 requires, marked.

3. **Versions as hashes or as counters is a model decision with a kernel consequence.** Binding is defined on `(id, version)`, so a changeset that reverts a veritoid to a version an old act read makes that act *bind again*. Right if versions are content hashes (the content is what was checked), a hole if they are counters an author can reuse. The kernel cannot tell which it has.

4. **Dangling and missing targets.** The spec does not define a ceiling for a reference whose target is gone; I made it `sketch` (what rests on nothing is supported by nothing). Consequence: a dangling reference shows up on the frontier twice, as stale and as unmet. Whether `unmet-need` should presuppose an existing target is for the model to say.

Also, as smaller observations: every veritoid predicated on an overclaimed root is itself an overclaim item (correct by definition, four items from one cause; porcelain should group by cause and the model may want a word for that); the model puts affirmation *inside* the changeset while the spec makes it an act beside it, which is two records for one logical instant; and the spec's open gap "veritoid identity under recut" is exactly where the kernel had to add a refusal (an id held by another segment).

## What was shown about the kernel, and how strongly

- All eight properties are **tested as properties** over random logs (proptest, 400 cases each, shrinking), plus the §6 walk step by step, plus every refusal, plus the edges above. I also measured the generator's reach, since a green property over a generator that never produces the interesting case is vacuous: it produces cycle refusals, lapses, dangling references and all three owed kinds in quantity; steady non-empty states are thin (13 in 600) and would be the first thing to improve.
- **Mutation testing** is the number I would put weight on: on the library alone, 80 mutants, 49 caught, 10 missed, 1 timeout (an infinite loop, caught in effect), 20 unviable. Every miss is in printing code or an equivalent mutant. Every mutant in the kernel's logic was caught. That says the tests pin the logic down to the operator; it says nothing a prover would say.
- **Nothing is proven.** I installed Kani (bounded model checking over CBMC) and wrote harnesses for P3–P7 against the real code. The family with symbolic ids did not leave symbolic execution in ~12 CPU-minutes on the smallest state; the idiomatic kernel (string ids, B-tree maps, a state clone per step) is the wrong shape for that checker. The family with concrete ids and symbolic values was started and stopped twice, once by my own mistake, once at your coordinator's request because the Rust spikes' CBMC processes were starving the other three agents. **Result unknown; I do not count it either way.** The harnesses are on the branch for anyone with a quiet machine.
- P2 (append-only) is the one property the *language* enforces rather than a test: the log's fields are private, `append` is the only mutator, records come out as a shared slice. The compiler enforces that against every future caller. That is less than a proof about `append` and more than a test.

## What I think it means for the Ada question

From one side only. Rust gave: the spec as types, equality and ordering for free, serialization for free, property and mutation testing as five-minute installs, and a kernel one mind can hold whole. Rust did not give: any unbounded proof, and bounded proof only at the price of either a fixed-shape harness or a second, checker-shaped kernel. The property whose proof would most change my confidence is P3, lapse is exact, because it is where a bug would lie about support silently; I have it as a two-direction property test with its mutants caught, not as a proof. If the Ada spikes discharge P3, P4, P6, P7 as postconditions with gnatprove, that is a strictly stronger statement than anything on this branch, and the question that then matters is the one you posed: how long it took them, and whether a cold mind could keep it so.
