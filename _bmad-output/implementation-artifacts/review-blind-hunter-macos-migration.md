# Blind Hunter Review Prompt: macOS Environment Migration

## Reviewer Instruction

Invoke the `bmad-review-adversarial-general` skill on the best-effort diff below. Review independently and report only actionable findings. Do not assume prior conversation context.

## Baseline Limitation

`baseline_commit` is `NO_VCS`. The project intentionally did not use Git, and `.git` is empty, so a unified Git diff cannot be constructed. The change manifest below is the reviewable best-effort diff.

## Intended Outcome

Migrate FitnessAI from Windows to the current Apple Silicon Mac, install the missing development tools, replace Windows absolute paths with truthful Mac state, delete Windows/Python caches, preserve bilingual documentation parity, and leave Git uninitialized.

## Added Files

- `environment.yml` defines the minimum `BMAD` baseline; `environment-osx-arm64.lock` records the exact verified Conda snapshot.
- `.gitignore` excludes macOS metadata, local uv/npm caches, Python bytecode, environment files, and Xcode/Swift generated state.
- `.gitattributes` normalizes text-based project files to LF.
- `docs/development-setup.md` and `docs/development-setup.zh-CN.md` document the verified Mac environment, reproduction, Node, Xcode, simulator, test, and migration procedures.
- `scripts/install-node-macos-arm64.sh`, `scripts/verify-macos-environment.sh`, and `scripts/check-bilingual-docs.py` provide repeatable installation and assertions.
- `spec-migrate-windows-development-environment-to-macos.md` and its `.zh-CN.md` counterpart capture the user-approved intent and execution tasks; workflow status was `in-review` when this prompt was issued.

## Modified Files

- `AGENTS.md`: replaced Windows Conda/PowerShell paths with `/Users/seanlee/anaconda3`, zsh, native arm64, explicit `conda run`, uv, Node, and Xcode rules.
- PRD `addendum.md` and `addendum.zh-CN.md`: changed “a Mac will be acquired” to the confirmed state that an Apple Silicon Mac and Xcode are available.
- PRD `.memlog.md`: appended the Mac-acquisition/configuration change.
- `poc/vivo-watch-gt2/docs/device-baseline*.md`: removed obsolete Windows absolute paths and recorded that BlueOS Studio/template artifacts were not migrated to the Mac.
- `poc/vivo-watch-gt2/docs/onboarding*.md`: removed the Windows drive-letter example while retaining the historical Windows-only procedure.

## Environment Mutations

- Installed `uv 0.11.29` in `/Users/seanlee/anaconda3/envs/BMAD`.
- Installed official Node.js 24.18.0 arm64 under `/Users/seanlee/anaconda3`; exposed `node`, `npm`, and `npx` through base and `BMAD` links after SHA-256 verification.
- Verified npm and npx 11.16.0.
- Verified Xcode 26.6 license, Apple Git 2.50.1, iOS/watchOS 26.5 SDKs.
- Installed and registered iOS 26.5 and watchOS 26.5 Simulator Runtimes.
- Left `/opt/anaconda3` and the intentionally empty `.git` directory unchanged.

## Deleted Generated State

- `.uv-python/` containing the Windows x86_64 Python runtime.
- `.uv-cache/` interpreter/package cache.
- POC `tools/__pycache__/` and `tests/__pycache__/` directories and their `.pyc` files.

## Verification Evidence

- BMAD Python: 3.11.15 native arm64.
- uv: 0.11.29 native aarch64-apple-darwin.
- Node/npm/npx: 24.18.0 / 11.16.0 / 11.16.0 in interactive zsh.
- `pip check`: no broken requirements.
- POC tests: 6/6 passed with bytecode writes disabled.
- BMAD config resolver: valid merged JSON, Chinese communication, English document output.
- Simulator registry: iOS 26.5 and watchOS 26.5 both registered.
- Repeatable verifier: exact Node path/architecture/type, Simulator Runtime IDs/builds/availability, BMAD JSON fields, Windows paths, binary architectures, uninitialized Git, secrets, and bilingual structure are machine-asserted.
- Audit artifacts: timestamped raw verification log, bilingual migration-evidence record, and post-migration SHA-256 manifest; missing pre-migration hashes are explicitly not reconstructed.

## Files to Inspect

- `AGENTS.md`
- `environment.yml`
- `environment-osx-arm64.lock`
- `.gitignore`
- `.gitattributes`
- `docs/development-setup.md`
- `docs/development-setup.zh-CN.md`
- `scripts/install-node-macos-arm64.sh`
- `scripts/verify-macos-environment.sh`
- `scripts/check-bilingual-docs.py`
- `_bmad-output/implementation-artifacts/macos-migration-evidence.md`
- `_bmad-output/implementation-artifacts/macos-migration-evidence.zh-CN.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/.memlog.md`
- `poc/vivo-watch-gt2/docs/device-baseline.md`
- `poc/vivo-watch-gt2/docs/device-baseline.zh-CN.md`
- `poc/vivo-watch-gt2/docs/onboarding.md`
- `poc/vivo-watch-gt2/docs/onboarding.zh-CN.md`
