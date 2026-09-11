---
title: 'Migrate the FitnessAI development environment from Windows to macOS'
type: 'chore'
created: '2026-07-19'
status: 'done'
baseline_commit: 'NO_VCS'
review_loop_iteration: 0
context:
  - '{project-root}/AGENTS.md'
  - '{project-root}/_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** FitnessAI was moved from Windows to an Apple Silicon Mac, but the project still records Windows-only Conda paths and contains Windows Python caches. The Mac has a working native `BMAD` Conda environment and licensed Xcode, but `uv`, Node.js/npm/npx are missing; the empty `.git` directory is intentional because the project did not use Git on Windows.

**Approach:** Make the Mac the authoritative development platform, define a reproducible `BMAD` environment, install `uv` into `BMAD`, install Node.js/npm/npx into the zsh-default global Conda base environment, add macOS/Xcode hygiene, replace Windows absolute paths with truthful Mac-local state, synchronize English and Chinese documentation, and remove all verified Windows Python caches.

## Boundaries & Constraints

**Always:** Use `/Users/seanlee/anaconda3/bin/conda`; keep BMAD Python at 3.11.x and `uv` at 0.11.29; install Node.js 20.12 or newer plus npm/npx in the user-scoped Conda base environment so interactive zsh exposes them globally; keep every English formal document synchronized with a `.zh-CN.md` counterpart; preserve historical conclusions while removing obsolete Windows absolute paths; use project-local uv caches in restricted environments; verify on native `arm64`.

**Ask First:** Any deletion outside verified `.uv-python`, `.uv-cache`, `__pycache__`, and `.pyc` cache targets; deleting either Conda installation; initializing Git metadata; installing software outside the user-scoped Anaconda installation.

**Never:** Fabricate a Mac path for a Windows-only artifact that was not migrated; edit installer-managed `_bmad/config.toml` or generated skill files; remove `/opt/anaconda3`; initialize the intentionally empty `.git` directory; retain executable Windows Python caches.

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| Mac interactive shell | zsh sources `~/.zshrc` | `conda activate BMAD` selects the native arm64 Python 3.11 environment | Use the explicit Conda executable for non-interactive tools |
| Missing BMAD tools | `uv`, Node.js, npm, and npx are absent | `environment.yml` adds pinned uv to `BMAD`; Conda base receives supported Node.js plus npm/npx | Stop and report network/solver failures without replacing Conda |
| Licensed Xcode | Xcode 26.6 license was accepted by the user | Xcode, Git shim, SDK, and simulator queries succeed | Report any remaining first-launch component blocker accurately |
| Copied Windows caches | Windows `.uv-python`, `.uv-cache`, `__pycache__`, or `.pyc` entries exist | Remove all verified generated Windows/Python caches | Validate target types and keep source artifacts |
| Intentionally uninitialized Git | `.git` exists but is empty because Git was never used | Leave it unchanged and document that version control is not initialized | Do not initialize a repository implicitly |

</frozen-after-approval>

## Code Map

- `AGENTS.md` -- authoritative project execution rules and BMAD environment memory.
- `environment.yml` -- minimum cross-machine definition of the `BMAD` Conda tool baseline.
- `environment-osx-arm64.lock` -- exact verified Conda package snapshot for Apple Silicon.
- `.gitignore` -- macOS, Python, uv/npm, and Xcode generated-file exclusions.
- `.gitattributes` -- stable LF normalization for source and documentation files.
- `scripts/install-node-macos-arm64.sh` -- pinned, checksummed, idempotent Node.js installer and link lifecycle.
- `scripts/verify-macos-environment.sh`, `scripts/check-bilingual-docs.py` -- repeatable environment and bilingual-structure assertions.
- `docs/development-setup.md` -- English Mac bootstrap and verification guide.
- `docs/development-setup.zh-CN.md` -- structurally equivalent Chinese setup guide.
- `_bmad-output/implementation-artifacts/macos-migration-evidence*.md` -- bilingual evidence record and explicit historical limitations.
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum*.md` -- bilingual current platform prerequisite statement.
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/.memlog.md` -- append-only record of the Mac acquisition update.
- `.uv-python/`, `.uv-cache/`, `**/__pycache__/`, `**/*.pyc` -- generated caches to clear before native Mac use.

## Tasks & Acceptance

