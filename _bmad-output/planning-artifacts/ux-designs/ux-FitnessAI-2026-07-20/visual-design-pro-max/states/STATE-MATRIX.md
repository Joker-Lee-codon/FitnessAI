# FitnessAI Titanium Measure State Matrix

## 1. State Encoding Grammar

| Family | State | Symbol | Structure | Required copy behavior |
|---|---|---|---|---|
| Recognition | accepted | `checkmark.circle` | solid fact line | State plus source when automated |
| Recognition | uncertain | `questionmark.circle` | amber left rail | Name uncertainty and retained sibling facts |
| Recognition | corrected | `pencil.and.outline` | revision marker | Prior value, current value, user authority |
| Recognition | unresolved | `exclamationmark.triangle` | open-ended rail | Pending field and exact fallback |
| Attention | pending | `clock` | outlined segment | What waits and what remains usable |
| Attention | stale | `arrow.clockwise` | dashed dependent output | Why Analysis/proposal is not current |
| Attention | conflict | `arrow.triangle.2.circlepath` | split revision row | Preserve both revisions; user chooses on iPhone |
| Durability | saved locally | `applewatch` or device symbol | completed local rail | Exact local copy |
| Durability | sync pending | `clock` | pending sync segment | Local success remains true |
| Durability | synchronized | `checkmark.icloud` | completed sync segment | Exact account-scoped boundary |
| Support | manual-only | `hand.tap` | neutral boundary row | Available manual path |
| Support | unsupported | `slash.circle` | blocked boundary + fallback | Named unsupported combination |
| Integrity | failed | `exclamationmark.triangle` | destructive rail | Cause, surviving data, Retry/recovery |

## 2. Surface Coverage

| Surface | Required visual states |
|---|---|
| Watch Workout Entry | cold load; no plan/ad-hoc; unsupported device/Exercise; required capability missing; offline; start/local-commit failure |
| Watch Active Session | active set; resting; accepted/uncertain/unresolved fact; sensor gap; offline; low storage/resource warning; local-write failure |
| Watch Rest Resolution | not safe/deferred; safe; none/one/multiple pending; Later; corrected; manual fallback; RPE disabled/verification/drift; commit failure |
| Watch Recovery | recoverable; partial write; ambiguous boundary; restart; disconnect; concurrent session; discard confirmation |
| Watch Finish Review | Complete; Incomplete; finish committing/failed; sync pending; gated forgotten-Finish prompt |
| iPhone Today & Plans | cold load; no plan; draft; offline cached; stale revision; plan load failure |
| iPhone Training Plans | view; edit draft; field error; substitute proposal; explicit accept/decline; stale/conflict; commit failure |
| iPhone Session Review | loading; Complete; Incomplete; corrected; conflict; stale Analysis; correction commit failure |
| iPhone Training History | cold load; empty; offline cached; restoration in progress/failed; deleted/tombstoned; revision pending |
| iPhone Analysis | cold load; empty period; ready; incomplete excluded/labelled; stale conflict; calculation failure |
| iPhone Exercise Catalog | cold load; media unavailable; supported; limited; manual-only; canonical mapping unresolved |
| iPhone Sync & Recovery | no issues; sync pending; offline; delayed/reordered/duplicate replay; conflict; restoration lifecycle; concurrent sessions |
| iPhone Account & Privacy | signed out/in; capability-specific permission states; consent lifecycle; export; deletion scopes; sign-out choice; account switch preview |
| iPhone Support Matrix | loading; supported; limited; manual-only; unsupported; matrix version unavailable |
| iPhone Training Plan Portability (V1.1) | export ready/failed; validating; compatible; unsupported/newer; malformed/executable/over-limit; duplicate; unknown Exercise; unit/field mapping; explicit omission; ready; new-draft commit/failed/cancelled |
| iPhone Beginner Plan (Post-MVP) | intake incomplete; disclosure; warning-sign stop; draft; approval; declined proposal; safety review unavailable |
| Future voice input boundary (Post-MVP) | permission; idle/listening/interrupted/offline/unavailable; transcribing; ambiguous; draft; duplicate/conflict; confirmed; local commit/failed; cancelled; manual fallback |
| Future third-party/share boundary (Post-MVP / V2) | format/version; unit/mapping; partial failure; preview; expired/revoked/inaccessible/invalid transport; data minimization; new draft/cancelled |

## 3. Canonical High-Risk Copy

| State | Short visual Chinese | Required consequence |
|---|---|---|
| Auto-used RPE | 已自动采用 RPE 8 | Still editable; not user-confirmed |
| Model abstention | RPE 待确认 | Other workout data remains saved |
| HealthKit read | 暂无可读取数据 | Does not claim permission denial |
| Local save failure | 本机保存失败 | New content is unsafe; prior saved data remains |
| Sync pending | 已存于本机 · 等待同步 | Recording success is not revoked |
| Cloud deletion pending device | 云端已受理，1 台设备待处理 | Old data cannot be republished |
| Research withdrawal | 已停止研究上传 | Ordinary local recording continues |
| `healthKitDetached` | 已与 Apple Health 断开关联 | FitnessAI does not silently rewrite the Apple Health record |

## 4. State Transition Rules

1. `editing → committing locally → saved locally` is required before success language.
2. `saved locally → sync pending → synchronized` is independent; failure returns to sync pending/failed, not unsaved.
3. Correction creates a new auditable revision and preserves prior value/provenance.
4. Unsafe or interrupted Watch correction returns to pending without data loss.
5. Conflict preserves every involved user-authored revision and marks dependent Analysis/proposals stale.
6. Unsupported semantics preserve supported sibling facts and route to the exact iPhone field.
7. Deletion uses tombstone/copy-scope lifecycle; no offline replay may silently restore confirmed deletion.
8. Plan import and future source inputs create drafts only. Existing plans and committed workout facts remain effective until explicit review and successful local commit.
9. Voice, link, QR, and third-party import states are future boundaries; they must not appear in MVP navigation or previews.

## 5. Preview Mapping

- `previews/states-review.png`: pending, confirmed, corrected, sync, offline, failure, unsupported, recovery.
- `previews/watch-pages-review.png`: core Watch state composition.
- `previews/iphone-core-pages-review.png`: plan/review/history states.
- `previews/iphone-system-pages-review.png`: analysis, support, lifecycle, and Post-MVP gate.
