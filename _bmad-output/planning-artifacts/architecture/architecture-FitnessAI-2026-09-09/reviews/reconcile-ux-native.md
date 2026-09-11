# UX / Native Input Reconciliation Review

**Target:** `ARCHITECTURE-SPINE.md`  
**Inputs compared:** `EXPERIENCE.md`, `DESIGN.md`, `native-ui-spec.md`, `architecture-handoff.md`, `design-system/fitnessai/MASTER.md`, and both token files  
**Review date:** 2026-09-10  
**Verdict:** **NEEDS FIXES BEFORE FINAL**

The architecture captures the core truth, ownership, synchronization, AI proposal/approval, Apple Health adapter, persistence, and analysis invariants well. It is not yet safe to mark final because two accepted Product Owner overrides still conflict with authoritative UX text, and load-bearing navigation plus native visual/accessibility boundaries are neither bound nor explicitly deferred.

## Coverage Matrix

| Dimension | Verdict | Evidence in the spine | Reconciliation result |
|---|---|---|---|
| State and durable truth | Pass | AD-2, AD-4, AD-5, AD-7, AD-11; explicit-state convention | The important saved/pending/conflicted/stale/error distinctions survive. Exact UI state enumerations can remain in UX/native companions as long as those companions are made binding. |
| Ownership | Pass | AD-3 and Capability → Architecture Map | iPhone, Watch, HealthKit adapter, AI proposal, and analysis ownership agree with the native handoff. |
| Navigation | Fail | Stack names `NavigationStack/TabView`, but no route/root/restoration rule | The required tab set, contextual destinations, Watch route, and back-state restoration could be implemented incompatibly. The visual authority also contains a `Today` versus `Plan/More` conflict that the spine does not resolve. |
| AI approval | Pass | AD-7 and AD-8 | Complete structured proposal/diff, deterministic validation, digest-bound one-time approval, invalidation on change, and atomic revision commit are preserved. This correctly allows AI to fill the entire plan while forbidding silent/unreviewed mutation. |
| Error and recovery | Pass with one gap | AD-2, AD-4, AD-5, AD-7, AD-11 plus explicit-state convention | Durable recovery is strong. Presentation recovery rules—retain input, focus the error summary, retry only at the failed boundary, keep usable cached/local facts visible—are not bound; this can be covered by a native companion convention rather than a new AD. |
| Accessibility | Fail | AD-13 requires accessibility tests only | Testing is named, but the required implementation invariants are not: 200% iPhone/140% Watch text scaling, non-color cues, 44 pt targets, Crown alternatives, focus restoration, chart text/table alternatives, Reduce Motion/Contrast behavior. Tests cannot converge implementations unless the contract they test is bound. |
| Visual boundary | Fail | Source list includes the design system, but no rule binds it | The handoff explicitly calls Titanium Measure 1.1.0 and semantic tokens immutable. Without a Convention/AD, separate features may embed raw colors, fixed sizes, shadows, or conflicting status semantics. |

## Findings

### F1 — Blocker: the accepted Apple Health → remote AI override conflicts with all current UX/native screens

The Product Owner subsequently accepted broad, training-relevant Apple Health reads and explicit per-request AI use after a second authorization. The spine carries that newer decision correctly:

- AD-8 requires every remote request to preview purpose, categories, time window, provider, and local summary, with allow/narrow/cancel.
- AD-9 defines the versioned Apple Health read allowlist and permits remote use only through AD-8, using local summaries rather than unrestricted raw streams.

However, the current UX/native authority still states the opposite:

- `EXPERIENCE.md` Trust/Privacy says Apple Health is excluded from Alpha remote AI.
- `native-ui-spec.md` §4 says Apple Health remains excluded from authorization categories.
- `DESIGN.md` `HK-L01` requires a persistent “remote-AI exclusion” panel.

The spine acknowledges this only as a Deferred reconciliation item. That is insufficient for implementation: an engineer following AD-8/9 will offer scoped Apple Health summaries, while an engineer following the authoritative layouts will permanently label them excluded.

**Required fix before final:** record the Product Owner decision as the explicit newer behavioral override and update the bilingual `EXPERIENCE.md`, `DESIGN.md`, native UI spec/handoff, and affected preview/layout copy together. The UI must show two independent grants: HealthKit capability access, then per-request remote-AI use of named local summaries. Categories default off; narrowing or cancelling sends nothing. Keep AD-9’s medical exclusions and do not describe the decision as unrestricted access to every HealthKit type.

### F2 — Blocker: the phone-only first-class path conflicts with the UX foundation

AD-3 correctly binds phone-only capture to the same IDs, states, persistence, and Analysis as paired use. This reflects the accepted Product Owner requirement that many users have no Watch.

