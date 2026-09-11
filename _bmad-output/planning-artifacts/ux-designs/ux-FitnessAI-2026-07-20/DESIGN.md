---
name: FitnessAI
description: A coherent, test-ready native Apple Watch and iPhone visual system for the core-product private Alpha.
status: draft
sources:
  - "{planning_artifacts}/briefs/brief-FitnessAI-2026-07-19/brief.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/addendum.md"
  - "{planning_artifacts}/research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.md"
  - "{planning_artifacts}/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.md"
  - "{planning_artifacts}/research/technical-rpe-estimation-from-heart-rate-for-strength-training-research-2026-07-19.md"
updated: 2026-09-10
colors:
  # Compatibility aliases mapped to the confirmed Titanium Measure semantic token system.
  surface-base: '#F4F7F8'
  surface-raised: '#FFFFFF'
  surface-muted: '#EAF0F2'
  ink-primary: '#0B1115'
  ink-secondary: '#4F626C'
  border: '#B9C6CC'
  action: '#007D9A'
  on-action: '#FFFFFF'
  success: '#0A6E42'
  warning: '#875B00'
  error: '#B42318'
  pending: '#875B00'
  surface-base-dark: '#070A0D'
  surface-raised-dark: '#0D1318'
  surface-muted-dark: '#121A20'
  ink-primary-dark: '#F2F7FA'
  ink-secondary-dark: '#9CAAB2'
  border-dark: '#2B3740'
  action-dark: '#58D7FF'
  on-action-dark: '#07131F'
  success-dark: '#80D6A3'
  warning-dark: '#FFC857'
  error-dark: '#FF8A80'
  pending-dark: '#FFC857'
typography:
  session-value:
    note: 'Native SwiftUI numeric workout metric style; monospaced digits where values update.'
  title:
    note: 'Native SwiftUI large title/title role appropriate to the active platform.'
  body:
    note: 'Native SwiftUI body role with Dynamic Type.'
  label:
    note: 'Native SwiftUI headline/callout role with Dynamic Type.'
  meta:
    note: 'Native SwiftUI footnote/caption role with Dynamic Type; never the only carrier of critical state.'
rounded:
  sm: 8px
  md: 12px
  lg: 16px
  full: 9999px
spacing:
  '1': 4px
  '2': 8px
  '3': 12px
  '4': 16px
  '5': 24px
  '6': 32px
components:
  session-control:
    classification: 'native-with-named-delta'
    background: '{colors.action}'
    background-dark: '{colors.action-dark}'
    foreground: '{colors.on-action}'
    foreground-dark: '{colors.on-action-dark}'
    native-state-policy: 'focused, pressed, selected, disabled, and destructive/error inherit SwiftUI Button behavior; only enabled action colors are overridden'
  actual-set-row:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  recognition-state-chip:
    classification: 'fully-custom'
    interaction-policy: 'noninteractive; focused, pressed, selected, and disabled are not applicable'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    radius: '{rounded.full}'
    gap: '{spacing.1}'
    accepted-foreground: '{colors.success}'
    accepted-foreground-dark: '{colors.success-dark}'
    pending-foreground: '{colors.pending}'
    pending-foreground-dark: '{colors.pending-dark}'
    error-foreground: '{colors.error}'
    error-foreground-dark: '{colors.error-dark}'
  quick-correction-sheet:
    classification: 'native-as-is'
    native-state-policy: 'sheet material, geometry, focus, pressed, selected, disabled, and error presentation inherit SwiftUI; content uses other named components'
  load-stepper:
    classification: 'native-with-named-delta'
    value-typography: '{typography.session-value}'
    provenance-typography: '{typography.meta}'
    provenance-foreground: '{colors.ink-secondary}'
    provenance-foreground-dark: '{colors.ink-secondary-dark}'
    native-state-policy: 'geometry, focus, pressed, selected, disabled, and error presentation inherit SwiftUI Stepper/Digital Crown behavior'
  rpe-verification-prompt:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  plan-diff-review:
    classification: 'fully-custom'
    interaction-policy: 'container and diff rows are noninteractive; child actions inherit native SwiftUI states'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.3}'
    changed-border: '{colors.action}'
    changed-border-dark: '{colors.action-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  sync-state-indicator:
    classification: 'fully-custom'
    interaction-policy: 'noninteractive; focused, pressed, selected, and disabled are not applicable'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-secondary}'
    foreground-dark: '{colors.ink-secondary-dark}'
    radius: '{rounded.full}'
    gap: '{spacing.1}'
    pending-foreground: '{colors.pending}'
    pending-foreground-dark: '{colors.pending-dark}'
    error-foreground: '{colors.error}'
    error-foreground-dark: '{colors.error-dark}'
  recovery-choice-sheet:
    classification: 'native-as-is'
    native-state-policy: 'sheet material, geometry, focus, pressed, selected, disabled, and error presentation inherit SwiftUI; content uses native actions and other named components'
  support-boundary-notice:
    classification: 'fully-custom'
    interaction-policy: 'notice container is noninteractive; any child route action inherits native SwiftUI states'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    warning-border: '{colors.warning}'
    warning-border-dark: '{colors.warning-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  lifecycle-request-row:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.sm}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  plan-exchange-review:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.3}'
    unresolved-border: '{colors.pending}'
    unresolved-border-dark: '{colors.pending-dark}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  structured-input-draft:
    classification: 'fully-custom'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    draft-border: '{colors.pending}'
    draft-border-dark: '{colors.pending-dark}'
    conflict-border: '{colors.error}'
    conflict-border-dark: '{colors.error-dark}'
