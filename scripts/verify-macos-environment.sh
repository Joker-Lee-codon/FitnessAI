#!/bin/zsh
set -eu

readonly PROJECT_ROOT="${0:A:h:h}"
readonly CONDA_ROOT="${FITNESSAI_CONDA_ROOT:-/Users/seanlee/anaconda3}"
readonly CONDA="${CONDA_ROOT}/bin/conda"
readonly BMAD_BIN="${CONDA_ROOT}/envs/BMAD/bin"
readonly NODE_DIR="${CONDA_ROOT}/node-v24.18.0-darwin-arm64"
readonly CONFIG_OUTPUT="$(mktemp "${TMPDIR:-/tmp}/fitnessai-config.XXXXXX")"
trap 'rm -f "$CONFIG_OUTPUT"' EXIT

pass() { print -- "PASS: $*"; }
fail() { print -u2 -- "FAIL: $*"; exit 1; }

cd "$PROJECT_ROOT"

[[ "$(uname -m)" == "arm64" ]] || fail "host architecture is not arm64"
[[ "$($CONDA run -n BMAD python -c 'import platform; print(platform.machine())')" == "arm64" ]] || fail "BMAD Python is not arm64"
[[ "$($CONDA run -n BMAD python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')" == "3.11" ]] || fail "BMAD Python is not 3.11"
[[ "$($CONDA run -n BMAD uv --version)" == "uv 0.11.29 "* ]] || fail "uv version mismatch"
pass "BMAD Python 3.11 arm64 and uv 0.11.29"

scripts/install-node-macos-arm64.sh verify >/dev/null
[[ "$($CONDA run -n BMAD node -p 'process.arch')" == "arm64" ]] || fail "BMAD Node is not arm64"
[[ "$($CONDA run -n BMAD node --version)" == "v24.18.0" ]] || fail "BMAD Node version mismatch"
[[ "$(zsh -fc "$CONDA run -n BMAD node --version")" == "v24.18.0" ]] || fail "non-interactive zsh cannot run BMAD Node"
activated_node="$(zsh -ic 'conda activate BMAD && command -v node' 2>/dev/null)"
[[ "$activated_node" == "${BMAD_BIN}/node" ]] || fail "activated BMAD resolves unexpected Node path: $activated_node"
[[ "$(readlink "$activated_node")" == "${NODE_DIR}/bin/node" ]] || fail "BMAD Node link target mismatch"
pass "Node/npm/npx are arm64 and available before and after BMAD activation"

$CONDA run -n BMAD python -m pip check >/dev/null
PYTHONDONTWRITEBYTECODE=1 $CONDA run -n BMAD python -B -m unittest discover -s poc/vivo-watch-gt2/tests -p 'test_*.py' >/dev/null
pass "pip check and six Python POC tests"

$CONDA run -n BMAD python _bmad/scripts/resolve_config.py --project-root . >"$CONFIG_OUTPUT"
$CONDA run -n BMAD python - "$CONFIG_OUTPUT" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as stream:
    config = json.load(stream)
assert config["core"]["communication_language"] == "Chinese", config
assert config["core"]["document_output_language"] == "English", config
PY
pass "BMAD config JSON and required language fields"

runtime_output="$(xcrun simctl list runtimes)"
ios_line="$(print -r -- "$runtime_output" | grep -F 'iOS 26.5 (26.5 - 23F77) - com.apple.CoreSimulator.SimRuntime.iOS-26-5')" || fail "iOS 26.5 runtime/build is missing"
watch_line="$(print -r -- "$runtime_output" | grep -F 'watchOS 26.5 (26.5 - 23T570) - com.apple.CoreSimulator.SimRuntime.watchOS-26-5')" || fail "watchOS 26.5 runtime/build is missing"
print -r -- "$ios_line\n$watch_line" | grep -qi 'unavailable' && fail "required Simulator Runtime is unavailable"
pass "iOS 26.5 (23F77) and watchOS 26.5 (23T570) runtimes are available"

windows_matches="$(rg -n -P '(?i:[a-z]:\\[^\\\r\n]+)|\\\\[A-Za-z0-9._-]+\\|%(?i:(?:[a-z_][a-z0-9_]{2,}|cd))%' . \
  --glob '!.git/**' --glob '!.npm-cache/**' --glob '!.uv-cache/**' --glob '!.uv-python/**' \
  --glob '!.build/**' --glob '!DerivedData/**' \
  --glob '!scripts/verify-macos-environment.sh' || true)"
