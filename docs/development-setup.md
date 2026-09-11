# FitnessAI macOS Development Setup

## Purpose and Support Policy

This guide defines the authoritative Apple Silicon Mac environment for FitnessAI. `environment.yml` is the minimum BMAD tool baseline; `environment-osx-arm64.lock` is the exact Conda package snapshot verified on this Mac. Node.js and Apple Simulator Runtimes are managed separately. The repository contains one native workspace, independent iPhone and Watch schemes, and one local Swift package.

Minimum constraints are Apple Silicon `arm64`, Python 3.11.x, uv 0.11.29, Node.js 20.12 or newer, Xcode with an accepted license, and available iOS/watchOS 26.5 Simulator Runtimes. The table below is an observed snapshot, not a promise that every patch version must remain unchanged.

## Observed Snapshot

Last fully verified: **2026-07-19**.

| Component | Observed version or location | Verification status |
|---|---|---|
| Hardware / macOS | Apple Silicon `arm64` / macOS 26.5.1 | Native and verified |
| Xcode / developer directory | 26.6 / `/Applications/Xcode.app/Contents/Developer` | Installed; license accepted |
| iOS Simulator Runtime | iOS 26.5 (`23F77`) | Available |
| watchOS Simulator Runtime | watchOS 26.5 (`23T570`) | Available |
| Authoritative Conda | `/Users/seanlee/anaconda3` | Initialized by `~/.zshrc` |
| BMAD environment | `/Users/seanlee/anaconda3/envs/BMAD` | Python 3.11.15, native `arm64` |
| uv | 0.11.29 in `BMAD` | Installed |
| Node.js / npm / npx | 24.18.0 / 11.16.0 / 11.16.0 | Official macOS arm64 distribution |
| Git repository | `main` / `https://github.com/Joker-Lee-codon/FitnessAI.git` | Initialized and connected to the private GitHub repository |
| Native workspace | `FitnessAI.xcworkspace` | iPhone and Watch schemes verified independently |
| Shared package | `Packages/FitnessAICore` | Explicit boundaries; GRDB exactly 7.11.1 |

The separate `/opt/anaconda3` installation is not used by FitnessAI and must not be changed by this project workflow.

## Clean-Mac Bootstrap

Install the Apple Silicon Anaconda distribution at `/Users/seanlee/anaconda3` and install Xcode at `/Applications/Xcode.app`. Then select Xcode, finish first-launch work, and install the exact runtime versions:

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
xcodebuild -license status
xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS -buildVersion 26.5 -architectureVariant arm64
xcodebuild -downloadPlatform watchOS -buildVersion 26.5 -architectureVariant arm64
```

Create the environment from the minimum baseline for normal maintenance:

```bash
/Users/seanlee/anaconda3/bin/conda env create -f environment.yml
scripts/install-node-macos-arm64.sh install
scripts/verify-macos-environment.sh
```

For an exact recreation of the 2026-07-19 Conda snapshot, create the Conda packages from the platform lock and then add the pinned pip tool:

```bash
/Users/seanlee/anaconda3/bin/conda create -n BMAD --file environment-osx-arm64.lock
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip install uv==0.11.29
scripts/install-node-macos-arm64.sh install
```

## Shell, BMAD, and Idempotent Updates

Interactive zsh may activate the environment normally. Node links also exist inside `BMAD`, so activation does not hide the globally installed Node distribution:

```bash
conda activate BMAD
python --version
uv --version
node --version
npm --version
npx --version
```

Non-interactive tools must use the explicit Conda executable. Restricted environments keep uv state inside the project:

```bash
export UV_CACHE_DIR="$PWD/.uv-cache"
export UV_PYTHON_INSTALL_DIR="$PWD/.uv-python"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python --version
/Users/seanlee/anaconda3/bin/conda run -n BMAD node --version
```

`conda env update` preserves undeclared packages, so it verifies the minimum baseline but does not prove an exact environment. Audit update idempotency by comparing the complete Conda and pip state before and after a second update:

```bash
audit_dir="$(mktemp -d "${TMPDIR:-/tmp}/fitnessai-conda-audit.XXXXXX")"
trap 'rm -rf "$audit_dir"' EXIT
/Users/seanlee/anaconda3/bin/conda env update -n BMAD -f environment.yml
/Users/seanlee/anaconda3/bin/conda list -n BMAD --explicit >"$audit_dir/first.conda"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip freeze >"$audit_dir/first.pip"
/Users/seanlee/anaconda3/bin/conda env update -n BMAD -f environment.yml
/Users/seanlee/anaconda3/bin/conda list -n BMAD --explicit >"$audit_dir/second.conda"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip freeze >"$audit_dir/second.pip"
diff -u "$audit_dir/first.conda" "$audit_dir/second.conda"
diff -u "$audit_dir/first.pip" "$audit_dir/second.pip"
```

## Node.js Lifecycle and Supply-Chain Record

The installer is idempotent and refuses to overwrite unexpected files or links. It exposes one distribution through the Conda base prefix and through `BMAD`.

| Field | Pinned value |
|---|---|
| Archive | `node-v24.18.0-darwin-arm64.tar.gz` |
| Download URL | `https://nodejs.org/dist/v24.18.0/node-v24.18.0-darwin-arm64.tar.gz` |
| Official checksum list | `https://nodejs.org/dist/v24.18.0/SHASUMS256.txt` |
| Expected and observed SHA-256 | `e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1` |
| Distribution directory | `/Users/seanlee/anaconda3/node-v24.18.0-darwin-arm64` |

