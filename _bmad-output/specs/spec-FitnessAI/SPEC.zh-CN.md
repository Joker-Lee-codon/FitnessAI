---
id: SPEC-FitnessAI
companions:
  - implementation-contract.zh-CN.md
  - verification-matrix.zh-CN.md
  - open-gates.zh-CN.md
  - ../../planning-artifacts/prds/prd-FitnessAI-2026-07-19/prd.zh-CN.md
  - ../../planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.zh-CN.md
  - ../../planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/DESIGN.zh-CN.md
  - ../../planning-artifacts/architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.zh-CN.md
  - ../../planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.zh-CN.md
  - ../../planning-artifacts/native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.zh-CN.md
  - ../../../design-system/fitnessai/MASTER.zh-CN.md
sources: []
---

> **规范契约。** 本 SPEC 与 `companions:` 中的文件共同构成需要构建、测试与核验内容的完整、经过信息保全验证的契约。Frontmatter 中列出的 source 仅用于追溯；只有在需要本契约有意省略的叙事理由或文字背景时才查阅。

# FitnessAI 私有 Alpha 实施 SPEC

## Why

FitnessAI 要为中国大陆力量训练者实现一个原生 iPhone 与 Apple Watch 产品：把受限 AI 对话转化为可执行 Plan，同时以尽量少的打断保留完整、真实的训练记录。可信记录是基础；由用户掌权、可审核的 AI Plan 编排是差异点。本契约把已确认的 Product、UX 与 Architecture 决定转化为可直接实现、可独立核验的合同。

## Capabilities

- **CAP-1 — AI Plan 生命周期**
  - **intent:** 训练者可以通过文字 AI 创建或修改完整结构化 Training Plan，审核每个字段或 Diff，并且只有在 digest 绑定的明确批准后激活恰好一个不可变 Plan Revision。
  - **success:** 每次有效批准只产生一个完整已提交 revision；不存在静默、过期、重复或部分激活。
- **CAP-2 — 配对 Watch 训练**
  - **intent:** 训练者可以在 Apple Watch 上执行已传递 Plan 快照或自由训练，事实在本地保存且离线可用。
  - **success:** Complete 或明确标记 Incomplete 的场次经历断连、终止、重启、恢复与 replay 后，每项已提交事实都恰好存在一次。
- **CAP-3 — 纯手机训练**
  - **intent:** 没有 Watch 的训练者可以在 iPhone 上使用与配对记录相同的身份、状态、纠错和 Analysis 完成计划或自由训练。
  - **success:** 纯手机记录具备相同事实与恢复语义，不模拟 Watch 自动能力，也不建立第二套领域模型。
- **CAP-4 — 证据门控识别**
  - **intent:** 合格 Watch 配置可以通过置信度、abstention、快速纠正与手动 fallback 辅助 Exercise 分类、组边界和次数计数。
  - **success:** 每项功能独立通过冻结的 PRD 证据 Gate；不支持或不确定路径永不声称自动成功。
- **CAP-5 — 可选 RPE 辅助**
  - **intent:** 用户可以验证、纠正，并在之后明确开启高置信度 RPE auto-use，同时保留 provenance 与漂移恢复。
  - **success:** Predicted、confirmed、corrected、auto-used 与 effective 值保持分离；只有 confirmed 或 corrected 标签参与校准。
- **CAP-6 — 保守 Finish 辅助**
  - **intent:** Watch 只有在合格双信号窗口后才可提供忘记 Finish 提示，同时手动 Finish 保持权威。
  - **success:** 信号缺失时抑制提示，Continue 应用 cooldown，任何推断状态都不会自动结束场次。
- **CAP-7 — 纠错、恢复与同步**
  - **intent:** 用户可以纠正、split、merge、insert、delete、恢复、传输并解决冲突训练事实，不发生静默覆盖或重复。
  - **success:** 仅追加因果修订保留每项用户事实，直至确定性安全结果或 iPhone 明确解决选出生效 revision。
