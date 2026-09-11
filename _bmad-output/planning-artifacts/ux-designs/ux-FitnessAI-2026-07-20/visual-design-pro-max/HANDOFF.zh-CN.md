---
title: FitnessAI 钛衡视觉设计交接
status: confirmed-ready-for-bmad-consumption
version: 1.1.0
confirmed_direction: Titanium Measure
stack: SwiftUI
platforms: [iOS 18+, watchOS 11+]
updated: 2026-08-08
---

# FitnessAI 钛衡视觉设计交接

## 1. 交接状态

方向 A「Titanium Measure / 钛衡」已经确认。本交付是品牌表达、构图、排版、配色、间距、组件外观、图表、图标策略、动效、触觉以及深浅色/Always On 适配的视觉权威。

它不替代 PRD，也不授权超出现有范围的实现。静态 HTML/CSS 预览只是评审载体，不是 Web 实现指南。

## 2. 权威顺序

### 产品与行为权威

1. `../../../prds/prd-FitnessAI-2026-07-19/prd.md`
2. `../../../prds/prd-FitnessAI-2026-07-19/addendum.md`
3. `../EXPERIENCE.md`
4. `../review-accessibility.md`
5. `../review-trust-privacy-safety.md`
6. `../validation-report.md`
7. `../review-rubric.md`

这些来源管理功能、MVP/Post-MVP 范围、流程、安全、隐私、信任语义、状态行为、数据来源、同步、恢复和用户权威。

### 视觉权威

1. `../DESIGN.md` — BMAD 视觉 identity spine 与阶段感知 component contract。
2. `../../../../../design-system/fitnessai/MASTER.md` — 已确认 Titanium Measure system。
3. `../../../../../design-system/fitnessai/tokens.json`
4. `../../../../../design-system/fitnessai/pages/`
5. 本 `visual-design-pro-max/` 交付：页面、组件、状态、预览与 SwiftUI 规格。

`DESIGN.md` 继承 Titanium Measure。raw visual value 以 master token file 为准；phase scope、component availability 与 behavior 以 `DESIGN.md` 和 `EXPERIENCE.md` 为准。

## 3. 交付物地图

| 交付物 | 用途 |
|---|---|
| `../../../../../design-system/fitnessai/MASTER.md` | 已确认全局视觉权威 |
| `../../../../../design-system/fitnessai/MASTER.zh-CN.md` | 完整中文副本 |
| `../../../../../design-system/fitnessai/tokens.json` | 机器可读语义令牌 |
| `../../../../../design-system/fitnessai/pages/` | 平台/页面家族覆盖 |
| `components/COMPONENT-SPECS.md` | 组件结构、变体、状态和不变量 |
| `components/SWIFTUI-MAPPING.md` | 原生实现映射 |
| `states/STATE-MATRIX.md` | 状态编码和逐页面覆盖 |
| `states/ACCESSIBILITY-VALIDATION.md` | 无障碍与实体设备门槛 |
| `watch/` | 5 个 Watch 页面规格 |
| `iphone/` | 9 个 MVP iPhone 规格 + 1 个 V1.1 portability 规格 + 1 个受门槛约束 Post-MVP 规格 |
| `previews/` | 高保真 PNG 评审板与静态 HTML 载体 |

每份英文 Markdown 都在同目录拥有结构和结论一致的 `.zh-CN.md` 中文副本。

## 4. 平台职责

| 关注点 | Apple Watch | iPhone |
|---|---|---|
| 活动训练场次 | 本地优先权威；开始/继续、采集、完成训练组、手动结束 | 仅为伴侣；不能替代活动场次权威 |
| 快速纠错 | 安全休息中的受支持纠错；Crown 可选加速；明确提交 | 完整字段编辑和长说明 |
| 复杂记录 | 保留待处理事实并移交精确上下文 | 拆分/合并/插入/删除、冲突、不支持语义 |
| 计划 | 开始已选计划；查看即时上下文 | 查看、创建、编辑、替代、复用历史、批准变更 |
| 分析/历史 | 仅最小结束摘要 | 完整历史、趋势、排除项、修订 |
| 同步/恢复 | 本地持久边界、可恢复场次 | 恢复、重试、冲突选择、生命周期协调 |
| 隐私/账号 | 最小可观察状态 | 账号、权限、导出、删除、研究、退出/切换 |

## 5. 页面—需求与组件矩阵

### Apple Watch

