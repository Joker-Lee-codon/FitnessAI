# FitnessAI Watch 核心页面批次

## 文档状态

- 阶段：`ND-03 Screens`
- 批次：`Watch core`
- 状态：已由 Product Owner 于 2026-09-12 接受并冻结
- 方向：`Training Ledger`
- 冻结 Token：`0.2.0-nd02-accepted`
- 权威输入：`prd.md`、`EXPERIENCE.md`、`native-ui-spec.md`

## 批次主张

Watch 是一份可持久化的训练底稿，而不是缩小的仪表盘。每个页面只回答一个即时问题：下一步怎样做，才能既不丢失也不误述训练事实？左侧 `training-rail` 是唯一醒目的视觉装置，承载顺序和持久化提交状态；其余几何保持克制。

训练进行中默认采用 OLED 深色。用户静止时的复核、纠错与恢复页面可以采用米白浅色。外观切换不改变权威边界或状态含义。

## 流程图

```text
已批准计划 ──开始──> 训练进行中 ──完成组──> 本地持久化提交
    │                    │                       │
    └─开始自由训练       ├─编辑实际组             ├─成功 → 下一组
                         ├─手动结束               └─失败 → 保留输入并重试
                         └─restSafeForInteraction → 休息期消歧

中断 ──恢复──> Watch 恢复 ──继续──> 训练进行中
                           └─结束为不完整 / 明确确认丢弃

训练进行中 ──结束──> 结束复核 ──结束训练──> 本地保存结果
```

## 共享布局规则

- 内容左对齐；当前 Actual 核心数值可居中，以提高扫读速度。
- 顶部行只放上下文与一个明确的退出或结束动作，不做装饰性标题栏。
- 底部安全区域只放一个主操作；次级操作使用文字按钮或独立行。
- 动作名称、Actual 数值、单位、未解决数量与后果不得截断。
- 活动中页面不显示识别、RPE 或结束提醒；它们只能在 `restSafeForInteraction` 出现。
- 主动发起一次识别/RPE/纠错问题会消耗共享的五次提示预算；“稍后”保留待处理事实。

## 页面 WC-01 — 已批准计划 / 训练入口

**目的。** 开始最后一个完整送达且兼容的 Plan Revision，或创建身份独立的自由训练。

**进入 / 退出。** 完整接收修订后从 Watch App 根页面进入。`开始计划训练` 创建 session identity 和不可变 Start snapshot，随后进入 WC-02。`开始自由训练` 创建独立 session，不伪装为存在计划。

**可追溯性。** `FR-001`、`FR-028`、`FR-029`、`FR-043`；`UJ-1`、`Flow 2`。

**层级。** 修订与送达状态 → 训练名称 → 有序动作概览 → 计划组数/次数/重量/RPE → 主开始按钮 → 次级自由训练入口。

**组件 / Token。** Plan 状态的 `training-rail`；`durable-state-label`；`session-control`；`canvas`、`planText`、`textPrimary`、`confirmedText`、`watchExercise`、`watchMeta`、`watchAction`。

**状态。**

| 状态 | 契约 |
|---|---|
| 默认 | 开始前显示修订名称、digest 短标签、动作数与完整计划事实。 |
| 加载 | 检查回执时保留上一个完整送达的计划；绝不展示局部新修订。 |
| 空 | “这只 Watch 上没有已送达计划。”提供 `开始自由训练`；计划创建留在 iPhone。 |
| 离线 / 送达失败 | 指明最后可用修订并允许开始；不暴露新的 pending 内容。 |
| 冲突 | Watch 不合并计划。显示“请在 iPhone 解决计划送达”；最后完整修订仍可用。 |
| 无障碍 | 刻度朗读“4 个动作，尚未开始”。每个动作朗读顺序、组数、次数、重量和目标 RPE。 |
| 外观 | 深浅模式保持顺序和状态文案；Increase Contrast 增加形状/描边。 |

**SwiftUI 约束。** 使用类型化导航；Start 幂等；只有本地 Start 提交持久化后才创建 snapshot identity。加载层不得遮住最后可用计划。

## 页面 WC-02 — 训练进行中

**目的。** 以最低交互完成当前 Actual Set，同时保持 Plan 与 Actual 分离。

**进入 / 退出。** 从 WC-01 开始、WC-06 继续或上一组成功提交后进入。完成组必须先在本地持久化再前进。编辑进入 WC-03；结束进入 WC-05。

**可追溯性。** `FR-002–004`、`FR-007–011`、`FR-016–020`、`FR-029`、`FR-043`；`UJ-1`、`Flow 2`；`NFR-REC-002`、`NFR-RES-002`。

**层级。** 经过时间 + 结束 → 当前动作 → `training-rail` → Actual Load → 计划次数/RPE 参照 → 识别/手动状态 → 完成组。

**组件 / Token。** `training-rail`、`actual-set-primary-action`、`durable-state-label`、`recognition-state-chip`；`actualMark`、`planText`、`confirmedText`、`pendingText`、`watchMetric`。

