# Help and status action

Run:

```bash
/Users/seanlee/anaconda3/bin/conda run -n BMAD python \
  {skill-root}/scripts/status.py show --project-root {project-root} \
  --output-root {resolved-workflow-output-path} --format markdown
```

Resolve `{resolved-workflow-output-path}` from `{workflow.output_path}` before running the command. Omit `--output-root` only when using the default `_bmad-output/planning-artifacts/native-ui-designs` path.

Return a short Chinese response containing:

1. current run path or “not started”;
2. completed, current, and pending stages;
3. blocker or decision needed, if any;
4. the single recommended next action;
5. exact invocation examples.

Always show:

- `[ND] Design/Resume` — `Use $bmad-native-ui-design design to start or resume the recommended stage.`
- `[NH] Help/Status` — `Use $bmad-native-ui-design help to show progress and the next step.`
- `[NV] Validate` — `Use $bmad-native-ui-design validate to check Architecture readiness.`

Help/status is read-only. Do not create a workspace, update status, load screenshots, run design searches, or start the recommended action automatically.

Routing:

- No valid PRD/UX → recommend `bmad-prd` or `bmad-ux`.
- No native UI run → recommend ND-01.
- ND-01 waiting → ask the user to select a direction.
- ND-02 waiting → recommend design-system acceptance.
- ND-03 waiting → name the next incomplete screen batch.
- ND-04 waiting → recommend native validation/handoff.
- Complete → recommend `bmad-architecture`.
