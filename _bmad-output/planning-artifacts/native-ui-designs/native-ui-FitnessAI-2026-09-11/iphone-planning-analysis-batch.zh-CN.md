# FitnessAI iPhone 计划与分析页面批次

## 文档状态

- 阶段：`ND-03 Screens`
- 批次：`iPhone planning and analysis`
- 状态：Product Owner 已于 2026-09-12 通过“进入最后一批”的指令接受并冻结
- 方向：`Training Ledger`
- 冻结 Token：`0.2.0-nd02-accepted`
- 页面：`PA-01 Training Plans`、`PA-02 Analysis`、`PA-03 Exercise Catalog`

## 批次主张

本批把计划、证据和 Exercise 词汇拆成三种不同记录，而不是一个仪表盘。Training Plans 是修订谱系，Analysis 是证据阅读，Exercise Catalog 是规范索引。三者都把共享记录脊线用于真实排序关系，同时保持各自独立的页面任务。

Claude 同款米白、陶土、灰紫、苔绿和琥珀继续承担语义：Plan 使用陶土；effective Actual 证据使用墨色/灰紫；已验证支持使用苔绿；未解决、排除和 stale 输入使用琥珀。颜色本身不代表生效、支持或因果。

## 共享布局与导航

- 三个页面都是从 Plan Home/Today、Session Review/History 或搜索进入的上下文 route，不预先决定最终 Tab Bar。
- 原生大标题必须先明确当前对象，再展示派生指标或操作。
- 记录脊线在 PA-01 表示修订顺序，在 PA-02 表示时间证据，在 PA-03 表示规范分类/索引顺序。
- 原生返回保留选中修订、时段、Primary Exercise、筛选、搜索词和滚动位置。
- 加载保留 durable 内容；错误保留旧事实与输入；空状态引导第一个有意义动作，不编造内容。

## 页面 PA-01 — Training Plans

**目的。** 检查 effective Training Plan、不可变修订谱系、未来 session 结构、非生效 draft/proposal 与 Watch 送达，并避免混淆。

**进入 / 退出。** 从 Today & Plans 进入。选择 effective revision/session 查看详情；`创建或修订计划` 进入 AI Plan Chat。Proposal Review 与 Approval/Commit/Delivery 保持为独立下游页面。Export 进入受限 Plan Exchange 流程。

**可追溯性。** `FR-028–035`、`FR-054–060`、`FR-071–073`、`FR-078–087`；`UJ-4`、`Flows 3–5`。

**层级。** Effective plan identity → 周期进度和有序 session → Watch 送达 → 修订谱系 → 非生效 draft/proposal 状态 → 创建/修订/导出操作。

**主操作。** 浏览时为 `打开生效计划`；只有存在完整有效 proposal 时才显示 `复核提案`。创建/修订是上下文操作，绝不使用批准样式。

**组件 / Token。** `plan-revision-header`、`revision-lineage`、`plan-session-row`、`sync-state-indicator`、`proposal-approval-gate`；`planText`、`confirmedText`、`pendingText`、`destructive`、`phoneTitle`。

| 状态 | 契约 |
|---|---|
| 生效 | 指明 revision、开始日期、周期、schema/catalog version 和未来 session 范围。 |
| 加载 | 保留 effective revision；行内进度可以刷新谱系或送达。 |
| 空 | “没有生效计划。”把创建和 FitnessAI 文件导入作为不同路径。 |
| Draft / 生成中 | 标记非生效；取消或失败不能改变 effective plan。 |
| Proposal 有效 | 在独立完整复核前显示 proposal identity、base revision、digest、validation 与 unresolved 数量。 |
| 无效/未映射/安全阻塞 | 指明阻塞原因和允许的纠正/拒绝路径；不显示批准。 |
| 批准失效 / base stale | 清除批准，说明原因/新 base，要求重新完整复核；绝不静默 rebase。 |
| Commit pending/失败 | 不称 proposal 已生效；失败时旧 revision 完整有效。 |
| Watch pending/delivered/failed | 送达与本地生效分开；最后完整 Watch revision 继续被指明并可用。 |
| 破坏性 | 删除 plan/revision 指明未来范围和同步删除状态；历史 Actual Sets 不属于 mutation。 |
| 无障碍 | Revision 行朗读 identity、生效/非生效、base、validation、delivery 和可用动作。 |