**状态。**

| 状态 | 契约 |
|---|---|
| 默认 | 当前组刻度为空心；“完成组”是唯一主操作。 |
| 自动捕获待定 | 保留手动操作；活动中不连续播报。 |
| 不支持 / 放弃识别 | 显示“手动记录”；不把它样式化为识别失败或成功。 |
| 保存中 | 禁止重复语义提交但允许幂等 replay；显示“正在保存在这只 Watch…” |
| 保存成功 | 只有持久化提交后才填实刻度；播报一次后前进。 |
| 保存失败 | 保留动作、次数、重量、RPE、时间与顺序；重试不复制旧组。 |
| 离线 | 视觉不降级；本地记录仍为主。iPhone 回执是独立状态。 |
| 无障碍 | 合并刻度值：“5 组中已保存 3 组，当前第 4 组。”完成、编辑和结束均不依赖 Crown。 |

**SwiftUI 约束。** 合并模型更新；普通识别变化不抢 VoiceOver 焦点。保存完成必须由 durable-store acknowledgement 驱动，而不是按钮点击完成驱动。

## 页面 WC-03 — 编辑 Actual Set

**目的。** 纠正当前组的一个字段，不改变计划值或同组其他事实。

**进入 / 退出。** 从 WC-02 进入。保存成功并持久化后返回 WC-02。取消恢复最后一个持久化的 Actual 值。

**可追溯性。** `FR-013`、`FR-016–019`、`FR-026`、`FR-061–063`；`UJ-1`、`Flow 2`。

**层级。** 组身份 → 字段名称 → Plan 参照/来源 → Actual 值 → 控件 → 明确保存。

**组件 / Token。** `metric-stepper`、`durable-state-label`；`actualMark`、`planText`、`watchMetric`、`watchUnit`、`watchAction`。

**状态。**

| 状态 | 契约 |
|---|---|
| 重量 | 可见的 −/+ 触控区、Digital Crown 加速与 adjustable action；用户值拥有权威。 |
| 次数 | 整数 stepper，不要求隐藏手势。 |
| RPE | 仅启用后出现；区分 target、predicted、confirmed、corrected 与 effective Actual RPE。 |
| 动作纠正 | 仅在安全停顿打开；改动作标签保留次数、重量、RPE、时间和顺序。 |
| 局部 / 保存失败 | 保留编辑输入和具体字段，显示重试；其他持久字段继续有效。 |
| 无障碍 | 朗读“实际重量 77.5 千克，计划 80”；增减动作与可见控件等价。 |

**SwiftUI 约束。** 每个字段写入可审计修订。不要把全部组字段塞进一张密集表单。单位转换不属于此页面；使用领域层提供的规范存储单位。

## 页面 WC-04 — 休息期消歧

**目的。** 只在交互安全时解决一个不确定事实，并先说明已经保留的事实。

**进入 / 退出。** 仅在 `restSafeForInteraction` 自动进入，或从 pending 状态进入。确认/纠正提交解决结果后返回 WC-02；稍后保留 pending 事实并返回，不制造成功状态。

**可追溯性。** `FR-010–015`、`FR-020–026`；`UJ-1`、`Flow 2`；`SM-INT-001`、`NFR-RPE-002–013`、`NFR-REC-002`。

**层级。** 休息安全上下文 + 提示计数 → 已保留事实 → 一个不确定字段 → 确认 → 纠正 / 手动 / 稍后。

**组件 / Token。** `rest-resolution-banner`、`recognition-state-chip`、`rpe-verification-prompt`；`surface`、`pendingText`、`confirmedText`、`actualMark`。

**状态。**

| 状态 | 契约 |
|---|---|
| 动作不确定 | “5 次和 80 kg 已保留。”然后询问动作标签是否正确。 |
| 次数不确定 | 保留动作/重量/时间，询问 Actual 次数。 |
| RPE 验证 | 仅在 RPE 已启用且当前组 eligible 时显示预测来源和 1–10 整数值。 |
| 稍后 | 保留一个可见 pending 字段；不计为确认或完整。 |
| 提示预算用尽 | 转为手动/pending 解决，不再主动打断。 |
| 不安全 / 活动中 | 完全抑制本页面；保留 pending 事实。 |
| 无障碍 | VoiceOver 先读已保留事实，再读不确定项和选项；一次提示只产生一次播报。 |

**SwiftUI 约束。** 休息安全和提示预算由领域策略输入，不由 View 猜测。使用原生 sheet/push 呈现，并保留稳定退出路径。

## 页面 WC-05 — 结束复核与本地保存

**目的。** 让用户在精确看到持久化事实和未解决事实后手动结束，并把本地完成与 iPhone 回传分开报告。

**进入 / 退出。** 从 WC-02 的结束或符合双信号条件的提醒进入。继续返回 WC-02。结束执行持久化 session commit，然后显示 Complete 或 Incomplete 结果。iPhone 收到后接管完整 Session Review，但在此之前 Watch 保持本地权威状态。

