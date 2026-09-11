---
name: FitnessAI
status: draft
sources:
  - "{planning_artifacts}/briefs/brief-FitnessAI-2026-07-19/brief.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/addendum.md"
  - "{planning_artifacts}/research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.md"
  - "{planning_artifacts}/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.md"
  - "{planning_artifacts}/research/technical-rpe-estimation-from-heart-rate-for-strength-training-research-2026-07-19.md"
updated: 2026-09-10
---

# FitnessAI — 体验主干

## 基础

“第一版”指 Product Owner 可供个人使用的核心产品私有 Alpha，而不是狭窄的技术 walking skeleton，也不是 public beta。它必须通过 AI 计划、自动记录、可信纠正、完整 Analysis、Apple Health 互操作、第一方计划交换、训练后主动审核，以及统一、可测试的视觉/布局系统支持重复真实训练。

Alpha 是运行在 iPhone 以及可用时配对 Apple Watch 上的原生 SwiftUI 产品。iPhone 提供一等的纯手机 Workout Session 路径，并负责对话、授权、提案审核、批准、完整纠正、History/Analysis、Apple Health 与计划文件控制；当 Watch 被选为记录设备时，它负责活动中的 Workout Session、受支持的自动识别/RPE 辅助与本地持久 Actual Sets。两条记录路径使用相同的身份、持久状态、纠错语义与 Analysis。场次执行 Start 时的已批准 Plan Revision 快照；后续 revision 永不改变活动中或历史场次。

`DESIGN.md` 负责可测试的私有 Alpha 视觉系统；本文负责 IA、行为、状态、交互、无障碍与旅程。已批准 Watch v11 仅在与当前双语主干一致时可指导 Watch 布局。其他历史 mockup 在决策写入双语主干前仍只是讨论辅助。始终以主干为准。

## 信息架构

### iPhone 私有 Alpha 页面

| 页面 | 职责 | 对应旅程 |
|---|---|---|
| Plan Home | 当前生效 revision、Watch 传递状态、创建/修订入口、回流场次 | UJ-4、Flow 2–4 |
| AI Plan Chat | 收集目标、经验、可训练日程、单次时长、器械、偏好与必填身体限制；保持缺失答案/假设可见；文字修改草案 | UJ-4、Flow 3 |
| Remote AI Authorization | 披露目的、provider/subprocessor、保留、模型训练政策、所选类别与记录时间窗；授予、检查、撤回 | UJ-4、Flow 3–4 |
| Proposal Review | 完整新计划或完整字段级 Diff；映射、假设、未解决字段、未来影响范围、`proposalId`、base revision、digest | UJ-4、Flow 3–4 |
| Approval, Commit & Delivery | 将批准绑定到所显示提案，原子提交，显示 Watch `pending/delivered/failed` | UJ-4、Flow 4 |
| Session Return & Review | 显示全部 Actual Sets；编辑 reps/load；split、merge、insert、delete；解决 pending 字段 | Flow 2–3 |
| Phone-only Active Workout | 在 iPhone 上使用共享场次状态模型开始计划或自由训练、手动完成/编辑 Actual Sets、结束并恢复 | Flow 7 |
| Revision Proposal Review | 用户明确点击“请求 AI 审核”后，收集反馈/获准记录，显示一份完整 Diff，批准或拒绝 | Flow 3 |
| Training History | 浏览 Complete/Incomplete 场次与可审计纠正 | UJ-1、UJ-2 |
| Analysis | 完整周/月场次、Exercises、volume、intensity、Actual Load、duration 与所选 Primary Exercise 趋势 | UJ-2 |
| Exercise Catalog & Support | canonical Exercise mapping、supported/limited/manual-only 状态、简明第一方教学 | UJ-1、Flow 2 |
| Apple Health | 管理上下文读取/写入能力，检查 no-data/pending/written/failed/`healthKitDetached`，并为所选本地摘要进入独立、默认关闭的逐请求预览 | Flow 6 |
| Plan Exchange | 导出/导入一个 FitnessAI 自有计划文件、完整预览、新草案创建、原生 Share Sheet | Flow 5 |
| Settings | 自动识别、RPE、结束提醒、主动审核、Apple Health 与无障碍控制 | UJ-1、Flow 3–6 |

