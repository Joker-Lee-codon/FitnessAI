# FitnessAI iPhone 复核页面批次

## 文档状态

- 阶段：`ND-03 Screens`
- 批次：`iPhone review`
- 状态：已由 Product Owner 于 2026-09-12 接受并冻结
- 方向：`Training Ledger`
- 冻结 Token：`0.2.0-nd02-accepted`
- 页面：`IR-01 Today & Plans`、`IR-02 Session Review`、`IR-03 Training History`

## 批次主张

iPhone 是让训练事实变得可理解、可纠正、可复用的地方。它不把 Watch 放大，也不以激励型分析开场。页面像一份安静的训练账页：左侧记录脊线保留顺序，水平规则分隔证据，Plan/Actual 双栏让差异明确可见。

米白是文档表面，墨色承载持久事实，陶土色标记 Plan 来源，灰紫色标记 Actual/纠正，苔绿色标记已确认本地事实，琥珀色标记不完整或 pending 证据。独特元素是记录脊线，而不是 Claude 同款配色本身。

## 共享布局

```text
┌──────────────────────────────────┐
│ 原生大标题                操作 │
│ 上下文 / 字面状态               │
├─ 记录脊线 ──────────────────────┤
│ 一个主导对象                     │
│ 证据行 / Plan ↔ Actual           │
│                                  │
│ 与上下文相符的下一步              │
└──────────────────────────────────┘
```

- 默认左对齐。指标按数值与单位对齐，不做装饰性居中。
- 首屏先识别当前 effective plan 或所选 session，再展示派生摘要。
- 记录脊线延续 Watch `training-rail`：Plan Home 表示动作顺序，Session Review 表示 Actual Set 顺序，History 表示 session 时间顺序。
- 使用原生 list、disclosure row、navigation、refresh、search 和 sheet。自定义绘制只用于记录脊线和 Plan/Actual 差异规则。
- 不使用仪表盘拼贴、Hero 渐变、Activity Ring、装饰 streak、通用 insight card 或悬浮 AI 球。

## 页面 IR-01 — Today & Plans

**目的。** 明确当前 effective Plan Revision、真实 Watch 送达状态、下一次可执行训练，以及需要复核的回传 session。

**进入 / 退出。** 这是 private-Alpha 根页面。在 Watch 开始仍是 Watch 行为。`复核训练记录` 进入 IR-02；`查看训练历史` 进入 IR-03；计划创建/修订进入独立 AI planning flow。

**可追溯性。** `FR-028–035`、`FR-043–046`、`FR-054–060`、`FR-078–087`；`UJ-4`、`Flows 2–4`。

**层级。** 今天/日期 → 当前 effective revision → 字面 Watch 送达状态 → 下一 session 与有序动作 → 回传 session 复核队列 → 创建/修订操作。

**主操作。** 有回传 session 待处理时使用 `复核回传训练`；否则使用 `打开下一次训练`。AI 创建/修订保留为上下文操作，不与事实待解决动作竞争。

**组件 / Token。** `plan-revision-header`、`sync-state-indicator`、phone `training-rail`、`session-control`；`canvas`、`surface`、`planText`、`confirmedText`、`pendingText`、`phoneTitle`、`phoneBody`、`phoneMetric`。

| 状态 | 契约 |
|---|---|
| 默认 | 分别指明 effective revision、下一 session 和 Watch 送达。 |
| 加载 | 保留当前 effective plan 与缓存回传 session；刷新状态保持行内。 |
| 空 | “还没有生效计划。”提供 `创建计划` 与独立的 `开始手机自由训练`，不编造推荐。 |
| Watch pending | “Revision 8 正在等待送达 Watch；那里仍可使用 Revision 7。” |
| Watch 失败/离线 | 保留 Revision 7，指出失败，提供幂等重试，不展示局部 Revision 8。 |
| 回传 session pending | 显示 Watch 权威与回执状态，不阻止访问计划。 |
| 冲突 | 指明受影响 session/revision；通过明确比较解决，不以设备时间决定。 |
| 权限不可用 | 计划访问和本地训练仍可用；可选能力状态保持次级。 |
| 无障碍 | 修订标题朗读 effective identity 与送达状态；动作脊线提供一个摘要和可导航行。 |
| 外观 | 默认浅色；深色保留文档层级，不转成发光仪表盘。 |

