---
baseline_commit: NO_VCS
---

# Story 1.1: Launch the Runnable iPhone, Watch, and Shared-Contract Workspace

Status: done

Classification: Enabler  
Implementation slice: S0  
Story key: `1-1-launch-the-runnable-iphone-watch-and-shared-contract-workspace`

<!-- Validation is required before dev-story because this Story carries the AD-13 CI acceptance overlay. -->

## Story

As a Product Owner,  
I want a launchable iPhone and Apple Watch private-Alpha shell with enforced shared-package boundaries,  
so that every later workout capability is built on one runnable native product without creating incompatible truth models.

## Acceptance Criteria

### AC1 — Runnable native workspace and pinned dependency

**Given** a clean checkout on the specified Apple Silicon development environment  
**When** the developer opens and builds the FitnessAI workspace with Xcode 26.6 and Swift 6.3.3  
**Then** the iPhone and Watch app targets both compile and launch  
**And** the workspace uses one local Swift Package with explicit `Contracts`, domain, application-use-case, persistence-port, synchronization-contract, safety-rule, and analysis targets  
**And** GRDB is pinned exactly to 7.11.1 with the resolved dependency committed.

### AC2 — Enforced dependency direction

**Given** the shared-package dependency graph  
**When** dependency-direction tests inspect every domain target  
**Then** no domain target imports SwiftUI, GRDB, HealthKit, WatchConnectivity, Core Motion, an AI-provider framework, or an application target  
**And** adapters depend inward through named ports only  
**And** no generic `Utils` target is introduced.

### AC3 — Truthful iPhone shell

**Given** the iPhone app launches without an existing Plan or Workout Session  
**When** the Product Owner reaches the root experience  
**Then** Plan is selected within native Plan, History, Analysis, and More navigation  
**And** unfinished capabilities use truthful native empty states rather than developer placeholders or discoverable deferred-feature controls  
**And** contextual navigation uses typed destinations suitable for later object, filter, scroll-position, and non-effective-input restoration.

### AC4 — Truthful Watch shell

**Given** the Watch app has no compatible delivered Plan  
**When** it launches  
**Then** it shows a truthful no-delivered-Plan state  
**And** it exposes no partial Plan, simulated recognition, or nonfunctional future capability.

### AC5 — Accessibility and appearance floor

**Given** Light Mode, Dark Mode, increased text size, VoiceOver, Reduce Motion, or Differentiate Without Color is enabled  
**When** the launch and empty states are inspected  
**Then** semantic Titanium Measure tokens and native SwiftUI behavior are used  
**And** required state and navigation meaning remains available without relying only on color, motion, haptics, gestures, or Digital Crown.

### AC6 — Strict seed scope

**Given** this Story is only the repository and contract seed  
**When** its persistence content is inspected  
**Then** it creates no speculative tables or entities for future Stories  
**And** it stores no secrets, Health data, sensor data, AI content, or workout facts.

### AC7 — AD-13 Apple Silicon/macOS CI and required checks

**Given** the repository has an explicitly selected hosting and CI platform  
**When** a pull request or equivalent candidate change is evaluated on Apple Silicon macOS  
**Then** CI asserts `arm64`, Xcode 26.6 build `17F113`, and Apple Swift 6.3.3 instead of trusting a drifting “latest” label  
**And** it independently builds the iPhone and Watch schemes and tests the local Swift Package  
**And** uniquely named required checks cover compile, domain, schema, safety, persistence, sync, AI contract, and secrets  
**And** a required check that fails or is absent prevents merge  
**And** retained logs and result bundles contain no secrets, request bodies, free text, Health values, raw signals, Exercise/load/RPE content, or other user data  
**And** the untrusted pull-request path runs simulator-only build and tests with read-only minimum permissions and no signing, deployment, provider, or application secrets.

**Given** the current workspace has no initialized Git repository, remote, or selected hosting platform  
**When** Story 1.1 implementation begins  
**Then** provider-neutral local check entrypoints and a required-check manifest may be created first  
**But** Story 1.1 cannot be marked `done` until the Product Owner authorizes repository initialization/hosting, the selected platform enforces the named required checks, and evidence of that enforcement is recorded  
**And** GitHub Actions, GitHub branch protection, or any other provider is not claimed as selected before that decision exists.

