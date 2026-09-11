---
title: FitnessAI Native UI Architecture Handoff
status: complete
native_ui_gate: passed-with-owned-device-validation
selected_direction: Titanium Measure
updated: 2026-09-09
sources:
  - ../../prds/prd-FitnessAI-2026-07-19/prd.md
  - ../../ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
  - ../../ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  - native-ui-spec.md
---

# FitnessAI Native UI Architecture 交接

## 1. 交接状态与权威

ND-01 至 ND-04 已完成。Product Owner 于 2026-09-09 接受 core-flow Reviewer Gate。强制 native contract、traceability、accessibility、completeness 与 delivery 检查通过；仅限真机的检查已明确 owner，不阻塞精简 Architecture 创建。

权威顺序为当前双语 PRD → `EXPERIENCE.md` → `DESIGN.md` / `design-system/fitnessai/MASTER.md` → `native-ui-spec.md` → 本 handoff。Architecture 可选择实现内部机制，但不得折叠下述 truth、approval、revision、device、privacy 或 phase boundary。

## 2. 选定方向与不可变 Token

实现方向为 **Titanium Measure 1.1.0**，而非历史 Direction D。不可变 semantic source 是 `design-system/fitnessai/tokens.json`；native-run 镜像为 `tokens.json` version `1.1.0-alpha-layout`。

Architecture 必须保留 canvas/surface/subtle background、primary/secondary/tertiary text、standard border、primary user action、pending attention、confirmed/corrected/destructive state、Always On、spacing、radius、stroke、icon、touch、motion 与 platform layout 的 semantic name。SwiftUI 使用具名 Color Assets、原生 Dynamic Type roles、`@ScaledMetric`、SF Symbols 与原生 interaction state。组件不得嵌入无法解释的 raw color、固定 body size、装饰 shadow 或 web layout semantics。

## 3. Surface 与 Component 所有权

| Boundary | Owner | Architecture invariant |
|---|---|---|
| AI conversation、authorization、proposal review、approval、本地 plan commit | iPhone | Conversation/generation 永不批准；approval 独立并绑定不可变 proposal identity。 |
| Effective Training Plan 与 Plan Revision store | iPhone local domain | 一次 atomic、idempotent revision commit；失败使 prior revision 完整保持有效。 |
| Plan delivery | iPhone ↔ Watch transport | 最终一致、full-revision、digest-verified、idempotent；Watch 永不暴露 partial revision。 |
| Active Workout Session 与 Actual Set durability | Watch local domain | Start snapshot 固定；每个 saved claim 都在 durable local commit 后；phone/cloud receipt 独立。 |
| 完整 correction 与 conflict resolution | iPhone | Field-scoped auditable revision；在 effective resolution 前保留 sibling fact 和每个 user-authored branch。 |
| Automatic Exercise/set/rep recognition | Watch inference + support matrix | 保留 confidence/provenance；abstention/manual fallback 为正常行为；纠正不删除已捕获 fact。 |
| RPE verification/auto-use | Watch inference 与 local calibration | Predicted、confirmed、auto-used、corrected 与 effective value 保持不同且可纠正。 |
| History 与 Analysis | iPhone derived read model | 仅从 effective Actual Sets 派生；exclusion/conflict 可见并阻止 false precision。 |
| Apple Health | iPhone adapter | FitnessAI local record 保持权威；read 暴露 observable data state；write 是幂等 optional copy。 |
| Plan file exchange | iPhone document boundary | Versioned single-plan format 为 untrusted input；import 只创建新 draft；export data-minimized。 |
| Proactive review invitation | iPhone presentation state | 每个 completed session 一次；显示/Later 不发送，也不创建 authorization、proposal 或 approval。 |

必需可复用 SwiftUI component family：`ai-conversation`、`remote-ai-authorization`、`plan-diff-review`、`proposal-approval-gate`、`safety-stop`、`session-control`、`actual-set-row`、`load-stepper`、`recognition-state-chip`、`rpe-verification-prompt`、`forgotten-finish-prompt`、`analysis-summary`、`healthkit-capability-row`、`plan-exchange-review`、`proactive-review-invitation`、`sync-state-indicator`、`recovery-choice-sheet` 与 `support-boundary-notice`。

## 4. Navigation 与跨设备 Handoff

iPhone 使用原生 `TabView`，包含 Plan、History、Analysis 与 More。Plan 是 root。AI Chat、Remote Authorization、Proposal Review、Approval、Delivery、Session Review、Apple Health 与 Plan Exchange 为类型安全的 `NavigationStack` destination。Back 恢复 object identity、filter、scroll 与 unsent/non-effective draft。

Watch 使用浅层 task-specific navigation。Approved Plan → manual Start → Active Workout → 必要时 safe-rest correction/RPE → manual Finish → local save/return。Recovery 可 Resume、Finish Incomplete，或在确认后明确 discard。Digital Crown 是可选加速器，绝不是唯一 input 或 commit path。