**归属 / 交接。** iPhone 拥有创建、复核、批准、commit、谱系、送达状态和 Plan 文件交换。Watch 只接收完整 committed compatible revision，用于未来 Start。

**SwiftUI 约束。** 稳定 `planId/revisionId/proposalId` identity；类型化 route；批准绑定 `proposalId + baseRevision + digest`；原子/幂等 commit 与送达重试。

## 页面 PA-02 — Analysis

**目的。** 从 effective Actual Sets 解释训练发生了什么变化，并公开时段、Primary Exercise、排除项、来源，以及每个图表结论的文字等价物。

**进入 / 退出。** 从 History 或 Session Review 进入。原生返回时保留时段和 Primary Exercise。选择被排除/不完整事实进入准确 Session Review 记录。

**可追溯性。** `FR-036–041`、`FR-046`、`FR-059–060`、`FR-091`；`UJ-2`、`Flow 3`；`NFR-RPE-002`、`NFR-UX-001`。

**层级。** 时段 → 数据 freshness/排除状态 → 字面总结 → session/动作/训练量/强度/重量/时长事实 → 选中 Primary Exercise 证据曲线 → RPE 来源 → 可选复盘邀请。

**主操作。** 普通查看时无主操作。stale 或 partial 时为 `复核被排除记录`；可选 `请 AI 复盘` 保持非阻塞，并在发送任何数据前进入授权。

**组件 / Token。** `analysis-summary`、`evidence-curve`、`provenance-key`、`durable-state-label`、`proactive-review-invitation`；`actualText`、`confirmedText`、`pendingText`、`phoneMetric`。

| 状态 | 契约 |
|---|---|
| 当前 | 每个指标来自 effective Actual Sets，并指明选中时段。 |
| 加载 | 保留最后当前结果，行内显示计算进度。 |
| 空 | 说明该时段没有 effective Actual Sets；引导 History 或第一次训练。 |
| 局部 / stale | 指明被排除的不完整/冲突 session 与受影响指标；不展示虚假完整汇总。 |
| 计算失败 | 保留最后有效结果及其时段/version，并提供重试。 |
| 离线 | 本地可推导 Analysis 继续可用；Apple Health/AI 失败不移除它。 |
| RPE 来源 | 区分用户确认、纠正、auto-used、仅预测和被排除值。 |
| AI review 不可用 | 保留 Analysis 与反馈；不暗示 proposal 或 plan mutation。 |
| 无障碍 | 图表具有简洁趋势句和可导航点表，包含日期、Actual 值和来源。 |
| 外观 | 曲线使用实线/标记与文字 key，不使用渐变面积填充或只靠颜色区分系列。 |

**归属 / 交接。** iPhone 拥有聚合与解释。Watch 提供 committed Actual 事实；Plan 值绝不能代替缺失 Actual 值。

**SwiftUI 约束。** 可使用 Swift Charts，但必须有 accessibility representation 和文字总结。指标输入只使用 effective revision。Cache key 包括时段、Exercise、effective-record revision、schema 与 model provenance version。

## 页面 PA-03 — Exercise Catalog

**目的。** 在 iPhone 公开 canonical Exercise 词汇、自动支持边界、目标部位、动作类别、器械、替代依据和简洁合法教学文本。

**进入 / 退出。** 从 Plan detail、替代请求、纠正、Analysis Primary Exercise 选择或搜索进入。选择会把 canonical Exercise identity 返回来源流程，绝不静默替换动作。

