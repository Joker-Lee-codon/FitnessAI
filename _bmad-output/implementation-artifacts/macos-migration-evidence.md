# macOS Migration Evidence

## Evidence Integrity

Evidence date: **2026-07-19**. The migration intent was approved by the user. After the returned review findings were remediated and reverified, the workflow specification advanced from `status: in-review` to `status: done`.

The baseline is `NO_VCS`: Git was not used on Windows and `.git` had no repository metadata. No pre-migration directory manifest or checksum set was captured before the first edits and deletions. Therefore this record cannot prove the exact historical change set, cannot prove that external `/opt/anaconda3` bytes never changed, and cannot recreate hashes of deleted caches. Those facts are stated as limitations rather than reconstructed or inferred evidence.

## Best Available Deletion Record

| Target | Contemporaneous observation before deletion | Evidence limitation | Current guard |
|---|---|---|---|
| `.uv-python/` | Contained `cpython-3.11.15-windows-x86_64-none`; approximately 79 MiB | No per-file list or hashes were preserved | Reject any recreated Windows runtime directory |
| `.uv-cache/` | uv-generated interpreter/package cache copied with the workspace | No complete pre-deletion list or architecture output was preserved | Excluded generated state; Windows paths are scanned outside it |
| `poc/vivo-watch-gt2/tools/__pycache__/` | Python bytecode cache | No pre-deletion hashes were preserved | Reject remaining `.pyc` outside excluded caches |
| `poc/vivo-watch-gt2/tests/__pycache__/` | Python test bytecode cache | No pre-deletion hashes were preserved | Tests run with `python -B` and `PYTHONDONTWRITEBYTECODE=1` |

The targets were user-authorized generated caches. No claim is made that a missing pre-deletion artifact can now be independently inspected.

## Environment and Supply-Chain Evidence

| Item | Auditable state |
|---|---|
| Conda baseline | `environment.yml` defines the minimum Python 3.11/pip/uv 0.11.29 tool baseline |
| Conda snapshot | `environment-osx-arm64.lock` records the exact Apple Silicon Conda package URLs observed on 2026-07-19 |
| Node archive | `node-v24.18.0-darwin-arm64.tar.gz` from `https://nodejs.org/dist/v24.18.0/node-v24.18.0-darwin-arm64.tar.gz` |
| Node SHA-256 | Expected and observed: `e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1` |
| Node binary | Mach-O 64-bit executable `arm64`; `process.arch` is `arm64` |
| Node exposure | Base links in `/Users/seanlee/anaconda3/bin`; equivalent links in `/Users/seanlee/anaconda3/envs/BMAD/bin` prevent activation-time shadowing |
| Simulator Runtimes | iOS 26.5 `23F77` and watchOS 26.5 `23T570`, exact runtime identifiers asserted as available |

## Repeatable Verification

`scripts/verify-macos-environment.sh` is the authoritative repeatable verifier. It records commands as executable assertions and exits nonzero on failure. `_bmad-output/implementation-artifacts/macos-migration-verification.log` contains the captured raw output, UTC start time, and exit code. `_bmad-output/implementation-artifacts/macos-migration-post-state.sha256` is the post-migration checksum manifest; it excludes itself and generated/local cache state.

The verifier covers:

- native BMAD Python and Node architecture, exact uv/Node/npm/npx versions, executable path, links, and binary type;
- non-interactive execution and interactive `conda activate BMAD` behavior;
- `pip check`, six POC tests with bytecode writes disabled, and machine-asserted BMAD language fields;
- exact iOS/watchOS runtime IDs, builds, and availability;
- Windows drive, UNC, and percent-style environment paths with documented exclusions;
- residual Windows runtime/bytecode, PE, and x86_64-only Mach-O scans;
- absence of `.git/HEAD` and required secret/signing ignore patterns;
- bilingual heading levels, tables, code blocks, links, inline code, and requirement identifiers.

## Bilingual Semantic Review

Automated equality is insufficient for translation. The English/Chinese pairs changed by this migration were manually compared for section purpose, table meaning, commands, links, paths, identifiers, and conclusions. The reviewer confirmed that the setup guide, migration specification, PRD addendum, vivo device baseline, and vivo onboarding pairs convey the same requirements and conclusions while retaining code and paths verbatim.

Future changes must run `scripts/check-bilingual-docs.py` and repeat semantic review for conclusions that machines cannot compare.

## Review Triage Outcome

| Severity | Disposition | Findings and outcome |
|---|---|---|
| High | Patched | Node disappeared after `conda activate BMAD`; added guarded BMAD links and activation/non-interactive assertions |
| High | Patched | Runtime/config checks were summaries rather than exact assertions; added exact ID/build/availability and JSON-field checks |
| Medium | Patched | Reproducibility, Node supply chain/lifecycle, clean-Mac bootstrap, retry, LF scope, ignore scope, bytecode, architecture, path-scan, and bilingual checks were incomplete |
| Medium | Recorded limitation | No pre-migration manifest or deletion hashes exist; documented without fabrication and added repeatable post-state evidence |
| Low | Patched | Review scope omitted the PRD memlog and described an in-review specification as completed; review prompts now state the workflow status and complete file scope |