---

# FitnessAI — Design Spine

## Brand & Style

FitnessAI should look like a trustworthy training instrument: quiet while the lifter is working, precise when a fact needs attention, and explicit about what is saved, inferred, pending, or unsupported. The source-backed visual priorities are glanceability under exertion, truthful provenance, reversible automation, and continuity across Watch and iPhone.

**Confirmed private-Alpha visual direction:** minimalist, clean, restrained native utility using SwiftUI/watchOS/iOS conventions and the existing Titanium Measure semantic tokens. The private Alpha requires a coherent final style and complete test-ready layout for every in-scope surface; it is not satisfied by placeholder or developer-only screens. Public-launch brand polish and broad device-specific optimization remain later work.

**Confirmed design system:** Titanium Measure in `design-system/fitnessai/MASTER.md` is inherited. This spine carries machine-readable compatibility aliases and UX-specific components; the master token file wins for raw visual values, while this spine and `EXPERIENCE.md` win for phase scope and behavior.

Private-Alpha implementation scope includes first-class phone-only workout capture, AI planning, Watch automatic recognition, optional automatic RPE, finish reminder, complete Analysis, Apple Health, first-party plan portability/Share Sheet, and proactive post-session review components named in `EXPERIENCE.md`. Voice, arbitrary third-party formats, server-backed link/QR sharing, and account/cloud lifecycle components remain later-phase compatibility notes.

The approved `.working/watch-final-review-v11.html` is the Watch starting reference only where it agrees with the current bilingual spines. Other historical boards remain discussion aids. The iPhone private-Alpha key-screen layouts are finalized in the contract below and rendered in `native-ui-designs/native-ui-FitnessAI-2026-08-08/previews/iphone-core-alpha-final-v1.html`; its hierarchy, containment, action placement, navigation, reflow, and state grammar are implementation-authoritative, while fixture values and system-owned Share Sheet chrome are illustrative.

**Confirmed color reference:** Titanium Measure uses a calibrated cyan action role inspired by high-energy training contrast without replicating the Apple Activity ring element or reassigning Apple's exact Move/Exercise/Stand semantics.

The Watch view is an instrument panel, not a dashboard. iPhone may carry denser review and analysis, but evidence and correction still outrank decoration. No visual treatment may imply sensed external load, confirmed RPE, supported exercise coverage, or successful synchronization when the underlying state says otherwise.

## Colors

Palette roles map to the confirmed Titanium Measure system. Physical-device testing remains a release check for rendered contrast, Always On, P3/sRGB, and gym lighting; it is not an unresolved brand decision.

