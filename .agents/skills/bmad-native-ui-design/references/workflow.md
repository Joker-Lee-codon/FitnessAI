# Native UI workflow

## Operating rules

- Work in one stage or one bounded screen batch per conversation.
- Preserve PRD/UX behavior while allowing a visual reset.
- Render representative screens before expanding coverage.
- Ask for decisions only at the three gates: direction selection, core-flow acceptance, final handoff acceptance.
- Do not equate artifact count with progress.

## ND-01 — Direction

Read the current PRD, UX spines, reconciliation report, existing design-system files, rejected screenshots, and explicit user feedback. Produce a compact diagnosis separating:

- upstream invariants that must survive;
- visual decisions that may be discarded;
- observable reasons the prior work feels generic, dense, unclear, or off-brand;
- platform-specific constraints for a glanceable Watch and a richer iPhone companion.

Create exactly two directions. Each must name:

1. audience and use context;
2. the surface's single primary job;
3. a memorable visual thesis;
4. typography, color, material, geometry, imagery, motion, and data-display posture;
5. one justified aesthetic risk;
6. explicit anti-patterns;
7. representative Watch Active Session and iPhone Today & Plans or Analysis renders/specs.

The two directions must differ structurally, not merely by palette. Record the selected direction only after explicit user approval. Update status: ND-01 complete, ND-02 ready.

## ND-02 — System

Run the local UI/UX Pro Max search once with product, industry, audience, native stack, tone, density, and motion keywords. Always pass the SwiftUI stack. Treat results as candidates, not authority.

Reconcile the selected direction with Apple-native behavior and freeze:

- semantic light/dark colors and contrast roles;
- Dynamic Type-based typography roles;
- spacing, radius, material/elevation, icon, chart, motion, and haptic semantics;
- Watch versus iPhone component deltas;
- loading, pending, success, warning, error, incomplete, conflict, disabled, and unavailable treatment;
- SwiftUI token and component mapping.

Write `tokens.json` and the design-system portion of `native-ui-spec.md` plus its Chinese sibling. Do not rerun style generation for each page. Update status only after the user accepts the system and representative surfaces.

## ND-03 — Screens

Expand `{workflow.mvp_batches}` in order. Finish one batch before starting the next. For every surface record:

- purpose and entry/exit;
- requirement and journey IDs;
- content hierarchy and primary action;
- components and token references;
- required default, loading, empty, partial, offline, failure, permission, conflict, destructive, accessibility, and appearance states where applicable;
- Watch/iPhone ownership and handoff;
- SwiftUI implementation notes that constrain Architecture without prescribing its internals.

Use shared component/state contracts instead of generating a separate high-fidelity image for every combinatorial state. Ask for core-flow acceptance after the Watch core and iPhone review batches. Update batch progress in the status file.

## ND-04 — Gate and handoff

Read `native-quality-gates.md`. Validate the selected system and every MVP surface. Optional Impeccable review is allowed only after the mandatory native checks, and only for a named problem or explicit user request.

Create `architecture-handoff.md` containing:

- selected direction and immutable tokens;
- surface/component ownership boundaries;
- navigation and cross-device handoff constraints;
- required state machines and accessibility semantics;
- FR/NFR → UX journey → surface/state traceability;
- physical-device validations and open product/UX decisions;
- Architecture decisions still intentionally unresolved.

Mark complete only when mandatory gates pass or every remaining item is explicitly owned and nonblocking. Route next to `bmad-architecture`.

