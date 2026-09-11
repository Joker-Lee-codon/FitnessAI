---
title: FitnessAI Native UI Specification
status: nd-03-reviewer-gate
stage: ND-03
selected_direction: Titanium Measure
stack: SwiftUI
updated: 2026-09-09
---

# FitnessAI Native UI 规范

## 1. Checkpoint 与权威

核心产品私有 Alpha 的 iPhone 视觉与布局合同已完成，并停在用户要求的 Reviewer Gate Checkpoint。尚未运行昂贵 reviewer。本规范恢复 2026-08-08 native UI run；2026-09-08 PRD 与 UX reconciliation 已解除之前的范围 blocker。

权威顺序为：当前双语 PRD → `EXPERIENCE.md` 行为/状态合同 → `DESIGN.md` 与 `design-system/fitnessai/MASTER.md` 视觉系统 → 本页面/布局合同。早期 Direction D board 和 ND-03 讨论 wireframe 仅为历史记录，不约束实现。

生产 review carrier 是 `previews/iphone-core-alpha-final-v1.html`。其层级、containment、navigation relationship、action placement、state grammar 与 responsive behavior 具有规范性。代表性名称、日期、测量值和由系统拥有的 Share Sheet chrome 为 fixture。

## 2. 冻结视觉系统

已选系统为 **Titanium Measure** 1.1.0：极简、清洁、克制的原生训练仪器。它使用原生 San Francisco/PingFang、tabular training figures、semantic light/dark colors、4 pt rhythm、20 pt iPhone compact inset、8/12/16 pt radius、SF Symbols，且无装饰性 shadow。`tokens.json` 镜像当前 semantic system，只增加 reference-frame 和 fixed-action layout 数值。

视觉优先级为 Actual fact → source/authority → durability → next user action。青色表示当前用户权威操作，而非 AI 批准。绿色、琥珀色、紫蓝色和红色只辅助直白的 confirmed、pending、corrected/revision 与 destructive/error 标签。任何状态都不只依赖颜色。

## 3. iPhone Shell 与 Navigation

- 参考 frame：390 × 844 pt；支持 iPhone 11+/iOS 18+，不出现水平滚动。
- 顶层：Plan、History、Analysis、More。Plan 是私有 Alpha root。
- AI Chat、Authorization、Proposal Review、Approval、Delivery、Session Review、Apple Health 与 Plan Exchange 是上下文 `NavigationStack` route。
- 原生 back 恢复来源 object、filter、scroll position 与 unsent/non-effective input。
- Fixed bottom action 使用 safe-area inset，并提供至少 88 pt 的匹配 scroll inset。每个状态只出现一个有后果的 primary action。
- accessibility 字号下，metric grid 堆叠，comparison column 转为顺序 Current/Proposed group，metadata 比 fact、consequence 或 action 更早让位。

## 4. AI Plan 生命周期

Traceability：UJ-4；FR-054–060；FR-078–087；NFR-AI-001–006；NFR-PRIV-007；NFR-SAFE-001。

| ID | Surface | 最终层级与 primary action | 完整状态族 |
|---|---|---|---|
| `AI-01` | Plan Home | Effective revision 与 Watch delivery truth → 今日有序 session → 次级“与 AI 调整计划”。Start 仍为 Watch action。 | 无计划；本地计划 ready；Watch pending/delivered/failed；offline last-delivered revision。 |
| `AI-02` | AI Plan Chat | Missing answers/assumptions → 线性文字 conversation → 独立 non-effective structured draft → 原生 composer。Send 永不批准。 | Empty；composing；generating/cancellable；retained-input failure；safety stop。 |
| `AI-03` | Remote AI Authorization | Purpose/provider/retention/training policy → 全部 category 默认关闭 → record time window → excluded sources。 | Required；partial；authorized；withdrawn；disclosure incomplete；expanded scope blocked。 |
| `AI-04` | Proposal Review | `proposalId`/base → 完整新计划或每个 field diff → mappings/assumptions/unresolved fields → Safety Rule Pack → digest 与 non-mutation scope。 | Valid；invalid；unmapped；contradictory；safety-blocked；base stale；approval invalidated。 |
| `AI-05` | Approval | 独立页面重复 identity、base、digest、validation、future-session scope 与 consequence。Primary：“批准并创建 Revision N”。 | Ready；因具名原因 disabled；invalidated；需 refreshed review。 |
| `AI-06` | Commit and Delivery | Local commit 与 Watch delivery 是独立 state panel。Local success 使 revision 生效；Watch 可保留最后完整 revision。 | Commit pending/failed/succeeded；delivery pending/delivered/failed；幂等 Retry。 |

