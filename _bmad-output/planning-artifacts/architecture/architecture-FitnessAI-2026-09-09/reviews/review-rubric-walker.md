# Architecture Spine Rubric Walker Review

**Target:** `../ARCHITECTURE-SPINE.md`  
**Translation checked:** `../ARCHITECTURE-SPINE.zh-CN.md`  
**Review lens:** BMad Architecture good-spine checklist  
**Date:** 2026-09-10  
**Verdict:** **NEEDS FIXES**

The spine has a strong and unusually coherent core: it names a paradigm, gives every AD `Binds` / `Prevents` / `Rule`, separates durable truth from adapters, preserves user-authored revisions, and covers device ownership, local persistence, AI approval, HealthKit, analysis, environments, presentation, and future cloud work. The English and Chinese copies have matching structure, AD IDs, limits, stack choices, capability rows, and deferred decisions. It should not be finalized yet because one retention sentence can be implemented as destructive deletion of iPhone history, and several remaining initiative-level seams can still produce incompatible implementations.

## Findings

### F1 — CRITICAL — The seven-day retention rule can be read as permission to delete iPhone history

- **Location:** AD-5 Rule; compare AD-3 and the Capability → Architecture Map.
- **Finding:** AD-5 binds both databases and says “acknowledged facts retain an initial seven-day window.” It does not say that this applies only to acknowledged Watch-side staging copies. AD-3 separately says iPhone owns long-term records, but it does not define retention. One persistence unit can therefore retain iPhone workout facts indefinitely while another can auto-delete any acknowledged structured fact after seven days, and both can plausibly claim compliance.
- **Why it matters:** This ambiguity sits on the destructive-data boundary. It can erase Training History, invalidate Analysis, and contradict the stated iPhone long-term truth ownership.
- **Actionable fix:** Rewrite the retention sentence to scope the seven-day safety window explicitly to redundant, acknowledged **Watch-side transfer copies**. State that iPhone authoritative Plans, Workout Sessions, Actual Sets, corrections, approvals, and effective revisions are never removed by this cleanup policy. Require an explicit user deletion revision or a separately bound retention policy for authoritative facts. Mirror the wording in Chinese.
- **Disposition:** Autofix before finalization.

### F2 — HIGH — The accepted eight-exercise recognition seed is referenced but not identified

- **Location:** AD-6 Rule (“accepted eight-exercise candidate set”); `.memlog.md` recognition decision.
- **Finding:** The spine neither lists the eight exercises nor points to a versioned artifact that does. The accepted set in the memlog is barbell bench press, incline dumbbell press, assisted pull-up, barbell row, seated row, lateral raise, hammer curl, and barbell Romanian deadlift. A model unit, onboarding unit, and UI support-matrix unit could select different exercises while all claiming to implement “the accepted set.”
- **Why it matters:** The support boundary controls what the product may claim to recognize. Divergence produces unsupported automation, misleading onboarding, and incomparable evidence.
- **Actionable fix:** Either name all eight exercises in AD-6, or bind AD-6 to a checked-in, versioned support-matrix artifact whose v1 rows contain those exact canonical Exercise IDs and separately qualify classification, set-boundary, and rep-count capability. Keep the second-wave/manual-only sets outside v1 until separately evidenced.
- **Disposition:** Autofix before finalization.

### F3 — HIGH — Watch-offline session origination has no identity rule

- **Location:** AD-3 Rule; AD-4 Rule; phone/Watch capability rows.
- **Finding:** AD-3 says iPhone creates the shared session identity in paired use, while Watch owns offline facts and active-session recovery. The document does not decide whether a Watch that has a cached Plan but cannot reach iPhone may begin a new session. If it may, no rule defines the provisional stable ID and later reconciliation; if it may not, no rule requires the Watch to block new-session start while still allowing recovery of an existing session.
- **Why it matters:** Separate iPhone and Watch session-state implementations can create duplicate sessions, attach facts to different snapshots, or silently refuse the offline behavior expected by the product.
- **Actionable fix:** Make the topology explicit. Recommended: iPhone-originated identity for the normal paired flow; Watch may always resume an already-issued active/recoverable identity. Then either (a) permit disconnected Watch start with a Watch-generated globally unique provisional session ID plus cached Plan revision and idempotent iPhone adoption, never merge-by-time, or (b) explicitly exclude disconnected new-session start from Alpha. Add the same rule to the Chinese copy.
- **Disposition:** Discuss only if the memlog does not already settle whether a disconnected Watch can start; otherwise autofix from the accepted decision.

