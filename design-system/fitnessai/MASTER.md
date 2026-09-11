---
title: FitnessAI Titanium Measure Design System
status: confirmed-visual-authority
version: 1.1.0
confirmed_direction: Titanium Measure
stack: SwiftUI
platforms: [iOS 18+, watchOS 11+]
updated: 2026-09-09
---

# FitnessAI Titanium Measure Design System

## 1. Authority and Use

This file is the global visual source of truth for FitnessAI. Page overrides in `pages/` may specialize composition but cannot change product behavior, scope, safety, privacy, trust semantics, or platform ownership.

Behavioral authority remains, in order: the PRD, Addendum, `EXPERIENCE.md`, and their accessibility, trust/privacy/safety, validation, and review documents. When behavior and visuals conflict, behavior wins. When the old BMAD `DESIGN.md` and this confirmed system differ on visual expression, this system wins.

The system is for native SwiftUI implementation. HTML files in the visual delivery are review carriers only.

## 2. Brand Foundation

**Direction:** Titanium Measure — a calibrated training instrument that feels precise, quiet, durable, and user-authoritative.

**Brand attributes:** calibrated, quiet, technical, trustworthy, durable, exact, restrained.

**Visual premise:** facts occupy stable, aligned locations. Thin rails, tabular figures, explicit provenance labels, and bounded attention zones make uncertainty visible without turning the product into a traditional dashboard.

**Never imply:** sensed external load, certain subjective RPE, full-body form judgment from wrist signals, cloud completion before synchronization, or automatic authority over user corrections.

## 3. Core Principles

1. One primary task per Watch screen; one primary action per state.
2. Actual facts outrank plan, prediction, automation, and synchronization metadata.
3. State is expressed through text, symbol, structure, and contrast—not color alone.
4. Local durable commit is the saved boundary; cloud synchronization is separate.
5. Automation is reversible and never hides original provenance.
6. Active sets remain visually and behaviorally quiet.
7. iPhone supports denser review without repeating identical rounded cards.
8. Light, dark, Always On, Increase Contrast, Dynamic Type, VoiceOver, and Reduce Motion are designed together.

## 4. Semantic Color System

Raw values live in `tokens.json`. Components consume semantic roles only.

| Role | Dark | Light | Purpose |
|---|---|---|---|
| `background.canvas` | `#070A0D` | `#F4F7F8` | App canvas |
| `background.surface` | `#0D1318` | `#FFFFFF` | Raised working surface |
| `background.subtle` | `#121A20` | `#EAF0F2` | Grouping without card overload |
| `text.primary` | `#F2F7FA` | `#0B1115` | Critical facts and headings |
| `text.secondary` | `#9CAAB2` | `#4F626C` | Supporting context |
| `text.tertiary` | `#74838B` | `#61737C` | Noncritical metadata only |
| `border.standard` | `#2B3740` | `#B9C6CC` | Rails, ledgers, separators |
| `action.primary` | `#58D7FF` | `#007D9A` | User-initiated primary action |
| `attention.pending` | `#FFC857` | `#875B00` | Pending or needs review |
| `status.confirmed` | `#80D6A3` | `#0A6E42` | Confirmed plus check/text |
| `status.correction` | `#A9B4FF` | `#4B55A5` | Corrected/revision plus pencil/delta |
| `status.destructive` | `#FF8A83` | `#B42318` | Destructive or integrity-threatening |

Rules:

- `action.primary` is not a generic brand fill; it identifies the current user action.
- Amber never means failure. It means unresolved attention, pending confirmation, or deferred consequence.
- Green never means synchronized unless the adjacent label explicitly says synchronized.
- Increase Contrast changes secondary rails to 2 pt, elevates secondary text contrast, and adds outlines to filled status regions.
- Always On uses black canvas, `#D9E0E3` primary content, `#8B979D` secondary content, and outline-only action/status treatments.

## 5. Typography and Numerals

Use native San Francisco and the system Simplified Chinese fallback only. Do not ship Inter, Google Fonts, or a custom font dependency.

| Role | SwiftUI baseline | Weight | Behavior |
|---|---|---|---|
| Watch metric | Scaled 48–64 pt reference | Bold | `monospacedDigit()`, one dominant fact |
| iPhone metric | Scaled 40–56 pt reference | Bold | `monospacedDigit()`, direct unit |
| Page title | `.largeTitle` / `.title` | Bold | Wrap before truncation |
| Section title | `.title2` / `.headline` | Semibold | Left aligned |
| Body | `.body` | Regular | Literal Chinese, 1.25–1.45 line height |
| Label | `.subheadline` / `.caption` | Medium | State or source labels |
| Metadata | `.caption2` | Medium | Never carries a required action alone |

Training values use tabular figures. Units remain visually attached but lower emphasis. Dynamic Type reflows columns into a linear reading order before clipping. At accessibility sizes, decorative index labels may disappear; state, value, source, and action may not.

## 6. Grid, Spacing, Shape, and Layering