### AC8 — Existing environment verification remains truthful

**Given** the current environment verifier and development guide intentionally assert that Git is uninitialized and that no Xcode project exists  
**When** the repository and workspace are initialized for this Story  
**Then** those assertions are replaced or isolated as historical migration evidence  
**And** the verifier continues to enforce the existing BMAD environment, Apple Silicon architecture, Xcode/simulator runtime, secret-ignore, cache, binary-architecture, and POC checks  
**And** it adds machine-verifiable checks for the workspace, both app schemes, local package boundaries, toolchain versions, and resolved GRDB version  
**And** documentation never reports CI, a remote, signing, or required-check enforcement before it is actually configured.

## Tasks / Subtasks

- [x] Resolve implementation authorities that cannot be inferred locally (AC: 1, 7, 8)
  - [x] Obtain Product Owner decisions for permanent bundle identifiers, Apple development-team/signing ownership, Git initialization, repository host, default branch, and CI provider.
  - [x] Do not create a remote repository, configure hosted branch protection, upload signing material, or initialize Git without the required user authorization.
  - [x] Record the chosen CI runner image/label, immutable Xcode selection method, required check names, and evidence location.
- [x] Create the single native workspace with independent iPhone and Watch targets (AC: 1, 3, 4, 5)
  - [x] Create one workspace/project carrier, shared schemes, iPhone app target, Watch app target, unit-test targets, and the minimum launch configuration.
  - [x] Set deployment baselines to iOS 18+ and watchOS 11+; compile with Swift 6 language mode where supported by the bound toolchain.
  - [x] Keep simulator build/test free of signing credentials; isolate device signing from the untrusted PR path.
  - [x] Verify the iPhone and Watch schemes separately. An iPhone build is not evidence that the Watch target builds.
- [x] Create the local Swift Package boundary (AC: 1, 2, 6)
  - [x] Add explicit targets/products for contracts, domain, application use cases, persistence ports, synchronization contracts, safety rules, and analysis; use clear capability names rather than a generic `Utils`.
  - [x] Keep domain targets framework-free and make dependency direction visible in `Package.swift`.
  - [x] Add only seed types required to prove module wiring; do not define future business entities, tables, schemas, provider routes, Health types, sensor models, or workout facts.
  - [x] Add dependency-direction tests or a deterministic source check for every forbidden import in AC2.
- [x] Pin GRDB without leaking it into the domain (AC: 1, 2, 6)
  - [x] Use the official `https://github.com/groue/GRDB.swift.git` package at exact version `7.11.1` because the Architecture Spine chooses reproducibility over a version range.
  - [x] Link the `GRDB` product only from an adapter/infrastructure boundary that needs it; never import GRDB from a domain target.
  - [x] Commit the workspace-level `Package.resolved` and add a check that fails if the resolved GRDB version differs from 7.11.1.
  - [x] Do not use `swift-tools-version` as proof that Apple Swift patch version 6.3.3 is pinned.
- [x] Implement the truthful iPhone shell (AC: 3, 5, 6)
  - [x] Use native SwiftUI `TabView`/navigation with Plan, History, Analysis, and More; Plan is the selected root.
  - [x] Use typed `NavigationStack` destinations without inventing nonfunctional routes.
  - [x] Render truthful empty states using semantic Titanium Measure assets/tokens and SF Symbols; do not parse HTML/CSS prototypes at runtime.
  - [x] Do not copy the older design-system “Today” navigation wording; Story 1.1, the current Native UI spec, and AD-14 govern.
- [x] Implement the truthful Watch shell (AC: 4, 5, 6)
  - [x] Show only the no-compatible-delivered-Plan state and a valid native recovery/help boundary if required.
  - [x] Do not show simulated Plan content, recognition, RPE, sensor, synchronization success, or future controls.
  - [x] Keep Digital Crown optional and ensure VoiceOver and touch expose all required meaning.
