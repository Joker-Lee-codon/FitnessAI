---
baseline_commit: 6bfc287
---

# Story 1.2: Unify Cross-Device Fact Identity, Units, and Digest Contracts

Status: in-progress

Classification: Enabler  
Implementation slice: S0  
Story key: `1-2-unify-cross-device-fact-identity-units-and-digest-contracts`

## Story

As a trainee,  
I want every Plan, Workout Session, Actual Set, and revision to retain the same identity and meaning across iPhone, Watch, retries, and transfer,  
so that workout facts are never duplicated, mistranslated, or interpreted as different content.

## Acceptance Criteria

### AC1 — Stable identity before every boundary

**Given** the app is creating a Plan, Plan Revision, Workout Session, Actual Set, revision event, device message, approval, or proposal identity  
**When** the object first exists in the domain  
**Then** it receives a stable ID before persistence, transfer, or UI success  
**And** local retry, restart, Watch transfer, and replay retain that ID  
**And** device time or arrival order never regenerates or selects fact identity.

### AC2 — Platform-neutral shared contracts

**Given** iPhone and Watch exchange or compare workout facts  
**When** shared `Contracts` encode or decode them  
**Then** the contracts define platform-neutral IDs, units, revision metadata, error codes, and version fields  
**And** they expose no SwiftUI, GRDB-row, HealthKit, WatchConnectivity, or provider-specific model  
**And** a future Kotlin implementation can implement the schema and golden fixtures without sharing Swift code.

### AC3 — Lossless load semantics

**Given** the user enters a load  
**When** it enters a domain contract  
**Then** the original entered value and kg/lb unit are preserved  
**And** canonical conversion is a separate derived value  
**And** external, bodyweight, assisted, unloaded, timed, and non-comparable load kinds are distinct  
**And** total and per-side basis are distinct when applicable  
**And** semantically incomparable loads are never forced into one value class.

### AC4 — Version provenance and compatibility

**Given** a fact will be interpreted outside its originating component  
**When** it enters persistence, Watch transfer, an AI proposal, a Plan file, or Analysis  
**Then** it carries every applicable app, schema, Exercise-catalog, model, support-matrix, Safety-Rule-Pack, or algorithm version  
**And** a missing or incompatible required version produces an explicit pending, unsupported, or rejected error  
**And** historical facts are never silently reinterpreted under a current version.

### AC5 — One normative canonicalization/digest profile

**Given** the same structured content participates in display, approval, sync, import, or commit  
**When** canonical serialization and digest are generated  
**Then** one normative profile specifies UTF-8 encoding, Unicode normalization, decimal and unit representation, UTC/time-zone meaning, unknown-field behavior, covered fields/bytes, and a versioned hash algorithm  
**And** equivalent iPhone and Watch input produces identical canonical bytes and digest  
**And** changing any covered field changes the digest.

### AC6 — Cross-target golden fixtures and strict failure

**Given** the contract repository contains golden vectors  
**When** iPhone-target, Watch-target, and shared-package tests run  
**Then** every target agrees on valid-fixture bytes, digest, IDs, units, and version interpretation  
**And** malformed, unknown-required-field, unsupported-version, decimal-boundary, Unicode, and time-zone fixtures return the specified typed error  
**And** no fixture produces partial success or an automatically substituted fact.

### AC7 — Strict scope boundary

**Given** Story 1.2 is limited to stable contracts  
**When** its implementation scope is inspected  
**Then** it creates only the schemas, value types, canonicalization implementation, and fixtures required here  
**And** it creates no Workout, Plan, AI, Health, or sync database table  
**And** it sends no network request or exposes a later user capability.

## Tasks / Subtasks

