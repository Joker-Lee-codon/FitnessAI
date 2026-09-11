# FitnessAI 钛衡组件规格

## 1. 范围与权威性

本规格定义已确认视觉形态与面向 SwiftUI 的契约。行为不变量仍由 PRD 和 `EXPERIENCE.md` 管理。令牌来自 `design-system/fitnessai/tokens.json`。

## 2. 共享组件契约

- 高频/后果显著触控目标最小 44 × 44 pt；相邻目标最小 8 pt。
- 状态使用符号 + 字面文字 + 结构处理；颜色只是冗余信号。
- 只有本地持久提交后才显示成功。同步拥有独立指示器。
- 按压状态使用 100 ms 透明度/状态层，不改变布局边界。
- 所有组件支持 Dynamic Type、VoiceOver、Increase Contrast、Reduce Motion 和深浅色外观。

## 3. 组件清单

### 3.1 `TitaniumPrimaryAction`

**结构：** 标签、可选前置 SF Symbol、可选进度指示器、通栏操作表面。

**变体：** 主要、次级轮廓、安静文字、破坏性确认。

**状态：** 空闲、按下、带原因禁用、本地提交中、已提交、失败并保留草稿。

**视觉：** 单一主要操作使用冰蓝填充；8–12 pt 圆角；首选高度 48 pt。破坏性操作不能共享冰蓝主层级。

**SwiftUI：** 带语义 role 的 `Button`；提交时 `ProgressView` 替代前置符号；`.disabled` 搭配可见原因。

### 3.2 `InstrumentReadout`

**结构：** 数值、单位、事实标签、来源/权威行、可选草稿标记。

**变体：** 实际负重主导、次数次级、RPE 可调节、时长。

**状态：** 计划预填、复制自上一组、历史预填、用户输入、预测、已确认、已纠正、未解决。

**视觉：** 表格粗体数值、基线单位、下方来源；绝不显示“检测到负重”。

**无障碍：** 一个分组摘要；可编辑变体提供原生增减 action 和数值/来源。

### 3.3 `DurabilityRail`

**结构：** 2–4 个分段、文字边界、可选同步符号。

**状态：** 编辑中、本地提交中、已存于本机、等待同步、已同步、失败。

**视觉：** 4 pt 轨道；已完成段实心、待处理段轮廓、失败段中断。文字状态保持可见。

**规则：** 后续云同步失败时，本机已保存段仍保持完成。

### 3.4 `FactStateLabel`

**结构：** SF Symbol、字面状态、可选来源后缀。

**状态：** 已接受、不确定、已纠正、未解决、待处理、待更新、冲突、仅手动、不支持。

**视觉：** 紧凑行内标签，或高注意状态使用 4 pt 左边界。它与受影响事实合并，而不是作为通用漂浮 Badge。

### 3.5 `ActualSetLedgerRow`

**结构：** 组序号、次数、实际负重、RPE/有效来源、完整性、修订状态。

**变体：** Watch 紧凑摘要、iPhone 账本行、展开可编辑组。

**状态：** 已确认、自动采用 RPE、已纠正、必填字段待处理、已删除/Tombstone、修订冲突。

**视觉：** 使用线条和基线对齐，不使用卡片。待处理使用琥珀轨道 + 字面标签；已纠正使用修订标记以及旧值/当前值。

### 3.6 `CorrectionBoundary`

**结构：** 问题标签、保留的同组事实、最短纠正选择、更改、稍后处理。

**状态：** 安全、已延后、提交中、已提交、提交失败、安全状态撤回。

**视觉：** 琥珀左轨、强问题、保留事实账本、一个高强调确认。

**不变量：** “稍后处理”和安全状态丢失都保留待处理事实；不使用倒计时。

### 3.7 `CrownAdjustableValue`

**结构：** 已提交值/来源、草稿值、单位、Crown 提示、触控替代、明确确认。

**状态：** 未改变、草稿中、达到边界、不支持语义、提交中、失败。

**SwiftUI：** `.focusable()`、`.digitalCrownRotation`、原生无障碍可调节 action 和明确的 `Button` 提交。

### 3.8 `RPEVerificationPrompt`

**结构：** 预测值与来源、可编辑整数、验证窗口状态、确认、更改/稍后。

**状态：** 已关闭、前五次验证、通过/提供自动采用、重新校准、自动采用、漂移、弃权、信号缺失。

**视觉：** 使用字面整数；不使用密集十按钮 Watch 网格，也不使用未验证的锚点文案。

### 3.9 `PlanDiffReview`

**结构：** 受影响的未来计划/修订、字段、计划/当前/建议值、后果、接受/编辑/拒绝。

**状态：** 建议、已编辑建议、已接受、已拒绝、待更新、冲突、提交失败。

**视觉：** 标准字号使用三列账本；无障碍字号使用堆叠字段组。

### 3.10 `SyncBoundaryIndicator`

