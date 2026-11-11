# kernel-2 in OCaml: the toolchain base

A hello-world dune project that builds, runs one unit test and one property test, so work on the model can start from something known to work. `Kernel.Hello` (a toy event log and a fold over it) and its tests are placeholders and can be deleted. Set up 2026-11-10 on macOS 27.0.1, arm64. The spec is `../KERNEL-SPEC.md`.

## Commands

No shell profile was edited, so `ocaml` and `dune` are not on PATH. Everything goes through `opam exec` against the user-level switch `kernel-2`:

```sh
cd ~/src/verisectorium/msc/scratch/kernel-2/ocaml
opam exec --switch=kernel-2 -- dune build
opam exec --switch=kernel-2 -- dune test            # 1 Alcotest unit test + 1 QCheck property (1000 cases)
opam exec --switch=kernel-2 -- dune test --force    # run again when nothing changed
opam exec --switch=kernel-2 -- dune fmt             # ocamlformat, rewrites files in place
opam exec --switch=kernel-2 -- dune utop lib        # REPL with the library loaded (interactive)
```

For an interactive shell, `eval "$(opam env --switch=kernel-2 --set-switch)"` puts the tools on PATH for that shell only. An agent's shell state usually does not persist between commands, so the `opam exec` form is the dependable one there.

## What was checked

- **Exit status means what it says.** With a deliberately broken `step` and a property it violates, `dune test` exited 1; it exits 0 when all pass.
- **Counterexamples print and shrink.** The broken run reported `[(Add 101)] (after 70 shrink steps)`: the minimal failing log, printed by the derived `show`. The generator came from `[@@deriving qcheck2]`, and QCheck2 generators shrink without extra code.
- **Seeds replay.** Every run prints `qcheck random seed: N`. `QCHECK_SEED=N opam exec --switch=kernel-2 -- dune test --force` reproduced the same counterexample in the same number of shrink steps, twice.

## Things that may surprise

- **`dune test` prints nothing and exits 0 when nothing changed since the last passing run.** Dune caches test results like any other build rule. `--force` runs them again; a new random seed is only drawn when the tests actually run.
- **`dune fmt` exits 1 when it reformats something**, having already rewritten the files. Run it again for 0. `dune build @fmt` is the same thing.
- **Deriving printers and generators.** `lib/dune` enables `ppx_deriving.show`, `.eq` and `.ord`; a type gets them with `[@@deriving show, eq, ord]`, giving `show_t`, `pp_t`, `equal_t`, `compare_t`. `show { with_path = false }` prints `Add 3` rather than `Hello.Add 3`. A hand-written `.mli` must repeat the type with its `[@@deriving …]` to export those functions.
- **Generators live in the tests.** `test/test_kernel.ml` re-declares the type with its manifest (`type event = Hello.event = Add of int | Reset [@@deriving qcheck2]`) so the library does not depend on QCheck. The cost is that the constructors are written twice; the compiler rejects the re-declaration if they drift apart.
- **`QCheck2`, not `QCheck`.** The package holds both APIs. `QCheck2` has integrated shrinking and takes the printer as `~print` on `Test.make`; the older `QCheck` module uses `arbitrary` values and needs shrinkers written by hand.
- **Test output files** go under `_build/…/_tests/`; Alcotest prints the path. `_build/` is gitignored.
- **No coverage tool.** `bisect_ppx` 2.8.3 does not install on OCaml 5.5 (it needs `ppxlib < 0.36`), so it is not in the switch. If coverage of the property tests matters, a second switch on OCaml 5.2 or 5.3 would have to be tried; I did not try it.

## Layout

- `dune-project`: `(lang dune 3.24)`, no opam package stanza.
- `lib/`: library `kernel`; `hello.ml` and `hello.mli` are the placeholder. Modules are reached as `Kernel.Hello`.
- `test/`: one executable, `test_kernel.ml`, an Alcotest runner. QCheck properties join it through `QCheck_alcotest.to_alcotest`. A new library a test needs is added to `libraries` in `test/dune`.
- `.ocamlformat`: pins ocamlformat 0.29.0, default profile.

## Toolchain: what is installed and where

| Tool | Version | How / where |
|---|---|---|
| opam | 2.6.1 | `mise use -g --pin opam@2.6.1` (mise's registry maps `opam` to the GitHub release `opam-2.6.1-arm64-macos`). Binary in `~/.local/share/mise/installs/opam/2.6.1/`; the entry is in `~/.config/mise/config.toml`. Reaches the shell through mise's shims. |
| opam root | | `~/.opam`, from `opam init --bare --no-setup` (no shell hook, no profile change). About 950 MB. |
| Switch `kernel-2` | | `opam switch create kernel-2 ocaml-base-compiler.5.5.2 --no-switch` → `~/.opam/kernel-2`. A global, named switch, so nothing is installed in the repository. Built from source, with opam's sandbox on. |
| OCaml | 5.5.2 | in the switch |
| dune | 3.24.2 | in the switch |
| qcheck, qcheck-core, qcheck-alcotest | 0.91 | in the switch |
| alcotest | 1.9.1 | in the switch |
| ppx_deriving | 6.2.0 (ppxlib 0.39.0) | in the switch |
| ppx_deriving_qcheck | 0.9 | in the switch |
| fmt | 0.11.0 | in the switch |
| ocamlformat | 0.29.0 | in the switch |
| ocaml-lsp-server (`ocamllsp`) | 1.28.1 | in the switch; installed, not exercised |
| utop | 2.17.0 | in the switch; `-version` runs, the REPL itself was not exercised |

Adding a package: `opam install --switch=kernel-2 <package>`. Available but not installed or tried: `qcheck-stm` 0.10 (state-machine tests against a model), `monolith` 20250922, `crowbar` 0.2.2, `ppx_expect`, `odoc`.

To remove everything: `opam switch remove kernel-2` (or delete `~/.opam`), and `mise uninstall opam@2.6.1` plus its line in `~/.config/mise/config.toml`.

mise wrote the `opam` config line itself, with an `asset_pattern` in a template syntax that mise warns it will drop in 2027.3.0. The warning shows on `mise use`, not when running `opam`.