Plan Home 是 Alpha 根页面。其他页面是上下文路由，而非最终 tab bar 决策。原生返回保留未发送聊天与未生效草案。批准永不出现在聊天消息内部。

### Apple Watch 私有 Alpha 页面

| 页面 | 职责 | 对应旅程 |
|---|---|---|
| Approved Plan | 最后完整 delivered 的兼容 revision；计划 Exercises、sets、reps、loads、可选 target RPE；手动 Start | Flow 2 |
| Active Workout | 固定 Start 快照；受支持自动识别或低交互 Complete Set；计划事实与 Actual 事实保持分离 | Flow 2 |
| Edit Actual Set | 必要的 reps 与 Actual Load 编辑；用户输入是权威值 | Flow 2 |
| Rest Resolution | 在 `restSafeForInteraction` 下处理识别/RPE 不确定性、Later 与手动 fallback | UJ-1、Flow 2 |
| Watch Recovery | 中断后恢复最后持久场次，Resume、Finish as incomplete 或明确确认 discard | UJ-1 |
| Finish & Local Save | 手动 Finish；持久提交；complete/incomplete Actual Sets；独立 iPhone 传输状态 | Flow 2、4 |

Watch 永不展示部分 revision。离线或传递失败时，最后 delivered 的兼容 revision 仍可用。计划传递与 Actual Set 回流最终一致且幂等；两者均不阻塞本地记录。

### 明确延后；不设计首版页面

完整云账号/跨设备恢复、丰富教学媒体、语音、任意第三方计划格式、服务端链接/二维码分享、每周/周期末主动 AI 节奏与开放式 coaching 不是 Alpha 页面。公开发布视觉精修与广泛设备优化发生在完整、可测试的 Alpha 视觉/布局合同之后。Architecture 可保留领域边界，但实现不得增加可发现的占位页面或暗示功能可用。

## 语言与语气

中文优先、直白、非诊断，并明确说明什么发生变化、什么继续生效，以及可执行动作。

| 应该 | 不应该 |
|---|---|
| “本次批准仅适用于提案 P-104 和 revision 7。” | 不说明身份/范围的“批准 AI 修改” |
| “提案已变化。请审核并批准新版本。” | 编辑/再生成后复用批准 |
| “Revision 7 仍生效。提交失败。” | 声称部分成功或乐观成功 |
| “Watch 传递失败。Revision 7 在 Watch 上仍可用。” | pending 时声称 delivered |
| “已停止对该部位的建议。” | 诊断或判断伤病严重程度 |
| “选择并授权前，不会发送任何内容。” | 预选敏感类别 |

## 组件模式

