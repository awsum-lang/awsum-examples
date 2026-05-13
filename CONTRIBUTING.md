# Contributing to `awsum-examples`

Thanks for your interest in contributing.

## Development setup

Install the [Awsum compiler](https://github.com/awsum-lang/awsum). Then from a checkout:

```bash
just format    # awsum format -i over every .aww file
just test      # run every example through llvm / jvm / clr / wasm / js, assert identical stdout
just fix       # format + test
```

`just test` requires the same five backend runtimes that the Awsum compiler's CI uses — LLVM 15 (`clang`), JDK 11, .NET 9, `wasmtime`, Node 22. See [.github/workflows/ci.yml](.github/workflows/ci.yml) for the matching install scripts.

## Signed commits

The `main` branch requires signed commits — every commit you push to a PR needs a verified signature, otherwise the merge button stays grey.

Minimal `~/.gitconfig` for SSH signing:

```ini
[user]
	email = ...
	name = ...
	signingkey = ~/.ssh/id_ed25519.pub
[commit]
	gpgsign = true
[gpg]
	format = ssh
```

For GPG signing instead, set `gpg.format = openpgp` (or omit — that's the default) and point `signingkey` at your GPG key ID. The option name `gpgsign` is git's historical name for "sign this thing" and applies regardless of format.

The same key file must be added to GitHub Settings → SSH and GPG keys as a **Signing Key** (a separate category from Authentication Key, even if you reuse the same file). Verify locally:

```bash
git commit -S -m "test" --allow-empty
git log --show-signature -1
```

If you already made unsigned commits on a feature branch, retroactively sign with:

```bash
git rebase --exec 'git commit --amend --no-edit -S' <range>
```

then force-push your branch.

## Pull requests

- Open against `main`. CI must be green before merge.
- For user-visible changes, add a bullet under `## [Unreleased]` in [CHANGELOG.md](CHANGELOG.md). Infrastructure-only changes (CI, dev tooling) still get an entry so the next release notes are complete.
- Releases of `awsum-examples` are tagged whenever the examples here have been verified against a fresh `awsum` release; the tag matches the compiler's version (`vA.B.C`). [`AWSUM_VERSION`](.github/workflows/ci.yml) is the source of truth — `just release` reads from it.