| 页面/规格 | 需求与流程 | 主要组件 | 信任/状态职责 | 预览 |
|---|---|---|---|---|
| `watch/WORKOUT-ENTRY.md` | FR-001、FR-028、FR-030–032、FR-043、FR-049；UJ-1、UJ-3、Flow 8 | Primary Action、Support Boundary、Sync Boundary | 离线开始、计划/自由、支持/仅手动/不支持 | `previews/watch-pages-review.png` 01 |
| `watch/ACTIVE-SESSION.md` | FR-002–004、FR-008–010、FR-016–019、FR-043、FR-061；UJ-1、UJ-3、Flow 6/8 | Instrument Readout、Durability Rail、Fact State、Primary Action | 实际/计划、用户负重权威、本地写入、传感器中断 | 预览 02 |
| `watch/REST-RESOLUTION.md` | FR-007、FR-011–015、FR-019–027、FR-061–062；UJ-1、UJ-3、Flow 8 | Correction Boundary、Crown Adjustable、RPE Prompt、Set Row | 安全交互、保留事实、预测/确认/纠正/待处理 | 预览 03 |
| `watch/WATCH-RECOVERY.md` | FR-043、FR-046、FR-064–066；UJ-5、Flow 6/7 | Recovery Choice、Set Row、Durability、Sync | 持久边界、部分写入、重复 Replay、并发场次 | 预览 04 |
| `watch/WATCH-FINISH-REVIEW.md` | FR-004–007、FR-029、FR-033–034、FR-062–063；UJ-1、UJ-3、Flow 6 | Set Row、Fact State、Durability、Sync、Primary Action | 完整/待补全、手动结束权威、本地/同步 | 预览 05 |

### iPhone

| 页面/规格 | 需求与流程 | 主要组件 | 信任/状态职责 | 预览 |
|---|---|---|---|---|
| `iphone/TODAY-PLANS.md` | FR-028、FR-035、FR-043–045；UJ-1/2/3 | 计划账本、Primary Action、Sync、Support | 计划/实际边界、Watch 路径、离线缓存 | `previews/iphone-core-pages-review.png` 01 |
| `iphone/TRAINING-PLANS.md` | FR-028–035；UJ-1/2/3、Flow 8 | 计划账本、Plan Diff、Support Boundary | 明确替代/更新选择、未来修订、草稿 | 核心预览 02 |
| `iphone/SESSION-REVIEW.md` | FR-006–007、FR-026、FR-029、FR-033–035、FR-040–041、FR-061–063；UJ-1/3、Flow 7/8 | Set Row、Fact State、RPE Prompt、Plan Diff、Sync | 完整纠错、来源、冲突、有效修订 | 核心预览 03 |
| `iphone/TRAINING-HISTORY.md` | FR-035–041、FR-045–046、FR-063、FR-067–068；UJ-2/3/5 | 训练场次账本、Fact State、Sync、Lifecycle | 完整/待补全、离线缓存、恢复、Tombstone | 核心预览 04 |
| `iphone/ANALYSIS.md` | FR-037–040、FR-046、FR-063；UJ-2 | Trend Chart、指标、Fact State、排除边界 | 有效实际训练组、被排除待处理数据、冲突待更新 | 核心预览 05 |
| `iphone/EXERCISE-CATALOG.md` | FR-030–032、FR-049–053；UJ-1/4、Flow 8 | 规范身份、Support Boundary、属性账本 | 支持/仅手动、合法媒体、无腕部动作结论 | `previews/iphone-system-pages-review.png` 01 |
| `iphone/SYNC-RECOVERY.md` | FR-043–048、FR-063–070；UJ-5、Flow 6/7 | Sync、Lifecycle、Recovery、修订对比 | 重试、Replay、冲突、恢复、并发场次 | 系统预览 02 |
| `iphone/ACCOUNT-PRIVACY.md` | FR-042–048、FR-067–070；UJ-5、Flow 9 | Lifecycle、Sync、能力/副本范围行 | 权限词汇、导出、删除、研究、退出/切换 | 系统预览 03 |
| `iphone/SUPPORT-MATRIX.md` | FR-049–053 和发布门槛；Flow 8 | Support Boundary、矩阵账本、Fact State | 明确支持/有限/仅手动/不支持状态 | 系统预览 04 |
| `iphone/TRAINING-PLAN-PORTABILITY-V1-1.md` | FR-071–FR-073、NFR-PORT-001、DV-007；Flow 10 | Plan Exchange Review、Fact State、Support Boundary、Primary Action | **仅 V1.1**；untrusted file、完整 preview、mapping/omission、新草稿、无覆盖 | 仅 spine/page spec；无 MVP preview |
| `iphone/BEGINNER-PLAN-POST-MVP.md` | FR-054–060、NFR-SAFE-001；UJ-4 | 带标签采集、Safety Boundary、Plan Diff | **仅 Post-MVP**；专业安全门槛；明确批准 | 系统预览 05 |