| 模式 | 行为合同 |
|---|---|
| `ai-conversation` | 仅文字；只提出必要澄清。聊天、编辑、再生成永不批准或提交。对话与结构化未生效草案保持区分。 |
| `remote-ai-authorization` | 所有类别默认关闭：当前对话、档案/偏好、身体限制、已确认/纠正的 FitnessAI 记录，以及符合条件的本地 Apple Health 摘要类别。记录与 Health 摘要使用均需明确时间窗。每次请求绑定 route/provider/account、purpose、categories/window、outbound digest、policy version、expiry 与一次性消费状态。HealthKit 权限永不替代远程授权；扩大范围必须重新预览。服务商/合规 Gate 获批前，真实 Health 摘要传输保持禁用。 |
| `plan-diff-review` | 新计划显示全部结构化字段；修订显示每个新增/删除/修改、before/after 值与受影响未来场次。始终显示 mappings、assumptions、base revision、`proposalId`、digest 与阻塞校验结果。 |
| `proposal-approval-gate` | 完整审核后的审慎动作，绑定 `proposalId + base revision + digest`。任何内容、映射、规则结果或 base 变化都会使批准失效并要求完整复审。重复批准/重试幂等。 |
| `safety-stop` | 新的/加重伤病或恢复状态停止受影响范围，直至用户排除该范围或暂停并寻求专业指导。警示征兆停止生成并在不诊断的前提下引导线下就医。不确定/拒答不能授权严重程度推断。 |
| `session-control` | 手动 Start/Finish 是权威动作；一个主要场次动作；Start 快照保持固定。 |
| `actual-set-row` | 将 Exercise、顺序、reps、Actual Load、时间、完整性、provenance 保持在一起。计划值与 Actual 值分离；iPhone 纠正限定字段且可审计。 |
| `load-stepper` | 第一组从计划预填；后续组继承上一 Actual Load。用户编辑是权威值；来源/单位可见；不得声称感知负重。 |
| `sync-state-indicator` | 分离本地计划提交、Watch 传递、Watch 训练保存与 iPhone 接收。每个边界显示 pending/success/failed 与幂等 Retry；远程状态不得撤销本地保存。 |
| `recognition-state-chip` | 命名 accepted、uncertain、corrected、unresolved、manual-only 或 unsupported Exercise/set/rep 结果。低置信度时 abstain 或在安全休息期询问；纠正保留其他字段，初始错误仍计为识别失败。 |
| `rpe-verification-prompt` | 仅 opt-in。为五次估算窗口显示 prediction provenance 与整数 1–10 确认/纠正；低置信度 abstain；验证后 auto-use 需要明确同意且仍可纠正。 |
| `forgotten-finish-prompt` | 仅在持续生理恢复和持续无力量活动均满足冻结 operating point 后出现。只提供 Finish 或 Continue，永不 auto-finish，并尊重 cooldown/disable。 |
| `analysis-summary` | 所有指标源自生效 Actual Sets，标记被排除的 incomplete/conflicted 事实，提供周期与 Primary Exercise 选择，永不以计划值替代。 |
| `healthkit-capability-row` | 每项读取/写入能力一行。只使用可观察状态；HealthKit 确认后写入才成功；外部副本缺失变为 `healthKitDetached`，不得静默重建。 |
| `plan-exchange-review` | 将 FitnessAI 文件视为不可信；创建新草案前显示 source/version/完整 plan/mappings/omissions。导出只通过原生 Share Sheet 分享所选计划。 |
| `proactive-review-invitation` | 每个完成场次一次：Review、Later 或 Disable。仅展示不发送数据、不创建提案；Review 进入既有授权与 Diff/批准流程。 |

## 状态模式

### 提案、批准与授权

| 状态 | 表现 |
|---|---|
| Authorization required | 不发送远程请求；打开默认关闭的范围审核。 |
| Generating | 当前计划仍可用；取消后返回且不产生变更。 |
| Valid proposal | 打开完整审核；批准仅对该提案有效。 |
| Invalid/unmapped/contradictory/safety-blocked | 显示阻塞原因；澄清、纠正、再生成或拒绝。绝不虚构补全。 |
| Approved, commit pending | 不得称计划已生效；状态恢复幂等。 |
| Commit failed | 旧 revision 完整生效；Retry 或丢弃未生效提案。 |
| Committed | 显示不可变 revision，再开始 Watch 传递。 |
| Approval invalidated | 点明原因，清除批准，重算 identity/digest，要求再次完整审核。 |
| Base revision stale | 绝不静默 rebase；显示新 base，要求再生成/新审核。 |
| Not authorized / withdrawn | 当前计划/本地训练仍可用；撤回停止未来远程使用且不改变既有记录。 |
| Scope changed / disclosure incomplete | 阻止扩大范围的请求；在真实披露与肯定授权前不发送内容。 |

### 传递、训练、回流与降级

| 状态 | 表现 |
|---|---|
| Watch plan pending | Watch 保留最后 delivered revision；自动/手动重试不产生重复。 |
| Watch plan delivered | 两端 revision/digest 一致；Watch 仅能为未来 Start 提供它。 |
| Watch plan failed/offline | 点明失败与最后可用 revision；Retry；永不展示部分内容。 |
| Actual Set saved locally | 已在 Watch 持久化；手机是否接收是独立状态。 |
| Local save failed | 保留输入；不声称 saved；此前持久组继续有效。 |
| Session incomplete | Finish 后仍显示缺失/pending 字段。 |
| Return pending/failed/received | 幂等接收前 Watch 保持权威；重复传输不生成副本。 |
| AI unavailable/timeout/invalid/mapping failure | 当前计划、Watch 训练和本地记录仍可用。保留聊天输入；仅当 identity/校验状态可信时保留草案。 |
| Recognition accepted/uncertain/corrected/unsupported | 保留 provenance；只在安全休息期询问；unsupported/abstained 进入 manual fallback。 |
| RPE verifying/abstained/auto-used/drift | opt-in 且状态分离；drift 恢复确认；用户纠正始终优先。 |
| Finish reminder eligible/dismissed/disabled | 只提供 Finish/Continue；Continue 应用 cooldown；永不自动结束。 |
| Analysis ready/pending/stale | 只从 effective Actual Sets 派生；依赖冲突时标记 pending/stale 而非显示错误汇总。 |
| Health not requested/no accessible data/pending/written/failed/detached | 本地功能继续；写入失败可重试；detached 不自动重建。 |
| Plan file unresolved/invalid/imported/export failed | 保存前预览；映射未解决保持明确；invalid/cancel/failed commit 不改变任何计划；成功导入只创建新草案。 |
| Proactive review available/later/disabled | 一次非阻塞邀请；Later 不保留隐藏批准；Disabled 在重新开启前停止后续邀请。 |