- [x] Task 1 — Add nominal stable identity contracts (AC: 1, 2)
  - [x] Add non-interchangeable public ID value types for Plan, Plan Revision, Workout Session, Actual Set, revision event, device message, approval, proposal, and source device.
  - [x] Generate RFC 9562 UUIDv4 only at an explicit creation boundary; decode/retry/replay must reuse the supplied ID and never call a generator.
  - [x] Canonical wire text is lowercase 36-character hyphenated UUID; parsing may accept RFC-valid hexadecimal case but canonical output is always lowercase.
  - [x] Ensure IDs are identity only: no ordering, conflict choice, or chronology may use UUID value, device time, arrival order, `hashValue`, or `Hasher`.

- [x] Task 2 — Define precise load and decimal value contracts (AC: 2, 3, 6)
  - [x] Add a strict `CanonicalDecimal` parsed from ASCII decimal text, never `Double`, locale formatting, or `Measurement<UnitMass>`.
  - [x] Freeze v1 grammar: no exponent, sign only where explicitly allowed, no leading zeros, no negative zero, maximum 28 significant digits and 12 entered fractional digits; canonical output removes redundant trailing fractional zeros.
  - [x] Preserve entered value and `kg|lb`; represent `external|bodyweight|assisted|unloaded|timed|nonComparable` and `total|perSide|notApplicable` as closed wire enums with validated combinations.
  - [x] Derive canonical kilograms without replacing the entered fact, using the exact relationship `1 lb = 0.45359237 kg`; allow up to 20 canonical fractional digits so supported lb inputs convert without rounding.
  - [x] Return a typed error for invalid decimal, unsupported unit, invalid kind/basis combination, overflow, or an attempted comparison of semantically incomparable load kinds.

- [x] Task 3 — Add version provenance and compatibility contracts (AC: 2, 4, 6)
  - [x] Define platform-neutral version values for app, schema, Exercise catalog, model, support matrix, Safety Rule Pack, algorithm, and canonical profile.
  - [x] Make applicable required versions explicit; never default a missing historical version to the current version.
  - [x] Freeze compatibility outcomes: missing-but-recoverable dependency → `pending`; known incompatible/unknown critical capability → `unsupported`; malformed, contradictory, or digest-invalid envelope → `rejected`.
  - [x] Add stable error codes, field paths, expected/actual versions, and recoverability without embedding user content.

- [x] Task 4 — Implement FitnessAI Canonical Profile v1 (AC: 2, 5, 6)
  - [x] Implement a small canonical value tree and serializer rather than hashing ordinary `Codable`, `JSONEncoder(.sortedKeys)`, `Hashable`, or localized display output.
  - [x] Profile identifier: `fitnessai-canonical-v1`; bytes are UTF-8 without BOM or insignificant whitespace.
  - [x] Normalize every string and object key to Unicode NFC, reject post-normalization duplicate keys, sort object keys by normalized UTF-8 bytes, preserve array order, and use fixed RFC 8259 escaping for quotes, reverse solidus, and control characters without escaping `/` or valid non-ASCII scalars.
  - [x] Encode decimals, UUIDs, units, kinds, bases, and versions using their canonical contract strings.
  - [x] Encode instants as signed base-10 Unix epoch milliseconds; preserve a separate IANA time-zone identifier only when local-calendar meaning is part of the fact. Never use default `Date`/locale encoding.
  - [x] Reject unknown required capabilities. Preserve declared optional extension values as inert canonical fields so round-trip and digest coverage are explicit; never silently omit an unknown field.
  - [x] The digest envelope covers profile/version plus the declared content and excludes the digest field itself.

- [x] Task 5 — Add the versioned digest contract (AC: 5, 6)
  - [x] Hash exact canonical bytes with SHA-256 and emit exactly 64 lowercase hexadecimal characters under algorithm identifier `sha256-v1`.
  - [x] Make canonical bytes inspectable in tests and keep digest construction fallible so serialization errors cannot produce a partial digest.
  - [x] Prove equivalent semantic inputs create byte-identical output and every covered-field mutation changes the digest.