## 6. 组件状态清单

| 组件 | 必需状态 |
|---|---|
| `TitaniumPrimaryAction` | 空闲、按下、带原因禁用、提交中、已提交、失败并保留草稿 |
| `InstrumentReadout` | 计划预填、上一组/历史预填、用户输入、预测、确认、纠正、未解决 |
| `DurabilityRail` | 编辑中、本地提交中、已存于本机、等待同步、已同步、失败 |
| `FactStateLabel` | 已接受、不确定、已纠正、未解决、待处理、待更新、冲突、仅手动、不支持 |
| `ActualSetLedgerRow` | 已确认、自动采用 RPE、已纠正、必填待处理、Tombstone、冲突 |
| `CorrectionBoundary` | 安全、延后、提交中、已提交、失败、安全状态撤回 |
| `CrownAdjustableValue` | 未改变、草稿、边界、不支持语义、提交中、失败 |
| `RPEVerificationPrompt` | 关闭、前五次、通过/提供自动采用、重校准、自动采用、漂移、弃权、信号缺失 |
| `PlanDiffReview` | 建议、已编辑、已接受、已拒绝、待更新、冲突、失败 |
| `SyncBoundaryIndicator` | 已存本机、iPhone 已收到、待处理、已同步、离线、重试、失败、冲突 |
| `RecoveryChoiceSheet` | 精确恢复、部分写入、边界不明确、并发场次、提交中、失败 |
| `SupportBoundaryNotice` | 支持、有限、仅手动、不支持、低置信度、矩阵不可用 |
| `LifecycleRequestRow` | 已受理、处理中、范围完成、失败、离线设备待处理、保留例外 |
| `TrendEvidenceChart` | 加载、就绪、空白、排除待处理输入、冲突待更新、计算失败 |
| `SystemStatePanel` | 加载、空白、离线缓存、错误、不支持、恢复、本地写入失败 |
| `PlanExchangeReview` | export ready/failed、validating、compatible、unsupported/newer、malformed/over-limit、duplicate、mapping required、explicit omission、ready、committing new draft、committed、failed |
| `StructuredInputDraft` | future permission/unavailable、listening/transcribing、interrupted、ambiguous、draft、conflict、edited/confirmed/rejected、committing、committed、failed |

## 7. 同步、恢复、隐私与确认边界

- **同步：** 本地持久成功与云同步分离。同步失败绝不能撤销“已存于本机”。
- **恢复：** 显示恢复身份与最近持久边界。部分写入形成一个待处理实际训练组。Replay 幂等。
- **冲突：** 保留所有相关用户修订。不能只按设备时间选择。依赖 Analysis/建议保持待更新/待处理。
- **隐私：** 始终明确副本——本地结构化、已同步、Apple Health 所有、研究上传、导出或本地原始流。
- **权限：** HealthKit 读取只有可观察数据状态，不能宣称拒绝。
- **确认：** 预测、自动采用 RPE、用户确认、纠正和有效值保持可区分。自动化不能成为不可逆事实。
- **不支持语义：** 保留已支持的同组事实，并移交到精确 iPhone 字段。
- **Plan portability：**对 untrusted input 执行有界处理、preview 与 mapping，并且只转换为新草稿。取消或失败时，现有计划保持不变。
- **Future voice/share：**保留 extension state 与 provenance，但不增加 MVP navigation、持续监听、share affordance 或 raw-audio authorization。
- **Record-informed AI：**DV-006 阻断 UX/feature design。Architecture 只能保留通用 evidence/provenance/proposal/decision 字段；不暗示存在 AI page 或 service。

## 8. 预览清单

| 预览 | 覆盖 |
|---|---|
| `previews/watch-pages-review.png` | 全部 5 个 Watch 页面 |
| `previews/iphone-core-pages-review.png` | Today、Plans、Session Review、History、Analysis |
| `previews/iphone-system-pages-review.png` | Catalog、Sync、Account、Support、受门槛约束 Beginner Plan |
| `previews/states-review.png` | 8 个高风险状态处理 |
| `previews/themes-review.png` | Watch 深色/Always On；iPhone 深色/浅色/Increase Contrast |

对应 `.html` 与 `titanium.css` 是静态评审载体。不要把它们转换成 Web 架构或 Tailwind 组件。

## 9. SwiftUI 实现位置

