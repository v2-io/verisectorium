//! Not a property: a probe that the random-log generator in `properties.rs`
//! reaches the cases the properties are about. Run with `--nocapture` to see
//! the counts. It fails only if a whole class never appears, which would make
//! the corresponding property vacuous.

use kernel::*;
use proptest::prelude::*;
use proptest::strategy::ValueTree;
use proptest::test_runner::TestRunner;

#[path = "properties.rs"]
#[allow(dead_code)]
mod props;

#[test]
fn generator_reaches_every_interesting_class() {
    let mut runner = TestRunner::deterministic();
    let mut n = 0usize;
    let (mut cycles, mut held, mut lapsed, mut steady_nonempty, mut overclaim, mut stale, mut unmet, mut dangling) =
        (0, 0, 0, 0, 0, 0, 0, 0);
    for _ in 0..600 {
        let b = props::built().new_tree(&mut runner).unwrap().current();
        n += 1;
        for (_, _, r) in &b.refused {
            match r {
                Refusal::Cycle { .. } => cycles += 1,
                Refusal::HeldElsewhere { .. } => held += 1,
                _ => {}
            }
        }
        let s = b.log.head();
        lapsed += s.acts().iter().filter(|a| !s.binds(a)).count();
        if s.steady() && !s.veritoids().is_empty() {
            steady_nonempty += 1;
        }
        for o in s.frontier() {
            match o {
                Owed::Overclaim { .. } => overclaim += 1,
                Owed::StaleReference { v, target } => {
                    stale += 1;
                    if s.veritoid(&target).is_none() && s.veritoid(&v).is_some() {
                        dangling += 1;
                    }
                }
                Owed::UnmetNeed { .. } => unmet += 1,
            }
        }
    }
    println!(
        "logs={n} cycle-refusals={cycles} held-elsewhere={held} lapsed-acts={lapsed} \
         steady-nonempty={steady_nonempty} overclaim={overclaim} stale={stale} (dangling {dangling}) unmet={unmet}"
    );
    for (name, count) in [
        ("cycle refusals", cycles),
        ("held-elsewhere refusals", held),
        ("lapsed acts", lapsed),
        ("steady non-empty states", steady_nonempty),
        ("overclaims", overclaim),
        ("stale references", stale),
        ("dangling references", dangling),
        ("unmet needs", unmet),
    ] {
        assert!(count > 0, "the generator never produced any {name}");
    }
}