跨设备 message 携带稳定 object/revision ID、适用时的 schema/catalog/model/support-matrix version、content digest、idempotency identity 与 causality/revision metadata。Device time 不能解决 plan 或 record conflict。较新的 iPhone plan 永不修改已经开始的 Watch session。Delivery 失败时，最后一个完整兼容 Watch revision 保持可用。

## 5. 必需 State Machine

### 5.1 AI proposal 与 approval

`conversation → authorizationRequired → authorized → generating → proposed → validating → reviewable → approvalReady → committing → effective`。

分支：`cancelled`、`aiFailed`、`invalid`、`unmapped`、`contradictory`、`safetyBlocked`、`baseStale`、`approvalInvalidated`、`commitFailed` 与 `rejected`。任何 proposal content、mapping、base revision、digest 或 validation result 变化都会创建新 identity，并要求完整重新 review。只有 `effective` 可开始 Watch delivery。

### 5.2 Watch plan delivery

`notQueued → pending → delivered`，包含 `failed` 与 retry/reconnect transition。Watch 仅在完整兼容内容和 digest 验证后切换。Duplicate、late、reordered 或 repeated event 不得重复或回滚 revision。

### 5.3 Workout 与 Actual Set

Session：`notStarted → active → finishing → complete | incomplete`，并有 `interrupted → recoverable → active | incomplete | discarded`。Actual Set：`draft → committingLocal → savedLocal → transferPending → received`，并有 `localWriteFailed`、`transferFailed`、`pendingField`、`corrected` 与 `conflict` 分支。只有 `savedLocal` 后才可合法显示“Saved”。

### 5.4 Recognition、RPE 与 finish assistance

Recognition：`supportedAttempt → accepted | uncertain | abstained | manualOnly | unsupported`；uncertainty 仅在 `restSafeForInteraction` 显示，并保留所有 sibling fact。RPE：`disabled | verifying → confirmed/corrected → verificationPassed → autoUseOptIn → autoUsed`，并有 `abstained`、`lowConfidence` 与 `drifted → verifying`。Forgotten Finish：`suppressed | eligible → prompted → finish | continue`；它永不自动 finish。

### 5.5 Apple Health

Read capability：`notRequested → noAccessibleData | available | unavailable | failed`。Write copy：`notEnabled | pending → written | failed`；外部消失产生 `healthKitDetached`，只有新的 explicit action 才能再次进入 `pending`。

### 5.6 Plan exchange

Export：`review → creating → shareSheet → completed | cancelled | failed`。Import：`selected → parsing → invalid | unsupported | duplicate | unresolved | reviewable → committingDraft → draftCreated | commitFailed`。任何 import state 都不修改现有 effective plan。

### 5.7 Analysis 与 proactive review

Analysis：`loading → current | empty | partial | stale | failed`；input conflict 未解决时，依赖 metric 保持 stale。Invitation：`available → review | later | disabled`；Review 进入 remote authorization，Later 不创建 hidden state，Disabled 持续到用户重新开启。

## 6. Accessibility 与原生语义

- iPhone 至少支持 200% Dynamic Type；Watch 至少支持 140%。Metric grid 与 diff 在 clipping 前 linearize。
- VoiceOver 阅读顺序遵循 fact → source/authority → durability → consequence → action。Diff row 宣读 field path、change type、before/after 与 future scope。
- 每个状态使用 text 加 symbol/structure；hue、animation、gesture、haptic 或 Crown 永不作为唯一 cue。
- 高频/关键 target 至少 44 × 44 pt，间隔 8 pt。Full Keyboard Access 覆盖 iPhone review/correction。
- Error focus 移至 error summary；Retry 保留数据；success focus 移至精确 local/remote result。跨设备返回恢复精确 object 与 field。
- Reduce Motion 移除 displacement/chart drawing；Reduce Transparency 与 Increase Contrast 使用冻结 semantic variant。
- Fixed action 遵循 keyboard 和 safe area，并预留匹配 scroll inset。原生 sheet、alert、destructive confirmation、file picker、Share Sheet 与 Health authorization 继续由平台拥有。

## 7. Requirement—Journey—Surface Traceability

| Requirement group | Journey/flow | Surface/state ownership |
|---|---|---|
| FR-001–041；NFR-RPE；NFR-SESSION；NFR-REC；NFR-RECOV；NFR-COMPAT | UJ-1、UJ-2、Flow 2 | Watch Entry/Active/Rest/Recovery/Finish；Session Review；History；完整 Analysis；manual 与 error fallback。 |
| FR-043；FR-046–047；FR-049–050；FR-052–053 | UJ-1、Flow 2、Flow 4 | Local durability、idempotent transfer/conflict、privacy boundary、support state 与 continued local use。 |
| FR-054–060；FR-078–087；NFR-AI-001–006；NFR-PRIV-007；NFR-SAFE-001 | UJ-4、Flow 3、Flow 4 | `AI-01`–`AI-06`：chat、authorization、safety stop、完整 review、approval、atomic commit、delivery、stale/failure recovery。 |
| FR-061–066 | UJ-1、Flow 2 | Field correction、split/merge/insert/delete、incomplete record、auditable revision、active-session recovery、idempotency。 |
| FR-071–073；NFR-PORT-001 | Flow 5 | Export scope review、versioned file、原生 Share Sheet、bounded import、mapping/omission，只创建 new draft。 |
| FR-088–090；NFR-HK-001–002 | Flow 6 | Capability row、observable read state、write pending/written/failed、local authority、`healthKitDetached`。 |
| FR-091；NFR-UX-001 | UJ-2、Flow 3、所有 flow | 一次 proactive invitation；完整最终 visual/layout、exceptional state、accessibility 与 native reflow。 |

