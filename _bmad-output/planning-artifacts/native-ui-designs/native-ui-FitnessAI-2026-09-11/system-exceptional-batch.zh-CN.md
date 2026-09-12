# FitnessAI 系统与异常状态页面批次

## 文档状态

- 阶段：`ND-03 Screens`
- 批次：`System`
- 状态：已由 Product Owner 于 2026-09-12 接受并冻结
- 方向：`Training Ledger`
- 冻结 Token：`0.2.0-nd02-accepted`
- 页面：`SY-01 Sync & Recovery`、`SY-02 Account & Privacy`、`SY-03 Remote AI Authorization`、`SY-04 Apple Health`、`SY-05 Plan Exchange`、`SY-06 Settings & Capabilities`

## 批次主张

系统状态是一份边界账页，而不是设置卡片合集。每行回答 durable fact 在哪里、谁拥有它、失败影响什么、用户下一步能做什么。记录脊线映射本地提交、Watch 送达、iPhone 回执、remote AI authorization 和可选 Apple Health 副本，绝不合并成“已同步”。

米白是文档表面，墨色是 durable fact，陶土是 Plan 边界，灰紫是用户/Actual 操作，苔绿是确认本地状态，琥珀是 pending/incomplete，红色只用于破坏或失败后果。符号不能替代字面状态。

## 导航与共享规则

```text
Today / 上下文失败
  ├─ Sync & Recovery
  ├─ Account & Privacy ── Remote AI Authorization
  ├─ Apple Health
  ├─ Plan Exchange
  └─ Settings & Capabilities
```

- 系统页面是 More/Settings 下的上下文 route；阻塞错误可深链到准确边界。
- 原生返回恢复来源 plan、session、proposal、筛选、滚动位置与未发送/非生效输入。
- 失败摘要先获得焦点，再到恢复操作；普通 pending/success 变化不抢焦点。
- 破坏性操作绝不只靠 swipe，也不使用创建/批准样式。

## SY-01 — Sync & Recovery

**目的。** 检查并恢复每条持久化或送达边界，同时不撤销本地 durable truth。

**可追溯性。** `FR-003`、`FR-043–047`、`FR-064–070`、`FR-080–085`；`Flows 2, 4`；`NFR-RECOV-001`、`NFR-COMPAT-002`。

**层级。** iPhone 本地 store → Watch plan delivery → Watch workout save → iPhone receipt → restoration → 冲突/删除 → 精确 Retry。

| 状态 | 契约 |
|---|---|
| 当前/pending | 指明 object/revision 与最后确认边界；排队时保留 durable source。 |
| 失败/离线 | 指明失败 edge 与仍可用内容；Retry 幂等。 |
| 局部恢复 | 指明已恢复/未恢复数据类；本地捕获仍可用。 |
| 冲突/多只 Watch | 保留每个 identity/revision；不安全比较转到 iPhone；设备时间不能决定。 |
| 删除 pending/失败 | Tombstone 防止 replay 复活；适用时显示 Retry 或恢复窗口。 |
| 无障碍 | 行朗读 object、source、destination、state、consequence 与 action。 |

**SwiftUI 约束。** 稳定 event/object/revision ID、类型化 deep link、可见离线队列、幂等 Retry，且无合成“同步健康分数”。

## SY-02 — Account & Privacy

**目的。** 解释本地/account 边界、登录连续性、隐私操作和 remote-AI authorization，不暗示本地权限授权远端使用。

**可追溯性。** `FR-042–048`、`FR-067–070`、`FR-082`、`FR-086`；`Flows 3–4`；`NFR-PRIV-001–007`、`NFR-SEC-001–003`。

| 状态 | 契约 |
|---|---|
| 已登录/未登录 | 指明 account 与本地可用事实；绝不静默合并 account。 |
| 恢复 pending/失败 | 报告数据类/进度；已开始本地捕获仍可用。 |
| Authorization none/active/expired/withdrawn | 显示 purpose、provider、categories/window、policy version、expiry 与 one-time consumption。 |
| Sign-out | 提供保留加密本地数据或移除；先指明未同步记录。 |
| Export/delete | 显示 accepted/in progress/complete/failed；高影响操作重新认证。 |
| 无障碍 | 行朗读 data class、scope、destination、state 与 consequence。 |

## SY-03 — Remote AI Authorization

**目的。** 在远端发送任何合格内容前，取得一次 affirmative、default-off、request-bound authorization。

**可追溯性。** `FR-054–060`、`FR-078–087`；`UJ-4`、`Flow 3`；`NFR-PRIV-007`、`NFR-SAFE-001`。

**层级。** Purpose/provider/route → retention/training policy/region → default-off category → record window → digest/policy/expiry → `授权并发送一次`。

| 状态 | 契约 |
|---|---|
| Required/selected | 操作前不发送；显示准确 category/window 与 outbound digest。 |
| Scope changed | 使旧 preview/authorization 失效并要求重新复核。 |
| Compliance gate closed | Fail closed；本地 plan/workout 保持可用。 |
| Withdrawn/expired/consumed | 防止复用；旧 plan/history 不变。 |
| 网络/AI 失败 | 保留 input 与 audit；Retry 不能扩 scope。 |
| 无障碍 | 控件朗读 category、off/on、purpose、window 和一次性后果。 |

