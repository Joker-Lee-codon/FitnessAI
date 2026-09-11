# Accessibility and Device Validation Specification

## 1. Required Modes

Test every primary page in dark/light, Increase Contrast, Differentiate Without Color, Reduce Motion, VoiceOver, and the largest supported Dynamic Type size. Watch pages additionally require Always On/luminance-reduced output.

## 2. Numeric Acceptance

| Check | Acceptance |
|---|---|
| Normal text contrast | At least 4.5:1 |
| Large text/non-text data marks | At least 3:1 |
| Frequent/consequential target | At least 44 × 44 pt |
| Adjacent target separation | At least 8 pt |
| iPhone text enlargement | At least 200% without loss of essential content |
| Watch text enlargement | At least 140% without loss of essential content |
| Press feedback | Visible within 100 ms |
| Micro state replacement | 150–220 ms, or immediate/crossfade with Reduce Motion |

## 3. Focus and Announcement

- Active Set announcements are quiet; noncritical recognition/sync updates wait for a safe pause.
- Correction focus order: retained facts → issue → choices; dismissal returns to the affected fact.
- Recovery focus order: recovered identity/durable boundary → Resume → Finish incomplete → Discard.
- iPhone correction returns focus to the edited field/set. Conflict resolution returns to the chosen revision.
- Polling progress does not repeatedly announce. Boundary change announces once with scope and next action.

## 4. Physical-Device Matrix

| Area | Devices/conditions |
|---|---|
| Watch glance | Small and large supported cases; bright gym, dim gym, arm motion, sweat |
| Watch input | Touch, Digital Crown, VoiceOver adjustable action, one hand, accidental touch |
| Watch continuity | Always On, app termination, restart, disconnect/reconnect, low resource |
| iPhone layout | Small/large supported phone; portrait and applicable landscape; keyboard present |
| Cross-device | Exact-field handoff, offline queue, delayed/reordered delivery, conflict |
| Color | sRGB/P3, dark/light, Increase Contrast, grayscale/color differentiation |
| V1.1 plan files | Document picker, source/version announcement, complete preview, mapping focus return, omission disclosure, cancellation, Full Keyboard Access, 200% text |
| Future voice boundary | Contextual permission, listening/transcription state, noise/offline/interruption, draft/conflict reading order, equivalent non-voice path; test only after phase activation |

## 5. Known Gates

- RPE Chinese anchors require validated release evidence; literal integers remain the safe interim.
- Load semantics outside the approved Watch subset remain pending with exact-field iPhone handoff.
- Forgotten-Finish remains unavailable until the PRD's physical-device signal gate passes.
- SF Symbol availability and optical weight must be checked in the deployment targets.
- Static previews do not prove Dynamic Type, VoiceOver, haptic, Always On, or real-device lighting behavior.
- DV-007 parser limits must be frozen before the V1.1 portability surface enters story acceptance.
- Future voice and sharing states remain non-implementing; accessibility validation cannot be claimed until Product activates and bounds the feature.