- `{colors.surface-base}` / `{colors.surface-base-dark}` are the native-adjacent base canvases.
- `{colors.surface-raised}` / `{colors.surface-raised-dark}` hold reviewable facts and sheets.
- `{colors.ink-primary}` / `{colors.ink-primary-dark}` carry essential values and actions; `{colors.ink-secondary}` / `{colors.ink-secondary-dark}` carry provenance and secondary sync text.
- `{colors.action}` / `{colors.action-dark}` are reserved for user-authoritative actions such as Start, Resume, confirm, or apply. They do not mean “AI approved.”
- `{colors.success}` / `{colors.success-dark}`, `{colors.warning}` / `{colors.warning-dark}`, `{colors.error}` / `{colors.error-dark}`, and `{colors.pending}` / `{colors.pending-dark}` supplement text and symbols; color is never the sole state cue.

Contrast targets: normal text and essential numeric values meet WCAG 2.2 AA 4.5:1 against their rendered surface; large text meets 3:1; focus indicators, controls, and meaningful non-text state marks meet 3:1. The final palette must be re-measured for every load-bearing light/dark combination.

## Typography

Typography inherits native SwiftUI roles. This spine defines semantic use, not fixed pixel sizes.

- `{typography.session-value}` is for changing repetitions, load, rest, and RPE values. Use monospaced digits where reflow would impair glanceability.
- `{typography.title}` names the current surface or review context.
- `{typography.body}` explains actions and consequences.
- `{typography.label}` names fields and decisive controls.
- `{typography.meta}` carries provenance, model/source labels, timestamps, and synchronization detail, but never as the only critical state indicator.

Dynamic Type is mandatory on iPhone and respected wherever watchOS exposes the equivalent. Avoid truncating Exercise names, lifecycle consequences, or correction values; wrap, scroll, or move expanded detail to iPhone instead.

## Layout & Spacing

**[ASSUMPTION]** The spacing extension uses a 4-point scale: `{spacing.1}` through `{spacing.6}`. Native safe areas, navigation containers, lists, sheets, and toolbar placement remain platform-owned.

- Watch: one primary task per view; expose current exercise/set facts, the next authoritative action, and no competing navigation during an active set.
- iPhone: dense information may use grouped lists and summaries, but field-level correction, provenance, and plan diffs remain readable in linear order.
- Related label/value/provenance clusters use `{spacing.1}`–`{spacing.2}`; separate correction choices use `{spacing.3}`–`{spacing.4}`; major review sections use `{spacing.5}`–`{spacing.6}`.
- Do not compress pending, conflict, deletion, or privacy consequences merely to avoid scrolling.

## Elevation & Depth

Inherit native material, sheet, and navigation elevation. Hierarchy comes from platform containment, typography, and tonal separation—not decorative shadow.

**[ASSUMPTION]** Custom shadows are disallowed in the initial spine. A raised surface uses `{colors.surface-raised}` or `{colors.surface-raised-dark}`; destructive or uncertain meaning remains in text/state, not elevation.

## Shapes

**[ASSUMPTION]** `{rounded.sm}`, `{rounded.md}`, and `{rounded.lg}` provide a restrained extension for custom rows and sheets; `{rounded.full}` is limited to compact controls and state chips. Native controls keep native geometry.

Shape never carries state by itself. Pending and confirmed facts must remain distinguishable by label, symbol, and accessibility value even when both use the same radius.

## Components

The names below are the shared component contract with `EXPERIENCE.md`.

Classification is normative:

- **`native-as-is`** has no custom color, radius, spacing, or interaction-state tokens; SwiftUI owns focused, pressed, selected, disabled, and error presentation.
- **`native-with-named-delta`** inherits all native geometry and interaction states except the exact machine-readable delta listed in frontmatter.
- **`fully-custom`** uses the light/dark and state tokens in frontmatter. Noninteractive custom components explicitly mark focused/pressed/selected/disabled as not applicable; native child actions still inherit native state.