Authorization category 是 current conversation、profile/preferences、physical limitations 与带明确 time window 的 confirmed/corrected FitnessAI records。Apple Health、raw motion/heart rate、imported-plan contents 与 unconfirmed prediction 继续排除。缺少 provider、retention、model-training 或 request-field mapping 披露时禁用授权。

## 5. Training History 与完整 Analysis

Traceability：UJ-1、UJ-2；FR-035–041；FR-061–066；NFR-SESSION；NFR-REC；NFR-COMPAT。

### 5.1 Training History

Period/filter control 优先，其后为精确 summary 与 chronological session ledger。每行保持 planned/ad-hoc、Complete/Incomplete、sets/duration、effective revision 与 copy/sync state 附着。选择 row 打开 Session Review；Reuse 是具名 secondary action，并且只创建新 draft。

必需状态：ready、loading、empty filtered period、offline cached history、incomplete、corrected、revision conflict、return pending/failed、restoration pending/failed 与 tombstoned copy。返回时保留 filter 和 scroll position。

### 5.2 Analysis

每个视图以直白 conclusion 开头，随后是 exact metric、一个 evidence chart、相邻文字等价内容、exclusion/provenance 与 data-table alternative。Weekly/monthly period 和选中的 Primary Exercise 是显式 control。指标包括 session count、performed Exercises、volume、intensity、Actual Load、duration、effective RPE provenance 与 selected Primary Exercise trends。

只有 effective Actual Sets 参与计算。Incomplete/conflicted fact 被排除并明确命名。Stale analysis 保留不受影响的 conclusion，并路由到精确 record。Apple Health failure 永不移除本地派生 analysis。

必需状态：weekly、monthly、Primary Exercise trend、empty、loading、partial、stale/conflicted、calculation failure 与 current。Chart 使用 direct label、solid confirmed series、outlined corrected point；Reduce Motion 下不绘制动画；point 有 44 pt 有效 target，并提供完整 VoiceOver summary/table。

## 6. Apple Health

Traceability：Flow 6；FR-088–090；NFR-HK-001–002。

Apple Health 是 More/Settings route，每个 purpose 使用一个原生 capability row：workout-summary read、required health-signal read 与 completed-workout write。每行命名 scope 和 observable state。页面持续区分权威 FitnessAI local record、可选 Apple Health copy 与独立 remote-AI boundary。

必需状态为 not requested、no accessible data、available、unavailable、write pending、written、failed/retry 与 `healthKitDetached`。UI 不声称 read denial，因为 HealthKit 不暴露该信息。只有 FitnessAI durable Finish 后才开始 write；retry 幂等，且永不阻止或改变 local record。Detached copy 需要新的明确 write action。

## 7. 第一方 Plan Exchange 与 Share Sheet

Traceability：Flow 5；FR-071–073；NFR-PORT-001。

Export review 命名所选单个 plan、file/schema/catalog/revision/provenance，以及排除的 Workout Sessions、Actual Sets、health data 与 credentials。“创建文件并分享”创建有界文件，然后展示原生 iOS Share Sheet。取消或分享失败不改变计划。

Import 从 system file picker/open route 开始，把文件视为不可信输入，执行 schema/size/executable-content limit，并展示 source/version、完整 plan、mapping、omission、duplicate 与 unsupported field。Unknown item 必须映射或明确省略。“创建新草稿”在解决完成前禁用，并且永不 merge 或 replace 现有 plan。

必需状态：export ready、export creation failed、Share Sheet cancelled/failed；import loading、valid、unresolved mapping、duplicate、unsupported version、malformed/invalid、cancelled、commit failed 与 draft created。

## 8. 训练后主动 AI Review

Traceability：UJ-2、Flow 3；FR-059；FR-060；FR-091。

完成 session 可 review 后，一个原生 nonmodal sheet 可在 Session Review 上出现一次。它明确说明尚未发送任何内容且不存在 proposal。Review 为 primary；Later 与 Disable 为 secondary。Later 不创建 hidden authorization 或 approval；Disable 在设置改变前阻止未来 invitation。

Review 路由到 record-scoped authorization 页面，随后进入 generating、完整 field-level diff、独立 approval、commit 与 delivery。Evidence 命名精确 confirmed/corrected record 与 time window。AI unavailable/timeout/invalid 保留 session、feedback、current plan 与普通 History/Analysis 使用。