**可追溯性。** `FR-008`、`FR-030–032`、`FR-049–053`、`FR-055`、`FR-073`；`UJ-1`、`UJ-4`、`Flow 2`。

**层级。** 搜索/筛选 → support matrix 上下文 → canonical Exercise 名称 → supported/limited/manual-only 状态 → primary target/movement/equipment → 教学文本 → 替代差异 → 明确选择。

**主操作。** 只有请求来源流程中显示 `选择这个动作`；普通浏览详情无常驻主 CTA。

**组件 / Token。** `exercise-index-row`、`recognition-state-chip`、`support-boundary`、`canonical-mapping-row`、`substitution-diff`；`confirmedText`、`pendingText`、`textPrimary`、`textSecondary`。

| 状态 | 契约 |
|---|---|
| 支持 | 指明准确 Watch/device/OS/佩戴侧/方向矩阵及支持的识别能力；不暗示普遍支持。 |
| 有限 | 指明哪个能力有限，并保留手动记录。 |
| 仅手动 / 不支持 | 字面状态 + 手动路径；不把它表现为 Exercise selection 禁用。 |
| 加载 | 保留缓存 canonical names 与已知支持状态；version refresh 行内进行。 |
| 搜索为空 | “没有匹配的规范动作。”允许修改查询或在适用处请求手动映射；绝不编造 mapping。 |
| Mapping 未解决 | 在所属流程中阻止 proposal/import 完成，直到映射或明确省略。 |
| 权限/信号不可用 | 将运行时可用性与 catalog 支持资格分开。 |
| 媒体不可用 | 保留第一方文本与事实；不显示破损或无授权媒体占位。 |
| 替代 | 选择前显示匹配 primary target/movement 以及准确 secondary-target/range 差异。 |
| 无障碍 | 支持状态、目标、动作模式、器械和替代差异使用文字/accessibility values，不只靠图标。 |

**归属 / 交接。** iPhone 拥有 catalog 查看、教学、mapping 与替代复核。Watch 只显示记录所需的 canonical name 与真实 supported/manual 边界。

**SwiftUI 约束。** 原生 searchable list，稳定 `exerciseId` 与 catalog/support-matrix version。资源必须合法/自有，非必要资源不进入 Watch。选择会把 identity 与依据返回来源 domain flow。

## 共享异常状态契约

| 边界 | 行为 |
|---|---|
| Effective plan vs proposal | Effective 内容保持墨色/confirmed；proposal 使用 Plan 色并明确标为非生效。 |
| Planned vs performed | Analysis 只消费 Actual；Plan 只能作为比较出现。 |
| Supported vs available | Catalog 资格与当前传感器/权限可用性是不同事实。 |
| Corrected vs predicted RPE | 纠正/用户确认事实驱动 effective Analysis；预测来源继续可见。 |
| Incomplete/conflicted records | 从依赖聚合中排除，并显示准确数量与恢复链接。 |
| Remote AI 不可用 | Plan、Analysis、Catalog、History 与本地记录仍可用。 |

## 视觉自我审查

计划页很容易变成卡片网格，Analysis 很容易变成通用 KPI 仪表盘，Catalog 很容易变成图标画廊。本设计拒绝三种默认做法：修订谱系强调时间与不可变性；Analysis 先给出文字发现，再用细证据曲线和数据点表支撑；Catalog 像严谨动作索引。记录脊线通过三种不同排序语义证明其必要性。装饰渐变、进度环、没有文字事实的身体热力图和通用 AI 闪光均被移除。

## 批次接受 Gate

Product Owner 已于 2026-09-12 通过“进入最后一批”的指令接受 PA-01 至 PA-03。Revision/effectiveness 分离、Actual-only Analysis、可见排除项和来源，以及真实 Exercise 支持边界现已冻结。当前 ND-03 批次为 System：Sync & Recovery、Account & Privacy 与必需异常状态。