Use these lifecycle commands:

```bash
scripts/install-node-macos-arm64.sh install
scripts/install-node-macos-arm64.sh verify
scripts/install-node-macos-arm64.sh unlink
```

`unlink` removes only links owned by the script and retains the distribution directory for recovery. To upgrade, unlink the current version, update the version, archive, URLs, and SHA-256 together in the installer, then install and verify. To roll back, restore those pinned values and run `install`; the retained prior distribution avoids a new download. Permanently deleting a retained distribution is a separate destructive action and requires an explicit target review.

## Xcode and Simulator Runtime Recovery

Verify the selected developer directory and exact registered runtimes:

```bash
xcode-select -p
xcodebuild -version
git --version
xcrun simctl list runtimes
```

If a download is interrupted, rerun the same exact-version command; do not manually delete Xcode-managed partial assets. Retry both platforms independently, and finish by running the project verifier, which requires runtime IDs and builds `iOS 26.5 (23F77)` and `watchOS 26.5 (23T570)` without an `unavailable` marker:

```bash
xcodebuild -downloadPlatform iOS -buildVersion 26.5 -architectureVariant arm64
xcodebuild -downloadPlatform watchOS -buildVersion 26.5 -architectureVariant arm64
scripts/verify-macos-environment.sh
```

## Project Verification and Audit Evidence

Open `FitnessAI.xcworkspace`, not the project file. Simulator builds and tests require no signing team or credentials. Run the complete provider-neutral check contract with:

```bash
scripts/ci/run-all.sh
```

Run focused native validation with:

```bash
xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-iPhone -derivedDataPath DerivedData -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-Watch -derivedDataPath DerivedData -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO build
xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-iPhone -derivedDataPath DerivedData -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5' CODE_SIGNING_ALLOWED=NO test
xcodebuild -workspace FitnessAI.xcworkspace -scheme FitnessAI-Watch -derivedDataPath DerivedData -destination 'platform=watchOS Simulator,name=Apple Watch Series 11 (46mm),OS=26.5' CODE_SIGNING_ALLOWED=NO test
```

GitHub Actions uses the explicit Apple Silicon `macos-26` runner, selects `/Applications/Xcode_26.6.app/Contents/Developer`, grants only read access to repository contents, and exposes eight unique checks: `compile`, `domain`, `schema`, `safety`, `persistence`, `sync`, `ai-contract`, and `secret`. The pull-request workflow is simulator-only and does not use signing, deployment, provider, or application secrets.

Run the repeatable verifier from the project root and preserve its timestamp, exit code, and raw output:

```bash
started_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
scripts/verify-macos-environment.sh 2>&1 | tee _bmad-output/implementation-artifacts/macos-migration-verification.log
exit_code="${pipestatus[1]}"
printf 'started_at=%s\nexit_code=%s\n' "$started_at" "$exit_code" | tee -a _bmad-output/implementation-artifacts/macos-migration-verification.log
test "$exit_code" -eq 0
```

The verifier uses `python -B` and `PYTHONDONTWRITEBYTECODE=1`, asserts BMAD JSON fields, verifies Node path/architecture/type, requires exact Simulator Runtime IDs/builds, scans for PE and x86_64-only Mach-O artifacts, checks secret-file ignore coverage, verifies Git `main` and `origin`, checks both shared schemes, validates local-package dependency direction, and confirms the workspace lock resolves GRDB 7.11.1. Its Windows-path scan excludes only `.git`, `.npm-cache`, `.uv-cache`, `.uv-python`, and the verifier source that contains the scan expression itself.

Automated structure checks cannot prove translation meaning. The migration evidence records the required human semantic review of sections, tables, commands, links, identifiers, and conclusions.

## Migration Evidence Limits

No version-control baseline or pre-migration manifest existed, so the exact historical diff and claims that external `/opt/anaconda3` contents were unchanged cannot be proven retroactively. The same limitation applies to complete pre-deletion hashes for removed caches. The evidence document records the contemporaneous observations that are available and a post-migration checksum manifest; it does not fabricate missing history.

Windows Python, uv, and bytecode caches are generated state and must not be retained. Historical vivo POC conclusions remain truthful, but obsolete Windows absolute paths are replaced with migration status rather than invented Mac paths. The vivo route is outside initial launch scope; the active route is Apple Watch plus iPhone. Git and hosted CI were initialized only after explicit Product Owner authorization for Story 1.1.