- [x] Establish the AD-13 local and hosted check contract (AC: 2, 5, 7)
  - [x] Create stable local entrypoints for compile, domain, schema, safety, persistence, sync, AI-contract, and secret checks.
  - [x] At this seed stage, each check must perform a meaningful module/build/boundary assertion; an empty or unconditional-success job is not acceptable.
  - [x] Build both platforms and run package/unit/UI launch smoke tests on Apple Silicon macOS.
  - [x] If GitHub is selected, use an explicit Apple Silicon macOS 26 runner and explicit Xcode 26.6 selection; use `pull_request` with minimum read permissions and do not execute untrusted code through `pull_request_target`.
  - [x] Configure the selected repository host so the unique check names are actually required, then retain privacy-safe evidence.
- [x] Reconcile environment verification and developer setup (AC: 1, 7, 8)
  - [x] Update `scripts/verify-macos-environment.sh` so repository initialization no longer makes the project verifier fail, while preserving every unrelated existing assertion.
  - [x] Update `docs/development-setup.md` from “no Xcode project / Git uninitialized” to the verified current state and add exact local build/test commands.
  - [x] Preserve `.gitignore` secret patterns and generated-state exclusions; add `*.xcresult`, `*.xcarchive`, or other new generated outputs only if the implementation produces them.
  - [x] Do not modify the historical Vivo POC or include it in Apple app targets.
- [x] Validate the complete seed and collect evidence (AC: 1–8)
  - [x] Run the environment verifier, local package tests, dependency-boundary checks, iPhone build/launch smoke test, Watch build/launch smoke test, and every AD-13 check.
  - [x] Verify a clean checkout resolves GRDB 7.11.1 and produces no untracked generated or secret material.
  - [x] Exercise Light/Dark, Dynamic Type, VoiceOver, Reduce Motion, and Differentiate Without Color on both empty-state shells; retain privacy-safe evidence.
  - [x] Prove that no database table, Health/sensor/AI integration, workout fact, fake recognition result, or GATE-1–7 enablement was introduced.

## Dev Notes

### Developer Context

This is the greenfield Apple implementation seed. The repository contains product/UX/architecture artifacts, environment tooling, a historical Vivo POC, and HTML design review carriers, but no production Xcode project, workspace, Swift Package, app target, app source, Swift tests, CI workflow, Git history, branch, or remote.

Story 1.1 must leave one real native product skeleton that later Stories can extend without redefining truth. It does not implement a thin vertical workout slice, persistence schema, synchronization, AI, HealthKit, sensors, recognition, RPE, or release Gate. The shell must be truthful precisely because those capabilities do not yet exist.

The current `.git` directory is empty. `scripts/verify-macos-environment.sh` and `docs/development-setup.md` encode that uninitialized state as a migration-era invariant. Treat those files as UPDATE targets when Git/workspace initialization is authorized; do not delete their other environment checks.

### Non-Negotiable Technical Requirements

- Host and CI execution architecture: Apple Silicon `arm64`.
- Bound toolchain: Xcode 26.6 build `17F113`; Apple Swift 6.3.3. Verify them at runtime.
- Platform baseline: iPhone 11+/iOS 18+ and Apple Watch Series 6+/watchOS 11+; capability-specific device evidence remains later work.
- UI: native SwiftUI, semantic Titanium Measure assets, system fonts, SF Symbols, typed navigation, thin presentation state.
- Repository shape: one workspace/repository, separate iPhone and Watch app targets, one local Swift Package.
- Package architecture: presentation → application use cases → domain/ports; adapters point inward. Domain targets do not import platform, database, transport, sensor, or provider frameworks.
- Dependency: GRDB 7.11.1 exact, with `Package.resolved` committed. Exact pinning is an intentional architecture constraint even though SwiftPM generally favors compatible ranges.
- Local package path dependencies are fixed by the same repository revision, not by a semantic-version rule.
- All high-risk capabilities remain fail closed. Story status changes do not modify `capability_gates.*.implemented`, `evidence_passed`, or `feature_enabled`.
- No production secret, signing identity, provisioning profile, API key, Health value, AI body, user free text, or raw signal may enter source control, ordinary logs, or CI artifacts.

### Architecture Compliance