- [x] Task 6 — Add one authoritative golden-vector corpus (AC: 2, 5, 6)
  - [x] Store one shared fixture corpus with input, expected canonical UTF-8 bytes/hex, expected digest, and expected typed outcome; do not duplicate expected values for different targets.
  - [x] Cover key insertion order, UUID case normalization, NFC composed/decomposed text, emoji/non-BMP keys, decimal zero/boundaries/rejections, exact lb conversion, time-zone/instant semantics, optional extensions, unknown critical fields, missing/unsupported versions, malformed UTF-8, duplicate normalized keys, and each load kind/basis.
  - [x] Add a covered-field mutation vector and explicit failures for exponent numbers, `NaN`, infinity, partial decoding, and automatic substitution.

- [ ] Task 7 — Run the same contract evidence in package, iPhone, and Watch targets (AC: 1–6)
  - [ ] Add Swift Testing package suites for Contracts and SyncContracts.
  - [ ] Add iPhone XCTest and Watch XCTest adapters that load the same corpus and assert identical bytes, digest, IDs, units, versions, and errors on their real target runtimes.
  - [ ] Give both app test targets a direct `FitnessAIContracts` dependency; do not rely on host-app transitive linkage.
  - [ ] Update `schema` and `sync` CI entrypoints to execute the new suites while preserving the existing eight required check names.

- [x] Task 8 — Preserve architecture and strict scope (AC: 2, 7)
  - [x] Keep the existing seed wiring, package products, dependency direction, GRDB 7.11.1 pin, UI behavior, and required-check manifest intact.
  - [x] Add no database schema, GRDB row, persistence adapter behavior, revision DAG/reducer, outbox/ack transport, WatchConnectivity type, AI/Health/provider DTO, network call, or user-visible capability.
  - [x] Keep the user's untracked `prototypes/iphone-trust-ledger/` content untouched.

## Dev Notes

### Locked Implementation Decisions

- Public contract values must explicitly conform to `Codable`, `Equatable`, `Hashable`, and `Sendable`; use explicit `CodingKeys` and custom decoding where compatibility behavior matters. Do not use `@unchecked Sendable`.
- Auto-synthesized `Codable` is not the wire-version or canonicalization policy. Required fields use strict decode; missing and explicit `null` must not be collapsed unless the schema declares them equivalent.
- The v1 profile is a FitnessAI profile, not RFC 8785/JCS: JCS neither normalizes Unicode nor supports arbitrary exact decimal semantics. Its ordering/escaping ideas may inform implementation, but its numeric and normalization rules are not normative here.
- `Hashable` supports in-process collections only. Persisted identity, replay keys, fingerprints, and digests use the explicit contracts above.
- `CryptoKit.SHA256` is an implementation of the bound `sha256-v1` algorithm, not the source of canonical bytes. A future Kotlin implementation must reproduce the fixture bytes and digest independently.
- Mapping between domain, persistence, wire, UI, AI, and platform frameworks happens at ports. This Story defines wire/value contracts only.

### Architecture and Story Boundaries

- Story 1.1 created the package/targets and CI shell; extend them instead of creating a second package, fact model, or `Utils` target.
- Story 1.3 owns the revision DAG, reducer, conflict policy, and resolution behavior. Story 1.2 defines only IDs and revision metadata needed by that future implementation.
- Story 1.4 owns GRDB schema, transactions, outbox/invalidation/idempotency records, protection, and recovery.
- Story 1.5 owns the Exercise Catalog contents and mapping behavior. Story 1.2 only defines catalog/support-version provenance.
- Stories 1.6–1.14 and Epics 2/5 must reuse these IDs, load semantics, versions, canonical bytes, and digest; they may not introduce competing profiles.

### Expected File Structure

New production files should remain under existing targets:

