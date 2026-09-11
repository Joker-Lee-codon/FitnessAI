#!/bin/zsh
set -eu

readonly ROOT="${0:A:h:h:h}"
readonly CHECK="${1:-}"
readonly PACKAGE="$ROOT/Packages/FitnessAICore"
readonly DERIVED_DATA="$ROOT/DerivedData"
export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"
export CLANG_MODULE_CACHE_PATH="$ROOT/.build/ModuleCache"
readonly SWIFT_SCRATCH="$ROOT/.build/FitnessAICore"
readonly IPHONE_DESTINATION="${FITNESSAI_IPHONE_DESTINATION:-platform=iOS Simulator,name=iPhone 17 Pro,OS=26.5}"
readonly WATCH_DESTINATION="${FITNESSAI_WATCH_DESTINATION:-platform=watchOS Simulator,name=Apple Watch Series 11 (46mm),OS=26.5}"

run_hosted_simulator_tests() {
  local iphone_id watch_id
  iphone_id="$(xcrun simctl create 'FitnessAI CI iPhone' 'iPhone 17 Pro' 'com.apple.CoreSimulator.SimRuntime.iOS-26-5')"
  watch_id="$(xcrun simctl create 'FitnessAI CI Watch' 'Apple Watch Series 11 (46mm)' 'com.apple.CoreSimulator.SimRuntime.watchOS-26-5')"

  cleanup_simulators() {
    xcrun simctl shutdown "$iphone_id" >/dev/null 2>&1 || true
    xcrun simctl shutdown "$watch_id" >/dev/null 2>&1 || true
    xcrun simctl delete "$iphone_id" >/dev/null 2>&1 || true
    xcrun simctl delete "$watch_id" >/dev/null 2>&1 || true
  }
  trap cleanup_simulators EXIT INT TERM

  xcrun simctl boot "$iphone_id"
  xcrun simctl bootstatus "$iphone_id" -b
  xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-iPhone -derivedDataPath "$DERIVED_DATA" -destination "id=$iphone_id" CODE_SIGNING_ALLOWED=NO ONLY_ACTIVE_ARCH=YES -parallel-testing-enabled NO test
  xcrun simctl shutdown "$iphone_id"

  xcrun simctl boot "$watch_id"
  xcrun simctl bootstatus "$watch_id" -b
  xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-Watch -derivedDataPath "$DERIVED_DATA" -destination "id=$watch_id" CODE_SIGNING_ALLOWED=NO ONLY_ACTIVE_ARCH=YES -parallel-testing-enabled NO test
  cleanup_simulators
  trap - EXIT INT TERM
}

case "$CHECK" in
  compile)
    "$ROOT/scripts/ci/check-toolchain.sh"
    xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-iPhone -derivedDataPath "$DERIVED_DATA" -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
    xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-Watch -derivedDataPath "$DERIVED_DATA" -destination 'generic/platform=watchOS Simulator' CODE_SIGNING_ALLOWED=NO build
    if [[ -n "${GITHUB_ACTIONS:-}" ]]; then
      run_hosted_simulator_tests
    else
      xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-iPhone -derivedDataPath "$DERIVED_DATA" -destination "$IPHONE_DESTINATION" CODE_SIGNING_ALLOWED=NO test
      xcodebuild -workspace "$ROOT/FitnessAI.xcworkspace" -scheme FitnessAI-Watch -derivedDataPath "$DERIVED_DATA" -destination "$WATCH_DESTINATION" CODE_SIGNING_ALLOWED=NO test
    fi
    ;;
  domain)
    "$ROOT/scripts/ci/check-dependency-boundaries.sh"
    swift test --disable-sandbox --package-path "$PACKAGE" --scratch-path "$SWIFT_SCRATCH" --filter ArchitectureTests
    ;;
  schema)
    "$ROOT/scripts/ci/check-no-speculative-content.sh"
    "$ROOT/scripts/ci/check-resolved-dependencies.sh"
    ;;
  safety)
    "$ROOT/scripts/ci/check-accessibility-shells.sh"
    swift build --disable-sandbox --package-path "$PACKAGE" --scratch-path "$SWIFT_SCRATCH" --target SafetyRules
    ;;
  persistence)
    "$ROOT/scripts/ci/check-dependency-boundaries.sh"
    swift build --disable-sandbox --package-path "$PACKAGE" --scratch-path "$SWIFT_SCRATCH" --target PersistenceGRDB
    ;;
  sync)
    swift build --disable-sandbox --package-path "$PACKAGE" --scratch-path "$SWIFT_SCRATCH" --target SyncContracts
    ;;
  ai-contract)
    ! grep -ERn '^(import|@testable import) (OpenAI|Anthropic|GoogleGenerativeAI)|URLSession|https?://' "$PACKAGE/Sources"
    swift build --disable-sandbox --package-path "$PACKAGE" --scratch-path "$SWIFT_SCRATCH" --target Contracts
    ;;
  secret)
    "$ROOT/scripts/ci/check-secrets.sh"
    ;;
  *) print -u2 "Usage: $0 {compile|domain|schema|safety|persistence|sync|ai-contract|secret}"; exit 64 ;;
esac