- Base rhythm: 4 pt; preferred increments: 4, 8, 12, 16, 24, 32, 48.
- iPhone horizontal inset: 20 pt compact, 24–32 pt regular width.
- Watch content inset: system-safe 8–12 pt depending on case size.
- Minimum frequent/consequential touch target: 44 × 44 pt; minimum adjacent separation: 8 pt.
- Radius: 8 pt compact controls, 12 pt working surfaces, 16 pt modal/sheet boundary. Pills are limited to native status/control patterns.
- Borders: 1 pt standard, 2 pt focused/Increase Contrast.
- Shadows: none for ordinary grouping. Use native sheet/modal separation only.
- Blur: only for system sheets, navigation chrome, or modal background separation; never decorative ambience.

Grouping order: whitespace → alignment → rail/divider → subtle surface → raised modal. Do not put every section in a card.

## 7. Icon System

Use SF Symbols only for product UI. Use outline symbols for navigation and neutral status; filled variants only for selected navigation or committed emphasis.

| Meaning | Preferred symbol | Required adjacent language |
|---|---|---|
| Confirmed | `checkmark.circle` | “已确认” / exact confirmed fact |
| Pending | `clock` | “待处理” or “等待同步” |
| Corrected | `pencil.and.outline` | “已纠正” plus prior/current value |
| Sync | `arrow.triangle.2.circlepath` | Exact sync boundary |
| Synchronized | `checkmark.icloud` | “已同步” |
| Warning | `exclamationmark.triangle` | Cause and next action |
| Unsupported | `slash.circle` | “不支持” plus fallback |
| Manual-only | `hand.tap` | “仅支持手动记录” |
| Watch route | `applewatch` | Destination/action label |
| Analysis | `chart.xyaxis.line` | Chart title and summary |

Symbol size tokens are 12, 16, 20, and 24 pt. The visual glyph may be smaller than its 44 pt hit region. Do not use emoji, SF Symbols as the app logo, or animated Variable Color during formal sets.

## 8. Fact, Provenance, and Durability Grammar

Every recorded fact may expose four layers in this order:

1. **Value:** actual load, repetitions, exercise, RPE, time.
2. **Source:** plan, previous Actual Set, history, user input, model prediction.
3. **Authority:** predicted, auto-used, user-confirmed, corrected, unresolved.
4. **Durability:** editing, committing locally, saved locally, sync pending, synchronized, failed.

Compact views may collapse source and authority into one phrase but may not merge durability into it. “已记录” never implies “已同步.”

## 9. Component Language

| Component | Visual form | Key invariant |
|---|---|---|
| Instrument Readout | Dominant tabular value + unit + source line | No unsupported sensing claim |
| State Rail | Thin segmented progress/durability rail | Text alternative always present |
| Primary Action | Full-width cyan action, one per state | Result shown only after local commit |
| Actual Set Ledger Row | Aligned values separated by rules | Source/revision remains attached |
| Fact State Label | Symbol + literal state + optional source | Never color-only |
| Correction Boundary | Amber left rail + retained facts + choices | Later preserves the pending fact |
| Crown Adjustable Value | Draft value + source + explicit commit | Crown never commits by rotation alone |
| Plan Diff | Before/current/proposed ledger | Names future revision affected |
| Sync Boundary | Device/copy scope + state + next action | Local success survives cloud failure |
| Trend Evidence | Direct-labelled line/bar + text summary | Pending/conflicted inputs excluded or labelled |
| Plan Exchange Review | Source/version + complete plan ledger + mapping/omission + one Create Draft action | Private Alpha; untrusted input never overwrites an existing plan |
| Structured Input Draft | Source-labelled draft + parsed facts + ambiguity/conflict + explicit choices | Future only; committed facts remain authoritative until confirmed replacement commits |

Complete behavior and SwiftUI contracts are in the visual delivery `components/` directory.

## 10. Chart Language

- Trend over time → line chart with direct end value, exact selected point, time granularity, and text summary.
- Weekly/monthly comparison → aligned bars or compact table; never use a decorative donut for exact training values.
- Confirmed series → solid line; pending/excluded projection → dashed line; corrected point → outlined diamond or explicit revision marker.
- Gridlines are subordinate; axes include unit and granularity.
- Every chart includes a VoiceOver summary and a data-table alternative.
- Interactive points have an effective 44 pt target. Reduce Motion disables line drawing and animated interpolation.

## 11. Motion and Haptics

Motion communicates commit, replacement, or navigation only.

| Token | Duration | Use |
|---|---:|---|
| `motion.press` | 100 ms | Opacity/state-layer press feedback |
| `motion.replace` | 180 ms | Crossfade value or status replacement |
| `motion.enter` | 220 ms | Native sheet/detail entry |
| `motion.exit` | 150 ms | Dismissal |

No continuous ambience, celebration, bounce, parallax, marquee, or decorative loading during training. Reduce Motion uses an immediate update or short crossfade.