- `Packages/FitnessAICore/Sources/Contracts/StableIdentifiers.swift`
- `Packages/FitnessAICore/Sources/Contracts/CanonicalDecimal.swift`
- `Packages/FitnessAICore/Sources/Contracts/LoadContract.swift`
- `Packages/FitnessAICore/Sources/Contracts/ContractVersions.swift`
- `Packages/FitnessAICore/Sources/Contracts/ContractError.swift`
- `Packages/FitnessAICore/Sources/Contracts/TemporalContract.swift`
- `Packages/FitnessAICore/Sources/Contracts/CanonicalValue.swift`
- `Packages/FitnessAICore/Sources/Contracts/CanonicalSerializer.swift`
- `Packages/FitnessAICore/Sources/Contracts/ContractDigest.swift`
- `Packages/FitnessAICore/Sources/Domain/StableIdentityGenerating.swift` only if an injected creation boundary is needed without defining business entities.
- `Packages/FitnessAICore/Sources/SyncContracts/MessageIdentity.swift` for replay identity metadata only; no transport state machine.

Tests belong in `Packages/FitnessAICore/Tests/ContractTests`, `Packages/FitnessAICore/Tests/SyncContractTests`, and the existing `Tests/iPhone` and `Tests/Watch` targets. Keep a single fixture corpus under package test resources or a narrowly scoped fixture-support target.

### Existing Files That May Be Updated

- `Packages/FitnessAICore/Package.swift`: add test targets/resources without changing current products, platform floors, dependency direction, or GRDB pin.
- `FitnessAI.xcodeproj/project.pbxproj`: register target-level tests/resources and direct Contracts dependencies.
- `scripts/ci/run-check.sh`: make `schema` and `sync` run their relevant test suites; preserve all eight check names.
- `scripts/ci/check-dependency-boundaries.sh` and `scripts/ci/check-no-speculative-content.sh`: strengthen only if necessary; never loosen current forbidden imports/content.
- Preserve `ContractsSeed.schemaGeneration == 0`, `DomainSeed` defaults, `SyncContractSeed`, ArchitectureTests, and all current app/UI tests.

### Testing Requirements

- Assert exact canonical bytes and exact digest, not only encode/decode round trips.
- Assert decode/retry/replay preserves supplied IDs and never invokes an ID generator.
- Assert every nominal ID type is non-interchangeable at compile time through API signatures and runtime fixture decoding.
- Assert load original value/unit survives round trip and canonical kilograms are separately derived; incomparable kinds cannot enter comparable analysis paths.
- Assert missing, unsupported, malformed, unknown-required, duplicate-key, decimal, Unicode, and time errors return exact stable error codes with no partial value.
- Assert iPhone, Watch, and package targets consume one corpus and agree byte-for-byte.
- Continue passing `compile`, `domain`, `schema`, `safety`, `persistence`, `sync`, `ai-contract`, and `secret`.

### Previous Story and Git Intelligence

- Story 1.1 passed all eight required checks in GitHub Actions run `35552114045` and merged to `main` as `6bfc287`.
- The current code is still the Story 1.1 seed: `ContractsSeed.schemaGeneration == 0`, `DomainSeed` and `ArchitectureTests` rely on it, and `SyncContractSeed` proves the dependency edge. Extend rather than replace these fixtures.
- Recent commits changed only iPhone/Watch preview UI and Story status, not the core contract targets. Avoid unrelated UI cleanup or reconciliation in this Story.

### Latest Technical Information

