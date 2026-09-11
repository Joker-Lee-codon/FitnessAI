# Native quality gates

Apply these mandatory checks before Architecture handoff.

## Contract integrity

- Every MVP FR/NFR and UX journey maps to at least one surface/state or is explicitly nonvisual.
- User-confirmed/corrected facts outrank sensor, AI, voice, import, sync, and recovery drafts.
- Local commit, offline recording, conflict preservation, incomplete sessions, privacy scope, and version boundaries retain their UX meanings.
- No V1.1/Post-MVP route appears as an available MVP capability.

## Apple Watch

- Critical information is glanceable and primary actions take one or two deliberate interactions.
- Navigation depth is minimized; Digital Crown is optional acceleration where an accessible equivalent exists.
- Active-set silence, safe-rest interaction, wrist-down/resume, Always On, haptic meaning, accidental input, and recovery are specified.
- Layout covers every supported Watch size and both Crown orientations where relevant.

## iPhone and shared system

- Native navigation/back behavior, safe areas, sheets, destructive confirmation, keyboard/input, and focus restoration are explicit.
- Light/Dark, Dynamic Type, VoiceOver, Reduce Motion, non-color state cues, localization expansion, and minimum touch targets pass.
- Loading, empty, partial, offline, local-write failure, sync conflict, permission denial, and retry paths are represented by reusable contracts.
- Animation conveys causality, is interruptible where applicable, and has a reduced-motion alternative.

## Delivery

- Semantic tokens have stable names and SwiftUI mappings; components do not embed unexplained raw values.
- English and `.zh-CN.md` documents match structurally and preserve identifiers/conclusions.
- Required previews exist for the representative surfaces and each layout-critical MVP flow.
- Physical-device-only validations have owners and pass criteria.
- Architecture handoff lists decisions still intentionally deferred to Architecture.