Haptics are selective: selection feedback for intentional adjustable steps; success only after local commit; one warning for required attention; notification/error only when record integrity is at risk. Never haptic every tap.

## 12. Platform Composition

### Apple Watch

- Dominant hierarchy: Exercise → set/rest context → Actual Load → reps → one action.
- Every screen has one task. Complex correction, conflicts, and unsupported semantics hand off to the exact iPhone object and field.
- Digital Crown is an optional accelerator with touch and accessibility-adjustable equivalents.
- Always On preserves exercise, set, load/reps context, and durability state while reducing color and disabling actions.
- Formal sets do not present proactive prompts unless capture integrity is threatened.

### iPhone

- Top-level native navigation exposes Today, History, and Analysis; Catalog, Sync & Recovery, Account & Privacy, and Support Matrix are one level away.
- Use editorial alignment, ledgers, timelines, and direct chart labels instead of identical cards.
- Fixed bottom actions reserve safe-area and scroll insets.
- Complete correction, split/merge/insert/delete, conflicts, lifecycle scope, and long explanations belong here.

### Phase extensions

- Private-Alpha Training Plan portability is a contextual iPhone route, not a new tab. It uses `Plan Exchange Review`, treats files as untrusted, previews complete content and provenance, invokes the native Share Sheet for export, and creates a new draft only on import.
- Private-Alpha text AI planning uses native conversation, default-off remote-data authorization, complete plan/diff review, separate digest-bound approval, atomic local commit, and eventually consistent Watch delivery. Final layout IDs are `AI-L01`–`AI-L05` and `RV-L01` in `DESIGN.md`.
- Post-Alpha voice, third-party import, QR/link sharing, weekly/cycle proactive cadence, and open-ended coaching may reuse the grammar only after their Product gates pass. No continuous listening or first-build affordance is implied.

## 13. Accessibility Contract

- iPhone supports at least 200% text enlargement; Watch supports at least 140%.
- VoiceOver order follows visual priority, not implementation nesting.
- State updates coalesce; active-set announcements are deferred unless record integrity is threatened.
- Increase Contrast has explicit token mappings; Reduce Transparency removes nonessential blur.
- Full Keyboard Access works for iPhone review and correction.
- Charts expose summaries, selected values, and a table alternative.
- No required distinction relies on hue, animation, gesture, or Digital Crown alone.

## 14. SwiftUI Implementation Rules

- Use semantic `Color` assets with Any/Dark/High Contrast appearances.
- Use semantic `Font` roles and `@ScaledMetric`; avoid fixed body sizes.
- Use `NavigationStack` and typed `navigationDestination(for:)`.
- Use native `Button`, `Toggle`, `Picker`, `Stepper`, `Gauge`, `Chart`, `sheet`, `alert`, and accessibility actions where behavior matches.
- Use `Canvas`/custom drawing only for rails or chart marks that native APIs cannot express.
- Read `accessibilityReduceMotion`, `accessibilityDifferentiateWithoutColor`, `accessibilityContrast`, and `isLuminanceReduced` where relevant.
- Local commit state drives visual success; networking state may update a separate sync indicator only.

## 15. Page Override Routing

- `pages/watch-training.md`: all Watch training surfaces.
- `pages/iphone-planning-review.md`: Plan Home, AI planning/review/approval/delivery, Training Plans, History, Session Review, proactive review, and Plan Exchange.
- `pages/iphone-analysis-system.md`: complete Analysis, Apple Health, Catalog, Sync & Recovery, Account & Privacy, and Support Matrix.

Page-level product specifications live in the confirmed visual delivery under `watch/` and `iphone/`.

## 16. Forbidden Patterns

- Web/Tailwind components, hover-dependent behavior, GSAP, Google Fonts, or CSS token names as implementation guidance.
- Cinematic glow, ambient blobs, decorative glassmorphism, gradients that obscure data, or faux-hardware skeuomorphism.
- Generic orange/green fitness semantics, emoji icons, dense Watch dashboards, or ten-button RPE grids.
- “Detected load,” “your RPE is,” “fully synced” without proof, or hidden incomplete facts.
- Automatic plan mutation, automatic session finish, or irreversible automation.

## 17. Physical-Device Validation Gates

Before release, validate on supported small/large Watch cases and iPhone sizes:

- two-second glance comprehension under bright and dim gym lighting;
- sweat/one-hand touch, Crown adjustment, accidental-touch resistance, and haptic discernibility;
- Always On luminance reduction and burn-in-safe output;
- longest approved Chinese strings with largest supported text sizes;
- VoiceOver focus restoration across Watch↔iPhone handoff;
- P3/sRGB color appearance and Increase Contrast;
- chart point selection, safe-area clearance, offline/recovery, and local-write failure states.

## 18. Change Control

Visual changes update this file, `tokens.json`, affected page overrides, page specifications, previews, and both English/Chinese documents together. Behavioral changes must first update the authoritative product/experience documents; this visual system cannot silently redefine them.