## 交互原语

- iPhone 使用原生文字输入、滚动审核、披露行、toggle、明确时间窗选择与明确按钮。Send 永远不是批准。
- 完整审核为线性顺序。唯一 Approve 位于全部内容之后，并重复提案 identity、base revision、digest 短形式与后果。Reject 与 Continue Conversation 保持独立。
- 编辑可审核内容会生成新的提案 identity/digest，并清除旧批准。
- Watch 以 tap 为主。Digital Crown 可加速 reps/load 编辑，但不是唯一路径；accessibility-adjustable action 与之等价。
- 自动识别、RPE 与结束提醒只在 `restSafeForInteraction` 出现；superset、circuit、drop set、活动动作与极短休息会推迟 prompt，且不丢失 pending 事实。
- 代表性 20 组场次中，主动识别/RPE/纠正 prompt 合计最多五次。结束提醒和训练后 iPhone 邀请可独立关闭，且不与活动组控件竞争。
- Apple Health 授权按能力划分。导入使用系统文件选择器；导出仅在展示所选计划范围后调用原生 Share Sheet。
- Watch 高频控件至少 44 × 44 pt。使计划生效/破坏性动作使用明确标签，绝不只靠 swipe。
- 状态不抢焦点。本地保存失败、安全停止、批准过期或其他阻断动作的完整性失败可以中断。
- **禁止：**聊天消息批准、预选数据类别、复用批准、静默 rebase、部分激活、本地提交前显示“saved”、自动 Start/Finish、隐藏 Retry，以及 AI 修改 Actual Sets。

## 无障碍基线

- iPhone 支持 VoiceOver、Dynamic Type、Reduce Motion、增强对比度与 Full Keyboard Access；Watch 支持 VoiceOver 与原生 adjustable controls。
- 提案 heading 可导航。Diff 行读出字段路径、before/after 值、change type 与未来场次影响范围。
- 授权控件读出类别、状态、目的与记录时间窗；获得焦点/滚动/通用 App consent 永不选择类别。
- 批准读出提案 identity、base revision、校验结果，以及仅在本地提交后生效。
- Pending、delivered、failed、stale、withdrawn、incomplete 与 safety-blocked 使用文字/accessibility value，绝不只靠颜色。
- 失败时焦点落在错误摘要，再到恢复动作；Retry 保留输入。批准失效时先聚焦原因，再进入更新后的审核。
- Watch 完成组与 reps/load 编辑在 VoiceOver、出汗/精细操作降低且不使用 Crown 时仍可用。触觉反馈有可见/朗读等价物。
- 识别/RPE 更新合并播报，正式训练组期间不反复打断。在安全休息期，VoiceOver 先读已保留事实，再读不确定性与选择。
- Analysis 图表提供等价摘要、数值、周期与趋势，无需依赖视觉图表理解。
- Apple Health 与计划文件状态暴露范围、provenance、成功/失败与 Retry，不依赖系统图标或颜色。
- 最大支持中文字号不得截断后果、数值或动作标签。

## 信任、隐私与安全不变量

