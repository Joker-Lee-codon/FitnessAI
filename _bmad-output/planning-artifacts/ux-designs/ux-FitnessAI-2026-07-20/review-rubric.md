# Spine Pair Review — FitnessAI

## Overall verdict

The pair is **adequate as an in-progress Fast-path contract, but not ready for finalization**. Mechanical coverage is unusually complete: all five source journeys, FR-001–FR-070, every IA surface, every shared component, and every token reference are represented, and the bilingual twins preserve the same structure. Four high-impact gaps remain: unresolved active-session behavior, unresolved HealthKit copy/deletion behavior, appearance-mode component tokens that resolve only to light values, and an ambiguous boundary between native inheritance and custom component geometry.

Finding count: **critical 0 · high 4 · medium 4 · low 1**.

## 1. Flow coverage — adequate

Checked the five PRD journeys, FR-001–FR-070, the four source-required closure flows, named protagonists, numbered steps, climax beats, failure paths, and the requirements-to-flow/surface mappings. UJ-1 through UJ-5 are named verbatim; every FR range maps to at least one Key Flow.

### Findings

- **[high]** The MVP active-session flows are structurally present but not yet implementable as a single contract because Watch-versus-iPhone correction ownership, first-set/rest-safe timing, forgotten-Finish operating thresholds, and load/unit/per-side/assisted/bodyweight semantics remain open. These choices affect UJ-1, UJ-3, Flow 6, and Flow 8 rather than merely visual polish (`EXPERIENCE.md` § Open Questions 2, 3, 5, 7). *Fix:* resolve or explicitly phase each decision, then update the affected flow steps, component behavior, and state transitions together.
- **[high]** Flow 9 cannot close the data lifecycle while the relationship between an Apple Health deletion and the FitnessAI copy remains undefined (`EXPERIENCE.md` § Permissions, Privacy, and Sensitive Data; § Open Questions 6). This ambiguity can produce either unwanted resurrection or unexpected loss. *Fix:* commit the HealthKit detachment/deletion scope, user choices, copy provenance, and failure/retry behavior, then bind it to Flow 9 and `lifecycle-request-row`.
- **[medium]** The primary MVP cohort remains undecided even though UJ-1 uses a regular, progression-focused intermediate lifter and the PRD allows all experience levels (`EXPERIENCE.md` § Open Questions 1). *Fix:* declare the primary validation protagonist and retain broader eligibility as a secondary boundary.
- **[medium]** UJ-4 preserves the source's Post-MVP scope, but post-session, weekly, and cycle-end proposal precedence remains unresolved (`EXPERIENCE.md` UJ-4; § Open Questions 9). *Fix:* resolve the cadence before UJ-4 enters UX or epic implementation; until then keep the surface explicitly gated.

## 2. Token completeness — thin

Extracted 24 color tokens, five typography roles, four radii, six spacing values, 11 component token objects, and 36 distinct `{path.to.token}` references across the pair. Every reference resolves, every color is hex, light/dark palette pairs exist, and contrast targets are stated.

### Findings

- **[high]** Every component frontmatter object resolves to a light token only—for example `actual-set-row.background: {colors.surface-raised}` and `session-control.foreground: {colors.on-action}`—while dark counterparts exist only as prose. A downstream generator that follows the machine contract will render light surfaces in dark appearance (`DESIGN.md` frontmatter `components`; § Colors; § Components). *Fix:* add explicit appearance-aware component properties such as `background-dark`/`foreground-dark`/`border-dark`, or define another spec-valid machine-readable mode mapping and use it consistently.
- **[medium]** The palette, radii, spacing extension, visual direction, Crown behavior, haptics, and portrait posture are honestly labeled `[ASSUMPTION]`, but they are still load-bearing values in the contract (`DESIGN.md` frontmatter and §§ Brand & Style, Colors, Layout & Spacing, Shapes; `EXPERIENCE.md` §§ Interaction Primitives, Responsive & Platform). *Fix:* validate them with user/physical-device evidence or remove the delta and inherit native behavior before changing status to `final`.

## 3. Component coverage — strong