**SwiftUI 约束。** Consent request-bound 且 digest-bound。滚动、焦点、HealthKit permission 或 general App consent 不能选择数据。

## SY-04 — Apple Health

**目的。** 管理可观察的最小权限 read/write capability，同时保持 FitnessAI 本地记录权威。

**可追溯性。** `FR-088–090`；`Flow 6`；`NFR-HK-001–002`、`NFR-UX-001`。

| 状态 | 契约 |
|---|---|
| 未请求 | 解释收益与请求操作；绝不宣称被拒绝。 |
| 无可访问数据/可用/不可用 | 只使用可观察语言。 |
| 写入 pending/written/failed | 按 session 报告；只有 HealthKit 确认后才成功。 |
| `healthKitDetached` | 不静默重建丢失的外部副本；提供明确写入。 |
| 离线/系统不可用 | FitnessAI History 与 Analysis 仍可用。 |
| 无障碍 | Capability 行朗读 scope、observed state、consequence 和 action。 |

## SY-05 — Plan Exchange

**目的。** 只导出一个 FitnessAI Plan，或在创建新 draft 前检查不可信 FitnessAI Plan 文件。

**可追溯性。** `FR-071–073`；`Flow 5`；`NFR-PORT-001`。

| 状态 | 契约 |
|---|---|
| Export ready/failed/cancelled | 只包含 selected Plan；失败不改变任何内容。 |
| Import loading/valid | Validation/mapping 完成前把文件视为不可信。 |
| Unresolved/unsupported/newer | Map、明确 omit 或 cancel；绝不编造完成。 |
| Duplicate | 指明 existing import identity；不静默替换/修订。 |
| Commit failed | 不创建 draft；保留 preview/mapping 用于 Retry。 |
| 无障碍 | Mapping 行朗读 source、target、state、omission consequence 与 error。 |

**SwiftUI 约束。** 原生 file picker 与 Share Sheet；import 原子创建新 draft；export payload 不可变且只包含一个 Plan。

## SY-06 — Settings & Capabilities

**目的。** 管理识别、RPE、结束提醒、主动复盘、Apple Health、无障碍与设备支持，不暴露 deferred feature。

**可追溯性。** `FR-008–027`、`FR-049–053`、`FR-088–091`；`UJ-1`、`Flows 2–6`。

| 状态 | 契约 |
|---|---|
| 启用/停用 | 字面标签 + 原生 control；停用不重写 History。 |
| 不支持/不可用 | 指明 device/Exercise/signal 边界并保留手动记录。 |
| RPE verification/drift | 显示 five-estimate window 与 consent；prediction 不替换 confirmed RPE。 |
| Finish reminder | 解释双信号规则、不自动结束、cooldown 与 disabled state。 |
| Proactive review | Review/Later/Disable；仅显示不发送任何内容。 |
| Deferred | 不给 voice、Alpha cloud restore 或 unrestricted coaching 添加可发现 placeholder。 |

## 剩余 IA 闭环

| 页面 | 冻结布局/状态契约 |
|---|---|
| AI Plan Chat | 只用文字；missing answer/assumption 可见；Send 不批准；失败后保留 input。 |
| Proposal Review | 线性完整 plan/diff，含 mapping、assumption、unresolved field、future scope、`proposalId`、base 与 digest。 |
| Approval, Commit & Delivery | 完整复核后独立批准；commit 与 Watch delivery 状态保持分离。 |
| Phone-only Active Workout | 复用 Watch durable identity 与 Plan/Actual 语义，使用原生 iPhone control；不模拟 sensor automation。 |
| Revision Proposal Review | 精确 future field-level diff；历史 Actual Sets 和 active/completed session 不属于 mutation。 |

## 异常状态图谱

| 状态 | 内容 | 恢复 |
|---|---|---|
| Loading | 保留 durable/cached content；行内指明 object。 | 安全时取消。 |
| Empty | 解释将出现什么和第一个有效动作。 | 创建/开始/导入。 |
| Offline | 指明本地可用性和延迟 edge。 | 幂等自动/手动 Retry。 |
| Pending | 琥珀结构 + 字面状态；绝不表示成功。 | 等待/取消/解决。 |
| Failure | 具体摘要、保留事实/input、受影响 edge。 | 焦点先摘要，再精确 Retry。 |
| Incomplete | 准确 missing/pending 数量与后果。 | 解决或明确结束为不完整。 |
| Conflict | 保留 revision 与受影响 derivative。 | iPhone 明确比较/选择。 |
| Permission unavailable | 只显示可观察状态。 | 手动/本地 fallback。 |
| Destructive | 准确 object/scope 与同步后果。 | 明确确认；可选限时恢复。 |

## 视觉自我审查

系统页很容易变成相同圆角行和彩色图标。本批移除图标网格，改用边界账页：每个菱形是真实 durable/authorization edge，每行说明 ownership，每个恢复操作指明目标。Privacy 不用盾牌插图，Sync 不使用云健康分，Apple Health 不能借用 FitnessAI 记录权威。

## ND-03 最终接受 Gate

Product Owner 已于 2026-09-12 接受 SY-01 至 SY-06、剩余 IA 闭环与异常状态图谱。第四个 MVP 批次与 ND-03 均已完成；ND-04 native quality gate 与 Architecture handoff 已就绪。