[[ -z "$windows_matches" ]] || fail "Windows absolute paths remain:\n$windows_matches"
[[ -f .git/HEAD ]] || fail "Git repository is not initialized"
git show-ref --verify --quiet refs/heads/main || fail "local main branch is missing"
git show-ref --verify --quiet refs/remotes/origin/main || fail "origin/main tracking branch is missing"
[[ "$(git remote get-url origin)" == "https://github.com/Joker-Lee-codon/FitnessAI.git" ]] || fail "origin remote mismatch"
[[ ! -d .uv-python/cpython-3.11.15-windows-x86_64-none ]] || fail "Windows uv Python runtime remains"
[[ -z "$(find . -path './.git' -prune -o -path './.npm-cache' -prune -o -path './.uv-cache' -prune -o -path './.build' -prune -o -path './DerivedData' -prune -o -name '*.pyc' -print -quit)" ]] || fail "Python bytecode remains"
pass "Windows paths/caches are absent and Git main/origin remain configured from the current work branch"

binary_failure=""
while IFS= read -r -d '' artifact_path; do
  description="$(file "$artifact_path")"
  if [[ "$description" == *"PE32"* ]] || { [[ "$description" == *"Mach-O 64-bit executable x86_64"* ]] && [[ "$description" != *"arm64"* ]]; }; then
    binary_failure+="${description}\n"
  fi
done < <(find . -type f -not -path './.git/*' -not -path './.npm-cache/*' -not -path './.uv-cache/*' -not -path './.uv-python/*' -not -path './.build/*' -not -path './DerivedData/*' -print0)
[[ -z "$binary_failure" ]] || fail "unsupported binary artifacts:\n$binary_failure"
pass "no PE or x86_64-only Mach-O artifacts"

for pattern in '.env' '.env.*' '*.pem' '*.key' '*.p8' '*.p12' '*.mobileprovision'; do
  grep -Fxq "$pattern" .gitignore || fail "missing secret ignore pattern: $pattern"
done
pass "secret and signing-file ignore coverage"

[[ -f FitnessAI.xcworkspace/contents.xcworkspacedata ]] || fail "FitnessAI workspace is missing"
[[ -f FitnessAI.xcodeproj/project.pbxproj ]] || fail "FitnessAI Xcode project is missing"
[[ -f Packages/FitnessAICore/Package.swift ]] || fail "FitnessAICore local package is missing"
for scheme in FitnessAI-iPhone FitnessAI-Watch; do
  [[ -f "FitnessAI.xcodeproj/xcshareddata/xcschemes/${scheme}.xcscheme" ]] || fail "missing shared scheme: $scheme"
done
scripts/ci/check-toolchain.sh
scripts/ci/check-dependency-boundaries.sh
scripts/ci/check-no-speculative-content.sh
scripts/ci/check-resolved-dependencies.sh
scripts/ci/check-accessibility-shells.sh
pass "workspace, schemes, module boundaries, GRDB lock, and accessibility shell contract"

$CONDA run -n BMAD python scripts/check-bilingual-docs.py \
  _bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.md _bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.zh-CN.md \
  _bmad-output/implementation-artifacts/macos-migration-evidence.md _bmad-output/implementation-artifacts/macos-migration-evidence.zh-CN.md \
  _bmad-output/implementation-artifacts/review-blind-hunter-macos-migration.md _bmad-output/implementation-artifacts/review-blind-hunter-macos-migration.zh-CN.md \
  _bmad-output/implementation-artifacts/review-edge-case-hunter-macos-migration.md _bmad-output/implementation-artifacts/review-edge-case-hunter-macos-migration.zh-CN.md \
  _bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md _bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md \
  poc/vivo-watch-gt2/docs/device-baseline.md poc/vivo-watch-gt2/docs/device-baseline.zh-CN.md \
  poc/vivo-watch-gt2/docs/onboarding.md poc/vivo-watch-gt2/docs/onboarding.zh-CN.md
pass "machine-verifiable bilingual structure"

pass "all macOS migration checks completed"