## 9. Apple Watch 边界

已批准的 `.working/watch-final-review-v11.html` 只在与当前 PRD 和 spines 一致时继续作为 Watch 起始视觉参考。它覆盖 Planned/Free Workout Entry、planned/free Active Session、Rest Timer、Rest Confirmation、iPhone handoff、Recovery 与 Finish Review。Automatic Exercise/set/rep recognition、opt-in RPE verification/auto-use、conservative forgotten-Finish、manual fallback、local durability 与 transfer state 遵循当前合同，即使历史 fixture 未渲染它们。

Watch 永不显示 partial plan revision。Active session 绑定其 Start snapshot。复杂 privacy、plan diff、conflict、Apple Health、Analysis 与 Plan Exchange review 留在 iPhone。

## 10. 可复用异常状态合同

| State | 布局行为 | 保留真值与恢复 |
|---|---|---|
| Loading | 在受影响 boundary 使用 inline/native progress；可用 cached fact 保持可见。 | 命名正在加载的对象；Cancel/Back 保留 input。 |
| Empty | `ContentUnavailableView` 风格 symbol、直白原因、一个相关 route。 | 永不从缺失数据虚构 insight 或 recommendation。 |
| Offline | 受影响 action 旁使用全宽 neutral/attention row。 | 当前 local plan、cached History、Watch recording 与 manual path 仍可使用。 |
| Permission unavailable | capability row 与 explanation panel；不进入 generic modal loop。 | 命名 observable scope 与 system-settings route，不声称 denial。 |
| Pending | Amber rail/label 加精确 object 与 boundary。 | 区分 draft、local commit、Watch delivery、Health write 与 transfer。 |
| Failure | error summary 优先、retained fact 其次、Retry 位于失败 boundary。 | 不显示 optimistic success；prior effective revision 与 durable record 保留。 |
| Conflict/stale | 保留两个 revision，并标记依赖 Analysis/proposal stale。 | device time 永不选择真值；路由到显式 resolution。 |
| Destructive/omission | 原生 confirmation 明确 object、copy、Analysis effect 或被省略 import field。 | Cancel 使每个 current fact 保持不变。 |

## 11. Accessibility 与 Appearance 验收

- VoiceOver 顺序遵循视觉优先级。Proposal heading 可导航；diff row 宣读 path、change type、before/after value 与 future-session scope。
- Authorization 宣读 category、state、purpose 与 record window；focus 和 scrolling 不能选择 category。
- Error focus 落在 error summary，Retry 保留 input，success focus 落在精确 local/remote result panel。
- Dynamic Type 在 iPhone 至少支持 200%；必需中文字符串、consequence、digest、value 与 action 换行而非截断。
- Light/Dark、Increase Contrast、Differentiate Without Color、Reduce Motion、Full Keyboard Access、至少 44 × 44 pt target、localization expansion、keyboard avoidance、native back 与 safe-area clearance 都是强制项。
- P3/sRGB color、最大中文字号、VoiceOver focus restoration、chart point selection、单手使用与 Watch handoff 仍需真机验证。

## 12. 覆盖与 Reviewer Gate

| Requirement group | 视觉/状态覆盖 |
|---|---|
| FR-001–041、FR-061–066 | Watch v11 boundary、Session Return、Training History、完整 Analysis、correction/incomplete/conflict/recovery。 |
| FR-054–060、FR-078–087 | `AI-01`–`AI-06`：conversation、remote authorization、完整 review、immutable approval、atomic commit、Watch delivery 与 graceful failure。 |
| FR-071–073 | Export review、原生 Share Sheet、安全 import preview/mapping，只创建 new draft。 |
| FR-088–090 | Apple Health capability scope、read observability、idempotent write、failure 与 detached copy。 |
| FR-091 | 一次 post-session invitation 与现有 authorized diff/approval lifecycle。 |

Reviewer Gate 状态：**ready，reviewer 未运行**。在 Product Owner 接受本合同之前，ND-03 不标记为 accepted。ND-04 与 `architecture-handoff.md` 有意保持未开始。

Architecture 在实现验收前的 blocker：冻结 recognition whitelist、RPE verification/auto-use operating point、forgotten-Finish operating point、plan-file parser/size limit、Apple Health capability-to-data mapping 与 Alpha Plan Safety Rule Pack v1。真实 remote-AI traffic 前，需要确定 provider/subprocessor、retention、model-training policy 与 request-field-to-authorization-category mapping。超出 Product Owner 测试的发布前仍需要专业审核。