- 远程 AI 只接收肯定授权的类别/时间窗。符合条件的 Apple Health 输入仅限版本化允许清单中由用户选择的本地摘要，并受逐请求一次性授权约束；仅有 HealthKit 权限不会发送任何内容。原始传感器流、导入计划内容、云恢复副本及被排除的临床/医疗类别仍不属于 Alpha 远程 AI。服务商/法律/隐私/区域/保留/训练用途/删除/撤回/用户权利 Gate 获批前，所有真实 Health 摘要传输均 fail closed。
- 授权/提案显示 data-source summary，而非 chain-of-thought；FitnessAI 不存储或展示模型 chain-of-thought。
- 显示与提交的 digest 一致。生效 revision 保留 `proposalId`、digest、approval event、base revision、schema/model version、Safety Rule Pack version 与 data-source summary。
- Alpha Plan Safety Rule Pack 检查单位、缺失/矛盾日程、canonical Exercise 支持、有界 volume/intensity/load progression；每项返回 pass 或 blocking reason。
- 已确认/纠正 Actual Sets 是证据，而非 AI 修改目标。提案只通过新 revision 影响命名的未来场次。
- 未知优于虚构；旧活动 revision 优于部分/未经批准的替代。

## 离线、同步与恢复

| 边界 | 权威与恢复 |
|---|---|
| iPhone Plan commit | 原子/幂等本地 store；失败时旧 revision 生效。 |
| Plan delivery | 校验 Watch 完整接收；重试/重连不得重复/回滚；完整兼容 revision 到达后才切换。 |
| Active Workout | Watch Start 快照在断连或新提交时保持固定。 |
| Actual Set save | 仅 Watch durable commit 后显示“Saved”；恢复最后场次和一个可见 pending fragment，不丢弃/复制。 |
| Actual Set return | 幂等传输；重复/乱序事件只产生一个有效 set/revision，永不回滚后续纠正。 |
| Apple Health | FitnessAI 本地记录保持权威；读取/写入失败或外部删除不能回滚或静默重建任一副本。 |
| Plan file exchange | 导入原子提交新草案；导出/分享失败不改变计划，也不保留更广数据 payload。 |

## 响应式与平台

私有 Alpha 面向 iPhone 11+/iOS 18+ 与 Apple Watch Series 6+/watchOS 11+，仍需真机检查。iPhone 审核使用原生滚动/reflow；不要求 iPad 或横屏专用布局。Watch 每页只承担一个主要任务，并将完整提案/隐私审核交给 iPhone。

## 关键旅程

### UJ-1 — Wei 安静地完成一场自动辅助力量训练

1. Wei 在 Watch 打开 delivered 计划并手动 Start；场次绑定该 revision 快照。
2. 在冻结白名单内，Watch 尝试识别 Exercise、set boundary 与 reps，同时在正式训练组期间保持安静。每个结果保留 confidence/provenance。
3. 在 `restSafeForInteraction` 下，不确定结果可确认、纠正或选择 Later。unsupported/abstained 情况使用手动 Complete Set；纠正 Exercise 保留 reps、load、RPE、timing 与 order。
4. 若启用 RPE，预测进入五次估算确认窗口。低置信度时 abstain；验证后 auto-use 需要明确同意且仍可纠正。
5. 若两个冻结的结束信号均满足，Watch 可询问 Finish 或 Continue；永不自动结束，手动 Finish 始终可用。
6. 每个 accepted/corrected Actual Set 在显示 saved 前先于 Watch 持久提交。Finish 将 Complete 或 Incomplete 场次回流 iPhone。
7. **高潮：**Wei 无需反复切换手机即可结束训练，并看到自动化、纠正与手动 fallback 均可区分的完整真实记录。

失败：识别/RPE/提醒失败降级到手动记录，不丢数据、不虚报成功；全部主动 prompt 遵守共享场次负担预算。

### UJ-2 — Wei 审核完整 Analysis 并决定是否调整

1. Wei 打开 Training History，查看 Complete/Incomplete 场次与可审计纠正。
2. 他选择一周或一月。Analysis 只从 effective Actual Sets 派生场次数、完成 Exercises、volume、intensity、Actual Load 与 duration。
3. 他选择 Primary Exercise 查看趋势；被排除的 incomplete/conflicted 输入与 RPE provenance 保持可见。
4. 每个图表结论都有 VoiceOver 可访问的等价文字摘要。
5. Wei 接受一次非阻塞训练后审核邀请，或主动打开审核；只有此时获准证据才可进入 AI 提案流程。
6. **高潮：**Wei 能解释训练中发生的变化，并在不混淆计划与实际完成内容的前提下决定未来计划是否调整。