**Execution:**
- [x] `AGENTS.md` -- replace Windows paths and legacy shell instructions with the verified Mac/zsh/Conda workflow; record Node, uv, Xcode, cache, and architecture rules.
- [x] `environment.yml` -- define Python 3.11, pip, and `uv==0.11.29`; update `BMAD` without pruning unrelated packages, then install Node.js >=20.12 plus npm/npx into the zsh-default Conda base environment.
- [x] `.gitignore`, `.gitattributes` -- add macOS/Xcode/cache exclusions and LF normalization without touching historical content.
- [x] `docs/development-setup.md`, `docs/development-setup.zh-CN.md` -- document bootstrap, verification, accepted Xcode state, duplicate-Conda policy, intentionally uninitialized Git, and current absence of an Apple app project.
- [x] `addendum.md`, `addendum.zh-CN.md`, `.memlog.md` -- change the Mac prerequisite from future acquisition to completed availability and preserve the decision trail.
- [x] `poc/vivo-watch-gt2/docs/*.md`, `.uv-python/`, `.uv-cache/`, `**/__pycache__/`, `**/*.pyc` -- remove Windows absolute paths from documentation without inventing missing Mac installs, and delete all verified Windows/Python caches.
- [x] Review remediation -- keep Node available after `conda activate BMAD`; add exact Node/runtime/config/architecture assertions, clean-Mac recovery steps, bilingual structure checks, and an auditable verification log without fabricating pre-migration evidence.

**Acceptance Criteria:**
- Given the updated environments, when tool versions are checked, then BMAD Python is 3.11.x, BMAD uv is 0.11.29, and interactive zsh exposes global Node.js >=20.12 plus npm/npx.
- Given the user has accepted the Xcode license, when Xcode, Git shim, and simulator tooling are queried, then they run without the license blocker.
- Given the migrated workspace, when project text is scanned, then it contains no Windows absolute paths; historical vivo POC conclusions remain truthful and explicitly historical.
- Given the Python POC, when its test suite runs in `BMAD`, then all six existing tests pass and `pip check` reports no broken requirements.
- Given any updated English formal document, when its Chinese counterpart is inspected, then headings, commands, paths, conclusions, and requirement meaning remain aligned.

## Spec Change Log

- 2026-07-19 review remediation: classified the returned Blind Hunter and Edge Case Hunter findings. Patched the Node activation failure and verification/documentation gaps; added a minimum-baseline versus exact-lock distinction; recorded the unavailable pre-migration manifest and cache hashes as a non-reconstructable evidence limitation. The frozen intent was unchanged and `review_loop_iteration` remains `0`.

## Design Notes

The user-scoped Anaconda installation is authoritative because it owns the verified native `BMAD` environment and is initialized for zsh. Its base environment is the approved global location for Node.js/npm/npx. The separate `/opt/anaconda3` installation is left untouched. The empty `.git` directory is intentional. All verified Windows uv/Python caches are removed, while historical POC conclusions are preserved without obsolete absolute paths.

## Verification

**Commands:**
- `scripts/install-node-macos-arm64.sh verify` -- expected: pinned Node/npm/npx versions and native arm64 binary.
- `scripts/verify-macos-environment.sh` -- expected: all machine-verifiable Conda, Node, Python test, BMAD config, Simulator Runtime, Windows-path/cache, binary-architecture, secret-ignore, uninitialized-Git, and bilingual-structure assertions pass.
- See `_bmad-output/implementation-artifacts/macos-migration-verification.log` for timestamped raw output and exit code.

**Manual checks:**
- Semantically compare the bilingual sections, tables, code, links, identifiers, and conclusions; automated structure equality alone is not translation proof.
- Accept the explicit evidence limitation that no pre-migration checksum/tree snapshot or deleted-cache hashes can be reconstructed after the fact.

## Suggested Review Order

**Intent and operating model**

- Start with the user-approved migration boundaries and platform authority.
  [`spec-migrate-windows-development-environment-to-macos.md:15`](spec-migrate-windows-development-environment-to-macos.md#L15)

- Separate the minimum baseline, exact snapshot, and clean-Mac bootstrap.
  [`development-setup.md:3`](../../docs/development-setup.md#L3)

- Inspect the exact Apple Silicon Conda package snapshot.
  [`environment-osx-arm64.lock:1`](../../environment-osx-arm64.lock#L1)

**Toolchain lifecycle**

- Review pinned Node provenance, guarded links, and recoverable unlink behavior.
  [`install-node-macos-arm64.sh:4`](../../scripts/install-node-macos-arm64.sh#L4)

- Confirm activation and non-interactive execution resolve one arm64 Node distribution.
  [`verify-macos-environment.sh:27`](../../scripts/verify-macos-environment.sh#L27)

**Verification and auditability**

- Exact runtime identifiers and builds prevent false-positive Simulator readiness.
  [`verify-macos-environment.sh:48`](../../scripts/verify-macos-environment.sh#L48)

- Windows-path and binary scans guard migrated source state.
  [`verify-macos-environment.sh:54`](../../scripts/verify-macos-environment.sh#L54)

- Evidence limitations are explicit; post-state checks never fabricate history.
  [`macos-migration-evidence.md:3`](macos-migration-evidence.md#L3)

**Documentation and hygiene**

- Bilingual signatures catch structural, link, code, and identifier drift.
  [`check-bilingual-docs.py:23`](../../scripts/check-bilingual-docs.py#L23)

- LF normalization and scoped generated-file ignores close platform hygiene gaps.
  [`.gitattributes:1`](../../.gitattributes#L1)
