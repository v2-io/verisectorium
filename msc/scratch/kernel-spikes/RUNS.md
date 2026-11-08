# Kernel spikes: measured spend per agent

*Numbers as reported by the harness's task notifications (total tokens for the whole session, tool uses, wall-clock duration). Wall clock ran under heavy CPU contention (four spikes plus two Rust agents' Kani/cbmc runs at once), so it is reported, not compared. Tokens and tool uses are the comparable figures. Each agent's own `account.md` carries its felt split of time between language and kernel; `git log` on its branch carries commit times.*

| agent | model | branch / dir | tokens | tool uses | wall clock | status |
|---|---|---|---|---|---|---|
| setup | Opus 5.5 | `spike/kernel-base` | 141,772 | 71 | 8m 16s | done: toolchain + hello-worlds |
| ada-opus | Opus 5.5 | `spike/kernel-ada-opus` | 293,422 | 91 | 49m 35s | done; 9 commits; 7/8 proved, P8 tested |
| rust-fable | Fable 5.1 | `spike/kernel-rust-fable` | 188,507 (interim) | 44 (interim) | 23m 30s (interim) | running; waiting on Kani, told to stop |
| rust-opus | Opus 5.5 | `spike/kernel-rust-opus` | 354,371 | 180 | 58m 12s | done; 5 commits; all 8 tested (1024 generated logs vs naive oracle, 20/20 seeded bugs caught), nothing proved; 8 Kani runs aborted for CPU |
| ada-fable | Fable 5.1 | `spike/kernel-ada-fable` | — | — | — | running |

Interim rows are updated when the final notification arrives; a final row replaces the interim one.
