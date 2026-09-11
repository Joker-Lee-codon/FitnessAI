# FitnessAI 实施合同

## 1. 权威与读取顺序

先读取 `SPEC.zh-CN.md`，再读取其 `companions:` 数组中的全部文件。措辞冲突时，以 2026-09-10 Architecture Spine 及其记录的 Product Owner override 为准；其他情况按 PRD → EXPERIENCE → DESIGN/Titanium Measure → native UI specification → architecture handoff 排序。代码、测试、fixture 与审核证据必须保留稳定的 `CAP-*`、`FR-*`、`NFR-*`、`SM-*` 与 `AD-*` 标识。

## 2. 交付切片

| Slice | 可演示结果 | 退出条件 |
|---|---|---|
| S0 — Contracts 与仓库种子 | 一个 Xcode workspace、iPhone/Watch targets、本地 package 边界、平台中立 schemas、IDs、units、errors、规范 serialization/digest profile 与 golden vectors | 两个 App 均可编译；跨 target golden fixtures 一致；依赖测试证明 AD-1 |
| S1 — 持久手动 iPhone 闭环 | 计划/自由纯手机 Start → Actual Sets → 纠错 → Finish/Incomplete → History | 故障测试证明仅 commit 后显示本地成功、恢复无丢失/重复，且可选依赖不阻塞记录 |
| S2 — 配对 Watch 手动闭环 | 完整兼容 Plan 传递 → 不可变 Start snapshot → 持久 Watch sets → 幂等 iPhone 回流 | 断连/重启/replay/chunk 故障测试使每项事实恰好一次；部分 Plan 永不激活 |
| S3 — AI Plan 生命周期 | 文字输入 → 一次性授权 → 结构化 draft/diff → Safety 结果 → 完整审核 → digest 批准 → 原子 revision | Invalid/stale/changed proposal 无法提交；重试返回原结果；每种失败下最后 Plan 仍可用 |
| S4 — 纠错、History 与 Analysis | 字段和拓扑纠错使 revision-bound read models 失效并重算 | 冲突保持可见；current/stale/pending 状态真实；公式匹配 PRD 定义 |
| S5 — Health 与 Plan exchange adapters | 位于 ports 后的可选 HealthKit context/copy 与有界 JSON draft exchange | 每种 adapter 失败下本地事实继续；远程 Health 被 Gate 禁用；import 永不修改现有 Plan |
| S6 — 证据门控辅助 | 合格 recognition、RPE 验证与忘记 Finish 行为 | 每项功能通过自身预注册真机 Gate，并可独立关闭且不阻塞手动记录 |
| S7 — Alpha 闭环 | 完整原生页面、无障碍、migration/fault 证据、体积报告与重复 owner 训练 | `SM-COMP-001`–`SM-INT-001`、`SM-AI-001/002`、`SM-E2E-001` 与 `SM-ALPHA-CORE-001` 通过并报告 counter-metrics |

每个切片均为纵向且可交付到 Product Owner 测试环境。不得为延后能力建立可发现占位页面。

## 3. Domain 与 Persistence 合同

- 定义独立 domain、application-use-case、persistence-port、synchronization-contract、safety-rule、analysis 与 adapter targets。UI models、database rows、wire payloads、AI payloads 与 HealthKit models 在 ports 映射。
- 使用唯一规范 revision DAG 与 effective-value reducer。Revision 携带 revision/event ID、object ID、规范 field path 或 operation kind、parent/head set、author device、resolution references 与适用版本。
- 不同字段修改可以 merge。不可比较的同字段写入，以及重叠 split/merge、insert/delete、reorder、completion 或 Plan-topology 操作产生 conflict 并保持可见。Resolution 引用全部已解决 head。缺失 parent 保持 pending。
- 关键 transaction 同时写入 fact、revision、outbox 与范围明确的 invalidation。稳定 idempotency key 在 replay 时返回原结果。
- iPhone 与 Watch 使用独立 GRDB stores。Raw streams 是由所属 store 索引的受保护文件。未确认事实永不自动删除；可选 raw 或 automation data 先于用户事实降级。
- 纯手机与配对场次使用相同合同。场次保持来源 global ID 与不可变 Plan snapshot；sessions 永不按时间合并。

## 4. Watch Runtime 与传输合同

- Watch 持续记录使用配合 workout processing 的 `HKWorkoutSession`，不得以 `WKExtendedRuntimeSession` 代替。Runtime start、pause、failure、recovery 与 end 映射到持久 session states。
- 重要待发送内容先持久化到 outbox。Live message 只用于加速；queued user-info 用于持久结构事件；application context 用于可替换最新状态；file 用于 chunks。
- Replay identity 为 `(pairingEpoch, sourceDeviceId, messageId)`。Revoked-epoch 输入进入隔离区等待明确恢复。
- Transfer manifest 携带 chunk IDs/counts/sizes/digests、whole-object digest、causality 与 dependency/support versions。Acknowledgement 为 `received`、`durablyCommitted`、`applied` 或 `rejected(reason)`。
- Watch 只在完整兼容 revision 与 dependencies 一起提交后激活 Plan。Active automation eligibility set 在 Start 时冻结，紧急 fail-closed disable 除外。

## 5. AI、Authorization 与 Safety 合同