失败：stale/conflicted 输入使依赖 Analysis 标为 pending，而非显示虚假汇总；Apple Health 失败不会移除本地派生 Analysis。

### UJ-4 — Lin 创建并批准一个可执行的首个计划

1. Lin 开始文字聊天，并提供目标、经验、日程、单次时长、器械、偏好与身体限制；缺失项/假设保持可见。
2. 远程使用前所有类别关闭。Lin 审核目的/provider/保留/训练政策，选择类别及记录时间窗，再肯定授权。
3. 伤病/恢复披露停止受影响范围，直至排除或寻求专业指导；警示征兆停止生成并在不诊断下引导线下就医。
4. AI 返回完整结构化草案；校验 schema、mapping、单位、日程与 Safety Rule Pack。
5. Lin 继续聊天修改；旧 proposal/approval 失效。
6. 完整审核显示周期、频率、有序场次、Exercises、sets、reps/ranges、建议 loads、可选 target RPE、mappings、assumptions、unresolved fields。
7. Lin 批准所显示的 `proposalId`、base revision 与 digest。
8. 一个不可变 revision 原子提交；仅成功后生效并开始 Watch 传递。
9. **高潮：**Watch 报告同一 delivered revision；Lin 无需重建即可打开可执行计划。

失败：AI/校验/映射/提交失败时旧计划仍生效。过期 base 要求新审核提案；禁止静默 rebase 或复用旧批准。

### Flow 2 — Lin 在 Watch 执行并回流真实 Actual Sets

1. Lin 打开完整 delivered 计划并点击 Start；场次绑定该快照。
2. 受支持识别可以自动完成一组；abstained、unsupported 或错误结果在安全休息期提供手动 Complete Set 或纠正。
3. 计划首组 load 与前一 Actual Load 默认值保持可见。实际不同时编辑 reps/load；Actual 与计划事实保持分离。
4. 仅 durable local commit 后组才 saved。Lin 手动 Finish；未解决字段生成 Incomplete 场次。
5. 传输显示 pending/received/failed 与幂等 Retry。
6. **高潮：**iPhone 显示每组，并支持完整字段纠正及 split/merge/insert/delete，且不改变计划快照。

失败：离线、中断、replay 或传输失败保留 Watch 记录且不生成副本；写入失败保留输入且不声称成功。

### Flow 3 — Lin 主动请求并决定一次有证据边界的修订

1. Lin 纠正回流场次、添加简短反馈，并明确选择“请求 AI 审核”。
2. Lin 检查授权，只选择已确认/纠正记录与时间窗。
3. AI 标明记录/假设、执行 safety stop，并针对当前 base 提案。
4. 完整 Diff 显示所有新增/删除/修改与受影响未来场次；历史 Actual Sets 与活动/已完成场次不在修改范围。
5. Reject 保持计划不变；Approve 使用同一 identity、原子提交与传递合同。
6. **高潮：**Lin 能理解并一次决定，无需逐项重建或接受静默变更。

### Flow 4 — Lin 从 AI 或 Watch 传递失败中恢复

1. AI 失败时最后确认计划仍可见，安全的聊天输入得以保留。
2. Lin 在 Watch 使用最后 delivered revision 并本地记录。
3. iPhone 将新 revision 显示为 pending/failed，Watch 保留旧 revision。
4. 重连后幂等重试；只有完整匹配 revision 才替换未来 Start 的计划。
5. **高潮：**远程失败不能损坏、复制、部分激活或隐藏计划/训练记录。

### Flow 5 — Jia 往返并分享一个 FitnessAI 计划

1. Jia 打开一个 Training Plan 并选择 Export。审核页面点明所选计划、schema/catalog/revision/provenance，以及被排除的训练、健康与 credential 数据。
2. FitnessAI 创建版本化文件；Jia 调用原生 iOS Share Sheet。取消或分享失败不改变计划。
3. 随后 Jia 打开一个 FitnessAI 计划文件。App 将其视为不可信输入，执行有界解析并显示完整 source/plan/mapping 预览。
4. Unknown Exercises、不兼容字段、重复与省略保持可见。Jia 映射、明确省略或取消；App 永不猜测。
5. 确认只创建一个新的未生效草案；永不覆盖现有计划，仍须经过正常提案批准流程才能激活。
6. **高潮：**Jia 可以发送并重新打开完整可移植计划，并能解释进入计划库的每一项内容。