- **AD-1:** Domain targets are framework-free; adapters cannot bypass ports or create a second business-rule owner.
- **AD-12:** Use a modular-monolith seed, not multiple repositories, shared UI, shared database files, or Swift-shaped future Android contracts.
- **AD-13:** Every change runs the named check set; Alpha claims need platform-appropriate evidence and privacy-safe logs.
- **AD-14:** The accepted Native UI/Titanium Measure contract governs presentation.
- The Architecture Spine is a structural seed, not a permanent folder mandate. Equivalent paths are allowed only when module ownership and dependency direction remain obvious and the deviation is recorded.
- No speculative database schema is permitted. Story 1.4 owns the first persistence foundation; later capability Stories own their business tables.

### Boundaries with Subsequent Stories

- **Story 1.2** owns stable IDs, load/unit semantics, version fields, platform-neutral schemas, canonical serialization/digests, and cross-target golden fixtures. Story 1.1 creates only the module/target boundary and test entrypoint for those contracts.
- **Story 1.3** owns the revision DAG, effective-value reducer, conflict policy, and property/golden-vector behavior. Story 1.1 must not introduce revision logic or conflict UI.
- **Story 1.4** owns the iPhone GRDB store, schema metadata, revision/outbox/invalidation/idempotency foundations, transactions, protection, and recovery. Story 1.1 pins and resolves GRDB only; it must not create a database, migration, table, or row type.
- **Story 1.5** owns the versioned Exercise Catalog, search/detail/support boundaries, and RPE explanation. Story 1.1 must not add Catalog content or teaching UI.
- Later Stories own Plans, Workouts, Actual Sets, WatchConnectivity, HealthKit, Core Motion, AI providers, Safety Rule Pack behavior, Analysis, recognition, RPE, and Finish assistance. Do not expose any of them as discoverable placeholders.
- The deferred private-Alpha exclusions remain absent: `FR-042`, `FR-044`, `FR-045`, `FR-048`, `FR-051`, `FR-067`–`FR-070`, and `FR-074`–`FR-077`.

### UX and Accessibility Guardrails

- iPhone root navigation is Plan, History, Analysis, More, with Plan selected.
- The design-system `MASTER.md` contains historical “Today” navigation wording. Do not use it where it conflicts with the newer Native UI spec, Story 1.1, or AD-14.
- Watch without a compatible Plan shows a literal no-delivered-Plan state; it must not resemble an active workout.
- Use one primary action per state, 44×44 pt minimum consequential targets, semantic colors, and non-color state cues.
- Support Light/Dark, at least 200% Dynamic Type on iPhone and 140% on Watch, VoiceOver order, Increase Contrast, Differentiate Without Color, Reduce Transparency, and Reduce Motion.
- HTML, SVG, PNG, and web prototypes are review carriers only. Do not embed Tailwind, CSS tokens, Google Fonts, web views, or prototype JavaScript in the native runtime.

### Library and Framework Requirements

| Technology | Required use |
|---|---|
| Xcode | 26.6, build 17F113; select and assert explicitly in local/CI checks |
| Apple Swift | 6.3.3; `swift-tools-version` alone does not pin the compiler patch |
| SwiftUI | Native iOS/watchOS shell only; no third-party UI framework |
| Swift Package Manager | One local package; commit resolved remote dependency state |
| GRDB.swift | Official repository, exact 7.11.1, `GRDB` product unless an evidence-backed need selects another product |
| XCTest / Swift Testing | Use the toolchain-native test stack; avoid adding a test dependency for seed assertions |
| HealthKit / WatchConnectivity / Core Motion | Not implemented or imported by domain targets in this Story |

### Expected File Structure

All product-code paths are NEW because no Apple app project exists. The exact folder labels may vary, but the ownership boundaries may not.

```text
FitnessAI.xcworkspace/
FitnessAI.xcodeproj/                 # or one equivalent project carrier inside the workspace
Apps/
  iPhone/
  Watch/
Packages/
  FitnessAICore/
    Package.swift
    Sources/
      Contracts/
      Domain/
      Application/
      PersistencePorts/
      SyncContracts/
      SafetyRules/
      Analysis/
    Tests/
Tests/
  iPhone/
  Watch/
scripts/
  ci/
```