**归属 / 交接。** iPhone 拥有计划事实、送达检查和回传 session 路由。Watch 拥有由 Watch 捕获的活动 session，并保持 Start snapshot 固定。

**SwiftUI 约束。** `NavigationStack` 根页面配合原生 refresh。稳定 ID 保留滚动/筛选状态。加载不替换持久内容。送达重试幂等，不能激活局部修订。

## 页面 IR-02 — Session Review

**目的。** 展示全部 Actual Set、与 Plan 区分、解决不完整事实，并在 Analysis 或 AI review 前公开可审计纠正。

**进入 / 退出。** 从 Today 回传队列、History 或传输通知进入。字段编辑打开范围明确的原生编辑器。完成后返回同一 session；只有确定 effective revision 后才更新依赖的 History/Analysis。

**可追溯性。** `FR-002–007`、`FR-029`、`FR-033–041`、`FR-061–067`、`FR-089–091`；`UJ-1`、`UJ-2`、`Flows 2–3`。

**层级。** Complete/Incomplete 状态 → session identity 与本地/回执来源 → Actual 摘要 → 有序动作/Actual Set 账页 → 未解决或已纠正事实 → 训练部位 → 可选 Apple Health 写入 → 非阻塞 AI review 邀请。

**主操作。** 不完整时为 `解决 1 个不完整项目`；完整时不保留常驻主 CTA。编辑、Apple Health 写入和 `请 AI 复盘` 保持为明确分离的操作。

**组件 / Token。** `actual-set-row`、`durable-state-label`、`recognition-state-chip`、`sync-state-indicator`、`proactive-review-invitation`；`actualText`、`confirmedText`、`pendingText`、`destructive`、`phoneMetric`。

| 状态 | 契约 |
|---|---|
| 完整 | 展示全部 effective Actual Sets 和来源；Finish 后不消失任何内容。 |
| 不完整 / 局部 | 在摘要前显示精确 missing/pending 字段；可用事实继续可见。 |
| 加载 / 离线缓存 | 渲染缓存的完整事实和字面 freshness/receipt 状态。 |
| 已纠正 | 字段行显示 effective 值和纠正标记；展开后显示旧值和来源。 |
| 冲突 | 保留两个 revision，并阻止依赖的 Analysis/AI proposal，直到明确解决。 |
| 编辑失败 | 保留用户输入，焦点到错误摘要，提供重试且不改写同组其他字段。 |
| 破坏性 | 删除/拆分/合并动作指明准确 set 范围；必要时确认，并保持视觉隔离。 |
| Apple Health 不可用/失败 | 本地 session 保持权威；写入状态可选且可重试。 |
| 主动复盘 | 一次非模态邀请，含复盘/稍后/停用；仅显示不会发送数据。 |
| 无障碍 | 标题可导航各动作组；每行朗读顺序、Actual 值、Plan 差异、完整性与来源。 |

**归属 / 交接。** Watch 提交事实幂等到达。iPhone 拥有完整纠正、拆分/合并/插入/删除、冲突解决、完整复核、Apple Health 写入和可选 AI review 入口。

**SwiftUI 约束。** 使用稳定、字段范围明确的编辑 route。原子应用 revision。行在本地写入成功前不得视觉提交。训练部位与摘要只从 effective Actual Sets 派生。

## 页面 IR-03 — Training History

**目的。** 浏览完整与不完整、计划与自由训练 session，同时保留纠正、传输和冲突事实。