**可追溯性。** `FR-003–007`、`FR-033`、`FR-041`、`FR-062`；`UJ-1`、`Flows 2, 4`；`NFR-SESSION-001–005`。

**层级。** 手动/提醒原因 → 已保存动作/组总数 → 未解决字段数及明细 → 结束后果 → 主结束 / 继续 → 本地保存结果 → iPhone 回传状态。

**组件 / Token。** `session-control`、`durable-state-label`、`forgotten-finish-prompt`；`confirmedText`、`pendingText`、`destructive`、`watchAction`。

**状态。**

| 状态 | 契约 |
|---|---|
| 完整 | “已保存 18 组，0 个未解决。”主操作：`结束训练`。 |
| 不完整 | 逐项指出 missing/pending 字段；主操作明确写 `结束为不完整`，不丢弃事实。 |
| 提醒可用 | 询问“训练结束了吗？”并提供结束/继续；绝不自动结束。 |
| 提醒抑制 | 不显示任何东西；手动结束仍可用。 |
| 本地保存中 / 失败 | 提交成功前不说已结束；保留整个 session 并提供重试。 |
| 已保存、回传待定 | “已保存在这只 Watch · 等待发送到 iPhone。”本地使用已完成。 |
| 回传失败 / 已收到 | 失败提供幂等重试；收到显示“iPhone 已收到”，不改变本地事实。 |
| 无障碍 | 摘要先朗读完整/不完整，再读未解决数量、后果与操作。 |

**SwiftUI 约束。** Finish 幂等。双信号提醒与冷却由策略层输出。训练部位只在持久化完成后出现，并从 effective Actual Sets 推导。

## 页面 WC-06 — Watch 恢复

**目的。** 在中断后恢复最近的持久化活动 session 和一个可恢复 pending fragment。

**进入 / 退出。** App 终止、Watch 重启、可恢复电量/传感器中断或重新连接后发现活动 session 时进入。继续返回 WC-02；结束通过 WC-05 生成 Incomplete session；丢弃必须二次明确确认。

**可追溯性。** `FR-043`、`FR-046`、`FR-064–066`；`UJ-1`、`Flow 4`；`NFR-RECOV-001`、`NFR-COMPAT-002`。

**层级。** “已恢复训练” → 持久保存摘要 → pending fragment → 继续 → 结束为不完整 → 丢弃。

**组件 / Token。** `recovery-action-group`、`durable-state-label`、`actual-set-row`；`confirmedText`、`pendingText`、`destructive`。

**状态。**

| 状态 | 契约 |
|---|---|
| 仅持久 session | 指明最后保存的动作/组和经过时间；继续为主操作。 |
| Pending fragment | 用已知事实和未解决边界显示一个 fragment；绝不复制或丢弃。 |
| 并发 session | 保持各自身份。Watch 不合并；不安全的解决转到 iPhone。 |
| 加载 | 显示“正在恢复训练…”，可用时保留持久摘要。 |
| 恢复失败 | 解释仍然持久化的内容并提供重试；不用空状态替换本地记录。 |
| 丢弃 | 二次确认指明已保存与尚未回传的事实；破坏性样式与继续隔离。 |
| 无障碍 | 初始焦点落在恢复摘要；操作朗读准确后果。 |

**SwiftUI 约束。** 恢复基于事件身份并保持幂等；设备时间不能解决冲突修订。Pending fragment 拥有独立于 committed sets 的稳定身份。

## 共享异常状态契约

| 状态 | Watch core 行为 |
|---|---|
| 权限不可用 | 自动能力可降级为仅手动；开始、完成组、编辑和结束仍可用。 |
| 不支持的动作/设备/信号 | 指明不支持范围并提供手动记录；绝不暗示自动覆盖。 |
| iPhone 断开 | 不打断活动记录；只有本地提交后才改变回传状态。 |
| Session 中途送达新计划 | 当前 Start snapshot 保持固定；新修订只影响未来。 |
| 需要完整比较的冲突 | 保留事实并把解决转到 iPhone；Watch 显示字面 pending/conflict 标签。 |
| Reduce Motion / Differentiate Without Color | 立即改变状态；形状、文字、填充和符号保持冗余表达。 |

## 视觉自我审查

Claude 米白/陶土组合如果被当作生活方式外壳会显得模板化。本批次把米白限制在静止复核与恢复，把陶土色限制为 Plan 来源；真正的产品识别来自训练特有的顺序刻度，而不是配色。圆角容器只用于控件和明确的内容边界；训练事实直接落在画布上，不切成重复卡片。装饰性统计、渐变、传感器波形、Activity Ring 与“AI 正在监听”动效均被移除。

## 核心流程接受 Gate

Product Owner 已于 2026-09-12 接受 WC-01 至 WC-06 这一连续 Watch 流程，包括 Plan/Actual 分离、持久化保存反馈、休息安全打断、手动结束、不完整结束与恢复后果。Watch core 批次现已冻结；只有其余已配置 MVP 批次也被接受，ND-03 才能整体完成。