Expected UPDATE candidates:

- `scripts/verify-macos-environment.sh`
- `docs/development-setup.md`
- `.gitignore` only for newly produced generated artifacts
- `_bmad-output/implementation-artifacts/sprint-status.yaml` through BMAD status transitions

Do not update historical design previews, the Vivo POC, or deferred planning artifacts as part of implementation.

### Testing Requirements

Minimum automated evidence before Story completion:

1. Clean-resolution check proving GRDB 7.11.1 in committed `Package.resolved`.
2. Local package build/tests and dependency-direction/forbidden-import checks.
3. Independent iPhone and Watch scheme builds on Apple Silicon.
4. iPhone root navigation and truthful-empty-state launch smoke test.
5. Watch no-delivered-Plan launch smoke test.
6. Accessibility identifiers/order plus manual or UI-test evidence for the required appearance/accessibility states.
7. All eight AD-13 check names executed with meaningful assertions.
8. Secret scanner and artifact-content check.
9. Existing `scripts/verify-macos-environment.sh` passes after its Git/workspace assertions are reconciled.
10. A clean checkout reproduces the result; generated build output remains ignored.

Simulator CI is not physical-device, signing, entitlement, HealthKit, WatchConnectivity, battery, background-runtime, or model evidence. Do not claim those later Gates from this Story.

### Repository and Git Intelligence

There is no Git history to learn from: `.git` has no `HEAD`, and Git reports that the directory is not a repository. Existing migration evidence intentionally preserved this state. Repository initialization and hosted settings are external state changes and require Product Owner authorization.

Reusable local assets:

- Environment baseline and verifier: `docs/development-setup.md`, `scripts/verify-macos-environment.sh`
- Secret/generated-state policy: `.gitignore`, `.gitattributes`
- Visual authority: `design-system/fitnessai/MASTER.md`, `design-system/fitnessai/tokens.json`, page overrides
- Native UI authority and mappings: `native-ui-spec.md`, `architecture-handoff.md`, `SWIFTUI-MAPPING.md`, `COMPONENT-SPECS.md`

### Latest Technical Information

- Apple ships Xcode 26.6 with the 26.5 platform SDK family; the local machine reports the required Xcode and Swift versions.
- A local Swift Package is path-based and has no separate version requirement; its exact state comes from the repository revision.
- `Package.resolved` records the actual remote dependency resolution. Commit and verify it.
- GRDB v7.11.1 declares Swift tools 6.1, Swift language mode 6, and platform minimums below this project's baselines.
- If GitHub is selected, use an explicit Apple Silicon macOS 26 runner and explicit Xcode 26.6 selection rather than `macos-latest`. Fork pull requests do not receive ordinary Actions secrets; keep the PR workflow secretless and do not use `pull_request_target` to execute untrusted code.
- Required-check enforcement belongs to the repository host. A workflow file alone is not evidence that checks are required.

### Project Context Reference

No `project-context.md` exists. This is non-blocking. The Story's authorities are the current PRD, Epic 1, Architecture Spine, Native UI/UX artifacts, Sprint Plan, design system, and development setup.

### References

