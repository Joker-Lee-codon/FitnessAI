# PRD Quality Review — FitnessAI

- **Review date:** 2026-08-08
- **Reviewed artifacts:** `prd.md`, `addendum.md`, and their complete `zh-CN` counterparts
- **Gate verdict:** Pass with two non-blocking follow-ups

## Overall verdict

FitnessAI remains a strong, decision-ready chain-top PRD, and this update honestly keeps the first release centered on trustworthy, low-interaction recording. FR-071–FR-077, NFR-PORT/VOICE/SHARE, and DV-006 preserve stable IDs and cleanly separate V1.1, Post-MVP / V2, and uncommitted exploration; two medium-urgency clarifications are needed before voice enters design or Training Plan portability enters V1.1 implementation, but neither blocks MVP UX, architecture, or story creation.

## Decision-readiness — strong

The update records product decisions rather than smuggling ideas into the first release. General record-informed AI is an explicitly uncommitted exploration (§§5–6.3, DV-006); voice is a future user-invoked input source (§6.3, FR-074–FR-075); the FitnessAI-owned single-plan file is V1.1 (§§6.2–6.3, FR-071–FR-073); and third-party formats plus QR/link sharing remain Post-MVP / V2 (§§6.2–6.3, FR-076–FR-077). DV-006 gives the AI concept an owner, an evidence-based revisit condition, and the decisions required before it may enter downstream design.

### Findings

None.

## Substance over theater — strong

The new material is proportionate to its maturity. Deferred ideas receive enough boundary definition to protect provenance, correction, privacy, and local/cloud authority without pretending that an AI journey, voice interaction, sharing transport, or third-party compatibility promise has already been discovered. The addendum's “Deferred Input and Training Plan Exchange Boundaries” section preserves architecture-relevant mechanisms while leaving normative scope and acceptance in the PRD.

### Findings

None.

## Strategic coherence — strong

The update reinforces rather than dilutes the thesis that complete, recoverable, user-authoritative workout truth is the first release gate. Existing bounded capabilities—RPE, next-set load, substitutions, plan-difference proposals, and Analysis—remain distinct from the newly deferred general record-informed AI idea (§6.2). Voice and plan exchange are roadmap items, not substitutes for proving the core recorder proposition.

### Findings

None.

## Done-ness clarity — adequate

FR-071–FR-073 define observable V1.1 round-trip behavior: a versioned documented artifact, complete pre-save preview, creation of a new draft, explicit handling of unknown or incompatible data, and no silent overwrite. FR-074–FR-077 and the matching NFRs appropriately state future invariants for provenance, conflict handling, fallback input, preview, data minimization, and server-backed sharing controls. Most consequences are testable, but two future-phase contracts are not yet closed tightly enough for direct story acceptance.

### Findings

- **medium** Voice draft-to-commit authority is not fully explicit (§6.3, FR-074–FR-075, NFR-VOICE-001) — The confirmed boundary says parsed speech first becomes a correctable draft, and §6.3 says it remains a draft until “explicit commit.” FR-074, however, only prohibits silent overwrite of an already confirmed fact, while NFR-VOICE-001 merely requires observable draft, confirmation, and commit states. A downstream implementation could therefore auto-commit a new or previously empty fact without contradicting the numbered requirements. *Fix:* Before voice enters UX, architecture, or epic design, state in FR-074 that every parsed value begins as a draft and cannot become an effective workout fact until the user explicitly confirms or corrects it; if confidence-based auto-commit is ever desired, treat that as a separately approved trust policy.
- **medium** The Training Plan import size bound is not acceptance-ready (§8.8, NFR-PORT-001) — “Enforce schema and size limits” names a control but supplies neither a numeric maximum nor a required pre-implementation freeze point. Engineering and security cannot derive a deterministic V1.1 acceptance test from it. *Fix:* Add a V1.1 gate that freezes the maximum compressed and expanded artifact sizes, nesting/item-count limits, and failure behavior before portability stories are accepted, or put those exact bounds in NFR-PORT-001 once the format is defined.

## Scope honesty — strong

MVP exclusions are explicit in both Non-Goals and §6.2. The PRD distinguishes the already covered bounded advice features from genuinely new general record-informed advice, labels the file round-trip as V1.1, labels voice as Post-MVP, labels third-party import and QR/link sharing as Post-MVP / V2, and gives the AI idea no release commitment. DV-006 is an honest deferred discovery gate rather than a disguised feature requirement.

### Findings

None.

## Downstream usability — adequate

The document remains cleanly extractable for current MVP work. FR definitions are contiguous and unique from FR-001 through FR-077; DV definitions are contiguous and unique from DV-001 through DV-006; the three new NFR namespaces are unique and phase-labeled. The new plan-portability requirements distinguish themselves from the existing account-scoped privacy export in FR-048/NFR-PRIV-005 by limiting the artifact to one re-importable Training Plan. Future-phase extraction will be reliable after the two Done-ness findings are closed at their stated revisit points.

### Findings

None beyond the two Done-ness findings above.

## Shape fit — strong

The journey-led consumer-product shape still fits FitnessAI. No speculative AI or voice journey was invented after the Product Owner explicitly deferred those concepts. The PRD holds roadmap phase and product-visible invariants, while the addendum holds schema/provenance direction, raw-audio authorization boundaries, and QR/link transport caveats. This is the right level of detail for ideas that must be remembered without being treated as current implementation scope.

### Findings

None.

## Mechanical notes

- `prd.md` and `prd.zh-CN.md` each contain 379 lines and the same 37-heading hierarchy; `addendum.md` and `addendum.zh-CN.md` each contain 77 lines and the same 15-heading hierarchy.
- English and Chinese copies preserve the same frontmatter dates/status, section order, tables/list structure, phase labels, requirement IDs, exclusions, conclusions, links, and architecture boundaries. The reviewed additions are semantically aligned rather than merely ID-aligned.
- FR definitions are contiguous and unique from FR-001 through FR-077. The added FR-071–FR-077 do not renumber or repurpose FR-001–FR-070.
- DV definitions are contiguous and unique from DV-001 through DV-006. `NFR-PORT-001`, `NFR-VOICE-001`, and `NFR-SHARE-001` are unique and do not collide with existing namespaces.
- Inspected references to UJ-4, FR-054–FR-060, NFR-RPE-014, NFR-SESSION-005, SM-INT-001, and SM-RET-001 resolve.
- No `[ASSUMPTION]`, `[NOTE FOR PM]`, or Open Question marker appears. Future uncertainty is represented through labeled scope and Deferred Validation Gates.
- The PRD frontmatter remains `status: draft`, which is appropriate during the active update/finalization pass and should be changed only by the parent workflow after findings are triaged.

## Resolution After Review

Both medium findings were resolved on 2026-08-08. FR-074 now requires every voice-parsed value to begin as a correctable draft and become an effective workout fact only after explicit user confirmation or correction and a successful local commit. DV-007 now requires Product and Architecture to freeze compressed/expanded file sizes, nesting and item-count limits, parser resource budgets, and failure reporting before FR-071 through FR-073 enter story acceptance. No reviewer finding remains open.