### F4 — HIGH — Load semantics are too narrow for the product’s own exercise set

- **Location:** Consistency Conventions (“Loads preserve entered value and kg/lb”); AD-7 Safety Rules; AD-10 exchange; AD-11 Analysis.
- **Finding:** The spine preserves a numeric value and kg/lb but does not bind load kind or entry basis. Assisted pull-ups are already in the v1 recognition seed, and the PRD also distinguishes externally loaded, bodyweight, assisted, timed, and otherwise non-comparable work. Implementations could encode assistance as positive load, negative load, bodyweight subtraction, or free text; dumbbell/machine values could be total or per-side.
- **Why it matters:** Incompatible load semantics corrupt Safety Rule checks, plan exchange, next-set suggestions, history comparisons, and volume Analysis even when the raw number and unit are faithfully preserved.
- **Actionable fix:** Add a platform-neutral load contract that keeps the authoritative entered value/unit **and** an explicit load kind and basis (at minimum external, bodyweight, assisted, unloaded/timed/non-comparable; total vs per-side where applicable). Derived canonical values must retain provenance and must not collapse assisted/bodyweight/timed work into external-load volume. Put the schema detail below the spine, but bind these semantic distinctions here.
- **Disposition:** Autofix before finalization.

### F5 — HIGH — The mandatory built-in AI route has no runnable private-Alpha gateway boundary

- **Location:** AD-8; AD-13; Deferred items 2 and 5.
- **Finding:** AD-8 mandates that built-in DeepSeek use a FitnessAI gateway, and AD-13 says private Alpha has separate endpoints, identities, and credentials. Yet hosting, region, caller authentication, deployment, rollback, and abuse controls for that gateway are deferred to public beta. The provider-policy deferral blocks only real remote **health** traffic, not ordinary AI plan generation, so the private-Alpha built-in route still needs an operationally coherent gateway.
- **Why it matters:** The first implementation unit cannot know whether the built-in route is enabled, where it runs, how the owner-only Alpha authenticates, or which failures must fail closed. Two units can choose incompatible regions/authentication/deployment while obeying the current text.
- **Actionable fix:** Before finalization, choose one of two explicit contracts: (a) private Alpha ships BYOK only and the built-in route remains feature-disabled until the gateway gate is closed; or (b) bind the minimal private-Alpha gateway runtime/region, owner-only authentication, secret store, endpoint separation, request-size/rate ceilings, redacted logging, deployment/rollback owner, and kill switch. Keep production vendor selection and scale engineering deferred.
- **Disposition:** Discuss; this changes what “built-in default” means in the first runnable Alpha.

### F6 — HIGH — Public-beta cloud deferral still omits non-negotiable lifecycle invariants

- **Location:** Deferred item 5; AD-2 and AD-13.
- **Finding:** The expanded deferral now preserves tenant isolation, no cross-account merge, export, 30-day deletion, tombstones, incident response, deployment, and rollback. It still does not preserve local-first event synchronization, visible restoration progress/failure, sign-out retain/remove choice with unsynced-data warning, reauthentication for destructive privacy actions, or continued local capture during auth/cloud failure.
- **Why it matters:** These are not provider choices. They determine destructive behavior and whether cloud/account units can overwrite or strand local facts. Leaving them inside a broad “choose and threat-model” bucket permits incompatible cloud designs at the next level.
- **Actionable fix:** Keep backend/provider details deferred, but add these lifecycle semantics to the same Deferred item as invariants the later design must preserve. State that application-cloud sync inherits AD-2 revision/conflict rules and cannot introduce clock-only last-write-wins.
- **Disposition:** Autofix in Deferred before finalization.

### F7 — MEDIUM — Structural and destructive revisions are not explicitly covered by the merge rule

