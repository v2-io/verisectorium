# Kernel spikes: the toolchain base

The spec is `KERNEL-SPEC.md`, in this directory. `ada/` and `rust/` are hello-world crates that already build, test and (for Ada) prove, so a spike can start on the kernel itself. `Kernel.Hello` / `saturating_add` and their tests are placeholders and can be deleted. Set up 2026-11-07 on macOS 27.0.1, arm64.

## Rust (`rust/`)

```sh
cd rust
cargo build
cargo test                    # 1 unit test + 1 proptest property
cargo clippy --all-targets    # currently clean
```

- rustc / cargo 1.96.0, stable-aarch64-apple-darwin via rustup (already installed; components include clippy, rustfmt, rust-analyzer).
- Crate `kernel`, edition 2024, library. `proptest = "1.12.0"` is a dev-dependency. `Cargo.lock` is committed so every spike resolves the same versions.

## Ada 2022 + SPARK (`ada/`)

```sh
cd ada
alr build            # builds the library crate `kernel`
alr test             # builds and runs the AUnit suite in tests/
alr gnatprove        # flow analysis + proof of the kernel crate
```

- **Exit status means what it says.** I checked both failure paths. A broken postcondition makes `alr gnatprove` exit 1. A failing assertion makes `alr test` exit 1, and `alr run` in `tests/` too.
- **Proving.** `alr gnatprove` is Alire's built-in alias for `alr exec -P1 -- gnatprove`, which adds `-P kernel.gpr`. The switches live in `kernel.gpr`, `package Prove`: `--level=2 --checks-as-errors=on --counterexamples=on -j0`. `--checks-as-errors` is the one that makes an unproved check fail the command. Level 2 is a starting point. Extra flags pass straight through, e.g. `alr gnatprove --level=4`, `alr gnatprove --report=all`, `alr gnatprove -u kernel-hello.adb`. The summary table is written to `obj/<profile>/gnatprove/gnatprove.out`, where the profile is `development` or `release` depending on what was built last.
- **Seeing test output.** `alr test` prints only pass or fail; the runner's output goes to `alire/alr_test_local.log`. For live output, run `cd tests && alr run`.
- **Layout.** `src/` holds the library: `Kernel` is the root package, and `Kernel.Hello` is the placeholder with one proved contract. `SPARK_Mode` is set per unit, by an aspect on each package. `tests/` is a separate Alire crate, `kernel_tests`. It pins `kernel` by path (`..`) and depends on `aunit`. `Kernel_Suite` collects the test cases, so a new test case is added there. The tests crate is not in SPARK mode.
- **Compiler settings.** `[build-switches]` in both `alire.toml` files set Ada 2022 (`-gnat2022`) and contracts on (`-gnata`), so `Pre`/`Post` and assertions are also checked at run time in tests. Alire's development profile adds `-gnatwa` and style checks (`-gnaty…`, including a 79-column line limit). These print as warnings and don't fail the build.
- **Property testing.** Ada has no proptest equivalent in common use. The Alire index does have `strategy` 0.1.0 ("Property-based testing framework", Fabien Chouteau, AdaCore), but I have not added or tried it. `tests/src/hello_tests.adb` contains a hand-rolled randomized check (`Ada.Numerics.Discrete_Random`, fixed seed) as the plain-Ada alternative.
- **Files you don't commit.** `alire/`, `config/`, `obj/`, `lib/` and `tests/bin/` are generated and gitignored; `alr` recreates them on first use in a fresh worktree.

### Toolchain: what is installed and where

| Tool | Version | How / where |
|---|---|---|
| Alire (`alr`) | 2.1.1 | `mise use -g github:alire-project/alire@2.1.1`. mise's GitHub-release backend picked `alr-2.1.1-bin-aarch64-macos.zip`. Binary in `~/.local/share/mise/installs/github-alire-project-alire/2.1.1/bin`; the entry is in `~/.config/mise/config.toml`. No Homebrew formula exists. |
| GNAT FSF (`gnat_native`) | 16.1.0 | `alr toolchain --select gnat_native=16.1.0 gprbuild=26.0.1` → `~/.local/share/alire/toolchains/` (Alire's user-level default toolchain) |
| GPRbuild | 26.0.1 | same command, same place |
| gnatprove | 16.1.0 (native aarch64-darwin build) | Crate dependency `gnatprove = "=16.1.0"` in `ada/alire.toml`, pinned to match GNAT 16.1.0 → `~/.local/share/alire/releases/` |
| Provers bundled with gnatprove | Why3 1.8.2+git, Alt-Ergo 2.6.1, cvc5 1.3.2, Z3 4.15.4 | inside the gnatprove release |
| AUnit | 26.0.0 | crate dependency of `tests/` → `~/.local/share/alire/releases/` |
| Alire index | community `stable-1.4.0` | `~/.config/alire/indexes/` |

**PATH.** `alr` reaches the shell through mise's shims (`~/.local/share/mise/shims`), which are already on PATH on this machine. If `alr` is ever not found, either use `mise exec github:alire-project/alire@2.1.1 -- alr …` or put the bin directory above on PATH; no shell rc file was edited. `gnat`, `gprbuild` and `gnatprove` are not on PATH on purpose. Reach them through `alr`, either with `alr build` / `alr gnatprove` or with `alr exec -- <tool> …` from inside `ada/` or `ada/tests/`. `eval "$(alr printenv)"` gives a shell the full build environment. Nothing was installed into the repository.