- 把 provider output 视为不可信 typed input。Proposal 包含不可变 `proposalId`、base revision、provenance、permitted scope、assumptions、schema/model/rule-pack versions、canonical digest，以及全部结构化 Plan 字段或字段级变化。
- 生成后及提交前再次运行 deterministic balanced Safety Rule Pack。结果为 pass、需要澄清/纠正，或 affected-scope stop；未解决结果阻止 Plan commit，但永不阻止真实训练记录。
- Approval UI 暴露全部 added、removed 与 changed fields、值与单位、assumptions、warnings、scope、Safety result、base revision 与 digest。Commit 校验未消费 proposal、显示 digest 完全一致、Plan head 未变且 policy versions 未变；`proposalId` 是 commit key。
- Built-in 与 BYOK DeepSeek routes 使用独立 adapters 与 isolation identities。Route/account 切换创建新 pseudonymous identity，绝不复用 conversation history。
- 远程 send 原子匹配并消费一次性 authorization。Audit 只记录 IDs、versions、categories、digest、status 与 timing——绝不记录 content、secrets 或 chain-of-thought。

## 6. 证据门控辅助合同

| Function | 冻结 Alpha 行为 | 发布证据 |
|---|---|---|
| Recognition | AD-6 device/orientation/handedness/eight-candidate row；classification、set boundary 与 reps 独立合格；不确定性等待安全休息；始终有手动 fallback | PRD §3.2 与 NFR-REC 冻结 holdout、slices、denominators、confidence intervals、silent misses、false sets 与真机 support matrix |
| RPE | Opt-in；整数 1–10；前五个合格估算确认/纠正；≥4 个误差在 ±1 内可以提供 auto-use；≥2 个错误时重新校准并重启；滚动五次 auto-used 中两次纠正触发 drift | Participant-held-out 与 chronological data、baseline improvement、risk–coverage、missing-signal、subgroup、prompt/correction burden、resource 与 frozen holdout 证据 |
| Forgotten Finish | 恢复与无力量活动均持续 15 分钟；缺失信号时抑制；只有 Finish/Continue；Continue cooldown 15 分钟 | 冻结 personalization 与 false/missed thresholds，并针对长休息、器械等待、低动作幅度和真机测试 |
| Shared prompting | Exercise、rep、load 与 RPE 主动 prompt 共享一个 session counter；约 20 组代表性预算为五次 | Prompt source/count/correction counter-metrics 与 completeness/accuracy 一起报告 |

## 7. Apple Health 合同

- 精确实现 AD-9 的版本化 allowlist 与 exclusions；authorization 按 capability 划分且可选。只暴露可观察 read states。
- FitnessAI session ID 加本地原子分配的单调递增 export generation 标识有意 create/update 的副本。版本化 transition table 管理 create、update、delete、detach、relink 与 self-authored retry。
- 外部缺失或变化成为 `healthKitDetached`；永不自动重建。HealthKit 失败不能修改或阻塞 FitnessAI records 或 Analysis。
- 远程 AI 只在独立 AD-8 preview/authorization 后接收所选本地计算摘要。GATE-3 关闭前，send path 在技术上保持禁用。

## 8. Plan Exchange 合同

- 恰好导出一个纯文本、未压缩 UTF-8 `.json` Plan，包含 FitnessAI marker、format/catalog/source versions、source identity、完整 ledger、原始 load value/unit 与 digest。排除 sessions、health、account、secrets、authorizations 与 sensors。
- 拒绝超过 2 MB、嵌套超过 12、超过一个 Plan、366 days、30 Exercises/day、20 Sets/Exercise、10,000 Sets total 或 2,000 characters/note 的输入。
- 完整预览前校验 syntax、schema、version、digest、duplicate identity/fingerprint、mapping 与 Safety Rules。Unknown required fields 失败；known aliases 确定性映射；optional unknown fields 惰性 round-trip 或要求逐项 omission confirmation。
- 确认使用新本地 IDs 创建未生效 draft。Activation 仍使用普通 proposal review 与 approval lifecycle。

## 9. Presentation 合同

- iPhone 顶层为 Plan、History、Analysis 与 More；其他 destination 均为 typed contextual routes。Native back 恢复 object identity、filters、scroll position 与 unsent/non-effective input。
- 使用 Titanium Measure semantic tokens、每个状态一个有后果 primary action，以及 fact → source/authority → durability → consequence/action 展示顺序。本地 save 永不暗示 delivery 或 synchronization。
- 实现 `AI-L01`–`AI-L05`、`PW-L01`–`PW-L02`、`HX-L01`、`AN-L01`、`HK-L01`、`PX-L01` 与 `RV-L01`，以及双语 UX 合同中的 Watch surfaces。
- 失败时保留输入；焦点先到 error summary，再到 recovery action。提供 non-color、non-motion、non-haptic 与 non-Crown 等价方式；charts 具有相邻 text 与 table alternative；高频或有后果 controls 至少 44 × 44 pt。

## 10. Definition of Done

一项 capability 只有在其 domain contract、persistence behavior、state transitions、error/recovery path、UI/accessibility states、automated tests 与必需真机证据全部通过后才算完成。可选 adapter 失败时必须保留最后持久事实与手动记录。延后 Gate 只阻塞其具名高风险路径，绝不阻塞本地手动核心。