- **Location:** AD-2 Rule.
- **Finding:** AD-2 defines automatic merge for different-field edits and visible branches for same-field edits, but the bound mutation set also includes split/merge of set boundaries, insertion, deletion, completion state, and Plan revision changes. These are graph/structural mutations rather than ordinary field edits. The rule does not say whether they may be auto-merged with concurrent child edits or how delete-versus-edit remains visible.
- **Why it matters:** A field-oriented implementation may drop repetitions or resurrect deleted sets during concurrent Watch/iPhone correction while still following the stated field rule.
- **Actionable fix:** Add one enforceable sentence: destructive or structural conflicts (split/merge, insert/delete, completion, Plan topology) never auto-collapse when causal branches overlap; preserve every user-authored branch and dependent facts, mark results pending/stale, and require deterministic safe resolution or explicit iPhone choice. Story-level merge algorithms can remain outside the spine.
- **Disposition:** Autofix before finalization.

### F8 — MEDIUM — Alpha diagnostic/telemetry privacy is not bound although AD-13 claims to bind logs

- **Location:** AD-13 Binds/Rule; AD-5; AD-8 audit rule; PRD NFR-PRIV-003 and NFR-SEC-003.
- **Finding:** AD-13 lists logs in `Binds` but its Rule only requires secret checks. AD-8 protects AI audit content, while no cross-cutting rule prevents ordinary logs/crash diagnostics from containing workout facts, Exercise/load/RPE, health summaries, free-text notes, raw signals, or request bodies. The public-beta incident-response deferral does not settle private-Alpha diagnostics.
- **Why it matters:** Independent adapter and presentation units will otherwise log different payloads, creating a privacy leak and making later telemetry cleanup unreliable.
- **Actionable fix:** Add an Alpha observability convention: structured identifiers/state codes/versions/timing only; no secrets, request/response bodies, free text, HealthKit values, raw signals, or Exercise/load/RPE content in operational logs or automatic diagnostic payloads. Make remote telemetry opt-in or disabled for private Alpha, and keep local export/support handling explicit.
- **Disposition:** Autofix before finalization.

### F9 — LOW — Mermaid fences are escaped and will not render as a diagram

- **Location:** Structural Seed in both language copies.
- **Finding:** The document contains literal `\`\`\`mermaid` and `\`\`\`` markers. They are escaped Markdown text, not a fenced Mermaid block.
- **Why it matters:** The structural seed is the only diagram carrying the dependency shape; rendering it as punctuation makes the artifact less usable and fails the skill’s valid-Mermaid requirement.
- **Actionable fix:** Remove the backslashes from the opening and closing fences in both copies, then render or parse-check the Mermaid block.
- **Disposition:** Autofix.

## Good-Spine Checklist Assessment

| Checklist item | Assessment | Notes |
|---|---|---|
| Fixes real divergence points for the level below | **Needs fixes** | Core truth, sync, AI, HealthKit, analysis, UI, and release gates are strong; F1–F8 remain cross-unit seams. |
| Every AD Rule is enforceable and prevents its stated divergence | **Needs fixes** | Most do. AD-5 retention is dangerously ambiguous; AD-6 points to an unnamed set; AD-13 binds logs without a logging rule. |
| Nothing under Deferred could let two units diverge | **Needs fixes** | Public-beta account lifecycle and the private-Alpha gateway boundary need stronger preserved invariants. |
| Named technology is verified-current | **Pass with implementation check** | The memlog records local Xcode/Swift verification and a current GRDB check. The exact GRDB pin still needs normal project-resolution verification when the project exists. |
| Ratifies rather than contradicts a brownfield codebase | **Pass / not applicable** | The native implementation is greenfield; existing planning/design artifacts are treated as sources. No production convention was displaced. |
| Covers the driving specification capabilities | **Needs fixes** | Strong overall coverage. Load semantics, offline origination, diagnostics, and several deferred account lifecycle invariants are not yet preserved. The known phone-only and Apple Health overrides are clearly identified for upstream reconciliation. |
| No inherited parent spine is weakened | **Not applicable** | No parent spine is declared. |
| Every initiative-level dimension is decided, deferred, or open | **Needs fixes** | Deployment/environments are named, but the required private-Alpha AI gateway is neither minimally bound nor disabled. Operational diagnostics are also silent. |
| English/Chinese copies preserve the same contract | **Pass** | Same 182-line structure, frontmatter fields, AD-1…AD-14 ordering, numeric limits, stack, capability map, and deferred list. No decision-level translation divergence found. Fixes must be mirrored. |