- **CAP-8 — History 与 Analysis**
  - **intent:** 用户可以检查完整 History，以及仅从生效 Actual Sets 派生的周、月和所选 Exercise Analysis。
  - **success:** 输出要么当前有效，要么明确标为 stale、pending、partial、conflicted 或 excluded；计划内容与语义不可比训练绝不产生虚假汇总。
- **CAP-9 — Apple Health 互操作**
  - **intent:** 用户可以授予最小权限 HealthKit 能力、保持 FitnessAI 本地权威，并独立预览所选本地摘要以进行一次性远程授权。
  - **success:** 读取、写入、重试与 detached 状态可观察；fail-closed Gate 通过前，真实远程 Health 摘要流量为零。
- **CAP-10 — 有界 Plan 交换**
  - **intent:** 用户可以导出一个 FitnessAI JSON Plan，并且只能在完整预览后把它导入为独立草稿。
  - **success:** 不发生隐藏数据、parser 滥用、静默遗漏、merge、overwrite、部分导入或 activation。
- **CAP-11 — 主动训练后审核**
  - **intent:** 完成场次可以提供一次 Review、Later 或 Disable 邀请，并进入现有授权和提案流程。
  - **success:** 显示或关闭邀请不会发送数据，也不会创建 authorization、proposal、approval 或 mutation。
- **CAP-12 — 原生可用体验**
  - **intent:** 每个 Alpha 页面实现已接受的原生导航、Titanium Measure 语义、恢复状态与无障碍契约。
  - **success:** 所有必需 light/dark、Dynamic Type、VoiceOver、error、empty、loading、offline 与 recovery 状态可用，不存在占位页面。
- **CAP-13 — Exercise 目录与支持事实**
  - **intent:** 用户可以检查规范 Exercise 映射、身体部位与运动属性、支持边界，以及自有或合规授权的简明教学内容。
  - **success:** Supported、limited 与 manual-only 状态明确；不发布未授权媒体或单腕全身判断。
- **CAP-14 — 训练中 Plan 指导与对账**
  - **intent:** 训练期间与训练后，用户可以接受、编辑或拒绝下一组负重建议及规范 substitute Exercises，同时 planned 与 Actual 事实保持分离。
  - **success:** 没有所需用户动作时，任何建议都不会改变 Actual Set 或未来 Plan；拒绝指导保留已完成事实，获接受的未来修改进入普通完整 Diff 批准生命周期。

## Constraints

- 构建一个本地优先六边形模块化单体，使用独立 iPhone/Watch targets 与本地 Swift Package；domain targets 不依赖 UI、数据库、设备、Health、传感器或 AI provider framework。
- 使用 Xcode 26.6、Swift 6.3.3、配合轻量 MVVM 与显式状态机的原生 SwiftUI，以及通过精确锁定 GRDB 7.11.1 使用的系统 SQLite。
- 稳定 ID 在持久化前存在。每次用户或已批准 AI 修改是与持久 outbox 和 invalidations 原子提交的仅追加 revision；UI 成功晚于提交，设备时间永不决定事实。
- iPhone 拥有 Plans、长期记录、完整冲突解决、Analysis、AI、Health 与 exchange。被选记录设备拥有 live session；其 Plan snapshot 在 Start 后不可变。
- 重要 iPhone–Watch 内容使用有确认的因果传输。只有兼容 whole-object `applied` 才允许激活或清理；重试幂等。
- 手动本地记录必须在 AI、HealthKit、Watch 传递、网络或可选自动能力失败时继续可用。不支持或不确定路径 fail closed 到 manual 或 pending 状态。
- Alpha Watch 自动能力只能从 AD-6 的 Series 11 46 mm、方向、惯用手与八个 Exercise 证据行开始；扩展需要独立真机证据。
- Exercise、rep、load 与 RPE 确认在一次约 20 组代表性场次中共享最多五次主动提示，并且只在安全休息期出现。
- 忘记 Finish 要求恢复与无力量活动同时持续 15 分钟，信号缺失时抑制，永不自动结束，并在 Continue 后冷却 15 分钟。
- 内置 Alpha AI 是经过 Gate 的 FitnessAI gateway 后方 DeepSeek。BYOK 只支持 DeepSeek，使用仅本机、不参与同步的 Keychain secret 并直连；排除任意 provider URL。
- 每次远程请求消费一次 authorization，绑定 route、provider、account、purpose、categories/window、outbound digest、policy version 与 expiry。HealthKit permission 与 proposal approval 均不能替代。
- FitnessAI 对 HealthKit 保持权威。远程 Health 输入限于用户所选本地摘要；服务商/法律/隐私/区域/保留/训练用途/删除/撤回/用户权利 Gate 通过前，真实传输保持禁用。
- Plan exchange 遵守 AD-10 全部 JSON 体积、深度、数量、备注、映射、metadata 与 draft-only 限制；禁止 executable content、external references、attachments、partial import、merge、overwrite 与 activation。
- Stores、sidecars、outbox 与 chunks 使用 `completeUntilFirstUserAuthentication` 并排除 iCloud 和普通备份；secrets 使用仅本机且不参与同步的 Keychain；不可读 store 永不替换为空库。
- Titanium Measure semantic tokens 与原生平台行为是展示权威。iPhone 顶层为 Plan、History、Analysis 与 More，Plan 为 root；Watch 保持浅层、任务专用。
- 发布证据覆盖 compile、domain、schema、safety、persistence、synchronization、AI contract、secrets、migration、fault injection、accessibility、paired-device 与必需真机测试；私有 Alpha telemetry 默认关闭，除非明确 opt in。
- 体积 Gate 为：iPhone thinned installed variant ≤500 MB；Watch uncompressed <75 MB 且 installed target ≤25 MB；全部 Watch ML assets ≤6 MB；RPE assets ≤2 MB。