| Component | Classification | Visual specification | Focused / pressed / selected / disabled / error contract |
|---|---|---|---|
| `ai-conversation` | `native-as-is` | Native SwiftUI text editor, scroll container, and actions. No chat-bubble layout or final content composition is specified by this spine. | Native focus, pressed, disabled, keyboard, and error behavior. Send is visually and semantically distinct from approval. |
| `remote-ai-authorization` | `native-as-is` | Native list/form sections, toggles, disclosure text, and time-window controls. All categories render off initially. | Native states; focus or scrolling cannot change selection. Missing disclosure disables Allow and exposes a textual error. |
| `proposal-approval-gate` | `native-as-is` | Native review sections and one explicitly labelled approval action after the complete plan/diff. No sticky or chat-inline approval treatment is specified. | Native states; disabled until validation passes. Invalidated approval returns to review with a textual reason. |
| `safety-stop` | `native-as-is` | Native alert/inline notice using literal non-diagnostic copy and explicit allowed continuation actions. | Native states; warning/error meaning is named in text and never color-only. |
| `forgotten-finish-prompt` | `native-as-is` | Native Watch prompt with one summary and two text-labelled actions: Finish and Continue. No celebratory or urgency treatment. | Native states; never triggers automatically, and Continue/dismiss remains visually distinct from Finish. |
| `analysis-summary` | `native-as-is` | Native Swift Charts and grouped-list summaries; no custom chart geometry or palette is introduced in this update. Every chart has an adjacent textual equivalent. | Native selection/focus states; stale/pending/error remain explicitly labelled and never color-only. |
| `healthkit-capability-row` | `native-as-is` | Native settings row and status detail for capability-specific Apple Health read/write state. | Native states; system icons supplement explicit not-requested/no-data/pending/written/failed/detached text. |
| `proactive-review-invitation` | `native-as-is` | Native nonmodal iPhone card/sheet with Review, Later, and Disable; appears at most once per completed session. | Native states; Review uses the authoritative action role, while Later/Disable remain secondary and fully accessible. |
| `session-control` | `native-with-named-delta` | Native SwiftUI Button with only the enabled authoritative-action foreground/background overridden for light and dark appearance. Finish is text-labeled. Geometry is native. | All interaction states and destructive/error variants inherit SwiftUI; no custom state color or geometry. |
| `actual-set-row` | `fully-custom` | Actual Set values use `{typography.session-value}`, labels `{typography.label}`, provenance `{typography.meta}`; raised surface, border, and `{rounded.md}` have explicit light/dark tokens. | Focused uses action border; pressed uses muted surface; selected uses success border; disabled uses secondary ink; error uses error border. Text/symbol still names state. |
| `recognition-state-chip` | `fully-custom` | Compact text + symbol for accepted, uncertain, corrected, unresolved, pending, or stale, with explicit light/dark neutral and semantic tokens. | Noninteractive: focus/press/select/disabled do not apply. Accepted, pending, and error foreground tokens supplement—not replace—the label and symbol. |
| `quick-correction-sheet` | `native-as-is` | Native SwiftUI sheet. Retained captured facts and named child components provide its content; no custom sheet material, radius, or spacing contract. | Sheet and child native actions inherit all native states. No hidden destructive action. |
| `load-stepper` | `native-with-named-delta` | Native Stepper/Digital Crown editing; delta is `{typography.session-value}` for the value plus `{typography.meta}` and appearance-aware secondary ink for provenance. | Geometry, focus, press, selection, disabled, and error presentation inherit SwiftUI. Prefill source remains text, not a custom state color. |
| `rpe-verification-prompt` | `fully-custom` | Post-set prompt uses explicit light/dark surface, text, border, and `{rounded.md}`; prediction, integer response, provenance, and uncertainty remain visible. | Focused/action, pressed, selected/confirmed, disabled, and error have explicit border/surface/ink tokens; native choice controls retain their native state behavior. |
| `plan-diff-review` | `fully-custom` | Linear field-level comparison with explicit light/dark surface and border. Changed fields use the appearance-aware action border; unchanged context is de-emphasized. | Container and diff rows are noninteractive. Error uses error border; child accept/edit/decline actions inherit native states. |
| `sync-state-indicator` | `fully-custom` | Text + symbol for saved locally, syncing, restored, conflict, or failed, with explicit light/dark neutral, pending, and error tokens. | Noninteractive: focus/press/select/disabled do not apply. Pending/error tokens supplement the explicit state label. |
| `recovery-choice-sheet` | `native-as-is` | Native SwiftUI sheet naming recovered session/time; content uses native actions and named child components. No custom sheet geometry or color. | Sheet and Resume/Finish/discard actions inherit native states and destructive/error treatment. |
| `support-boundary-notice` | `fully-custom` | Inline notice has explicit light/dark surface, text, border, warning, and error tokens plus `{rounded.md}`. | Container is noninteractive; warning/error are labeled. Any child route action inherits native focused/pressed/selected/disabled behavior. |
| `lifecycle-request-row` | `fully-custom` | Request scope, time, and accepted/in progress/completed/failed state use explicit light/dark surface, border, and text tokens. | Focused uses action border; pressed uses muted surface; selected/completed uses success border; disabled uses secondary ink; failed uses error border. |
| `plan-exchange-review` | `fully-custom` | V1.1 file identity, version, source, plan ledger, mapping, omissions, and new-draft consequence use raised ledger surfaces. Pending mapping uses amber rail + literal text; invalid input uses error rail. | Focused uses action border; unresolved/error states remain text-labelled; Create Draft is the only primary action and appears only when review is complete. |
| `structured-input-draft` | `fully-custom` | Future-only draft boundary for voice/third-party input. Muted surface, source label, parsed fields, ambiguity/conflict rail, and explicit Confirm/Edit/Reject/Cancel actions. | Draft uses pending treatment; conflict uses error rail without replacing the committed fact; native child actions own interaction states. No MVP page may instantiate it. |