The same 11 component names appear in `DESIGN.md` Components and `EXPERIENCE.md` Component Patterns, with visual and behavioral rules rather than placeholders. English and Chinese component sets are identical.

### Findings

No component coverage misses.

## 4. State coverage — strong

Walked all five Apple Watch surfaces and nine iPhone/Post-MVP surfaces. Cold load, empty, active/rest, incomplete, offline, local-write failure, permission denied/revoked, sensor loss, recovery, conflict, stale Analysis, restoration, deletion, and lifecycle request states are covered where applicable.

### Findings

No mechanical state coverage misses. The unresolved behavior noted in §1 must still be committed before finalization.

## 5. Visual reference coverage — strong

`imports/` is empty; no `mockups/` or `wireframes/` artifacts exist. `EXPERIENCE.md` explicitly classifies all Watch, iPhone, and Post-MVP surfaces as spine-only and states the spines-win-on-conflict rule once.

### Findings

No orphan or unspecific visual references. Visual validation remains absent by deliberate Fast-path choice, not by broken linkage.

## 6. Bloat & overspecification — adequate

The 210-line DESIGN spine and 344-line EXPERIENCE spine are proportionate to a two-surface, 70-requirement health-adjacent product. Tables carry most repeated mappings, and exact pixel layout is generally avoided.

### Findings

- **[low]** Several trust invariants—local commit as saved boundary, user authority, no silent overwrite, and visible pending state—are repeated across Voice and Tone, Component Patterns, State Patterns, Trust, Offline/Sync, and Key Flows (`EXPERIENCE.md` §§ Voice and Tone through Key Flows). *Fix:* keep one normative rule in the relevant product-specific section and use shorter cross-references elsewhere when the next revision is polished.

## 7. Inheritance discipline — thin

All five `sources` entries resolve under `{planning_artifacts}`; UJ names are verbatim; FR ranges are preserved; component names and token references match; English and Chinese files have matching frontmatter structures, section order, component tables, flow headings, requirement IDs, conclusions, and open questions.

### Findings

- **[high]** Native inheritance and custom delta are internally ambiguous. `DESIGN.md` says native controls keep native geometry, yet `components.session-control` mandates `{rounded.full}` and custom action colors; several “native sheet” components also mandate custom radii (`DESIGN.md` frontmatter `components`; §§ Layout & Spacing, Shapes, Components). Because the frontmatter wins, downstream consumers cannot know which native defaults to preserve. *Fix:* classify each component as native-as-is, native-with-named-delta, or fully custom; remove conflicting token properties from native-as-is components.
- **[medium]** The contract requires one-to-one Chinese terminology, but neither spine contains the promised canonical English↔Chinese glossary (`EXPERIENCE.md` § Voice and Tone). Structural bilingual parity is strong, yet downstream localization still has to infer translations for states such as Complete/Incomplete, pending/stale, and RPE provenance. *Fix:* add one shared bilingual terminology table and use it as the localization authority in both versions.

## 8. Shape fit — strong

`DESIGN.md` uses the canonical order: Brand & Style → Colors → Typography → Layout & Spacing → Elevation & Depth → Shapes → Components → Do's and Don'ts. `EXPERIENCE.md` contains every required default plus the triggered Responsive & Platform and Inspiration & Anti-patterns sections. The added trust, synchronization/recovery, privacy, coverage, and open-question sections earn their place for this product.

### Findings

No shape-fit misses.

## Mechanical notes

- YAML frontmatter parses in all four spine files; all remain `status: in-progress` and list the same five sources.
- All 36 token references resolve against `DESIGN.md`; all 24 color values are hex.
- Component sets are exact: 11 in DESIGN, EXPERIENCE, and both bilingual copies.
- Key Flow sets are exact across languages: UJ-1–UJ-5 plus Flow 6–Flow 9.
- FR-001–FR-070 are continuously covered by the compact range mapping; there are no numeric gaps.
- English/Chinese line counts and H2/flow/component structures match, but semantic localization still needs the glossary finding above.
- No Mermaid or visual-artifact syntax is present to validate.