## Non-goals

- 私有 Alpha 中的 public-beta 应用云账号、恢复与中国区同步基础设施。
- 诊断、伤病严重度判断、康复处方、无限制 coaching，或根据单腕判断全身动作。
- 自动外部负重感知、自动 Start/Finish，或任何 AI 对活动场次或历史 Actual Sets 的修改。
- 语音、持续监听、任意/自托管 AI endpoints、任意第三方 Plan 格式、服务端 link/QR 分享、Android，或为延后功能提供可发现占位页面。
- 把原始传感器或不受限制的 HealthKit 数据传给远程 AI；排除临床、用药、化验、生育、原始 ECG、血糖、血压与疾病专属 HealthKit 类别。
- 公开发布品牌精修、广泛设备自动能力主张，或只依据模拟器证据得出发布结论。

## Success signal

Product Owner 可以重复完成“对话 → 完整审核 → 明确批准 → 原子 iPhone Plan Revision → 配对 Watch 或纯手机执行 → 持久 Actual Sets → 纠错/History/Analysis → 可选证据受限修订”，无需逐项重建、不丢失事实、不接受静默变更，也无需退回其他主要记录工具。每项可选能力失败时，最后持久事实与手动本地记录仍可用。

## Assumptions

- `project-context.md` 不存在；本 SPEC 假设其中没有额外绑定决定，因为仓库 `AGENTS.md` 与全部指定 planning artifacts 均可用且已完整读取。

## Open Questions

- 第一条 AI Plan Story 前，Product Owner 将冻结哪些 Alpha Plan Safety Rule Pack v1 数值边界与 golden fixtures？
- 内置流量开始前，将批准哪些当前 DeepSeek 法律主体、runtime provider、processing region、subprocessors、retention/cache、training use、deletion/revocation、disclosure、endpoint、ceilings、rollback owner 与 kill-switch 记录？
- 哪份 Apple health/fitness purpose、processor/contract、privacy、cross-border、retention、deletion、revocation 与 user-rights 书面审核将关闭真实 Health 摘要流量 Gate？
- 查看自动能力 holdout 前，将预注册哪些冻结 dataset、denominator、slice、confidence threshold、RPE baseline/burden Gate 与 false/missed reminder threshold？
- Plan import 验收前，将用哪些 parser time 和 memory budget 补充已冻结的 AD-10 结构限制？