## iPhone Private-Alpha Key-Screen Layout Contract

The compact-width reference frame is 390 × 844 pt with a 20 pt content inset. The same contract must reflow from iPhone 11 through current larger iPhones without horizontal scrolling. At accessibility sizes, metric grids become vertical fact groups, diff columns become sequential “Current / Proposed” groups, and bottom actions remain reachable above the home indicator.

| Layout ID | Final composition | Primary action placement | Required representative states |
|---|---|---|---|
| `AI-L01` Plan Home | Effective revision and Watch delivery truth lead; today’s ordered session ledger follows; AI revision entry is secondary. Four native destinations are Plan, History, Analysis, and More. | Contextual Start belongs to Watch; iPhone exposes “Adjust with AI” after current-plan facts. | No plan, local plan ready, Watch pending/delivered/failed, offline last-delivered revision. |
| `AI-L02` AI Plan Chat | Native navigation; one inline missing-answer/assumption summary; linear text conversation; persistent native composer; structured draft remains visually separate and explicitly non-effective. | Send remains inside the composer and can never approve. | Empty, composing, generating/cancellable, retained-input failure, safety stop. |
| `AI-L03` Remote AI Authorization | Purpose and provider policy precede default-off category rows; record categories expose a required time-window control; exclusions are a full-width attention panel. | One bottom-safe “Authorize and Continue,” disabled with a literal reason until disclosure and selection are complete. | Required, partially selected, authorized, withdrawn, expanded-scope blocked, disclosure incomplete. |
| `AI-L04` Proposal Review | Proposal identity precedes a complete new-plan ledger or complete field-level diff; Safety Rule Pack result, mappings, assumptions, unresolved fields, and non-mutation scope appear before the digest. | Bottom-safe pair: Continue Conversation/Reject secondary, Continue to Approval primary. | Valid complete plan, valid diff, unmapped, contradictory, safety-blocked, base stale, approval invalidated. |
| `AI-L05` Approval / Commit / Delivery | A separate approval screen repeats `proposalId`, base revision, digest, validation, consequence, and future-session scope. After approval, local commit and Watch delivery occupy separate state panels. | One explicit “Approve and Create Revision N”; later screens expose Retry only at the failed boundary. | Approval ready/disabled/invalidated, commit pending/failed/succeeded, Watch pending/delivered/failed. |
| `PW-L01` Phone-only Active Workout | Native iPhone workout view mirrors the shared session facts without imitating a Watch: immutable Plan snapshot, current Exercise/Set ledger, planned versus Actual values, local-save truth, and one manual Complete Set path. | One bottom-safe Complete Set or Finish action appropriate to the current state; editing remains inline/contextual. | Planned/ad-hoc, ready/active/paused, local save pending/failed/succeeded, unsupported automation absent, offline, recovery available. |
| `PW-L02` Phone-only Set Edit & Recovery | Native sheet/review exposes reps, Actual Load, provenance, pending fragment, split/merge/insert/delete, and exact recovered session identity using the same components as Session Review. | Save Correction or Resume is primary only after valid input; Finish Incomplete and confirmed Discard are explicit separate consequences. | Edit valid/invalid, correction commit failed/succeeded, recovered, pending fragment, incomplete, discard confirmation. |
| `HX-L01` Training History | Period and filters lead; exact period summary follows; chronological rows keep Complete/Incomplete, revision, and sync truth attached. | Row opens Session Review; reuse is a named secondary row action. | Ready, empty, offline cache, incomplete, conflict, tombstoned, restoration pending/failed. |
| `AN-L01` Analysis | A literal conclusion leads each view, followed by exact metrics, one evidence chart, adjacent textual equivalent, exclusions, and table alternative. Week/month and Primary Exercise are explicit selections. | Analysis has no forced CTA; stale inputs expose “Resolve Records.” | Weekly, monthly, Primary Exercise trend, empty, loading, stale/conflicted, calculation failure, partial data. |
| `HK-L01` Apple Health | One native capability row per read/write purpose; each row names scope and observable state. Local FitnessAI authority is persistent. A separate panel explains that HealthKit access sends nothing remotely and routes eligible user-selected local summaries to the default-off per-request authorization preview; the route is disabled with its blocking reason until the provider/compliance gate closes. | Capability toggle/route is row-scoped; Retry/Re-write appears only for the affected copy; “Preview AI Use” never implies authorization. | Not requested, no accessible data, available, write pending/written/failed, `healthKitDetached`, HealthKit unavailable, AI summary ineligible/previewable/gate-blocked. |
| `PX-L01` Plan Exchange | Export review shows selected plan plus included/excluded data before file creation. Import shows source/version, bounded validation, complete plan, mappings/omissions, and new-draft consequence. Native Share Sheet remains system-owned. | Export: “Create File and Share.” Import: “Create New Draft,” enabled only after every unresolved item is mapped or explicitly omitted. | Export ready/failed/share cancelled; import loading/valid/unresolved/duplicate/invalid/unsupported/commit failed. |
| `RV-L01` Proactive Review | A native nonmodal sheet overlays the completed Session Review once; it states that no data has been sent and no proposal exists. Review routes to explicit evidence authorization, then the existing complete diff and approval path. | Review primary; Later and Disable secondary and non-destructive. | Available, later, disabled, authorization required, generating, valid diff, AI unavailable/invalid. |