## Recommended Gate Disposition

1. Apply F1, F2, F4, F6, F7, F8, and F9 directly in both language copies.
2. Resolve F3 from the intended disconnected-Watch product behavior; do not infer it from “normally starts on iPhone.”
3. Resolve F5 as the only likely product/architecture choice: either private-Alpha BYOK-only or a minimally specified owner-only gateway.
4. Re-run `lint_spine.py`, verify the Mermaid fences render, and compare the bilingual AD/limit structure before setting `status: final`.

## Re-review — 2026-09-10

**Verdict:** **NEEDS ONE REMAINING FIX**

This re-review checked only original findings F1–F8 against the latest English and Chinese spines. The two copies remain decision-equivalent for every inspected fix.

| Original finding | Status | Re-review evidence |
|---|---|---|
| F1 — seven-day retention scope | **Resolved** | AD-5 now limits the window to redundant Watch-side structured transfer copies after whole-object `applied`, and protects iPhone-authoritative facts behind explicit deletion revision or a separately bound policy. |
| F2 — unnamed eight-exercise seed | **Resolved** | AD-6 names the exact eight v1 candidates in both languages and separates classification, set-boundary, and rep-count qualification. |
| F3 — disconnected Watch origination | **Resolved** | AD-3 permits a disconnected Watch with a complete cached Plan to create a globally unique session identity that iPhone adopts unchanged; facts retain source session and snapshot identity, with no time-based merge. |
| F4 — incomplete load semantics | **Resolved** | Consistency Conventions now bind authoritative value/unit plus load kind and basis, including assisted/bodyweight/timed/non-comparable and total/per-side distinctions. |
| F5 — private-Alpha gateway boundary | **Partially resolved; one high issue remains** | AD-8 now binds owner authentication, secret storage, allowlists, ceilings, rotation, redacted logs, rollback ownership, and a kill switch before Alpha traffic. It still neither pins nor creates a pre-traffic gate for the gateway deployment runtime/provider and processing region for **non-Health** AI traffic. The region gate under Deferred applies to remote HealthKit-derived values, while ordinary plan-generation traffic remains enabled. Add provider/runtime/processing-region to AD-8's “before Alpha traffic” release record, or explicitly defer and fail-close all built-in gateway traffic until they are frozen. |
| F6 — public-beta cloud lifecycle | **Resolved** | Deferred now preserves AD-2 sync semantics, no clock-only LWW, local capture through auth/cloud failure, visible restore state, sign-out retain/remove with unsynced warning, and destructive-action reauthentication. |
| F7 — structural/destructive conflicts | **Resolved** | AD-2 now defines the normative revision DAG/reducer and forbids auto-collapse of overlapping split/merge, insert/delete, reorder, completion, and Plan-topology branches. |
| F8 — diagnostic/telemetry privacy | **Resolved** | AD-13 limits logs/diagnostics to structured metadata, excludes sensitive payload classes, and disables private-Alpha remote telemetry unless explicitly opted in. |

**Required final fix:** Amend AD-8 in both copies so the pre-Alpha gateway gate explicitly freezes the deployment runtime/provider and processing region (plus their versioned release record), or keeps the entire built-in route disabled until those fields are frozen. No other original F1–F8 blocker remains.

### Final Re-review — 2026-09-10

**Verdict: PASS**

AD-8 now requires the gateway runtime provider and data-processing region to be frozen and documented before any built-in Alpha traffic, and explicitly keeps the built-in route disabled until that gate closes. The English and Chinese rules are equivalent. This resolves the last remaining portion of F5; all original F1–F8 findings are resolved, with no remaining blocker in this review lens.