Model accuracy、evaluation cohort threshold、data residency、cryptographic transport、parser fuzzing 与 professional policy review 等非视觉 requirement 继续属于 Architecture、test、security 或 release evidence；其 user-visible failure 与 provenance state 已在上表映射。

## 8. Native Quality Gate 结果

| Gate | Result | Evidence / owner |
|---|---|---|
| Contract integrity 与 phase separation | Pass | PRD §6.1 applicability set；`EXPERIENCE.md`；没有 deferred route 可发现。 |
| User truth、local commit、offline、conflict、incomplete、privacy | Pass | 第 5 节 state machine 与 `native-ui-spec.md` 第 4–10 节。 |
| Watch glanceability、silence、safe rest、recovery、Always On | Pass，device validation 已有 owner | Watch v11 加当前 spine；第 9 节 Product Owner/QA device plan。 |
| iPhone navigation、sheet、safe area、keyboard、focus | Pass | `AI-L01`–`RV-L01` 与综合 review carrier。 |
| Light/Dark、Dynamic Type、VoiceOver、Reduce Motion、non-color cue | Pass，device validation 已有 owner | 冻结 token/spec；第 9 节 Product Owner/QA device plan。 |
| Exceptional-state completeness | Pass | 可复用 state contract 与全部七个必需 state machine。 |
| 双语结构/ID parity 与 token validity | Pass | `validate_outputs.py`；paired spine structural audit；JSON parse。 |
| 必需 layout-critical preview | Pass | iPhone 28-instance final board；Watch v11 reference。 |

## 9. 真机 Validation Plan

| Validation | Owner | Pass criterion |
|---|---|---|
| Small/large Watch、两种 Crown orientation | Product Owner + implementation QA | Exercise/value/action 无 clipping；Crown 与 touch equivalent 可用；primary action 只需一/两次 deliberate interaction。 |
| Bright/dim gym 与 Always On | Product Owner | Essential Exercise/set/load/reps/durability 可在两秒 glance 内读取；action/status color 保持非必要。 |
| Sweat/one-hand/accidental touch 与 haptic | Product Owner | 44 pt target 可靠；无意外 destructive/Finish；success/warning/error haptic 可区分且有视觉/语音等价内容。 |
| iPhone 11 与当前更大设备 | Implementation QA | 无水平滚动；bottom action 避开 keyboard/home indicator；原生 back 恢复 state。 |
| 最大简体中文与 VoiceOver | Accessibility QA + Product Owner | 无必需 consequence/value/action 截断；error 与 Watch handoff 中 reading/focus order 稳定。 |
| P3/sRGB、Light/Dark、Increase Contrast | Implementation QA | 关键 surface 的 text/control/non-text contrast 达到 DESIGN target。 |
| Analysis chart selection | Accessibility QA | 44 pt 有效 point、精确 value/period/unit、完整文字与 table alternative。 |
| Offline、local-write failure、replay、reconnect | Integration QA | Actual Set 或 Plan Revision 不丢失/重复；不显示 false saved/delivered/written claim。 |

## 10. Architecture Open Decisions

以下 decision 在实现验收前必需，但不阻塞精简 Architecture spine 创建：

1. 冻结私有 Alpha automatic-recognition whitelist 与 versioned support-matrix representation。
2. 冻结 RPE verification/auto-use confidence、drift、recalibration 与 abstention operating point。
3. 冻结 forgotten-Finish two-signal threshold、`restSafeForInteraction`、cooldown、suppression 与 device evidence plan。
4. 定义 FitnessAI Plan File schema、extension/UTType、parser size/depth/count limit、canonical mapping strategy 与 fuzz/error boundary。
5. 定义 Apple Health capability-to-HealthKit-type mapping、read rationale、write metadata/deduplication key 与 detached-copy detection limitation。
6. 冻结 Alpha Plan Safety Rule Pack v1 data model、versioning、check、pass/block output 与 test-fixture ownership。
7. 真实 remote AI traffic 前，确定 provider/subprocessor、region、retention、training policy、request-field-to-authorization-category mapping、revocation storage 与 audit event。
8. 选择 local persistence、iPhone–Watch transport、background retry、idempotency、causal revision 与 derived-analysis invalidation mechanism，且不得弱化 state contract。

## 11. 精确下一步

使用当前双语 PRD、`EXPERIENCE.md`、`DESIGN.md`、`native-ui-spec.md`、`tokens.json` 与本 handoff，以 create mode 启动 `bmad-architecture`。Architecture 应先产生精简 spine，并把第 10 节每项作为具名 decision 或 validation owner，而不是静默虚构数值。