**结构：** 副本/设备范围、状态符号/文字、最近事件、可选下一步。

**状态：** 已存于本机、iPhone 已收到、等待同步、已同步、离线、重试中、失败、冲突。

**视觉：** 非模态状态行；正式组期间同步状态更新不打断用户。

### 3.11 `RecoveryChoiceSheet`

**结构：** 恢复的训练场次身份、持久边界、可恢复片段、继续、以待补全结束、确认丢弃。

**状态：** 精确恢复、部分写入、边界不明确、并发训练场次、提交中、失败。

**焦点：** 摘要第一、继续第二、破坏性丢弃最后。

### 3.12 `SupportBoundaryNotice`

**结构：** 明确设备/动作/信号、支持状态、保留字段、可用回退。

**状态：** 支持、有限、仅手动、不支持、低置信度、矩阵不可用。

**视觉：** 在受影响操作前显示行内边界。不支持使用符号 + 文字，不能静默禁用。

### 3.13 `LifecycleRequestRow`

**结构：** 请求类型、精确副本范围、状态、时间/进度、例外、下一步。

**状态：** 已受理、处理中、范围完成、失败、离线设备待处理、保留/法律例外。

**规则：** 轮询不反复播报；完成时明确哪些完成、哪些没有完成。

### 3.14 `TrendEvidenceChart`

**结构：** 结论、时间控件、绘图区、直接点标签、排除说明、表格替代。

**变体：** 主要动作负重趋势、周训练量、时长、组数。

**状态：** 加载骨架、就绪、空白、待处理输入被排除、冲突待更新、计算失败。

**视觉：** 已确认实线、被排除/待处理虚线区域、已纠正空心点，图形最低 3:1 对比。

### 3.15 `SystemStatePanel`

**结构：** SF Symbol、精确对象/状态、原因、保留数据、一个下一步。

**变体：** 加载、空白、离线缓存、错误、不支持、恢复、本地写入失败。

**规则：** 本地/缓存内容仍有效时，绝不能用全屏通用错误替代有用内容。

### 3.16 `PlanExchangeReview`（V1.1）

**结构：** file/source identity、schema/catalog/plan revision、included/excluded scope、完整 plan ledger、validation result、mapping/omission row、duplicate state、consequence、Create New Draft、Cancel。

**状态：** export ready/creating/failed；validating；compatible；unsupported/newer；malformed/executable/over-limit；duplicate；mapping required；explicit omission；ready；committing；committed；failed preserving review。

**视觉：** 采用 ledger composition，而不是 generic file card。amber rail 标记 unresolved mapping/omission；destructive rail 标记 invalid input。Original 与 canonical Exercise name 同时保持可见。

**不变量：** mutation 前必须预览；import 绝不 merge、overwrite 或 revise 现有计划。该组件在 MVP 中不可用。

### 3.17 `StructuredInputDraft`（Future Boundary）

**结构：** source modality、observable capture/transcription state、parsed field/value/unit、ambiguity/provenance、冲突的 committed fact，以及 edit/confirm/reject/cancel action。

**状态：** unavailable/permission state、listening、interrupted、transcribing、ambiguous、draft、conflict、edited、confirmed、committing、committed、rejected/cancelled、failed。

**视觉：** 带 literal source label 的 muted draft ledger；amber draft rail；conflict 使用 split comparison 与 destructive rail。替代值提交成功前，committed fact 在视觉上保持主位。

**不变量：** 面向 Post-MVP voice 或 third-party import 的非实现 pattern。不得有持续监听动画、不得在 MVP 实例化，也不得自动替代 confirmed fact。

## 4. 组件—状态组合规则

| 情境 | 组合 |
|---|---|
| 正式训练组 | `InstrumentReadout` + `DurabilityRail` + 一个 `TitaniumPrimaryAction`；不主动纠错 |
| 安全休息 | 保留的 `ActualSetLedgerRow` + `CorrectionBoundary` 或可调节组件 |
| 结束 | 边界摘要 + 训练组账本 + 持久性/同步 + 一个结束确认 |
| iPhone 复核 | 账本行 + 行内事实状态 + 计划差异 + 固定完成操作 |
| 同步/隐私 | 范围化生命周期行；不使用通用成功横幅 |
| 分析 | 结论 + 趋势证据 + 排除项 + 决策说明 |
| V1.1 Plan Portability | source/version + complete preview + mapping/omission ledger + 一个 Create New Draft action |
| Future Structured Input | committed fact + 带 source label 的 draft + conflict/ambiguity + 明确 confirm/edit/reject/cancel |

## 5. 必需实体设备验证

在 40/41 mm 与 44/45/46/49 mm Watch 类别、小/大受支持 iPhone、适用的横竖屏、最大字号、VoiceOver、Increase Contrast、Reduce Motion、Always On、流汗/单手交互，以及离线/本地写入失败状态下验证组件几何与反馈。