`EXPERIENCE.md` Foundation still describes the Alpha as native SwiftUI “on paired iPhone and Apple Watch,” and its primary execution journeys start from Watch. The spine defers reconciliation, but no companion currently defines the phone-only start/record/edit/finish/recovery surfaces and states.

**Required fix before final:** either update the UX/native companions so phone-only recording is an in-scope first-class journey, or explicitly bound a pre-implementation UX deliverable and block phone-only stories until it exists. Do not remove AD-3 or treat phone-only use as a degraded error path.

### F3 — High: Titanium Measure and accessibility are source links, not binding architecture conventions

The native handoff says Architecture **must preserve** Titanium Measure 1.1.0 semantic names and native implementation rules. `MASTER.md` also binds the fact/source/authority/durability visual grammar, one primary action per state, quiet active sets, semantic colors, native text sizing, non-color cues, and platform behavior. The spine merely lists these files as sources and names SwiftUI; AD-13 only says accessibility tests run.

Two feature teams could therefore choose incompatible token names, status semantics, focus behavior, touch sizes, or custom styling while still satisfying every current AD.

**Required fix before final:** add a load-bearing Convention (an AD only if desired) that binds:

1. `design-system/fitnessai/MASTER.md` and `tokens.json` as the visual semantic authority, with Titanium Measure 1.1.0 and semantic assets rather than raw values.
2. The display order fact → source/authority → durability → consequence/action; local save never implies synchronization.
3. Native Dynamic Type/VoiceOver/Full Keyboard Access, non-color/non-motion/non-haptic/non-Crown alternatives, 44 × 44 pt consequential/frequent targets, and chart text/table equivalents.
4. Error focus/input retention and back/handoff focus restoration from the native contract.

Raw token values and component styling should remain in the design-system companions rather than being copied into the spine.

### F4 — High: the navigation graph is omitted, and the visual sources disagree on its top level

The final native handoff and layout contract require:

- iPhone `TabView`: Plan, History, Analysis, More; Plan is root.
- AI Chat, Remote Authorization, Proposal Review, Approval, Delivery, Session Review, Apple Health, and Plan Exchange as typed contextual `NavigationStack` destinations.
- Native back restores object identity, filters, scroll state, and unsent/non-effective input.
- Watch uses shallow task-specific navigation and hands complex correction/privacy/conflict work to the exact iPhone object/field.

The spine’s Stack row only says `NavigationStack/TabView`, so all of the above can drift. In addition, `MASTER.md` §12 still says top-level navigation exposes Today, History, and Analysis, while the newer finalized native contract says Plan, History, Analysis, More.

**Required fix before final:** resolve the input conflict in favor of the accepted final native handoff (or obtain a new Product Owner decision), update `MASTER.md` if needed, and bind the resulting navigation/root/restoration rule as a Convention. A full page tree does not belong in the spine; the root tabs, contextual-route ownership, and restoration invariant do.

### F5 — Medium: proactive post-session review is absent from the spine

The UX/native handoff makes the proactive review invitation a load-bearing privacy boundary: at most once per completed session; showing it or choosing Later sends nothing and creates no authorization, proposal, or approval; Disable persists until re-enabled; Review enters the normal authorization/diff/approval flow.

AD-8 protects any request that is actually sent, but the invitation trigger/state and “no hidden state” behavior are not present in an AD, Convention, capability map, or Deferred item. Separate implementations could create repeated prompts or implicit authorization.

**Required fix before final:** add a concise Convention or extend AD-8 to bind the invitation’s no-send/no-authorization semantics and route into the existing approval lifecycle. Keep its layout in UX/native documents.

## Confirmed Alignments

- AD-7 is compatible with deep AI/App integration: AI may create a complete executable Plan or field diff so users do not re-enter individual exercises/sets; only the provider is barred from bypassing validation, one digest-bound approval, and atomic commit.
- AD-2/3/4 faithfully preserve local-save versus delivered/synchronized boundaries, active-session snapshot immutability, idempotency, causal conflict handling, and Watch offline durability.
- AD-6 lands the accepted Series 11 46 mm/orientation evidence start, safe-rest recognition confirmation, RPE verification, and 15-minute dual-signal Forgotten Finish behavior without overstating broader support.
- AD-9 correctly preserves FitnessAI local authority, HealthKit observable-read limitations, idempotent workout copies, and explicit re-write after detachment.
- AD-10 reflects the later Product Owner decision to use ordinary `.json`, not a custom file extension, while preserving bounded parsing and draft-only import.
- AD-11 preserves the Analysis contract that only effective Actual Sets enter definitive aggregates and stale/conflicted inputs stay visible.

## Finalization Recommendation

Do not finalize the spine until F1–F4 are resolved. F5 may be fixed in the same pass. The leanest repair is to add two concise Consistency Conventions—native/navigation and proactive-review privacy—while updating the upstream bilingual UX/native artifacts for the two Product Owner overrides. Do not expand the spine into a screen specification or duplicate token tables.