- [Source: `_bmad-output/planning-artifacts/epics.md#story-11-launch-the-runnable-iphone-watch-and-shared-contract-workspace`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-1--dependency-direction-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-12--modular-monolith-seed-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-13--environments-and-release-evidence-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-14--native-presentation-contract-adopted`]
- [Source: `_bmad-output/planning-artifacts/implementation-readiness-report-2026-09-11.md#major-issues`]
- [Source: `_bmad-output/implementation-artifacts/sprint-plan.md#7-ad-13-apple-siliconmacos-ci-overlay`]
- [Source: `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/prd.md#31-mvp-surfaces-and-device-topology`]
- [Source: `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/prd.md#810-apple-health-and-private-alpha-experience`]
- [Source: `_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md#information-architecture`]
- [Source: `_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md#accessibility-floor`]
- [Source: `_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md#iphone-private-alpha-key-screen-layout-contract`]
- [Source: `_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md#3-iphone-shell-and-navigation`]
- [Source: `_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md#11-accessibility-and-appearance-acceptance`]
- [Source: `_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md#2-selected-direction-and-immutable-tokens`]
- [Source: `_bmad-output/planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md#6-accessibility-and-native-semantics`]
- [Source: `design-system/fitnessai/MASTER.md#14-swiftui-implementation-rules`]
- [Source: `docs/development-setup.md#purpose-and-support-policy`]
- [Apple: Xcode 26.6 release](https://developer.apple.com/news/releases/?id=06252026a)
- [Apple: Xcode 26.6 release notes](https://developer.apple.com/documentation/Xcode-Release-Notes/xcode-26_6-release-notes)
- [Swift: Announcing Swift 6.3.3](https://forums.swift.org/t/announcing-swift-6-3-3/87888)
- [Apple: Organizing code with local packages](https://developer.apple.com/documentation/Xcode/organizing-your-code-with-local-packages)
- [Apple: Setting up a watchOS project](https://developer.apple.com/documentation/watchOS-Apps/setting-up-a-watchos-project)
- [SwiftPM: PackageDescription](https://docs.swift.org/package-manager/PackageDescription/PackageDescription.html)
- [GRDB: v7.11.1 release](https://github.com/groue/GRDB.swift/releases/tag/v7.11.1)

## Story Completion Status

- Status set to `done` after merge to `main`.
- The runnable iPhone and Watch workspace, shared-package boundaries, adaptive Simplified-Chinese-first UI, and AD-13 hosted CI overlay are implemented.
- GitHub PR #2 passed all eight required automated checks without human approval and merged as commit `6bfc287`.
- GATE-1 through GATE-7 remain fail closed; Story completion does not enable deferred capabilities.

## Dev Agent Record

### Agent Model Used

OpenAI Codex (GPT-5)

### Debug Log References

- `scripts/verify-macos-environment.sh` — passed the preserved BMAD/macOS/POC checks plus Git, workspace, schemes, package boundaries, toolchain, accessibility shell, and GRDB lock verification.
- `scripts/ci/run-all.sh` — passed all eight local entrypoints.
- Independent `xcodebuild` runs — iPhone and Watch simulator builds passed; two iPhone and two Watch tests passed; both app bundles installed and launched without signing.
- Isolated `--no-local` checkout — resolved GRDB 7.11.1 from the committed lock and passed boundary/no-speculative-content validation.
- GitHub Actions run `34580092908` — all eight hosted checks passed on Apple Silicon `macos-26` with Xcode 26.6 build `17F113` and Apple Swift 6.3.3.
- GitHub Actions run `35552114045` for PR #2 — all eight required checks passed, including launch-and-test coverage for the adaptive Chinese iPhone and crown-paged Watch UI.
- GitHub branch-protection API read-back at `2026-09-11 19:52:10 CST` — strict required contexts matched the eight-check manifest; administrators enforced; reviews not required; force pushes and deletion disabled.

### Completion Notes List

- Created one native Xcode workspace with independent iPhone and Watch app/test targets and shared schemes.
- Added a single local Swift Package with explicit inward-facing Contracts, Domain, Application, PersistencePorts, SyncContracts, SafetyRules, Analysis, and PersistenceGRDB boundaries.
- Pinned official GRDB exactly to 7.11.1 and confined its import to the persistence adapter seed without adding schema, tables, migrations, or business entities.
- Implemented truthful native SwiftUI launch shells: Plan-first four-tab iPhone navigation and a no-delivered-Plan Watch state, using semantic Light/Dark assets and accessibility identifiers.
- Added meaningful local and hosted checks for compile, domain, schema, safety, persistence, sync, AI contract, and secrets. GitHub now requires all eight checks on `main` without human approval.
- Verified clean resolution, simulator launch, appearance/Dynamic Type rendering, secret absence, and strict seed scope. GATE-1 through GATE-7 remain fail closed.
- Repository visibility was changed to public only after explicit Product Owner authorization because the current GitHub plan could not enforce required checks on a private repository.

### File List

- `.github/required-checks.json`
- `.github/workflows/ci.yml`
- `.gitignore`
- `Apps/Watch/Assets.xcassets/ActionPrimary.colorset/Contents.json`
- `Apps/Watch/Assets.xcassets/BackgroundCanvas.colorset/Contents.json`
- `Apps/Watch/Assets.xcassets/Contents.json`
- `Apps/Watch/Assets.xcassets/TextPrimary.colorset/Contents.json`
- `Apps/Watch/Assets.xcassets/TextSecondary.colorset/Contents.json`
- `Apps/Watch/FitnessAIWatchApp.swift`
- `Apps/Watch/WatchAppState.swift`
- `Apps/Watch/WatchRootView.swift`
- `Apps/iPhone/Assets.xcassets/AccentColor.colorset/Contents.json`
- `Apps/iPhone/Assets.xcassets/ActionPrimary.colorset/Contents.json`
- `Apps/iPhone/Assets.xcassets/BackgroundCanvas.colorset/Contents.json`
- `Apps/iPhone/Assets.xcassets/Contents.json`
- `Apps/iPhone/Assets.xcassets/TextPrimary.colorset/Contents.json`
- `Apps/iPhone/Assets.xcassets/TextSecondary.colorset/Contents.json`
- `Apps/iPhone/FitnessAIApp.swift`
- `Apps/iPhone/IPhoneAppState.swift`
- `Apps/iPhone/IPhoneRootView.swift`
- `FitnessAI.xcodeproj/project.pbxproj`
- `FitnessAI.xcodeproj/xcshareddata/xcschemes/FitnessAI-Watch.xcscheme`
- `FitnessAI.xcodeproj/xcshareddata/xcschemes/FitnessAI-iPhone.xcscheme`
- `FitnessAI.xcworkspace/contents.xcworkspacedata`
- `FitnessAI.xcworkspace/xcshareddata/swiftpm/Package.resolved`
- `Packages/FitnessAICore/Package.resolved`
- `Packages/FitnessAICore/Package.swift`
- `Packages/FitnessAICore/Sources/Analysis/AnalysisSeed.swift`
- `Packages/FitnessAICore/Sources/Application/ApplicationSeed.swift`
- `Packages/FitnessAICore/Sources/Contracts/ContractsSeed.swift`
- `Packages/FitnessAICore/Sources/Domain/DomainSeed.swift`
- `Packages/FitnessAICore/Sources/PersistenceGRDB/GRDBAdapterSeed.swift`
- `Packages/FitnessAICore/Sources/PersistencePorts/PersistencePortSeed.swift`
- `Packages/FitnessAICore/Sources/SafetyRules/SafetyRuleSeed.swift`
- `Packages/FitnessAICore/Sources/SyncContracts/SyncContractSeed.swift`
- `Packages/FitnessAICore/Tests/ArchitectureTests/ArchitectureTests.swift`
- `Tests/Watch/WatchAppStateTests.swift`
- `Tests/iPhone/IPhoneAppStateTests.swift`
- `docs/development-setup.md`
- `scripts/ci/check-accessibility-shells.sh`
- `scripts/ci/check-dependency-boundaries.sh`
- `scripts/ci/check-no-speculative-content.sh`
- `scripts/ci/check-resolved-dependencies.sh`
- `scripts/ci/check-secrets.sh`
- `scripts/ci/check-toolchain.sh`
- `scripts/ci/run-all.sh`
- `scripts/ci/run-check.sh`
- `scripts/verify-macos-environment.sh`
- `_bmad-output/implementation-artifacts/1-1-launch-the-runnable-iphone-watch-and-shared-contract-workspace.md`
- `_bmad-output/implementation-artifacts/sprint-status.yaml`
- `_bmad-output/implementation-artifacts/story-1-1-ci-evidence.md`

### Change Log

- 2026-09-11: Implemented and verified the complete Story 1.1 runnable native seed, hosted CI contract, and required-check enforcement; moved the Story to `review`.
- 2026-09-21: PR #2 passed all eight required automated checks and merged to `main` as `6bfc287`; moved Story 1.1 to `done` and selected Story 1.2 as the next executable work item.
