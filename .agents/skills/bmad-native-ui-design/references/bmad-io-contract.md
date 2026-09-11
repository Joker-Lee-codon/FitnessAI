# BMAD input and output contract

## Required inputs

Resolve the newest authoritative versions of:

- Product Brief when present;
- PRD, addendum, validation, update, and reconciliation artifacts;
- UX `DESIGN.md`, `EXPERIENCE.md`, validation, and reconciliation artifacts;
- project `AGENTS.md` and project knowledge;
- existing design-system tokens, screen specs, previews, imports, and explicit rejection feedback.

The PRD and UX spines are required. Old visual artifacts are diagnostic inputs only.

## Output workspace

Use `{workflow.output_path}/{workflow.run_folder_pattern}/` and create:

```text
.native-ui-status.json
design-direction.md
design-direction.zh-CN.md
native-ui-spec.md
native-ui-spec.zh-CN.md
architecture-handoff.md
architecture-handoff.zh-CN.md
tokens.json
previews/
prototypes/              # optional, non-production
```

Formal documents must be complete bilingual twins. `tokens.json`, status JSON, previews, and prototype source are language-neutral.

## Source and traceability rules

- Reference source documents by path rather than duplicating their prose.
- Preserve stable FR, NFR, journey, decision-gate, surface, component, and token identifiers verbatim.
- Record any approved visual override with its affected upstream token/section and rationale.
- Do not promote V1.1 or Post-MVP surfaces into the MVP navigation or completion gate.

## Completion meanings

- ND-01: the user selected one direction.
- ND-02: the user accepted the semantic system and representative surfaces.
- ND-03: all configured MVP batches are accepted and required states are specified.
- ND-04: mandatory native gates pass and Architecture handoff is complete.