### Flow 6 — Wei 连接 Apple Health，同时保持本地真实记录权威

1. Wei 在 Apple Health 设置中，仅开启所选训练/RPE/提醒/Analysis 能力需要的读取权限；UI 报告可观察可用性，而不声称知道不可观察的拒绝。
2. 数据不可用时 FitnessAI 仍可使用，并从 Actual Sets 派生完整本地 History/Analysis。
3. 持久 Finish 后，启用的写入创建 pending HealthKit 操作；written 或 failed/retry 与本地保存分离。
4. 若 Apple Health 副本随后被删除，FitnessAI 标记 `healthKitDetached`，不得静默重建。
5. **高潮：**Wei 在 Apple Health 看到完成训练，同时 FitnessAI 记录继续保持权威并可独立恢复。

### Flow 7 — Mei 完成一场纯手机训练

1. Mei 在 iPhone 打开计划训练或开始自由训练；App 分配与配对记录相同的稳定 session identity 和不可变 Plan snapshot。
2. 她使用相同的计划/历史/上一组负重默认值、provenance、pending 状态与本地持久提交规则，手动完成和编辑 Actual Sets。
3. 她可以纠正、split、merge、insert 或 delete 训练组而不改写无关事实；不支持的 Watch 自动能力保持不存在，而不是模拟成功。
4. 手动 Finish 保持权威。字段未解决时结果为可编辑 Incomplete Workout Session；App 终止后恢复最近持久状态。
5. **高潮：**没有 Watch 的用户也能完成同一套可信记录、纠错、History 与 Analysis 闭环，而无需进入第二套产品模型。

失败：可选 AI、Apple Health 或网络失败不阻塞本地记录；重试不得复制事实或回退后续纠正。

## 需求到旅程覆盖

| 需求 | 覆盖 |
|---|---|
| §6.1、UJ-1、UJ-2、UJ-4 | UJ-1/2/4、Flow 2–6：完整核心产品 Alpha 闭环 |
| FR-001–041、NFR-RPE/SESSION/REC/RECOV/COMPAT | UJ-1、UJ-2、Flow 2：自动记录/RPE/提醒、纠正、Analysis、恢复 |
| FR-054–060 | UJ-4、Flow 3：文字收集、结构化提案、安全停止、完整审核、不可变批准 |
| FR-061–066 | Flow 2：纠正、incomplete、审计 revision、恢复、幂等 |
| FR-071–073、NFR-PORT-001 | Flow 5：有界第一方文件导入/导出、预览、Share Sheet、只创建新草案 |
| FR-078–087；NFR-AI-001–006 | UJ-4、Flow 3–4：identity、校验、原子提交、传递、获准数据、失败行为 |
| FR-088–090、NFR-HK-001–002 | Flow 6：最小权限读取、幂等写入、本地权威、detached 状态 |
| FR-001–007、FR-016–019、FR-029、FR-036–041、FR-061–066 | Flow 7：使用共享事实、纠错、恢复与 Analysis 模型的一等纯手机记录 |
| FR-091 | UJ-2、Flow 3：一次训练后邀请、Later/Disable、接受前不发送数据 |
| NFR-SAFE-001 | UJ-4、Flow 3：非诊断停止与版本化审核边界 |
| NFR-PRIV-007 | UJ-4、Flow 3：默认关闭类别、时间窗、披露、检查、撤回 |
| NFR-UX-001 | 所有流程：统一可测试视觉/布局与完整无障碍/错误状态 |

## iPhone 布局与状态闭环

最终私有 Alpha iPhone 布局合同在 `DESIGN.md` 中标识为 `AI-L01`–`AI-L05`、`HX-L01`、`AN-L01`、`HK-L01`、`PX-L01` 与 `RV-L01`，综合渲染 review board 位于 `native-ui-designs/native-ui-FitnessAI-2026-08-08/previews/iphone-core-alpha-final-v1.html`。渲染示例使用代表性 fixture 数值；其信息层级、containment、state grammar、navigation relationship、primary-action location 与 responsive reflow 具有规范性。