**进入 / 退出。** 从 Today 或 Session Review 进入。原生返回后保留搜索/筛选和滚动位置。选择 session 后进入 IR-02 的准确 effective 或 unresolved 记录。

**可追溯性。** `FR-036–046`、`FR-061–068`；`UJ-1`、`UJ-2`、`Flows 2–4`。

**层级。** 时段/搜索/筛选 → 时间顺序账页 → 字面 session 完整性 → 计划/自由来源 → 动作数和 effective volume → 传输/纠正/冲突状态。

**主操作。** 有内容时无主操作；选择 session 是导航。空状态使用 `记录第一次训练`。

**组件 / Token。** `history-ledger-row`、`durable-state-label`、`sync-state-indicator`；`textPrimary`、`textSecondary`、`actualText`、`confirmedText`、`pendingText`。

| 状态 | 契约 |
|---|---|
| 就绪 | 最新 effective session 在前；按自然时段分组但不隐藏准确日期。 |
| 加载 | 保留缓存行；行内进度不替换历史。 |
| 空 | 解释记录的训练会出现在此，并转到计划或自由训练。 |
| 离线缓存 | 指明上次刷新时间，保留本地可用复核。 |
| 不完整 | 琥珀色结构标记 + 准确未解决数量；session 仍可选择。 |
| 已纠正 | 标记“已纠正”，但不视为错误；Session Review 公开审计历史。 |
| 回传 pending/失败 | 保持 Watch session identity 独立；重试不能复制。 |
| 冲突 | 显示“需要比较”；依赖 Analysis 保持 stale/pending。 |
| Tombstone/删除 pending | 不复活旧副本；只在可恢复/重试时显示删除状态。 |
| 无障碍 | 行朗读日期、session 名称、完整/不完整、计划/自由、动作/组数与异常状态。 |

**归属 / 交接。** iPhone 拥有浏览/筛选与 durable effective history 呈现。尚未收到的活动/已完成 session 可能仍由 Watch 拥有；History 必须字面呈现该边界。

**SwiftUI 约束。** 使用带稳定 session/revision ID 的 `List`、原生 searchable/filter 和缓存 snapshot。设备时间不能决定纠正冲突。行摘要只使用 effective Actual Sets。

## 共享异常状态契约

| 边界 | iPhone review 行为 |
|---|---|
| 当前计划 vs pending revision | 始终保留 effective revision；pending/失败 proposal 或送达单独显示。 |
| Watch 本地保存 vs iPhone 回执 | 绝不合并成“已同步”；分别显示每条边界。 |
| Plan vs Actual | Plan 用陶土色参照；Actual 用灰紫/墨色事实；变化值同时显示两者。 |
| Complete vs incomplete | 完整性是字面记录状态，不是颜色或分数。 |
| Correction vs conflict | 已解决纠正有效且可审计；未解决冲突阻止依赖汇总。 |
| AI 不可用 | 当前计划、History、Session Review 与本地训练仍可用。 |

## 视觉自我审查

第一版方案有变成熟悉暖米白 SaaS 卡片布局的风险。修订稿移除等尺寸圆角卡片与仪表盘 Tile：Today 只保留一个主导的下一训练对象，Session Review 使用连续 Plan/Actual 证据表，History 使用时间顺序账页。左侧脊线具有真实功能——在动作、组与时间排序中改变含义——因此值得承担视觉大胆性。Claude 同款颜色只表达语义，不作装饰。

## 核心流程接受 Gate

Product Owner 已于 2026-09-12 接受 IR-01 至 IR-03 作为 iPhone review 流程，包括 effective plan 优先、Watch 送达事实、完整 Actual Set 可见性、范围明确的纠正、不完整/冲突处理与时间顺序 History。iPhone review 批次现已冻结，ND-03 核心流程接受 Gate 已关闭；下一批为 iPhone planning and analysis。
