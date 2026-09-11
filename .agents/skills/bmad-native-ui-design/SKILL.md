---
name: bmad-native-ui-design
description: "Design, resume, or inspect BMAD-aligned native iPhone and Apple Watch UI after bmad-ux and before bmad-architecture. Use for visual-direction selection, SwiftUI design-system definition, staged MVP screen design, native accessibility review, Architecture handoff, or when the user asks for native UI design help, status, progress, or the next step."
---

# BMAD Native UI Design

Turn finalized BMAD product and UX contracts into a selected visual direction, a SwiftUI-ready native UI specification, and an Architecture handoff. Preserve upstream behavior and scope; redesign the visual expression freely.

## Route the action first

Interpret the first matching intent:

- **Help / Status / Next (`NH`)**: The user asks how to use the skill, where the run is, what is complete, or what comes next. Follow `references/help-status.md`. Run `scripts/status.py show`; do not load design references, invoke `ui-ux-pro-max`, create artifacts, or mutate progress.
- **Design / Resume (`ND`)**: The user asks to start, continue, redesign, choose a direction, expand screens, or prepare handoff. Follow the workflow below.
- **Validate**: The user asks whether an existing native UI run is Architecture-ready. Read the run outputs, then apply `references/native-quality-gates.md` without redesigning.

If intent remains ambiguous, show the two short choices `[ND] Design/Resume` and `[NH] Help/Status` and ask for one.

## Activate a design run

1. Verify the project BMAD runtime before Python commands. For FitnessAI use `/Users/seanlee/anaconda3/bin/conda run -n BMAD python --version` and expect Python 3.11.x.
2. Resolve workflow customization with:
   `UV_CACHE_DIR={project-root}/.uv-cache UV_PYTHON_INSTALL_DIR={project-root}/.uv-python /Users/seanlee/anaconda3/bin/conda run -n BMAD uv run --python 3.11 {project-root}/_bmad/scripts/resolve_customization.py --skill {skill-root} --key workflow`.
   If resolution fails, read `customize.toml` and use its defaults.
3. Resolve BMAD config with the same environment variables and `{project-root}/_bmad/scripts/resolve_config.py --project-root {project-root}`. Use `core.communication_language`, `core.document_output_language`, and `modules.bmm.planning_artifacts`.
4. Read `references/bmad-io-contract.md`. Discover candidate inputs; never treat old mockups as authority over the PRD or UX spines.
5. If the latest PRD or finalized UX contracts are missing, stop and route to `bmad-prd` or `bmad-ux`. Do not invent requirements.
6. Find the newest run under `{workflow.output_path}`. If its `.native-ui-status.json` is not complete, offer to resume it. Otherwise create `{workflow.run_folder_pattern}` and initialize status with `scripts/status.py init`.

## Run the four stages

Read `references/workflow.md` and execute exactly one stage or one bounded batch at a time:

1. **ND-01 Direction** — diagnose rejected visuals and present only two genuinely distinct directions through the representative Watch and iPhone surfaces. Stop for user selection.
2. **ND-02 System** — invoke `ui-ux-pro-max` once to establish the selected SwiftUI design system, then freeze semantic tokens.
3. **ND-03 Screens** — expand MVP surfaces in ordered batches. Reuse tokens and components; do not rerun style search per screen.
4. **ND-04 Gate & Handoff** — apply Apple-native, accessibility, traceability, and completeness gates; produce the Architecture handoff.

After a checkpoint is accepted, update progress with `scripts/status.py set`. Never mark a stage complete merely because files exist.

## Keep optional tools optional

- Apply the concise visual-direction rules embedded in `references/workflow.md`; do not load a separate `frontend-design` skill by default.
- Use `ui-ux-pro-max` only during ND-02 or when the selected system itself changes. Invoke its local search script through `scripts/run_uiux_pro_max.py` with the `BMAD` Python runtime.
- Offer Impeccable `critique`, `harden`, or `polish` only when the user requests extra critique/polish or ND-04 finds a material visual/completeness problem. Never make it a mandatory pass.
- Never use Web Interface Guidelines or Tailwind rules as native release gates. They may review an optional HTML presentation artifact only.
- Read `references/source-registry.md` only when updating, vendoring, or auditing upstream design dependencies.

## Preserve authority and scope

- PRD owns product scope and version boundaries.
- `EXPERIENCE.md` owns IA, behavior, states, journeys, accessibility behavior, and interaction semantics.
- `DESIGN.md` owns the upstream visual spine until ND-01 records an explicit, user-approved visual override.
- Native UI outputs own the selected visual realization and SwiftUI mapping; they cannot silently rewrite upstream contracts.
- If a requested screen exposes a product or UX gap, record the gap and route it upstream. Do not solve it through visual invention.
- Keep MVP, V1.1, and Post-MVP surfaces visibly separated.

## Deliver bilingually

Create every formal English Markdown document together with a complete `.zh-CN.md` sibling in the same directory. Keep headings, tables, links, requirement IDs, code, tokens, and conclusions structurally aligned. Machine-readable JSON and rendered previews do not need translated duplicates.

Finish by running `scripts/validate_outputs.py`, reporting the current stage, open blockers, and the exact next action. ND-04 completion routes to `bmad-architecture`.
