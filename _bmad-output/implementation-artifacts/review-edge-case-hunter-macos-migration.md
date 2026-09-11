# Edge Case Hunter Review Prompt: macOS Environment Migration

## Reviewer Instruction

Invoke the `bmad-review-edge-case-hunter` skill on the best-effort diff below. Walk every relevant path and boundary condition, and report only unhandled edge cases. Do not assume prior conversation context.

## Baseline Limitation

`baseline_commit` is `NO_VCS`. The project intentionally did not use Git, and `.git` is empty, so a unified Git diff cannot be constructed. The change manifest below is the reviewable best-effort diff.

## Intended Outcome

Migrate FitnessAI from Windows to the current Apple Silicon Mac, install the missing development tools, replace Windows absolute paths with truthful Mac state, delete Windows/Python caches, preserve bilingual documentation parity, and leave Git uninitialized.

## Change Manifest

- Added `environment.yml` as the minimum BMAD baseline and `environment-osx-arm64.lock` as the exact verified Conda snapshot.
- Added `.gitignore` for macOS, uv/npm, Python, environment, Xcode, Swift, and editor-generated files.
- Added `.gitattributes` with LF normalization for Markdown, Python, shell, JSON, TOML, YAML, Swift, and Xcode project files.
- Added bilingual `docs/development-setup*.md` plus machine-verifiable structure and required semantic review.
- Added guarded Node lifecycle and full migration verification scripts.
- Updated `AGENTS.md` from Windows paths to the verified Mac/zsh/Conda execution model.
- Updated bilingual PRD addendum and append-only memlog to record that the Mac prerequisite is satisfied.
- Updated bilingual vivo baseline/onboarding docs to remove drive-letter paths without inventing Mac installations.
- Deleted `.uv-python/`, `.uv-cache/`, POC `__pycache__/`, and `.pyc` generated state.
- Installed BMAD uv 0.11.29.
- Installed verified official Node.js 24.18.0 arm64 plus npm/npx 11.16.0 under the authoritative user Anaconda prefix and exposed them to zsh.
- Installed and registered iOS 26.5 and watchOS 26.5 Simulator Runtimes.
- Preserved `/opt/anaconda3` and the intentionally empty `.git` directory.

## Verification Evidence

- Native arm64 Python 3.11.15 and uv 0.11.29.
- Interactive zsh resolves Node/npm/npx before and after `conda activate BMAD`; non-interactive explicit Conda execution also works.
- Xcode 26.6, Apple Git 2.50.1, iOS/watchOS SDK 26.5.
- Exact iOS 26.5 `23F77` and watchOS 26.5 `23T570` runtime identifiers are available.
- `pip check` passes; six POC unit tests pass with bytecode writes disabled.
- BMAD config JSON parses and its language fields are machine-asserted.
- Reproducible Windows drive/UNC/environment path, binary architecture, secret-ignore, and uninitialized-Git scans pass with explicit exclusions.
- Cache targets are absent after cleanup.

## Edge Cases to Trace

- Interactive zsh versus non-interactive Codex execution.
- Activation of `BMAD` after Node was exposed from the user Anaconda prefix.
- Re-running `conda env update` on an existing environment.
- uv recreating project-local cache directories after cleanup.
- Xcode SDK presence versus Simulator Runtime registration.
- Simulator download interruption and resumption.
- Apple Silicon architecture versus stale Windows x86_64 artifacts.
- Bilingual document drift after future updates.
- Historical Windows-only vivo facts versus current Mac filesystem claims.
- An intentionally empty `.git` directory versus accidental repository initialization.
- Secret/environment-file ignore rules and Xcode user-state ignore coverage.

## Files to Inspect

- `AGENTS.md`
- `environment.yml`
- `.gitignore`
- `.gitattributes`
- `docs/development-setup.md`
- `docs/development-setup.zh-CN.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md`
- `poc/vivo-watch-gt2/docs/device-baseline.md`
- `poc/vivo-watch-gt2/docs/device-baseline.zh-CN.md`
- `poc/vivo-watch-gt2/docs/onboarding.md`
- `poc/vivo-watch-gt2/docs/onboarding.zh-CN.md`
