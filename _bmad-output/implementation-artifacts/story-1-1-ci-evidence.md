# Story 1.1 CI and Launch Evidence

## Authorized repository contract

- Repository: private `Joker-Lee-codon/FitnessAI`
- Default branch: `main`
- CI: GitHub Actions on Apple Silicon `macos-26`
- Xcode selection: `/Applications/Xcode_26.6.app/Contents/Developer`
- Simulator path: no signing team, certificate, provisioning profile, deployment secret, provider secret, or application secret
- Bundle identifiers: `com.fitnessai.ios` and `com.fitnessai.watch`
- Required check names: `compile`, `domain`, `schema`, `safety`, `persistence`, `sync`, `ai-contract`, `secret`

The machine-readable counterpart is `.github/required-checks.json`. Hosted enforcement evidence is recorded only after the GitHub rule is saved and observed.

## Local verification

Verified on Apple Silicon `arm64` with Xcode 26.6 build `17F113` and Apple Swift 6.3.3:

- `scripts/verify-macos-environment.sh`: passed, including the pre-existing BMAD, Node, POC, simulator-runtime, cache, binary-architecture, secret-ignore, and historical bilingual checks.
- `scripts/ci/run-check.sh domain`: passed; Swift Testing executed the package architecture seed test.
- `scripts/ci/run-check.sh schema`, `safety`, `persistence`, `sync`, `ai-contract`, and `secret`: passed.
- `FitnessAI-iPhone`: independent simulator build passed; two tests passed, including Plan-root truth and Dark Mode/accessibility Dynamic Type rendering.
- `FitnessAI-Watch`: independent simulator build passed; two tests passed, including no-delivered-Plan truth and Dark Mode/accessibility Dynamic Type rendering.
- Simulator launch: both bundles installed and launched successfully without signing.
- Visual evidence: iPhone Light/Dark Mode with accessibility-extra-extra-extra-large text and increased contrast was inspected; the Plan root and all four native tabs remained legible without color-only meaning. Watch launch was inspected at its truthful no-delivered-Plan state. The watchOS 26.5 simulator reports appearance, contrast, and Dynamic Type mutation through `simctl ui` as unsupported, so the Watch accessibility variants are covered by deterministic SwiftUI environment rendering tests plus semantic dynamic assets rather than a false simulator-toggle claim.

Local screenshots are generated under `.artifacts/story-1-1/` and intentionally ignored because CI/result artifacts must not enter source control. They contain only seed-shell text and no user, Health, sensor, workout, AI, or free-text data.

## Scope proof

- GRDB is resolved exactly at 7.11.1 and imported only by `PersistenceGRDB`.
- Domain boundaries contain no SwiftUI, GRDB, HealthKit, WatchConnectivity, Core Motion, AI-provider, or application-target import.
- No database migration, table, product entity, Health/sensor/AI integration, workout fact, fake recognition result, secret, or signing material was introduced.
- GATE-1 through GATE-7 remain fail closed; this Story does not change capability gate flags.

## Hosted enforcement

Pending the first pushed workflow run and repository rule configuration. This section must be updated with the observed GitHub evidence before the Story moves to `review`.