Shared fixed-bottom actions use a native safe-area inset and reserve equivalent scroll padding. They are permitted only for the screen’s single consequential next step; browsing, chart selection, field expansion, and ordinary navigation stay inline. Error focus lands on the error summary, Retry preserves inputs and selections, native back preserves non-effective chat/draft work, and successful local commit restores focus to the exact resulting state panel.

## Do's and Don'ts

| Do | Don't |
|---|---|
| Show saved, inferred, user-confirmed, pending, and synchronized as different concepts | Use one green checkmark to collapse all trust states |
| Keep active-set visuals quiet and glanceable | Prompt, animate, or celebrate during a formal set |
| Keep correction scope and retained facts visible | Replace a whole set when only one field changes |
| Label load as planned, historical, previous-set, or user-entered | Imply the Watch sensed external load |
| Pair semantic color with text, symbol, and accessibility value | Depend on red/green discrimination |
| Preserve native Dynamic Type, VoiceOver, Reduce Motion, and platform navigation | Override native behavior for visual novelty |
| Present phone-only recording as the same truthful session model with native iPhone controls | Fake Watch automation or create a second record model for users without a Watch |
| Name unsupported/manual-only behavior before it becomes a surprise | Present catalog size as automatic coverage |
| Treat dark mode and gym/outdoor legibility as release checks | Assume a simulator palette is sufficient |

**Remaining release validation:** physical-device dark/light/Always On tuning, haptic discernibility, SF Symbol optical weight, largest Chinese text, and geometry across supported devices. These validate the confirmed Titanium Measure system; they do not reopen phase scope or authorize deferred surfaces.