| Flow boundary | 必需页面序列 | 状态闭环 |
|---|---|---|
| 创建计划 | Plan Home → AI Plan Chat → Remote AI Authorization → 完整 Proposal Review → 独立 Approval → 本地 Commit 结果 → Watch Delivery 结果 | authorization required/selected/withdrawn；generating/cancel/failure；valid/invalid/unmapped/safety-blocked/stale；approval ready/invalidated；commit pending/failed/succeeded；delivery pending/delivered/failed。 |
| 修改计划 | Plan Home 或 Session Review → 显式 review 请求 → evidence authorization → 完整 field-level diff → 独立 Approval → Commit/Delivery | 显示每个变化字段与受影响未来 session；Reject 保留 active revision；base/content 变化使 approval 失效；historical/active session 在 mutation scope 外。 |
| 检查历史与证据 | Training History → Session Review 和/或 Analysis → 必要时进入精确 unresolved record | ready、loading、empty、offline cache、incomplete、corrected、conflict、tombstone、stale/partial analysis、calculation failure 与 current analysis。 |
| 连接 Apple Health | More/Settings → Apple Health capability list → 请求时进入 system authorization → per-record write state | not requested、no accessible data、available、unavailable、write pending/written/failed 与 `healthKitDetached`；每种状态下 local record 都保持权威。 |
| 交换一个计划 | Plan detail → Export Review → 原生 Share Sheet；或 system file open/picker → Import Validation → 完整 preview/mapping → Create New Draft | export ready/failed/cancelled；import loading/valid/unresolved/duplicate/invalid/unsupported/commit failed；没有任何 path 会替换已有计划。 |
| 训练后邀请 | 完整 Session Review → 一次非模态 invitation → Review/Later/Disable；Review → evidence authorization → 现有 revision proposal flow | 显示/关闭不会发送数据；Later 不创建 hidden approval；Disable 停止未来邀请；AI failure 保留 session、feedback 与 effective plan。 |

原生 back 恢复来源 object、filter、scroll position 与 unsent/non-effective input。Loading 不得遮住可用 current plan 或 cached history。失败操作保留用户输入和先前 durable fact。Destructive deletion、导入时 explicit omission、authorization withdrawal 与 proposal rejection 都明确命名精确 scope，且不与 creation/approval 共用 primary action styling。

## 页面闭环与交接边界

§6.1 每项都有页面、状态、恢复路径与最终布局合同；每个 Alpha 页面都落在 UJ-1、UJ-2、UJ-4 或 Flow 2–7。Watch v11 在与双语主干一致时是已接受的起始视觉参考。iPhone 纯手机训练、AI、History/Analysis、Apple Health、Plan Exchange 与 proactive-review 布局已提升进双语 DESIGN/EXPERIENCE 合同。Alpha 已准备进入实施 SPEC 提炼，但仍受下述具名 Architecture 与真机 Gate 约束。

启动精简 `bmad-architecture` 没有 blocker。实现验收前，Product/Architecture 必须冻结识别白名单、RPE 与结束提醒 operating points、计划文件 parser limits、Apple Health capability mapping 与 Alpha Plan Safety Rule Pack v1。真实远程调用前，还必须确定 provider/subprocessor、保留、训练政策及 request-field 到 authorization-category 的精确映射。NFR-SAFE-001 专业审核在超出 Product Owner 测试的发布前必需，但不阻塞 owner-only Alpha architecture 起草。

## 延后决策

1. 公开发布品牌精修与广泛设备优化仍延后；私有 Alpha key-screen 视觉/布局合同已经完成。
2. Post-Alpha 对话形式/解释密度（DV-008/009）：文字 chat + 完整线性审核。
3. 每周/周期末主动节奏、更广 AI 数据/coaching 与性能 operating point（DV-003/006/012）：Alpha 仅有一次训练后邀请，接受前不发送数据。
4. 识别、RPE、结束提醒的广泛覆盖：Alpha 使用冻结白名单、实验标记、abstention、纠正与手动 fallback。
5. 云账号/跨设备恢复、丰富媒体、语音、任意第三方格式与服务端 link/QR sharing：不提供首版页面或 affordance。