- Swift 6.3 public contract values should declare `Sendable`; stored properties/associated values must also be Sendable. [Swift Sendable](https://docs.swift.org/latest/documentation/swift/sendable/)
- `decodeIfPresent` merges missing and `null`; use strict custom decoding when the distinction is normative. [Apple custom Codable](https://developer.apple.com/documentation/foundation/encoding-and-decoding-custom-types)
- UUIDv4 is random identity, not chronological truth; RFC 9562 fixes its 128-bit/wire semantics. [RFC 9562](https://www.rfc-editor.org/rfc/rfc9562.html)
- Foundation `Decimal` is base-10, but construction from `Double` inherits binary floating-point behavior. [Apple Decimal](https://developer.apple.com/documentation/foundation/decimal)
- The exact mass relationship is `1 lb = 0.45359237 kg`. [NIST SP 447](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nbsspecialpublication447.pdf)
- SHA-256 deterministically hashes provided bytes; the application must define those bytes first. [Apple CryptoKit SHA256](https://developer.apple.com/documentation/cryptokit/sha256)
- Unicode normalization must be applied after string construction because concatenating normalized strings is not always normalized. [Unicode UAX #15](https://www.unicode.org/reports/tr15/)
- Cross-system timestamps must use a frozen UTC representation and separate local-zone semantics when required. [RFC 3339](https://www.rfc-editor.org/rfc/rfc3339.html)

### References

- [Source: `_bmad-output/planning-artifacts/epics.md#story-12-unify-cross-device-fact-identity-units-and-digest-contracts`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-2--durable-truth-and-revisions-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-4--acknowledged-causal-watch-synchronization-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#ad-12--modular-monolith-seed-adopted`]
- [Source: `_bmad-output/planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md#consistency-conventions`]
- [Source: `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/prd.md#85-recognition-recovery-and-compatibility`]
- [Source: `_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md#trust-privacy-and-safety-invariants`]
- [Source: `_bmad-output/implementation-artifacts/1-1-launch-the-runnable-iphone-watch-and-shared-contract-workspace.md#boundaries-with-subsequent-stories`]
- [Source: `Packages/FitnessAICore/Package.swift`]
- [Source: `scripts/ci/run-check.sh`]

## Story Completion Status

- Status set to `ready-for-dev`.
- Ultimate context engine analysis completed — comprehensive, implementation-ready developer guide created.
- Story 1.1 is complete; Story 1.2 may proceed without a manual review checkpoint.

## Dev Agent Record

### Agent Model Used

OpenAI Codex (GPT-5)

### Debug Log References

- RED: `swift test ... --filter StableIdentifiersTests` failed because nominal ID contracts did not exist.
- GREEN: the same filtered suite passed 4/4 tests after adding `StableIdentifiers.swift`.
- RED/GREEN: load, version, canonicalization, digest, golden-corpus, and sync identity suites each failed before their contract implementation and passed afterward.
- REGRESSION: the full package run passed 28 tests; seven locally runnable required checks passed.
- ENVIRONMENT: local Xcode 27 cannot load the host's older CoreSimulator framework; the pinned Xcode 26.6 hosted `compile` check remains the authoritative cross-runtime result.

### Implementation Plan

- Implement each contract area test-first in task order; keep schemas platform-neutral and defer persistence, reducers, transport, and UI.

### Completion Notes List

- Added nominal UUID identities, exact decimal/load semantics, explicit provenance compatibility, canonical UTF-8 serialization, SHA-256 binding, and replay-safe message identity.
- Added one resource-backed golden corpus consumed by package, iPhone XCTest, and Watch XCTest adapters.
- Preserved the eight check names; `schema` now runs contract suites and `sync` runs replay identity tests.
- No persistence, network, UI, provider, reducer, or transport capability was added.

### File List

- `FitnessAI.xcodeproj/project.pbxproj`
- `Packages/FitnessAICore/Package.swift`
- `Packages/FitnessAICore/Sources/Contracts/*.swift`
- `Packages/FitnessAICore/Sources/SyncContracts/MessageIdentity.swift`
- `Packages/FitnessAICore/Sources/ContractFixtureSupport/**`
- `Packages/FitnessAICore/Tests/ContractTests/*.swift`
- `Packages/FitnessAICore/Tests/SyncContractTests/MessageIdentityTests.swift`
- `Tests/iPhone/ContractGoldenAdapterTests.swift`
- `Tests/Watch/ContractGoldenAdapterTests.swift`
- `scripts/ci/run-check.sh`

### Change Log

- 2026-09-21: Created the complete Story 1.2 implementation contract and moved the Story to `ready-for-dev`.
- 2026-09-21: Implemented the Story 1.2 contract stack and prepared hosted cross-runtime verification.
