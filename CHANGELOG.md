# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

`awsum-examples` is tagged in lockstep with the `awsum` compiler — the tag `vA.B.C` bookmarks the commit at which every example in this repo was verified to run cleanly under `awsum A.B.C`. The compiler version this repo targets lives in [`AWSUM_VERSION`](.github/workflows/ci.yml). Only the latest tag is supported.

Until `awsum 1.0.0`, the project does not follow SemVer — every release increments only the patch (`0.0.1 → 0.0.2 …`), and any release may break. The lockstep above is the contract that does hold: within a single `0.0.x`, every example in this repo runs under `awsum 0.0.x` and produces identical stdout on every supported backend.

## [Unreleased]

## [0.0.4] - 2026-05-13

### Added

- Initial release. `hello/` example — basic string concatenation, helper function, `IO.Stdout.print` + `IO.Args.getArgs`. CI runs `awsum run hello/Main.aww` through every backend (`llvm`, `jvm`, `clr`, `wasm`, `js`) on every supported host OS and asserts identical stdout.
- `just format` / `just test` / `just fix` / `just release` recipes for local development, mirroring the other `awsum-lang/*` repos.