- 全局系统：`../../../../../design-system/fitnessai/MASTER.md`
- 令牌：`../../../../../design-system/fitnessai/tokens.json`
- 组件契约：`components/COMPONENT-SPECS.md`
- 原生控件映射：`components/SWIFTUI-MAPPING.md`
- 页面构图和状态规格：`watch/` 与 `iphone/`
- 无障碍/实体设备门槛：`states/ACCESSIBILITY-VALIDATION.md`

实现使用语义 Color Asset、语义 Font 角色、`@ScaledMetric`、`NavigationStack`、原生控件、Swift Charts、无障碍环境值，以及区分草稿/本地提交/同步的状态模型。

## 10. 给 BMAD Architecture 的指令

- 在架构中保留 Watch 本地优先活动场次权威，以及独立草稿/本地/同步状态。
- 保留稳定 ID、可审计修订、Tombstone、幂等 Replay 和精确字段 Handoff。
- 定义语义令牌 Asset 和可复用组件边界；不要逐页面编码原始视觉值。
- 不要把 HTML 预览文件变成实现依赖。

## 11. 给 Epics 与 Stories 的指令

- 每个 UI Story 引用页面规格、组件规格、状态矩阵、PRD FR 和用户流程。
- 验收标准必须包含该页面适用的正常、加载、空白、离线、失败、待处理、冲突、恢复和不支持状态。
- 添加明确无障碍、深浅色、Dynamic Type、VoiceOver、Reduce Motion、Increase Contrast 和安全区标准。
- Beginner Plan 的 Post-MVP Story 在安全/产品门槛通过前不得进入 MVP。
- V1.1 plan portability 不得进入 MVP。其 Story 进入验收前，Product 与 Architecture 必须冻结 DV-007 parser limit。
- Voice、third-party format、QR/link sharing 与 record-informed AI 不得进入 MVP；future-state contract 是 architecture boundary，不是 Story 授权。

## 12. 给 Dev Agent 的指令

- 实现前读取 `MASTER.md`、相关 design-system 页面覆盖、页面规格、组件规格和状态矩阵。
- 使用 SwiftUI 原生语义和 SF Symbols。不得引入 Web 字体、CSS 值、通用卡片组件或 hover 行为。
- 只有本地提交后才显示成功；同步独立更新。
- 保留 `EXPERIENCE.md` 中精确中文状态词汇。
- 预览是参考，不是像素固定布局；Dynamic Type 和设备适配优先于截图几何。

## 13. 仍需实体设备验证

- 明亮/暗光健身房中的 Watch 两秒扫读；
- 流汗、单手触控、Crown、误触防护和触觉辨识；
- Always On 亮度/防烧屏行为；
- 小/大 Watch 和 iPhone 几何，以及适用横屏；
- 最长中文字符串、iPhone 200% 和 Watch 140% 放大；
- 纠错/恢复/Handoff 的 VoiceOver 焦点恢复；
- P3/sRGB 与 Increase Contrast；
- 离线、本地写入失败、延迟/乱序 Replay、冲突与恢复；
- 部署目标中的 SF Symbol 可用性/光学字重。

## 14. 开放发布门槛

1. Watch 负重语义子集（单位、步进、单侧、辅助、自重、计时组、自定义动作）。
2. 中文 RPE 锚点和教育位置；字面整数仍为安全临时方案。
3. Forgotten-Finish 双信号实体设备证据；通过前保持不可用。
4. Post-MVP Beginner Plan 专业安全评审和 NFR-SAFE-001。
5. 合法授权/自有 Exercise 媒体可用性。
6. V1.1 Training Plan file 的 DV-007 bounded parser limit。
7. Future voice 支持的 surface/fact、duplicate identity、recognition mode，以及独立 raw-audio policy/consent。
8. Future sharing transport、access、expiry、revocation、forwarding risk、authenticity 与中国区 placement。
9. 任何 record-informed AI UX 或 feature architecture 前的 DV-006 Product 定义。

## 15. 冲突处理规则

1. 功能、范围、安全、隐私、状态行为和数据语义：PRD、Addendum、`EXPERIENCE.md` 和评审文档优先。
2. 配色、排版、构图、视觉层级、组件外观、图表语言和品牌表达：本次确认的 UI UX Pro Max 交付优先。
3. `DESIGN.md` 与 Titanium Measure 已对齐为 peer：raw visual token value 来自 master system；phase scope 与 component availability 来自 spines。
4. 实现便利不能改变已确认产品边界。
5. 新冲突仍含糊时，停止受影响实现，记录精确冲突并交回 Product/UX，不得猜测。
