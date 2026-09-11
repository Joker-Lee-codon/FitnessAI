---
stepsCompleted:
  - step-01-validate-prerequisites
  - step-02-design-epics
  - step-03-create-stories
  - step-04-final-validation
inputDocuments:
  - ../specs/spec-FitnessAI/SPEC.md
  - ../specs/spec-FitnessAI/SPEC.zh-CN.md
  - ../specs/spec-FitnessAI/implementation-contract.md
  - ../specs/spec-FitnessAI/verification-matrix.md
  - ../specs/spec-FitnessAI/open-gates.md
  - prds/prd-FitnessAI-2026-07-19/prd.md
  - ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md
  - ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md
  - architecture/architecture-FitnessAI-2026-09-09/ARCHITECTURE-SPINE.md
  - native-ui-designs/native-ui-FitnessAI-2026-08-08/native-ui-spec.md
  - native-ui-designs/native-ui-FitnessAI-2026-08-08/architecture-handoff.md
  - ../../design-system/fitnessai/MASTER.md
scope: private-alpha
authority: SPEC-FitnessAI and 2026-09-10 Architecture Spine
---

# FitnessAI - Epic 拆分

## Overview

本文档提供 FitnessAI 的完整 Epic 与 Story 拆分。需求从经过信息保全验证的 SPEC 合同及其 companions 中提取。私有 Alpha 实施集具有权威性；PRD 中明确延后的需求保留可追溯性，但不排入 S0–S7。

## Requirements Inventory

### Functional Requirements

#### 私有 Alpha 实施集（78 项）

FR-001: 在 iPhone 或 Apple Watch 上开始计划或自由 Workout Session，使用共享身份、持久状态、纠错规则和 Analysis；所选记录设备拥有 live session。
FR-002: 把每个 Actual Set 记录为结构化的 Exercise 状态、顺序、次数、Actual Load、可选 RPE 状态、时间、provenance 与完整性数据。
FR-003: 显示 saved/corrected/finished/discarded 成功或尝试传输前，先在本地提交采集或输入的训练事实。
FR-004: 提供权威的手动 Finish。
FR-005: 只有持续恢复与持续无力量活动同时满足后才提供完成询问；永不自动结束。
FR-006: 完成后显示 Actual Sets 与已训练身体部位。
FR-007: 让缺失或 pending 信息明确保持 incomplete；绝不猜测、隐藏或虚假确认。
FR-008: 仅在合格路径上，于自由 Watch 场次中无需预选地尝试 Exercise 识别。
FR-009: 仅在合格路径上，根据支持的 Watch 信号尝试 working-set 边界与次数识别。
FR-010: 保留置信度及 accepted、uncertain、corrected、unresolved、abstained、manual-only 或 unsupported 识别状态。
FR-011: 仅因不确定性、纠错或明确 trust gate 请求确认，并遵守共享打断预算。
FR-012: 在第一个 Actual Set 后允许纠正 Exercise 标签。
FR-013: Exercise 纠错保留组顺序、次数、负重、RPE 状态与时间。
FR-014: 后续组使用已纠正 Exercise，同时纠错历史保持可审计。
FR-015: 分别报告初始识别成功与纠错后的记录恢复成功。
FR-016: 计划训练的第一个 Actual Load 从 Plan snapshot 预填。
FR-017: 自由训练在有历史时预填最近 Actual Load，否则要求用户输入。
FR-018: 后续每组默认使用上一组 Actual Load，直至用户修改。
FR-019: 让用户权威修改 Actual Load；永不声称自动感知外部负重。
FR-020: 用户启用 RPE tracking 前，所有 RPE 估算、显示、验证与校准保持禁用。
FR-021: 向用户展示前五个按时间顺序合格的 RPE prediction，供确认或纠正。
FR-022: 五次中至少四次误差在 ±1 内后，仅提供关闭日常确认的选项，不静默开启。
FR-023: 五次中至少两次错误后，只从纠正标签进行校准，并启动新五次窗口。
FR-024: 窗口通过且用户明确同意后，允许高置信 RPE auto-use，同时保留 provenance 与纠错能力。
FR-025: 低置信、陌生、信号缺失或漂移的 RPE 保持 pending 或在预算内提示；绝不编造 Actual RPE。
FR-026: Target、predicted、confirmed、auto-used、corrected 与 effective RPE 保持区分。
FR-027: 根据 Actual RPE 与剩余 Plan 建议下一组负重，但只有明确 accept/edit 后才能改变下一 Actual Set；允许 reject。
FR-028: 选择并开始现有 Plan，查看 Exercise、组数、次数、负重与可选 target RPE。
FR-029: 实际执行与计划不一致时，planned content 与 Actual Sets 保持分离。
FR-030: 计划器械不可用时，允许用户请求 substitute。
FR-031: 使用版本化规范主要身体部位、movement pattern、可用器械，以及披露的次要部位/活动范围差异来匹配 substitute。
FR-032: 要求用户明确选择；永不静默替换当前或未来 Plan 中的 Exercise。
FR-033: 完成时识别 Plan 与 Actual 的实质差异，并显示影响未来范围的准确字段 diff。
FR-034: 拒绝指导时保留 Actual 事实，未来 Plan 不变。
FR-035: 把历史场次复用为新草稿，不更改来源历史，也不隐式批准未来 Plan 更新。
FR-036: 在 Training History 中浏览 complete/incomplete 的计划与自由场次。
FR-037: 查看所选周的已完成场次数与执行过的 Exercises。
FR-038: 仅从有效 Actual Sets 而非 planned content 计算周/月 volume、intensity、load 与 duration。
FR-039: 查看用户明确选择的 Primary Exercise 趋势。
FR-040: 在 History 与 Analysis 中保留纠正值及相关 RPE provenance。
FR-041: 完成后显示完整持久场次记录，不允许字段消失。
FR-043: 本地记录离线可用；并发场次保持分离且可恢复，直至得到明确安全解决。
FR-046: 在中断、重复、乱序或并发传输下防止重复及基于时钟的覆盖；保留冲突 revision，并在 iPhone 上暴露无法安全自动处理的冲突。
FR-047: 完整高频传感器流默认保持本地。
FR-049: 将 recognized、planned、substituted 与 corrected Exercise 引用映射到规范记录。
FR-050: 存储 substitute 与 Analysis 所需的规范身体部位和动作属性。
FR-052: 无需启用 RPE tracking 即可解释 RPE 等概念。
FR-053: 不发布未授权媒体，也不宣称单腕可精确判断全身动作。
FR-054: 根据目标、经验、可训练时间、场次时长、器械、偏好和必填限制启动受限文字 AI Plan 创建/修改；缺口与 assumptions 保持可见。
FR-055: 在生成前或生成后接收器械背景，只在有规范映射与理由时提供 substitute。
FR-056: 生成经过验证的完整结构化 Training Plan Draft；只有 prose 的输出不完整。
FR-057: 一次明确原子批准前，显示完整 Plan 或完整字段 diff、未解决字段及映射。
FR-058: 对 injury/recovery/warning signs 执行非诊断性的 affected-scope stop，并要求用户明确选择允许的继续路径。
FR-059: 在明确 review 请求后，只使用获准的 confirmed/corrected 记录与简短反馈，指出 evidence/assumptions，并执行 FR-058。
FR-060: 每次生效 AI 变更都绑定对不可变 `proposalId`、base revision 与 digest 的明确批准；任何相关变更使批准失效。
FR-061: 在场次中或场次后纠正次数并 split、merge、insert 或 delete Actual Sets。
FR-062: 可在 Finish 前后解决 pending 字段；带未解决字段的 Finish 产生可编辑 Incomplete 状态。
FR-063: 场次后纠错采用仅追加、可审计 revision，保留先前 provenance，并仅在得到 effective resolution 后 invalidation/recompute。
FR-064: 在终止、重启、电池/传感器中断或断连后恢复最近持久场次，并提供 Resume、Finish Incomplete 或确认 discard。
FR-065: 把 partial/ambiguous write 保留为一个可见 pending Actual Set，不丢弃也不重复。
FR-066: Recovery 与 replay 幂等，不能重复一组或回退后续纠正。
FR-071: 导出恰好一个版本化 FitnessAI Plan 文件，并通过原生 Share Sheet 以最小数据范围分享。
FR-072: 只有在有界校验和完整预览后才导入兼容 Plan，并创建新的未生效 draft。
FR-073: Unknown Exercises、不兼容字段、duplicates、omissions 与不支持版本保持明确；绝不编造映射或把部分导入显示为完整。
FR-078: 每个 AI draft/proposal 都有不可变身份、digest、provenance、target、base、generation time、permitted scope 与 assumptions。
FR-079: 显示全部 added/removed/changed 字段与受影响未来场次；历史与 active session 不属于 mutation scope。
FR-080: 把批准原子、幂等地提交为一个新 Plan Revision；失败时旧 Plan 完整保持有效。
FR-081: 仅把完整兼容 revision 传递到 Watch，显示真实 pending/delivered/failed 状态且无需手工重建。
FR-082: 将 Alpha AI 输入限制到允许来源；Apple Health 摘要默认关闭，GATE-3 关闭前所有真实 Health-derived 流量保持禁用。
FR-083: 允许继续对话、重新生成或拒绝，且不改变 active Plan。
FR-084: 防止重复、延迟、重试或乱序事件导致 Plan Revision 重复或回滚。
FR-085: AI、校验或传递失败时仍保留最后确认 Plan 与本地训练记录。
FR-086: 对准确 remote categories/window 要求肯定、可撤回、一次性 authorization；普通 App consent 或 HealthKit permission 不能替代。
FR-087: 在批准和提交前运行版本化 deterministic Safety Rule Pack；缺失、失败或不支持的 check 阻止提交。
FR-088: 管理冻结 allowlist 的最小权限 Apple Health 读取，只显示可观察状态；排除的临床类别保持不可访问。
FR-089: 持久 Finish 后可选择写入幂等 workout copy，并分别显示 pending/written/failed 状态。
FR-090: FitnessAI 本地事实独立保持权威；外部 Health 变更产生 `healthKitDetached`，永不静默重建。
FR-091: 每个场次最多显示一次非阻塞 Review/Later/Disable 邀请；显示或关闭不发送数据，也不创建 proposal/approval。

#### 从 S0–S7 延后或排除（13 项；保留追溯）

FR-042: FitnessAI Account 登录属于 public-beta 范围。
FR-044: 本地提交后的应用云同步属于 public-beta 范围。
FR-045: 账号范围跨设备云恢复属于 public-beta 范围。
FR-048: 账号范围导出与删除请求生命周期属于 public-beta 范围。
FR-051: Rich teaching images 延后；Alpha 仍通过 FR-052/053 提供简明自有/授权文本与支持事实。
FR-067: 云删除传播与防复活 tombstones 属于 public-beta 范围。
FR-068: 账号范围跨设备恢复进度/失败属于 public-beta 范围。
FR-069: 退出时 retain/remove 与未同步记录处理属于 public-beta 范围。
FR-070: 跨账号 non-merge 与可预览 transfer 属于 public-beta 范围。
FR-074: 用户调用的 voice draft capture 属于 Post-MVP。
FR-075: Voice ambiguity/conflict 处理与等价非语音路径属于 Post-MVP。
FR-076: 具名第三方 Plan 格式属于 Post-MVP/V2。
FR-077: 服务端 link/QR Plan 分享属于 Post-MVP/V2。

### NonFunctional Requirements

#### 私有 Alpha 实施与发布约束（46 项）

NFR-SIZE-001: Thinned iPhone installed variant ≤500 MB；分别报告 download 与 installed size。
NFR-SIZE-002: Watch App 保持 uncompressed <75 MB，内部 installed target ≤25 MB。
NFR-SIZE-003: Watch ML assets 总计 ≤6 MB，RPE component ≤2 MB；除非以证据修改 PRD。
NFR-SIZE-004: Watch bundle 不包含 rich teaching images 与非必要媒体。
NFR-SIZE-005: 验收使用 Xcode/App Store Connect thinning evidence，而非 debug/archive size。
NFR-RPE-001: 不声称只靠心率即可可靠确定 set-level Actual RPE。
NFR-RPE-002: 在每个边界保持 predicted、target、confirmed、corrected、auto-used 与 effective RPE 区分。
NFR-RPE-003: 低于冻结 confidence threshold 或必需信号不可用时 abstain 或简短询问。
NFR-RPE-004: 在 participant-held-out 与 later-session data 上优于预注册简单 baseline，并提供 calibration 与 slice evidence。
NFR-RPE-005: 通过位于 SM-INT-001 内的预注册 prompt/correction burden Gates。
NFR-RPE-006: 只用 confirmed/corrected RPE 作为校准或训练标签；永不以 prediction 递归标注。
NFR-RPE-007: 用户 opt in 前保持 RPE estimation/calibration 禁用。
NFR-RPE-008: 执行五次 estimate verification window、≥4 pass offer 与 ≥2 wrong recalibration/restart。
NFR-RPE-009: Auto-use 需要明确同意，并保留 model provenance 与纠错能力。
NFR-RPE-010: Verification 后遇到置信度、陌生度、信号或漂移问题时仍 abstain/reverify。
NFR-RPE-011: 使用 1–10 整数 RPE；verification success 为误差在 ±1 内，并单独报告 exact match。
NFR-RPE-012: 揭示 label 前冻结 eligibility；取前五个按时间顺序 eligible predictions，全部保留在 denominator。
NFR-RPE-013: 任意滚动五次 auto-used eligible estimates 中两次纠正，立即触发 drift reverification。
NFR-RPE-014: Final holdout 前冻结 participant/time partitions、model、eligibility、support、threshold、baseline、risk、burden 与 evaluation。
NFR-SESSION-001: 手动 Finish 是普通且权威的方式。
NFR-SESSION-002: Reminder eligibility 要求持续 recovery 与持续 absence of strength activity 同时满足。
NFR-SESSION-003: 推断 inactivity 永不自动结束；用户选择 Finish 或 Continue。
NFR-SESSION-004: 对 long rests、equipment waits 与 low-motion Exercises 验证并分别报告 false/missed reminders。
NFR-SESSION-005: 真机验证前预注册 personalization、windows、missing-signal behavior、cooldown 与 false/missed thresholds。
NFR-RES-001: 代表性真机场次无资源终止、明显无响应或记录信息丢失。
NFR-RES-002: 每个支持 Watch/OS pair 完成 90 分钟/20 组测试，资源终止/数据丢失为零，Start/correction/Finish p95 ≤1 s；报告 battery、thermal、memory 与 >2 s interactions。
NFR-REC-001: Final holdout 前冻结识别 partitions、model、eligibility、support matrix、thresholds、denominators 与 procedure。
NFR-REC-002: 不支持/不确定的 Exercises、devices、signals 与 results 明确降级到 manual/pending，绝不计为成功。
NFR-RECOV-001: 故障测试覆盖终止、重启、电池/传感器中断、断连、partial writes、重复传输及延迟/乱序 delivery，effective facts 恰好一次。
NFR-COMPAT-001: 只有覆盖每个具名 device/OS pair 的真机测试才能建立支持范围。
NFR-COMPAT-002: 保留 app/schema/model/catalog/support versions，绝不静默重新解释历史记录。
NFR-PRIV-001: 分别分类数据，按披露目的最小化收集与使用。
NFR-PRIV-003: 完整 raw motion/heart-rate 默认留在本地，并排除在普通 telemetry、logs 与 remote use 之外。
NFR-PRIV-007: 披露准确 remote-AI purpose、scope、provider/subprocessors、retention 与 training policy；获得 FR-086 authorization 且只发送所选字段。
NFR-SEC-003: 保护敏感本地数据，把 stores/secrets 排除在消费者备份与 diagnostics 之外，并对 secrets 使用本机不参与同步的 Keychain。
NFR-SAFE-001: 在 Alpha 中执行非诊断 stop 和 deterministic safety checks；超出 Product Owner testing 发布前完成专业审核。
NFR-AI-001: Commit 前针对版本化 schema 与规范 Exercise mapping 验证每个 proposal。
NFR-AI-002: 自动测试观察到无要求批准的有效 Plan 写入为零。
NFR-AI-003: 本地 revision commit 与完整 Watch delivery 原子/幂等，无 partial revision、duplicate、rollback 或 false delivery。
NFR-AI-004: AI 不可用、invalid output 或 timeout 不能阻塞当前 Plan 访问或持久本地记录。
NFR-AI-005: 有效 AI revision 保留 proposal/digest/approval/base/schema/model/rule-pack/data-source audit provenance，且无 chain-of-thought。
NFR-AI-006: Reject 或 clarify unmapped、contradictory、invalid 或 safety-excluded output，不编造事实。
NFR-PORT-001: 把 Plan 文件视为不可信输入，执行限制、拒绝 executable/malformed data、保留 provenance，且 import 永不修改现有 Plan。
NFR-HK-001: Apple Health 可选且最小权限；缺失/不可用/失败不能阻塞 Plan、correction、本地 Analysis 或 Watch recording。
NFR-HK-002: Health writes/retries 幂等且 logs 不含内容；不提前声称完成，也不静默重建 detached copies。
NFR-UX-001: 以原生 light/dark、Dynamic Type、VoiceOver、error、empty、loading、offline 与 recovery 状态实现完整双语 DESIGN/EXPERIENCE 合同，不允许 placeholder。

#### 延后或 public-beta 约束（8 项；保留追溯）

NFR-PRIV-002: 中国区应用云 residency 与 cross-border controls 属于 public-beta 范围。
NFR-PRIV-004: Production retention 与 30 天账号 deletion/de-identification 属于 public-beta 范围。
NFR-PRIV-005: 账号范围 self-service data export/deletion 属于 public-beta 范围。
NFR-PRIV-006: Public-beta privacy/security release record 延后。
NFR-SEC-001: Production synchronized-data encryption/access controls 属于 public-beta 范围。
NFR-SEC-002: Account authentication、revocation、rate limiting 与 high-impact reauthentication 属于 public-beta 范围。
NFR-VOICE-001: Post-MVP voice state 与 raw-audio 隐私合同。
NFR-SHARE-001: Post-MVP/V2 服务端分享安全与隐私合同。

### Additional Requirements

#### 成功指标与 counter-metrics

- SM-COMP-001: 每个 recorded/entered/corrected/confirmed 项均持久存在；缺失项使场次 incomplete。
- SM-ACC-001: Recognition accuracy 包含 abstentions/misses，且后续纠错不能提高该指标。
- SM-PRES-001: 纠错保留全部 sibling facts 与 timing。
- SM-RET-001: 四周 default-recorder continuation 要在 holdout 前预注册 cohort/denominator 规则。
- SM-FEED-001: 核心信任相关的 critical/recurring feedback 要预注册严重度、重复性、节奏与关闭证据。
- SM-INT-001: 约 20 组代表性场次最多五次主动 Exercise/rep/load/RPE prompts。
- SM-AI-001: 每个获批准 proposal 产生恰好一个完整结构化 revision。
- SM-AI-002: 未按要求明确批准的有效 Plan 变更必须为零。
- SM-E2E-001: Product Owner 完成 conversation → review → approval → commit → Watch execution → Actual Set return → AI change proposal，无需手工重建。
- SM-ALPHA-CORE-001: Product Owner 重复使用完整私有 Alpha 核心且不退回其他主要记录工具；实验错误保持可见、可纠正。

#### Architecture requirements

- AD-1/AD-12: 建立一个 Xcode workspace、独立 iPhone/Watch targets 与本地 Swift Package；domain targets 不依赖 framework，并在 ports 映射 models。这是 S0 starter seed 与 Epic 1 Story 1 关注点。
- AD-2: 稳定 IDs 在 persistence 前存在；每次用户/批准 AI mutation 原子提交 append-only revision + outbox + invalidation；定义唯一 revision DAG/effective reducer 与 golden vectors。
- AD-3: iPhone 拥有长期事实与完整 resolution；所选记录设备拥有 live session；Watch 使用 `HKWorkoutSession`；phone-only 使用同一 domain。
- AD-4: 使用持久因果 outbox transfer、pairing epochs、`(pairingEpoch, sourceDeviceId, messageId)` replay identity、chunk/whole-object digests、四种 acknowledgement states、compatibility handshake 与 whole-object `applied` cleanup。
- AD-5: 使用独立 GRDB 7.11.1 stores、原子关键写入、受保护文件、`completeUntilFirstUserAuthentication`、备份排除、不参与同步 Keychain、不可读 store 保留及保守 cleanup/tombstones。
- AD-6: Recognition/RPE/Finish assistance 独立 evidence-gated、在场次内冻结、fail closed 且可由手动路径替代；合格前只使用准确 candidate device/orientation/handedness/eight-Exercise row。
- AD-7: 把 AI 当作不可信结构化 proposal 输入；生成后与 commit 前校验；可访问 approval 绑定 identity/digest/base/policies；永不修改 active sessions/history。
- AD-8: 分离内置 gateway 与本机 BYOK DeepSeek routes，采用 route/account pseudonymous isolation、一次性 digest-bound authorization、无内容 audit、allowlists/ceilings 与 kill switches。
- AD-9: FitnessAI 对可选 HealthKit context/copies 保持权威；实现版本化 allowlist、observable states、export generations、transition table 与 detached-copy behavior。
- AD-10: 使用纯文本未压缩 UTF-8 JSON；执行 2 MB、depth 12、单一 Plan、366 days、30 Exercises/day、20 Sets/Exercise、10,000 Sets、2,000 chars/note，以及规范 unknown-field/mapping/duplicate 行为。
- AD-11: 仅从 effective Actual Set revisions 派生 Analysis；按范围 invalidation/recompute，并如实标记 stale/pending/partial/conflicted/excluded。
- AD-13: 分离 development/private-Alpha/future-production data 与 credentials；要求 compile/domain/schema/safety/persistence/sync/AI/secret checks、Alpha fault/accessibility/paired-device/physical-device evidence、隐私安全 logs、opt-in telemetry 与 size reports。
- AD-14: 实现 Titanium Measure semantic tokens、typed native navigation、thin MVVM/state machines、完整 exceptional states，以及 non-color/non-motion/non-haptic/non-Crown 等价方式。

#### Gate requirements

- GATE-1 enabling/evidence requirement: 第一条 AI Plan implementation Story 前冻结 Safety Rule Pack v1 数值边界与 golden fixtures。完整 deterministic results 存在前可以搭建 proposal 骨架，但 commit 保持阻塞。超出 owner testing 的发布由专业审核门控。
- GATE-2 enabling requirement: 任何内置 Alpha 流量前，冻结 DeepSeek legal/runtime/region/subprocessor/retention/training/deletion/disclosure 与 gateway operational controls。关闭前技术上禁用内置流量；可本地测试 ports 与 BYOK。
- GATE-3 enabling requirement: 任何真实 Health-derived remote traffic 前，批准 Apple-purpose、processor/contract、cross-border、disclosure、retention/training、deletion/revocation/user-rights 与 request-field mapping evidence。关闭前 preview 可渲染，但 send fail closed。
- GATE-4 evidence requirement: 自动 recognition 启用前，冻结并通过已注册真机 evidence record。关闭前 AD-6 row 只是 candidate，manual Complete Set 是 supported path。
- GATE-5 evidence requirement: RPE auto-use 前，冻结并通过 model、threshold、baseline、burden、drift、subgroup、missing-signal、resource 与 holdout evidence。关闭前 RPE 默认关闭，在已批准实验中仅 confirmation-only。
- GATE-6 evidence requirement: forgotten-Finish 启用前，冻结 thresholds/protocol，并通过 long-rest/equipment-wait/low-motion 真机 evidence。关闭前仅手动 Finish。
- GATE-7 prerequisite requirement: Plan import Stories 可验收前，冻结 parser time/memory ceilings 与 failure reporting。Import 验收保持阻塞时 Export 可推进。

#### Gate Story Placement Contract

| Gate | Story placement | Gate 开放时允许的工作 | 保持 fail closed 的路径 |
|---|---|---|---|
| GATE-1 | Epic 2 prerequisite → implementation → evidence → commit enablement | Proposal/schema/review/digest scaffolding | 依赖 Safety 的 AI Plan behavior 与全部 proposal commit |
| GATE-2 | Epic 2 adapter/control → evidence record → traffic enablement | Provider port、fake provider、BYOK、禁用状态 gateway adapter、本地 contract tests | 全部真实内置 DeepSeek 流量 |
| GATE-3 | Epic 2 authorization/fail-closed preview → Epic 6 local summary → evidence record → send enablement | 本地 Health、不含 Health 的 AI、默认关闭 preview 与本地 summaries | 全部真实 Health-derived remote sends |
| GATE-4 | Epic 7 candidate → preregistration → physical-device evidence → row-specific enablement | Candidate development、data capture、manual Complete Set | 每个未合格 recognition function/device/orientation/Exercise row |
| GATE-5 | Epic 7 disabled model/state flow → preregistration → evidence → explicit-user enablement | Manual RPE 与获准的 confirmation-only collection | RPE auto-use |
| GATE-6 | Epic 7 disabled candidate → preregistration → physical-device evidence → enablement | Manual Finish 与禁用状态 15-minute dual-signal candidate | Forgotten-Finish reminder 与所有 automatic Finish path |
| GATE-7 | Epic 5 export → parser-budget prerequisite → parser/preview/evidence | 有界 Plan export | Plan import Story acceptance |

每个 evidence Story 必须指出由谁负责的 evidence artifact、冻结 versions 与 inputs、thresholds、failure result 和 default-disabled control。Gate Story 不能只通过一句状态声明完成验收。

### UX Design Requirements

UX-DR1: 实现 iPhone 顶层 Plan、History、Analysis 与 More，以 Plan 为 root；使用 typed contextual routes，并在 back 时恢复 object/filter/scroll/non-effective input。
UX-DR2: 实现 `AI-L01`–`AI-L05`/`AI-01`–`AI-06`：Plan Home、文字 Chat、默认关闭 Authorization、完整 Proposal Review、独立 Approval 与独立 Commit/Delivery truth。
UX-DR3: 实现 `PW-L01`–`PW-L02` 纯手机 active workout、set editing、correction、recovery、Finish Incomplete 与 confirmed discard，并使用共享 session model。
UX-DR4: 实现 Watch Approved Plan、Active Workout、Edit Actual Set、Rest Resolution、Recovery 与 Finish/Local Save surfaces，每个状态只有一个主要任务/动作。
UX-DR5: 实现 `HX-L01` History 的 ready/loading/empty/offline/incomplete/corrected/conflict/tombstone/return/restoration 状态及 scroll/filter restoration。
UX-DR6: 实现 `AN-L01` Analysis 的准确指标、字面结论、effective-Actual-Set provenance、exclusions、stale/partial/error 状态及 chart 的 text/table alternatives。
UX-DR7: 实现 `HK-L01` capability-specific Apple Health rows、本地权威说明、detached/retry 状态与独立 gate-blocked remote-summary preview。
UX-DR8: 实现 `PX-L01` export scope review、原生 Share Sheet、有界 import preview/mapping/omission/duplicate/error 状态与唯一 Create New Draft 动作。
UX-DR9: 实现 `RV-L01` 每场一次的非模态 Review/Later/Disable 邀请，经由现有 authorization/diff/approval，且无隐藏状态。
UX-DR10: 构建可复用 `ai-conversation`、`remote-ai-authorization`、`plan-diff-review`、`proposal-approval-gate`、`safety-stop`、`session-control`、`actual-set-row`、`load-stepper`、`recognition-state-chip`、`rpe-verification-prompt`、`forgotten-finish-prompt`、`analysis-summary`、`healthkit-capability-row`、`plan-exchange-review`、`proactive-review-invitation`、`sync-state-indicator`、`recovery-choice-sheet` 与 `support-boundary-notice` families。
UX-DR11: 通过 SwiftUI Color/Font roles 使用 Titanium Measure semantic tokens、4 pt rhythm、native geometry、无 decorative shadow、SF Symbols，组件内不出现未解释 raw styling。
UX-DR12: 保持 fact → source/authority → durability → consequence/action 层级；local save、delivery、synchronization、Health write 与 remote send 是不同状态。
UX-DR13: 每个状态只使用一个 consequential primary action；controls ≥44 × 44 pt 且间距 8 pt；提供 safe-area bottom actions、keyboard avoidance 与原生 sheets/alerts/file picker/Share Sheet/Health authorization。
UX-DR14: 支持 light/dark/Increase Contrast/Differentiate Without Color/Reduce Motion/Reduce Transparency、iPhone ≥200% 与 Watch ≥140% text scaling、VoiceOver、Full Keyboard Access，且不以 color、motion、haptic、gesture 或 Crown 作为唯一方式。
UX-DR15: Error focus 落在字面 summary 后再到 recovery action；Retry 保留 input；success focus 落在准确 durable result；status update 不抢焦点，除非 integrity 受威胁。
UX-DR16: 主动提示延后到 `restSafeForInteraction`；保留 pending facts、合并 announcements，并执行 active-session 共享五次提示预算。
UX-DR17: 明确 unsupported/manual-only 边界，保留 manual Complete Set/Finish/local capture，不添加可发现的延后功能占位。
UX-DR18: 从 iPhone 11 到更大机型均无水平滚动地 reflow；在 accessibility size 下线性化 metrics/diffs，绝不截断关键中文 value、consequence、digest 或 action。
UX-DR19: 将 current、pending、stale、partial、conflicted、invalid、unsupported、failed、cancelled、incomplete 与 recovery 作为字面 UI semantics，永不呈现乐观或仅颜色表达的成功。
UX-DR20: 验证真机 Watch glanceability、Always On、Crown/touch equivalents、sweat/one-hand use、haptics、gym lighting、iPhone geometry、最大中文字号、P3/sRGB contrast、chart targeting、offline、failure、replay 与 reconnect behavior。

### FR Coverage Map

FR-001: Epic 1 — 共享 planned/ad-hoc session start 与 capture ownership。
FR-002: Epic 1 — 结构化 Actual Set 事实。
FR-003: Epic 1 — 持久本地保存边界。
FR-004: Epic 1 — 权威手动 Finish。
FR-005: Epic 7 — 证据门控 forgotten-Finish prompt。
FR-006: Epic 1 — 完成场次事实与训练部位。
FR-007: Epic 1 — 可见 incomplete/pending facts。
FR-008: Epic 7 — 合格 ad-hoc Exercise recognition。
FR-009: Epic 7 — 合格 set-boundary 与 repetition recognition。
FR-010: Epic 7 — recognition confidence 与 provenance states。
FR-011: Epic 7 — 共享预算内的 trust-gated prompting。
FR-012: Epic 7 — 第一组 Exercise correction。
FR-013: Epic 7 — recognition correction 时保留 sibling facts。
FR-014: Epic 7 — corrected continuation 与 audit。
FR-015: Epic 7 — recognition/recovery metric separation。
FR-016: Epic 1 — planned first-load default。
FR-017: Epic 1 — historical ad-hoc first-load default。
FR-018: Epic 1 — previous-Actual-Load default。
FR-019: Epic 1 — 权威 load editing。
FR-020: Epic 7 — RPE opt-in boundary。
FR-021: Epic 7 — five-estimate verification。
FR-022: Epic 7 — ≥4/5 auto-use offer。
FR-023: Epic 7 — ≥2/5 recalibration 与 restart。
FR-024: Epic 7 — explicit-consent high-confidence auto-use。
FR-025: Epic 7 — abstention/pending/drift behavior。
FR-026: Epic 7 — 不同 RPE states 与 provenance。
FR-027: Epic 3 — 下一组 guidance 的明确 accept/edit/reject。
FR-028: Epic 1 — 选择并执行现有 Plan snapshot。
FR-029: Epic 1 — planned/Actual 分离。
FR-030: Epic 3 — 请求 substitute Exercises。
FR-031: Epic 3 — 规范 substitute matching 与 comparison。
FR-032: Epic 3 — 用户权威 substitute selection。
FR-033: Epic 4 — 准确 post-session Plan reconciliation diff。
FR-034: Epic 4 — reject 保留 Actual facts 与未来 Plan。
FR-035: Epic 4 — 历史场次复用为新 draft。
FR-036: Epic 4 — 可浏览 complete/incomplete History。
FR-037: Epic 4 — 每周 session 与 Exercise evidence。
FR-038: Epic 4 — 基于 Actual Set 的周/月 Analysis。
FR-039: Epic 4 — 选定 Primary Exercise trends。
FR-040: Epic 4 — Analysis 中 corrected-value/RPE provenance。
FR-041: Epic 4 — 完整 session detail。
FR-042: Deferred — public-beta FitnessAI Account sign-in。
FR-043: Epic 1 — 离线本地 capture 与不同 concurrent sessions。
FR-044: Deferred — public-beta 应用云 synchronization。
FR-045: Deferred — public-beta account-scoped restoration。
FR-046: Epic 1 — causal/idempotent cross-device transfer 与可见 conflicts。
FR-047: Epic 1 — raw high-frequency streams 保持本地。
FR-048: Deferred — public-beta account export/deletion lifecycle。
FR-049: Epic 1 — 规范 Exercise identity。
FR-050: Epic 1 — body-area 与 movement attributes。
FR-051: Deferred — rich teaching media。
FR-052: Epic 1 — 简明 RPE 与概念解释。
FR-053: Epic 1 — licensed-content 与 support-claim boundary。
FR-054: Epic 2 — 受限 text AI Plan intake。
FR-055: Epic 2 — equipment context 与 mapped substitutions。
FR-056: Epic 2 — 完整结构化 Plan Draft。
FR-057: Epic 2 — 完整 review 与一次 atomic approval。
FR-058: Epic 2 — 非诊断 safety stop。
FR-059: Epic 2 — 明确调用的 evidence-bounded revision proposal。
FR-060: Epic 2 — digest/base/proposal-bound approval。
FR-061: Epic 1 — field/topology Actual Set correction。
FR-062: Epic 1 — pending-field resolution 与 Incomplete Finish。
FR-063: Epic 1 — append-only auditable corrections。
FR-064: Epic 1 — active-session recovery choices。
FR-065: Epic 1 — 一个可见 pending fragment。
FR-066: Epic 1 — 幂等 recovery 与 replay。
FR-067: Deferred — public-beta deletion propagation/tombstones。
FR-068: Deferred — public-beta cloud restoration status。
FR-069: Deferred — public-beta sign-out retain/remove。
FR-070: Deferred — public-beta cross-account non-merge。
FR-071: Epic 5 — 一个有界 Plan export 与 Share Sheet。
FR-072: Epic 5 — validated preview-to-new-draft import。
FR-073: Epic 5 — 明确 mapping/omission/duplicate/version handling。
FR-074: Deferred — Post-MVP voice draft capture。
FR-075: Deferred — Post-MVP voice conflict 与 fallback。
FR-076: Deferred — Post-MVP/V2 第三方 Plan formats。
FR-077: Deferred — Post-MVP/V2 link/QR sharing。
FR-078: Epic 2 — 不可变 proposal identity 与 scope。
FR-079: Epic 2 — 完整 future-scope diff。
FR-080: Epic 2 — atomic/idempotent revision commit。
FR-081: Epic 1 — 完整兼容 Plan delivery 到 Watch。
FR-082: Epic 2 — 受限 AI source policy 与 Health-summary gate。
FR-083: Epic 2 — non-effective conversation/regeneration/rejection。
FR-084: Epic 2 — duplicate/retry/out-of-order Plan protection。
FR-085: Epic 2 — AI/delivery failure degradation。
FR-086: Epic 2 — one-shot remote-use authorization。
FR-087: Epic 2 — deterministic Safety Rule Pack gating。
FR-088: Epic 6 — 最小权限 Apple Health reads。
FR-089: Epic 6 — 可选幂等 Health workout copy。
FR-090: Epic 6 — 本地 authority 与 detached-copy behavior。
FR-091: Epic 8 — 一次 non-blocking post-session review invitation。

## Epic List

### Epic 1: 跨 iPhone 与 Watch 完成可信手动训练

训练者可以先完成计划或自由纯手机场次，再使用同一事实模型在 Watch 上接收完整兼容 Plan、执行不可变 Start snapshot、在断连/重启期间把事实保存在本地，并恰好一次地回传 iPhone。S0 仓库/合同、S1 纯手机 capture 与 S2 配对 Watch capture 是同一个完整用户价值 Epic 内有序的检查点；AI、Health、网络或自动能力均不能阻塞手动核心。

**FRs covered:** FR-001–004、FR-006–007、FR-016–019、FR-028–029、FR-043、FR-046–047、FR-049–050、FR-052–053、FR-061–066、FR-081。

**Implementation slices:** S0 → S1 → S2。**Primary bindings:** CAP-2–3、CAP-7、CAP-12–13；AD-1–5、AD-12–14。

### Epic 2: 把获授权的 AI 对话转为获批准的 Plan Revision

训练者可以授权准确 remote data scope，创建或修改完整结构化 Plan，解决 safety/mapping 问题，审核每个字段，批准一个 digest-bound proposal，并原子激活恰好一个 revision；任何失败都保留先前 Plan 与手动训练核心。GATE-1 是 prerequisite/evidence Story；GATE-2 与 GATE-3 在关闭前技术上禁用内置及 Health-derived 流量，同时允许安全 scaffolding 及合格本地/BYOK 工作推进。

**FRs covered:** FR-054–060、FR-078–080、FR-082–087。

**Implementation slice:** S3。**Primary bindings:** CAP-1、CAP-9、CAP-11；AD-2、AD-7–9、AD-13–14；GATE-1–3。

### Epic 3: 在训练中作出由用户掌权的决定

训练期间，训练者可以在器械不可用时请求规范 substitute，并 accept、edit 或 reject 下一组 load guidance，而不静默改变当前 Actual Set 或未来 Plan。本 Epic 只消费稳定 Plan snapshots、effective Actual facts、RPE provenance 与 Exercise Catalog ports；既不依赖也不调用训练后 Analysis/read-model 实现。

**FRs covered:** FR-027、FR-030–032。

**Implementation slice:** S4A。**Primary bindings:** CAP-13–14；AD-2、AD-7、AD-14。

### Epic 4: 审核 History、Analysis 与未来 Plan 对账

在训练后或训练间隔期间，训练者可以浏览完整 History，查看 revision-bound 周/月与选定 Primary Exercise Analysis，如实看到 stale/partial/conflicted exclusions，把历史场次复用为新 draft，并 accept 或 reject 准确的未来 Plan reconciliation diff，而不修改已完成训练。本 Epic 拥有 Analysis/read-model 与 future-Plan reconciliation use cases，只依赖共享稳定 domain contracts，不依赖训练中 guidance 实现。

**FRs covered:** FR-033–041。

**Implementation slice:** S4B。**Primary bindings:** CAP-7–8、CAP-14；AD-2、AD-7、AD-11、AD-14。

### Epic 5: 把 FitnessAI Plan 安全交换为独立 Draft

训练者可以通过原生 Share Sheet 导出恰好一个有界 FitnessAI Plan，并且只有在完整 validation、mapping、omission、duplicate 与 provenance review 后，才把文件 import 为新的未生效 draft。Parser 或 sharing failure 不改变任何现有 Plan。GATE-7 是 prerequisite/evidence Story：export 可以推进，但 parser time/memory ceilings 与 failure reporting 冻结前，Plan import 不得通过验收。

**FRs covered:** FR-071–073。

**Implementation slice:** S5A。**Primary bindings:** CAP-10；AD-10、AD-13–14；GATE-7。

### Epic 6: 在不放弃本地事实权威的前提下使用 Apple Health

训练者可以授予可选、最小权限 Apple Health capabilities，只观察真实 read states，并创建或重试幂等 workout copies；FitnessAI 保持权威，外部变化成为 `healthKitDetached`。Health failure 不影响本地 Plan、History、Analysis 与 capture。本地 capability 独立可用；GATE-3 在允许独立 authorization preview 与不含 Health data 的 AI 时，继续技术性禁用每个真实 Health-derived remote send。

**FRs covered:** FR-088–090。

**Implementation slice:** S5B。**Primary bindings:** CAP-9；AD-8–9、AD-13–14；GATE-3。

### Epic 7: 在保留手动 fallback 的前提下获得证据门控 Watch 辅助

在准确合格的 device/orientation/handedness/Exercise rows 上，训练者可以获得独立合格的 recognition、set/rep、opt-in RPE 与保守 Finish assistance，同时具有 confidence、abstention、correction、drift recovery、safe-rest prompting 与共享 interruption budget。GATE-4–6 是 evidence Stories；每个开放或失败 Gate 只禁用其具名自动路径，Epic 1 手动 capture 始终受支持。

**FRs covered:** FR-005、FR-008–015、FR-020–026。

**Implementation slice:** S6。**Primary bindings:** CAP-4–6；AD-6、AD-13–14；GATE-4–6。

### Epic 8: 完成受控训练后审核并重复使用私有 Alpha

完成场次后，Product Owner 可以 accept、defer 或 disable 一次非阻塞 review invitation；接受后进入现有 authorized diff-and-approval path，不发生隐藏数据使用或 mutation。随后 Product Owner 可以通过无障碍原生 iPhone 与 Watch 页面重复完成完整 conversation-to-Plan-to-workout-to-Analysis 闭环；S7 关闭 migration、fault、size、privacy、paired-device 与 physical-device evidence，不出现可发现的延期占位或乐观状态声明。

**FRs covered:** FR-091。

**Implementation slice:** S7。**Primary bindings:** CAP-11–12 及全部集成 CAPs；AD-13–14；SM-COMP-001–SM-ALPHA-CORE-001。

## Epic 1: 跨 iPhone 与 Watch 完成可信手动训练

训练者可以先完成计划或自由纯手机场次，再使用同一事实模型在 Watch 上接收完整兼容 Plan、执行不可变 Start snapshot、在断连/重启期间把事实保存在本地，并恰好一次地回传 iPhone。S0 仓库/合同、S1 纯手机 capture 与 S2 配对 Watch capture 是同一个完整用户价值 Epic 内有序的检查点；AI、Health、网络或自动能力均不能阻塞手动核心。

### Story 1.1: 启动可运行的 iPhone、Watch 与共享合同工程

作为 Product Owner，
我希望获得一个可以启动运行、并强制执行共享 Package 边界的 iPhone 和 Apple Watch 私有 Alpha 工程，
从而让后续所有训练功能都建立在同一个原生产品和同一套事实模型上。

**验收标准：**

**假如** 开发者在规定的 Apple Silicon 开发环境中取得一份干净的代码副本
**当** 使用 Xcode 26.6 和 Swift 6.3.3 打开并构建 FitnessAI workspace
**那么** iPhone 和 Watch App targets 均可成功编译和启动
**并且** workspace 使用一个本地 Swift Package，明确定义 `Contracts`、domain、application-use-case、persistence-port、synchronization-contract、safety-rule 和 analysis targets
**并且** GRDB 被精确固定为 7.11.1，解析后的依赖版本文件已提交到仓库。

**假如** 检查共享 Package 的依赖关系
**当** dependency-direction tests 检查所有 domain targets
**那么** domain targets 不得 import SwiftUI、GRDB、HealthKit、WatchConnectivity、Core Motion、任何 AI-provider framework 或 App target
**并且** adapters 只能通过具名 ports 向内依赖
**并且** 不得创建笼统的 `Utils` target。

**假如** iPhone App 中还没有 Plan 或 Workout Session
**当** Product Owner 启动 App 并进入根页面
**那么** 原生顶层导航包含 Plan、History、Analysis 和 More，且默认选择 Plan
**并且** 尚未完成的能力使用真实原生 empty states，而不是开发者占位页面或可发现的延期功能入口
**并且** contextual navigation 使用 typed destinations，为后续恢复 object、filter、scroll position 和 non-effective input 提供基础。

**假如** Watch 尚未收到完整兼容的 Plan
**当** Product Owner 启动 Watch App
**那么** App 显示真实的“尚无已传递 Plan”状态
**并且** 不显示 partial Plan、模拟 recognition 或尚不能使用的未来功能。

**假如** 用户启用了 Light Mode、Dark Mode、增大文字、VoiceOver、Reduce Motion 或 Differentiate Without Color
**当** 检查启动页面和 empty states
**那么** 页面使用 Titanium Measure semantic tokens 和原生 SwiftUI 行为
**并且** 重要状态与导航含义不只依赖颜色、动画、haptic、gesture 或 Digital Crown 表达。

**假如** 本 Story 只负责建立仓库与合同种子
**当** 检查其数据和持久化内容
**那么** 不得提前创建后续 Stories 才需要的数据库表或 entities
**并且** 不得存储 secrets、Health data、sensor data、AI content 或 workout facts。

**追踪范围：** AD-1、AD-12、AD-13、AD-14；UX-DR1、UX-DR11～15、UX-DR17～19；NFR-UX-001。

### Story 1.2: 统一跨设备事实身份、单位与 Digest 合同

作为训练者，
我希望每个 Plan、Workout Session、Actual Set 和 revision 在 iPhone、Watch、重试与传输过程中始终保持相同的身份和含义，
从而避免训练事实被重复创建、错误转换或解释成不同内容。

**验收标准：**

**假如** App 准备创建 Plan、Plan Revision、Workout Session、Actual Set、revision event、device message、approval 或 proposal identity
**当** 对象首次在 domain 中产生
**那么** 对象必须在 persistence、传输或 UI success 之前获得稳定 ID
**并且** 同一对象经历本地重试、App 重启、Watch transfer 或 replay 后继续使用原 ID
**并且** 不得使用设备时间或到达顺序重新生成或选择事实身份。

**假如** iPhone 和 Watch 需要交换或比较训练事实
**当** 使用共享 `Contracts` 进行编码或解码
**那么** 合同必须定义平台中立的 IDs、units、revision metadata、error codes 和 version fields
**并且** 这些合同不暴露 SwiftUI、GRDB row、HealthKit、WatchConnectivity 或 provider-specific models
**并且** 未来 Kotlin 实现可以根据 schema 与 golden fixtures 独立实现，而不需要复用 Swift 代码。

**假如** 用户输入负重
**当** 该负重进入 domain contract
**那么** 必须保留用户输入的原始数值和 kg/lb 单位
**并且** 规范换算值作为独立派生值
**并且** 必须区分 external、bodyweight、assisted、unloaded、timed 或 non-comparable load kind
**并且** 在适用时区分 total 与 per-side basis
**并且** 语义不可比较的负重不得被合同强制合并。

**假如** 一个事实会被外部组件解释
**当** 该事实进入 persistence、Watch transfer、AI proposal、Plan file 或 Analysis
**那么** 必须携带适用的 app、schema、Exercise catalog、model、support matrix、Safety Rule Pack 或 algorithm version
**并且** 缺失或不兼容的必需版本产生明确的 pending、unsupported 或 rejected error
**并且** 不得静默按照当前版本重新解释历史事实。

**假如** 相同结构化内容需要用于显示、approval、sync、import 或 commit
**当** 生成 canonical serialization 和 digest
**那么** 统一规范必须明确 UTF-8 encoding、Unicode normalization、decimal 与 unit representation、UTC/time-zone meaning、unknown-field behavior、被 digest 覆盖的字段与 bytes，以及版本化 hash algorithm
**并且** 语义相同的 iPhone 与 Watch 输入产生完全相同的 canonical bytes 和 digest
**并且** 任何被覆盖字段的变化都会改变 digest。

**假如** 合同仓库包含 golden vectors
**当** iPhone target、Watch target 和 shared-package tests 运行
**那么** 每个 target 对有效 fixture 产生完全一致的 bytes、digest、IDs、units 与 version interpretation
**并且** malformed、unknown-required-field、unsupported-version、decimal-boundary、Unicode 和 time-zone fixtures 返回规定的 typed error
**并且** 不得产生 partial success 或自动替换成另一项事实。

**假如** Story 1.2 只负责稳定合同
**当** 检查其实现范围
**那么** 只创建本 Story 需要的 schema、value types、canonicalization implementation 和 fixtures
**并且** 不创建 Workout、Plan、AI、Health 或 sync 数据库表
**并且** 不发送网络请求，也不暴露后续用户功能。

**追踪范围：** AD-2、AD-4、AD-12；Architecture Consistency Conventions；S0 cross-target golden-fixture exit condition；NFR-COMPAT-002。

### Story 1.3: 用统一 Revision DAG 保留并解决训练事实

作为训练者，
我希望每次修改都保留原始事实，并按照相同规则决定哪个 revision 生效，
从而在 iPhone、Watch、纠错和重试发生冲突时，不会静默覆盖或丢失我的记录。

**验收标准：**

**假如** 用户或已批准 AI 对 Plan、Workout Session 或 Actual Set 进行修改
**当** domain 创建 revision
**那么** revision 必须包含稳定的 revision/event ID、object ID、规范 field path 或 operation kind、parent/head set、author device、resolution references 及适用版本
**并且** 原对象与旧 revision 保持不可变
**并且** reducer 通过统一合同计算 effective value，而不是直接覆盖旧值。

**假如** 两个 revision 修改同一对象的不同规范字段
**当** reducer 同时获得两个 revision 且所需 parents 均存在
**那么** 可安全合并的不同字段修改产生确定且与到达顺序无关的 effective result
**并且** iPhone 与 Watch 对同一 DAG 产生完全相同的结果。

**假如** 两个 revision 对同一个规范字段写入不可比较的值
**当** reducer 处理这些 revision
**那么** 结果保持 `conflicted`
**并且** 两个用户编写的值及其 provenance 都保持可见
**并且** 不得通过 device time、到达顺序、最大 ID 或 last-write-wins 静默选择胜者。

**假如** 并发 revision 涉及 split/merge、insert/delete、reorder、completion state 或 Plan topology
**当** 两个操作重叠或语义不可安全组合
**那么** reducer 不得自动压平或猜测组合结果
**并且** 受影响对象保持 `conflicted` 或 `pendingResolution`
**并且** 未受影响的 sibling facts 继续保持有效。

**假如** 一个 revision 引用了尚未获得的 parent
**当** reducer 计算状态
**那么** 该 revision 保持 `pendingMissingParent`
**并且** 不会提前成为 effective
**并且** 后续收到 parent 后可以重复计算，而不创建重复 revision。

**假如** 用户在 iPhone 上明确解决冲突
**当** 创建 resolution revision
**那么** resolution 必须引用被解决的全部 heads
**并且** 选择结果作为新的 append-only revision 保存
**并且** 未被选中的 revision 仍保留在 audit history 中
**并且** 再次提交相同 resolution idempotency key 时返回原结果。

**假如** 同一组 revision 以不同顺序、重复次数或批次输入 reducer
**当** 运行 golden-vector 和 property tests
**那么** 产生相同的 effective、pending 或 conflicted 状态
**并且** 不会重复 Actual Set、丢失 correction 或回退后续 user revision
**并且** iPhone、Watch 与平台中立 fixture 结果一致。

**假如** Story 1.3 只负责 revision policy
**当** 检查实现范围
**那么** 只实现 revision value types、DAG validation、effective-value reducer、typed conflict states 和 fixtures
**并且** 不创建数据库 tables、Watch transfer、UI conflict-resolution 页面或 Analysis recomputation
**并且** 后续 adapters 只能调用这一 reducer，不得另外实现自己的冲突规则。

**追踪范围：** AD-2、AD-3、AD-4、AD-11；FR-046、FR-063、FR-066 的共享 domain prerequisite；SM-PRES-001；S0 golden-vector exit condition。

### Story 1.4: 建立原子、安全、可恢复的 iPhone 本地存储边界

作为一名训练者，
我希望训练和计划数据能够安全、完整地保存在 iPhone 本地，
从而即使应用被中断或存储失败，也不会出现“显示保存成功，但实际只保存了一部分”的情况。

**验收标准：**

**假如** 应用首次创建或打开本地数据库
**当** 持久化组件完成初始化
**那么** 系统必须通过统一的存储接口使用 GRDB 7.11.1 和系统 SQLite
**并且** 本 Story 只建立版本记录、修订事件、待发送事件、失效记录和幂等记录等必要的最小存储基础
**并且** 不提前创建尚未由后续 Story 明确定义的业务数据表。

**假如** 后续功能需要同时保存业务事实、修订记录、待同步事件和相关失效记录
**当** 它通过统一事务接口提交这些内容
**那么** 所有内容必须在同一个数据库事务中成功
**并且** 任意一步失败时必须整体回滚，不得留下半成品数据
**并且** 上层只能在事务真正提交后显示“保存成功”。

**假如** 相同的操作因为重试而携带同一个幂等标识再次提交
**当** 存储层识别到该操作已经成功处理
**那么** 系统必须返回之前的处理结果
**并且** 不得重复创建修订、事件或待发送记录。

**假如** 测试在事务的不同写入阶段主动模拟断电、磁盘写入失败或应用终止
**当** 应用重新打开数据库
**那么** 数据库中只能出现“全部提交”或“完全未提交”两种结果
**并且** 不得出现部分业务数据已保存、但修订或待发送事件缺失的状态。

**假如** 本地保存失败
**当** 用户仍停留在当前操作界面
**那么** 系统必须保留用户尚未成功保存的输入
**并且** 返回可以区分原因的错误状态
**并且** 不得显示成功提示或丢弃用户输入。

**假如** 数据库及其辅助文件被创建
**当** 系统检查文件保护和备份属性
**那么** 数据库、WAL、SHM 以及后续由同一策略管理的本地传输文件必须使用 `completeUntilFirstUserAuthentication`
**并且** 必须排除在 iCloud 和普通设备备份之外
**并且** 密钥、令牌和其他敏感凭据不得写入数据库。

**假如** 数据库文件损坏、无法读取或迁移失败
**当** 应用尝试启动存储层
**那么** 系统必须进入明确的恢复状态并停止依赖该数据库的写入
**并且** 不得静默创建空数据库来替换原有数据
**并且** 必须保留原始文件，以便诊断或恢复。

**假如** 存储层记录诊断信息
**当** 写入日志或错误报告
**那么** 只能记录对象标识、状态、错误类型、版本和耗时等元数据
**并且** 不得记录训练内容、健康数据、用户自由文本或其他敏感正文。

**假如** 本 Story 完成
**当** 验证它的交付范围
**那么** 它只提供 iPhone 端的存储适配器、事务能力、保护策略和自动化测试
**并且** 不包含具体训练业务表、Watch 存储、跨设备同步、历史分析或 AI 功能。

**追踪范围：** AD-2、AD-5、AD-13；NFR-SEC-003；后续事实写入所需的原子提交基础。

### Story 1.5: 浏览规范动作目录并看清功能支持边界

作为一名训练者，
我希望在 iPhone 上查找并了解系统认可的标准动作，
从而在制定计划或记录训练时选择含义明确的动作，并知道哪些功能可以使用、哪些只能手动完成。

**验收标准：**

**假如** 用户在没有网络的情况下打开动作目录
**当** 应用加载随版本提供的本地动作数据
**那么** 用户可以浏览和搜索动作
**并且** 每个动作必须具有稳定的规范动作 ID 和动作目录版本
**并且** 搜索结果必须来自本地数据，不依赖 AI、账号或远程服务。

**假如** 用户打开一个规范动作
**当** 应用显示动作详情
**那么** 页面必须展示动作名称、主要训练部位、次要训练部位、动作模式和所需器械
**并且** 在适用时展示动作幅度或后续替代与分析所需的结构化属性
**并且** 这些属性必须来自版本化字段，而不是通过动作名称或自由文本猜测。

**假如** 一个动作只支持部分能力，或者只能手动记录
**当** 用户查看或选择该动作
**那么** 应用必须明确显示 `supported`、`limited`、`manual-only` 或 `unsupported` 状态
**并且** 必须说明当前可用的手动路径
**并且** 不得把尚未通过证据 Gate 的自动识别能力显示为可用功能。

**假如** 外部内容、旧数据或后续导入内容引用了无法映射的动作
**当** 动作目录尝试解析该引用
**那么** 系统必须将其保留为“映射未解决”
**并且** 不得根据相似名称自动编造规范动作映射
**并且** 不得把未解决动作表示为已获得完整支持。

**假如** 用户需要了解 RPE 等训练概念
**当** 用户打开相关说明
**那么** 应用可以提供简明的本地文字解释
**并且** 阅读说明不代表用户已经开启 RPE 记录或自动估算
**并且** 相关可选功能仍保持原来的关闭状态。

**假如** 动作详情包含教学媒体
**当** 应用展示图片或其他内容
**那么** 只能使用拥有合法授权或项目自有的媒体
**并且** 媒体缺失时仍需提供完整的文字信息和明确的不可用状态
**并且** 不得把 Apple Watch 的单点腕部数据描述成对全身动作质量的精确判断。

**假如** 用户使用 VoiceOver、放大字体或非触觉提示
**当** 浏览、搜索或选择动作
**那么** 规范动作身份、属性和支持状态必须具有可读标签
**并且** 状态含义不得只通过颜色、图片、动画或触觉反馈表达。

**假如** 动作目录在后续 App 版本中更新
**当** 历史事实或计划仍引用旧目录版本
**那么** 原有动作 ID 和版本来源必须继续保留
**并且** 系统不得使用新目录静默改变历史动作的含义。

**假如** Story 1.5 完成
**当** 检查其实现范围
**那么** 它只包含版本化动作目录、搜索与详情界面、支持边界、概念说明和相应测试
**并且** 不包含自动动作识别、替代动作推荐、AI 计划生成、训练分析或远程媒体下载。

**追踪范围：** FR-049、FR-050、FR-052、FR-053；AD-6、AD-12；UX-DR17；NFR-REC-002。

### Story 1.6: 创建本地训练计划并从固定快照开始 iPhone 训练

作为一名训练者，
我希望不依赖 AI 或网络就能创建、选择并开始一个训练计划，也可以直接开始自由训练，
从而即使其他高级功能不可用，我仍然可以在 iPhone 上完成核心训练流程。

**验收标准：**

**假如** 用户没有可用的训练计划
**当** 用户选择创建本地计划
**那么** 用户可以设置计划名称、训练日顺序、规范动作、计划组数、次数或次数范围、计划重量及可选目标 RPE
**并且** 动作必须引用 Story 1.5 的规范动作 ID 与目录版本
**并且** 创建计划不依赖 AI、账号、Apple Health 或网络。

**假如** 用户编辑现有计划
**当** 用户保存修改
**那么** 系统必须创建新的计划修订，而不是覆盖旧修订
**并且** 保存必须通过 Story 1.4 的原子事务完成
**并且** 保存失败时，原有生效计划保持不变，用户输入仍可继续修改或重试。

**假如** 计划缺少必要字段、包含无效单位或引用未解决的动作
**当** 用户尝试保存或开始训练
**那么** 系统必须在对应字段附近显示明确错误
**并且** 不得猜测缺失内容或把无效计划表示为可开始
**并且** 用户可以返回动作目录解决映射，或者保留为尚未完成的草稿。

**假如** 用户从计划列表选择一个有效计划
**当** 用户查看开始前的计划详情
**那么** 应用必须展示动作顺序、组数、次数、计划重量和可选目标 RPE
**并且** 明确显示当前生效修订及其状态
**并且** 用户必须主动点击开始，查看计划本身不得创建训练场次。

**假如** 用户开始一个计划训练
**当** 开始操作在本地成功提交
**那么** 系统必须创建稳定的 Workout Session ID
**并且** 保存一个不可变的 Start snapshot，其中包含所选计划修订、动作目录版本、动作顺序、组数、次数、计划重量和可选目标 RPE
**并且** 只有提交成功后，界面才进入进行中的训练状态。

**假如** 用户开始自由训练
**当** 开始操作在本地成功提交
**那么** 系统必须创建稳定的自由 Workout Session ID
**并且** 明确标记该场次没有计划快照
**并且** 用户可以随后从规范动作目录选择要记录的动作
**并且** 不得为了开始自由训练而要求先创建计划。

**假如** 同一个开始操作因为界面重复点击、应用重试或恢复而再次提交
**当** 系统收到相同的幂等标识
**那么** 必须返回原有 Workout Session
**并且** 不得创建重复场次或第二个 Start snapshot。

**假如** 当前记录设备上已经存在未结束的训练场次
**当** 用户尝试开始另一个场次
**那么** 应用必须先展示现有场次及其状态
**并且** 允许用户返回并继续处理现有场次
**并且** 不得静默结束、替换或合并现有场次。

**假如** 用户在训练开始后修改原训练计划
**当** 正在进行的场次再次显示计划内容
**那么** 该场次继续使用开始时保存的不可变快照
**并且** 后续计划修改只影响未来尚未开始的训练
**并且** 系统不得把后续计划修改伪装成当前场次原本的计划。

**假如** 计划训练已经开始但还没有完成任何组
**当** 系统检查计划内容与实际训练事实
**那么** Start snapshot 只代表计划内容，不得自动生成 Actual Set
**并且** 后续实际动作、次数、重量和 RPE 必须与计划字段分开保存。

**假如** Story 1.6 完成
**当** 检查其实现范围
**那么** 它只包含本地计划草稿与修订、计划选择、自由训练入口、Workout Session 身份及不可变 Start snapshot
**并且** 不包含 Actual Set 录入、训练完成、Watch 传输、AI 计划生成、替代动作推荐或训练分析。

**追踪范围：** FR-001、FR-028、FR-029；AD-2、AD-3、AD-4；S1 独立可用的纯手机训练入口。

### Story 1.7: 在 iPhone 上可靠记录每一个实际训练组

作为一名训练者，
我希望能够快速记录自己实际完成的动作、次数和重量，
从而训练记录反映我真正做了什么，而不是简单复制训练计划中的内容。

**验收标准：**

**假如** 用户正在进行计划训练
**当** 用户准备记录某个动作的第一组
**那么** 系统必须从不可变 Start snapshot 预填该组的计划重量
**并且** 清楚表明这是计划提供的默认值，而不是已经确认的实际重量
**并且** 用户可以在保存前修改该重量。

**假如** 用户正在进行自由训练，并且该动作存在历史 Actual Set
**当** 用户准备记录第一组
**那么** 系统可以预填该动作最近一次有效的 Actual Load
**并且** 显示该数值来自历史记录
**并且** 不得使用计划重量、AI 建议或无法确定来源的数值冒充历史实际重量。

**假如** 用户正在进行自由训练，但该动作没有可用的历史 Actual Load
**当** 用户准备记录第一组
**那么** 系统必须要求用户输入实际重量或选择适用的无重量类型
**并且** 不得自动猜测外部负重。

**假如** 用户已经保存同一动作的上一组
**当** 用户开始填写下一组
**那么** 系统默认沿用上一组已保存的 Actual Load
**并且** 用户仍可修改当前组
**并且** 修改当前组不得反向改变之前已经保存的组。

**假如** 用户记录一个实际训练组
**当** 系统准备创建 Actual Set
**那么** 必须保存稳定的 Actual Set ID、Workout Session ID、规范动作 ID 与目录版本、组次顺序、实际次数、Actual Load、时间、来源和完整性状态
**并且** Actual Load 必须保留用户输入的原始数值与 kg/lb 单位
**并且** 在适用时区分 total、per-side、bodyweight、assisted、unloaded、timed 或其他不可直接比较的负重类型。

**假如** 当前功能允许记录用户手动输入的 RPE
**当** 用户为该组输入 RPE
**那么** 系统必须把它保存为用户提供的 Actual RPE，并保留来源
**并且** 不得把用户输入表示为模型估算
**并且** 未启用或未填写 RPE 时必须保留明确状态，而不是自动补值。

**假如** 计划内容与用户实际完成的动作、次数、重量或 RPE 不同
**当** Actual Set 被保存
**那么** 系统必须分别保存计划字段和实际字段
**并且** 不得修改 Start snapshot 来掩盖差异
**并且** 实际训练事实以用户确认并成功提交的值为准。

**假如** 用户点击“完成本组”
**当** Actual Set、对应 revision、outbox event 和 invalidation 尚未全部提交
**那么** 界面不得显示该组已保存
**并且** 提交失败时必须保留用户输入并显示可重试错误
**并且** 只有 Story 1.4 的原子事务成功后，该组才能显示为已完成。

**假如** 用户重复点击“完成本组”，或应用重试相同保存请求
**当** 请求携带相同的幂等标识
**那么** 系统必须返回原来的 Actual Set
**并且** 不得创建重复组、重复 revision 或重复待发送事件。

**假如** 用户使用 VoiceOver、放大字体或减少动态效果
**当** 输入或确认次数、重量及单位
**那么** 每个字段、默认值来源、错误和保存状态必须具有可读标签
**并且** 关键操作不依赖颜色、滑动手势、动画或触觉反馈才能完成。

**假如** Story 1.7 完成
**当** 检查其实现范围
**那么** 它只包含完整 Actual Set 的手动输入、重量默认规则、结构化保存及相应测试
**并且** 不包含已保存事实的纠错、缺失字段恢复、训练结束、Watch 录入、自动动作识别、自动次数识别或 AI 下一组建议。

**追踪范围：** FR-002、FR-003、FR-016、FR-017、FR-018、FR-019、FR-029；AD-2、AD-4；SM-PRES-001。

### Story 1.8: 纠正进行中的训练记录并保留不完整信息

作为一名训练者，
我希望能在训练过程中修正填错、漏记或多记的训练组，同时保留暂时无法确认的信息，
从而记录出现问题时可以修复，而不会覆盖原始事实或假装数据已经完整。

**验收标准：**

**假如** 用户发现已保存训练组的次数、重量或手动 RPE 有误
**当** 用户提交修改
**那么** 系统必须创建新的修订，而不是覆盖原值
**并且** 新修订只改变用户明确修改的字段
**并且** 原值、原来源和修改历史必须继续保留。

**假如** 用户发现某个 Actual Set 使用了错误的规范动作
**当** 用户选择正确动作并确认修改
**那么** 系统必须通过新的修订更改动作引用
**并且** 保留原有的组次顺序、次数、重量、RPE 状态和时间
**并且** 记录修改前后的规范动作 ID、目录版本和用户修改来源。

**假如** 用户漏记了一个实际训练组
**当** 用户在正确位置补录该组
**那么** 系统必须创建具有稳定 ID 的新 Actual Set
**并且** 明确保存它在场次中的顺序和“用户补录”来源
**并且** 不得修改相邻训练组的原始事实。

**假如** 用户误记了一个不存在的训练组
**当** 用户确认删除
**那么** 系统必须创建可审计的删除修订
**并且** 不得直接从数据库中物理清除原始训练组
**并且** 被删除组不得继续计入有效训练事实。

**假如** 两个实际训练组应当合并为一个组
**当** 用户确认合并并提供最终字段
**那么** 系统必须创建明确引用两个源训练组的新修订关系
**并且** 两个源训练组及其来源继续保留在审计历史中
**并且** 有效结果只能计为一个 Actual Set。

**假如** 一个实际训练组应当拆分为两个组
**当** 用户确认拆分并分别补全字段
**那么** 系统必须创建两个具有稳定 ID 的结果组，并引用原始训练组
**并且** 原始组不得继续作为有效组重复计数
**并且** 重试相同拆分操作不得再次创建更多训练组。

**假如** 一个组缺少动作、次数、重量类型或其他必要字段
**当** 用户暂时无法确认完整信息
**那么** 系统必须把可恢复内容保存为可见的 `pending` Actual Set
**并且** 明确标出缺少哪些字段
**并且** 不得猜测缺失值、隐藏该组或将它显示为完整。

**假如** 用户准备补全一个 `pending` Actual Set
**当** 用户填写并成功提交所有必要字段
**那么** 系统必须创建新的解决修订并将该组变为完整
**并且** 保留之前的不完整状态和来源
**并且** 不得创建重复 Actual Set。

**假如** 同一字段存在两个无法安全自动合并的用户修订
**当** 系统计算有效训练事实
**那么** 该字段必须保持 `conflicted` 或 `pendingResolution`
**并且** iPhone 必须展示两个值及其来源，让用户明确选择
**并且** 不得使用设备时间、到达顺序或最后写入规则静默选择结果。

**假如** 用户解决一个修订冲突
**当** 用户确认应当生效的内容
**那么** 系统必须创建引用全部冲突 heads 的新 resolution revision
**并且** 未被选择的修订仍保留在审计历史中
**并且** 重复提交相同解决操作必须返回原结果。

**假如** 一项纠错会影响后续分析或计划建议
**当** 纠错成功提交
**那么** 系统必须同时创建对应的失效记录
**并且** 尚未重新计算的派生结果保持可见的 `pending` 或 `stale` 状态
**并且** 不得继续把旧派生结果表示为最新结果。

**假如** 任一纠错、补录、删除、拆分、合并或冲突解决提交失败
**当** 原子事务回滚
**那么** 之前有效的训练事实保持不变
**并且** 用户本次输入仍然可见并可重试
**并且** 界面不得显示纠错成功。

**假如** Story 1.8 完成
**当** 检查其实现范围
**那么** 它只处理进行中 iPhone 训练的纠错、补录、删除、拆分、合并、待确认字段和冲突解决
**并且** 不包含结束训练、训练结束后的纠错界面、Watch 恢复、自动识别或 Analysis 计算。

**追踪范围：** FR-007、FR-046、FR-061、FR-062；AD-2、AD-3、AD-11；SM-PRES-001。

### Story 1.9: 手动结束 iPhone 训练并审核实际结果

作为一名训练者，
我希望由自己决定何时结束训练，并立即查看和修正本次实际记录，
从而系统不会擅自结束训练，也不会把不完整或错误的数据当成最终结果。

**验收标准：**

**假如** 用户正在进行训练
**当** 用户主动选择“结束训练”
**那么** 系统必须显示结束确认
**并且** 只有用户明确确认后才可以结束场次
**并且** 空闲时间、应用进入后台或其他推测不得自动结束训练。

**假如** 当前训练不存在未解决的必要字段
**当** 用户确认结束并且本地事务成功提交
**那么** Workout Session 必须变为 `completed`
**并且** 完成修订、outbox event 和相关失效记录必须在同一个事务中提交
**并且** 只有提交成功后，界面才能显示训练已经完成。

**假如** 当前训练仍包含 `pending`、`conflicted` 或缺少必要字段的 Actual Set
**当** 用户选择结束训练
**那么** 应用必须列出尚未解决的项目
**并且** 允许用户返回修改、取消结束或明确选择“以不完整状态结束”
**并且** 不得隐藏、猜测或自动确认这些字段。

**假如** 用户明确选择以不完整状态结束
**当** 完成事务成功提交
**那么** Workout Session 必须保存为明确的 `completedIncomplete` 状态
**并且** 所有可恢复事实、缺失字段和冲突继续保持可见
**并且** 不得把该场次计为完整训练。

**假如** 结束事务失败
**当** 用户仍停留在训练界面
**那么** Workout Session 必须继续保持进行中状态
**并且** 已保存的 Actual Set 和用户尚未提交的输入都不得丢失
**并且** 应用必须显示可重试错误，而不是显示完成成功。

**假如** 用户重复确认结束，或应用重试同一个结束请求
**当** 请求包含相同的幂等标识
**那么** 系统必须返回原有完成结果
**并且** 不得创建第二次完成修订、重复场次或重复待发送事件。

**假如** 训练已经成功结束
**当** 应用显示本次训练结果
**那么** 必须列出所有当前有效的 Actual Set，包括动作、顺序、次数、Actual Load、可用的 RPE 状态和时间
**并且** 必须根据实际完成动作的版本化目录属性展示练到的身体部位
**并且** 不得使用未完成的计划组代替实际训练组。

**假如** 已完成场次包含未知动作映射或不完整 Actual Set
**当** 应用生成结果摘要
**那么** 未知或不完整内容必须继续明确显示
**并且** 身体部位摘要只能计算能够可靠映射的有效 Actual Set
**并且** 不得为了生成完整摘要而猜测动作或字段。

**假如** 用户在训练结束后发现次数、重量、动作、RPE 或组边界有误
**当** 用户从本次训练结果进入纠错
**那么** 系统必须复用 Story 1.8 的修订、补录、删除、拆分、合并和冲突解决规则
**并且** 所有纠错创建可审计的新修订，不得覆盖原始事实
**并且** 纠错不得把已完成场次重新变成进行中场次。

**假如** 训练结束后的纠错成功提交
**当** 系统重新生成本次结果
**那么** 摘要必须使用最新确定有效的修订
**并且** 只重新计算受影响的身体部位和摘要内容
**并且** 依赖旧值的后续 Analysis 或 Plan 提案必须保持 `pending` 或 `stale`，直到后续功能完成重新计算。

**假如** 用户使用 VoiceOver、放大字体或减少动态效果
**当** 查看结束确认、不完整项目或训练结果
**那么** 完成状态、实际训练组、缺失字段和纠错入口必须具有可读标签与可聚焦顺序
**并且** 关键含义不得只依赖颜色、动画或触觉反馈。

**假如** Story 1.9 完成
**当** 检查其实现范围
**那么** 它只包含 iPhone 上的权威手动结束、完整或不完整完成状态、当前场次结果及训练结束后的纠错
**并且** 不包含历史列表、周/月分析、Watch 训练、自动结束询问、Apple Health 写入或 AI 建议。

**追踪范围：** FR-003、FR-004、FR-006、FR-007、FR-029、FR-061、FR-062、FR-063；AD-2、AD-3、AD-11；SM-COMP-001、SM-PRES-001。

### Story 1.10: 在 iPhone 离线或中断后恢复可信训练状态

作为一名训练者，
我希望在没有网络、应用被关闭或设备重启后继续自己的训练，
从而已经可靠保存的训练事实不会丢失、重复或被旧状态覆盖。

**验收标准：**

**假如** iPhone 处于飞行模式、无网络或后端不可用
**当** 用户创建计划、开始训练、记录训练组、纠错或手动结束
**那么** 所有纯手机核心功能必须继续使用本地数据正常工作
**并且** 等待发送的 outbox 状态不得阻塞本地保存
**并且** 应用不得因为无法联网而把已本地提交的事实显示为未保存。

**假如** 用户每次成功开始训练、保存训练组、纠错或更改场次状态
**当** 操作完成本地提交
**那么** 最新可靠状态必须能够在应用重新启动后恢复
**并且** 恢复使用已提交的 revision DAG 和有效事实
**并且** 不得依赖界面内存、设备时间或远程副本决定恢复结果。

**假如** 应用在进行中的训练期间被系统终止或用户关闭
**当** 用户重新打开应用
**那么** 系统必须检测到最近一次可靠保存的活跃 Workout Session
**并且** 展示场次身份、已保存 Actual Set、`pending` 项目和最后可靠状态
**并且** 允许用户选择继续训练、以不完整状态结束或明确丢弃。

**假如** 用户选择继续恢复的训练
**当** 恢复操作完成
**那么** 系统必须继续使用原 Workout Session ID 和原 Start snapshot
**并且** 下一组顺序和重量默认值只能依据已经确定有效的 Actual Set
**并且** 不得新建场次、复制已有组或重新解释原计划。

**假如** 用户明确选择丢弃恢复的训练
**当** 丢弃事务成功提交
**那么** 系统必须创建可审计的场次状态修订
**并且** 只有提交成功后才从进行中入口移除该场次
**并且** 不得通过删除数据库内容来伪装场次从未存在。

**假如** 应用中断时某个训练组只有部分内容可靠写入
**当** 恢复流程能够识别属于同一次记录操作的可恢复内容
**那么** 系统必须保留恰好一个可见的 `pending` Actual Set
**并且** 标明缺失或边界不明确的字段
**并且** 不得静默丢弃片段，也不得从同一事件生成多个组。

**假如** 写入在原子事务提交前中断
**当** 应用重新打开数据库
**那么** 未完成事务必须整体回滚
**并且** 不得把其中任何部分显示为已经保存
**并且** 已存在的最后可靠状态保持不变。

**假如** 相同的持久化事件、恢复操作或待发送事件被重复重放
**当** 系统识别到相同稳定 ID 或幂等标识
**那么** 该事件最多生效一次
**并且** 不得创建重复 Actual Set、重复修订或重复场次
**并且** 不得回退用户在事件之后完成的纠错。

**假如** 事件以延迟或乱序方式重新出现
**当** revision reducer 重新计算有效状态
**那么** 结果必须与相同事件按正常顺序到达时一致
**并且** 缺少 parent 的事件保持 `pendingMissingParent`
**并且** 无法安全合并的事实保持可见冲突，交给用户解决。

**假如** 数据库损坏或不可读取
**当** 恢复流程无法建立可信状态
**那么** 应用必须使用 Story 1.4 的明确恢复状态
**并且** 不得创建空场次、猜测训练内容或静默替换原数据库
**并且** 必须清楚说明当前无法继续恢复。

**假如** 训练包含高频传感器数据或未来产生的本地原始信号
**当** 应用执行普通训练状态恢复
**那么** 核心恢复只能依赖结构化训练事实和修订
**并且** 不得要求完整高频传感器流存在
**并且** 原始信号默认继续保留在本地。

**假如** Story 1.10 完成
**当** 检查其实现范围
**那么** 它完成纯 iPhone S1 的离线使用、中断恢复、部分写入处理和幂等重放测试
**并且** 不包含 Watch–iPhone 传输、多 Watch 并发、云端账号恢复、自动识别或远程同步。

**追踪范围：** FR-003、FR-043、FR-046、FR-047、FR-064～FR-066 的纯手机基础部分；AD-2～AD-5；NFR-RECOV-001、SM-COMP-001、SM-PRES-001；UX-DR3。

### Story 1.11: 把完整且兼容的训练计划可靠送到 Apple Watch

作为一名训练者，
我希望已确认的训练计划能够完整送达配对的 Apple Watch，并清楚看到传送结果，
从而无需在 Watch 上重新建立动作和训练组，也不会使用损坏、过期或不兼容的计划。

**验收标准：**

**假如** iPhone 与 Apple Watch 建立当前有效的配对关系
**当** 两端进行能力协商
**那么** 必须交换并持久保存 `pairingEpoch`、设备 ID、App 版本、schema 版本、动作目录版本及适用的能力版本
**并且** 尚未启用的自动能力必须明确报告为关闭
**并且** 不能因为手动训练不需要自动模型，就阻止兼容的手动计划传送。

**假如** iPhone 上存在一个生效且适合 Watch 的计划修订
**当** 系统准备传送该计划
**那么** 待发送内容必须先写入 iPhone 本地 outbox
**并且** 传输内容必须包含完整计划、修订身份、动作目录依赖、来源、版本和 whole-object digest
**并且** 不得只发送需要 Watch 猜测上下文的零散字段。

**假如** 计划需要分块传输
**当** iPhone 创建传输 manifest
**那么** manifest 必须包含稳定的 message ID、chunk IDs、数量、大小、每块 digest、whole-object digest、因果关系和依赖版本
**并且** 每个 chunk 必须能够被重复发送而不重复应用
**并且** 缺失 chunk 必须可以被明确识别和重试。

**假如** 计划传送尚未完成
**当** 用户在 iPhone 上查看该计划的 Watch 状态
**那么** 应用必须显示待发送、传送中、已收到、已持久保存、已应用或失败原因
**并且** 不得在 Watch 只收到部分内容时显示为“已送达”
**并且** 本地 iPhone 计划和纯手机训练继续正常可用。

**假如** Watch 收到完整计划及全部依赖
**当** Watch 校验 schema、动作目录、大小、每块 digest 和 whole-object digest
**那么** 只有全部校验通过后，才可以在一个本地事务中保存计划及依赖
**并且** 兼容计划必须原子替换 Watch 上此前的 active Plan revision
**并且** Watch 必须返回 `received`、`durablyCommitted` 和 `applied` 确认状态。

**假如** 计划缺块、digest 不匹配、版本不兼容或包含不支持的必要字段
**当** Watch 无法安全应用该计划
**那么** Watch 必须返回明确的 `rejected(reason)` 或继续等待缺失内容
**并且** 保留之前已经可用的完整计划
**并且** 不得应用部分计划、自动省略字段或编造动作映射。

**假如** 相同传输因为断连、超时或重试而重复到达
**当** Watch 收到相同 `(pairingEpoch, sourceDeviceId, messageId)`
**那么** 必须返回之前的处理结果
**并且** 不得重复创建计划修订、重复替换 active Plan 或重复写入依赖。

**假如** 旧设备或已经撤销的配对关系发送计划
**当** Watch 或 iPhone 发现 `pairingEpoch` 已失效
**那么** 该内容必须进入隔离状态
**并且** 不得自动成为可用计划
**并且** 只有明确的恢复或重新配对流程才能处理它。

**假如** Watch 已确认 whole-object `applied`
**当** iPhone 清理本次传输数据
**那么** 清理必须保持 replay tombstone 和先前处理结果
**并且** 不得在 `received` 或 `durablyCommitted` 阶段提前清除唯一传输副本
**并且** 重试旧消息仍不得重复应用。

**假如** Watch 当前没有完整兼容的计划
**当** 用户打开 Watch App
**那么** 必须显示真实的“暂无可用计划”或不兼容原因
**并且** 不得展示部分计划或假装计划已经同步
**并且** 用户仍可返回，不会误启动损坏的训练。

**假如** 用户使用 VoiceOver、放大字体或非触觉提示
**当** 查看计划传送和错误状态
**那么** 每个状态、失败原因和重试操作必须具有可读标签
**并且** 不能只依赖颜色、动画或触觉反馈表达传送结果。

**假如** Story 1.11 完成
**当** 检查其实现范围
**那么** 它只包含配对能力协商、计划与依赖传输、Watch 原子应用、确认状态和失败恢复
**并且** 不包含在 Watch 上开始训练、记录 Actual Set、传感器采集、自动识别或训练结果回传。

**追踪范围：** FR-081；AD-4、AD-5、AD-12～AD-14；NFR-COMPAT-002。

### Story 1.12: 在 Apple Watch 上开始训练并手动记录实际训练组

作为一名训练者，
我希望可以直接在 Apple Watch 上开始计划训练或自由训练，并手动确认每一组的实际数据，
从而即使没有自动识别或暂时连接不到 iPhone，我也能可靠完成训练记录。

**验收标准：**

**假如** Watch 已经保存 Story 1.11 送达的完整兼容计划
**当** 用户查看可开始的计划
**那么** Watch 必须显示计划动作、组数、次数、计划重量和可选目标 RPE
**并且** 明确显示所使用的计划修订与同步状态
**并且** 不得展示尚未完整应用或已经被拒绝的计划。

**假如** 用户在 Watch 上开始计划训练
**当** 开始操作成功提交到 Watch 本地数据库
**那么** 系统必须创建或接纳一个全局唯一的 Workout Session ID
**并且** 保存不可变 Start snapshot、记录设备身份和 `Watch` capture owner
**并且** 只有本地提交成功后才显示训练已经开始。

**假如** iPhone 在开始时可以连接
**当** 两端协调 Workout Session 身份
**那么** Watch 与 iPhone 必须使用同一个稳定的 Workout Session ID
**并且** 重复的开始消息不得创建第二个场次
**并且** Watch 一旦成为 capture owner，iPhone 不得同时为同一场次创建另一套 live Actual Set。

**假如** iPhone 无法连接，但 Watch 已经保存完整兼容计划
**当** 用户在 Watch 上开始训练
**那么** Watch 可以在本地创建全局唯一的 Workout Session ID
**并且** 继续使用缓存计划的不可变 Start snapshot
**并且** iPhone 后续必须原样接纳该身份，不得根据时间新建或合并场次。

**假如** 用户在 Watch 上开始自由训练
**当** 开始操作成功提交
**那么** Watch 必须创建稳定的自由 Workout Session ID，并明确记录不存在计划快照
**并且** 用户可以从本地规范动作目录手动选择当前动作
**并且** 开始自由训练不要求预先选择完整动作列表或连接 iPhone。

**假如** Watch 启动训练运行环境
**当** Workout Session 进入进行中状态
**那么** 必须使用 active `HKWorkoutSession` 和相应 workout processing
**并且** runtime 的开始、暂停、失败和结束状态必须映射到持久化场次状态
**并且** 不得使用 `WKExtendedRuntimeSession` 代替训练运行环境。

**假如** 用户准备记录计划动作的第一组
**当** Watch 显示组录入界面
**那么** 必须从 Start snapshot 预填计划重量
**并且** 清楚标明它只是默认值
**并且** 用户可以修改次数、Actual Load 和适用的手动 RPE。

**假如** 用户记录自由训练的第一组，但 Watch 没有可靠的历史 Actual Load
**当** 用户准备完成该组
**那么** Watch 必须要求用户输入重量或选择适用的无重量类型
**并且** 不得猜测或声称自动感知外部负重。

**假如** 用户已经保存同一动作的上一组
**当** Watch 创建下一组输入
**那么** 默认沿用上一组确定有效的 Actual Load
**并且** 用户可以修改当前组
**并且** 修改当前组不得改变之前已保存的组。

**假如** 用户点击“完成本组”
**当** Watch 创建 Actual Set
**那么** 必须使用 Story 1.7 的稳定身份、单位、负重类型、来源和完整性合同
**并且** Actual Set、revision 和 Watch outbox event 必须在同一个本地事务中提交
**并且** 只有提交成功后才显示该组已经保存。

**假如** 实际次数、重量、动作或 RPE 与计划不同
**当** Watch 保存 Actual Set
**那么** 必须分别保留计划字段和实际字段
**并且** 用户确认的实际输入是权威事实
**并且** 不得修改 Start snapshot 来掩盖计划与实际的差异。

**假如** 保存失败或用户重复点击“完成本组”
**当** Watch 处理相同的幂等请求
**那么** 失败时必须保留输入并提供重试
**并且** 成功请求重复执行时返回原 Actual Set
**并且** 不得创建重复组、重复 revision 或重复 outbox event。

**假如** 自动动作识别、次数识别或 RPE 估算尚未通过对应证据 Gate
**当** 用户进行 Watch 训练
**那么** 完整的手动选择动作、输入次数、修改重量和完成训练组路径必须保持可用
**并且** Watch 不得显示虚假的自动结果
**并且** 自动能力缺失不得阻塞手动训练。

**假如** 用户使用 VoiceOver、较大文字或关闭触觉反馈
**当** 开始训练或填写 Actual Set
**那么** 当前动作、组次、次数、重量、单位、默认来源和保存状态必须具有可读标签
**并且** 关键操作不能只能通过 Digital Crown、滑动、颜色、动画或触觉完成。

**假如** Story 1.12 完成
**当** 检查其实现范围
**那么** 它只包含 Watch 上的计划与自由训练开始、capture ownership、训练 runtime 以及手动 Actual Set 录入
**并且** 不包含中断恢复、结束训练、训练结果回传、自动动作识别、自动次数识别或自动 RPE。

**追踪范围：** FR-001～FR-003、FR-016、FR-018、FR-019、FR-028、FR-029、FR-043；AD-3～AD-5；SM-COMP-001。

### Story 1.13: 在 Watch 中断后恢复、纠错并手动结束训练

作为一名训练者，
我希望 Apple Watch 发生应用退出、设备重启、断连或运行异常后仍能恢复训练，并由我决定继续、纠错或结束，
从而训练事实不会因为设备问题而丢失、重复或被系统擅自补全。

**验收标准：**

**假如** Watch App 被终止、设备重启、发生可恢复的电量中断、sensor interruption 或与 iPhone 断开
**当** 用户重新打开 Watch App
**那么** Watch 必须从本地数据库恢复最近一次可靠保存的活跃 Workout Session
**并且** 使用原 Workout Session ID、capture owner 和不可变 Start snapshot
**并且** 不得要求 iPhone 在线才能恢复。

**假如** Watch 恢复一个活跃场次
**当** 恢复页面显示训练状态
**那么** 必须展示已经保存的 Actual Set、`pending` 项目、当前动作和最后可靠状态
**并且** 允许用户选择继续训练、以不完整状态结束或明确丢弃
**并且** 不得自动选择其中任何一种结果。

**假如** active `HKWorkoutSession` 因系统原因停止或失败
**当** FitnessAI 处理 runtime 状态变化
**那么** 必须把失败、暂停或恢复状态持久映射到 Workout Session
**并且** runtime 失败不得自动把训练标记为正常完成
**并且** 已保存的结构化训练事实继续可用。

**假如** 中断前某次训练组操作只留下可识别的部分内容
**当** Watch 能确定这些内容属于同一个记录事件
**那么** 必须恢复恰好一个可见的 `pending` Actual Set
**并且** 标明缺少或无法确认的字段
**并且** 不得丢弃片段或生成多个重复训练组。

**假如** 用户在 Watch 上发现最近保存的训练组次数、重量、动作或手动 RPE 有误
**当** 用户确认修改
**那么** Watch 必须创建新的可审计修订，而不是覆盖原值
**并且** 未修改字段、原始来源和原始时间继续保留
**并且** 修订与 outbox event 必须原子提交。

**假如** Watch 上出现复杂的拆分、合并或无法安全解决的并发冲突
**当** 小屏界面无法完整表达所有修订
**那么** Watch 必须保持该事实为 `pendingResolution`
**并且** 显示它需要在 iPhone 上处理
**并且** 不得使用到达顺序或设备时间自动选择结果。

**假如** 用户在 Watch 上主动选择“结束训练”
**当** 系统显示结束确认
**那么** 用户必须明确确认才能结束
**并且** 断连、runtime 停止、长时间休息或没有操作不得自动结束场次
**并且** 用户可以取消并继续训练。

**假如** 场次包含未解决的必要字段
**当** 用户确认结束
**那么** Watch 必须列出存在未解决信息
**并且** 允许用户返回修改，或明确选择以 `completedIncomplete` 状态结束
**并且** 不得把不完整场次表示为完整。

**假如** 用户确认正常结束或以不完整状态结束
**当** Watch 本地完成事务成功提交
**那么** 完成状态、revision、outbox event 和相关 invalidation 必须一起保存
**并且** 即使 iPhone 仍然离线，Watch 也可以显示本地完成成功
**并且** 只有本地提交成功后才能结束 workout runtime。

**假如** 用户重复结束操作，或 Watch 在恢复后重新播放同一个完成事件
**当** 系统识别相同幂等标识
**那么** 必须返回原有完成结果
**并且** 不得创建第二个完成修订或重复 Workout Session
**并且** 不得回退已经发生的后续用户纠错。

**假如** 训练已经在 Watch 本地完成
**当** 用户查看本次结果
**那么** Watch 必须显示当前有效的 Actual Set 和根据可靠动作映射得到的训练部位
**并且** 不完整或未解决内容继续明确可见
**并且** 不得用计划组或自动猜测补齐摘要。

**假如** Watch 存储空间不足
**当** 系统需要保护核心训练记录
**那么** 必须优先停止或清理可选的原始信号与自动化数据
**并且** 不得优先删除 Workout Session、Actual Set、revision 或未确认事实
**并且** 无法继续可靠保存时必须在用户下一次提交前明确阻止并说明原因。

**假如** 运行故障测试覆盖应用终止、设备重启、电量或 sensor interruption、断连、部分写入及重复 replay
**当** 比较恢复前后的有效事实
**那么** 每个已可靠保存的事件必须恰好生效一次
**并且** 不得丢失用户纠错、生成重复 Actual Set 或把不完整事实伪装成完整
**并且** 手动继续和手动结束路径始终可用。

**假如** Story 1.13 完成
**当** 检查其实现范围
**那么** 它只包含 Watch 本地恢复、最近训练组纠错、复杂冲突转交、权威手动结束和本地结果
**并且** 不包含向 iPhone 应用完整结果、云端恢复、自动识别、自动 RPE 或遗忘结束提醒。

**追踪范围：** FR-003、FR-004、FR-006、FR-007、FR-043、FR-046、FR-061～FR-066；AD-2～AD-5；NFR-SESSION-001、NFR-SESSION-003、NFR-RECOV-001；UX-DR4。

### Story 1.14: 把 Watch 训练事实恰好一次地应用到 iPhone

作为一名训练者，
我希望 Watch 上已经保存的训练记录能够在重连后完整回到 iPhone，
从而断连、重试、乱序或同时使用多块 Watch 都不会造成训练组重复、丢失或错误合并。

**验收标准：**

**假如** Watch 成功保存开始、Actual Set、纠错、待确认状态或结束事件
**当** 本地事务提交
**那么** 对应结构化事件必须同时进入 Watch 的持久 outbox
**并且** 携带 `pairingEpoch`、source device ID、稳定 message ID、Workout Session ID、revision 因果关系、版本和 digest
**并且** Watch 不需要等待 iPhone 确认才能继续本地训练。

**假如** Watch 与 iPhone 可以即时通信
**当** Watch 尝试回传训练事件
**那么** 在线消息可以用于加速传送
**并且** 持久 user-info 或文件传输必须负责最终可恢复交付
**并且** 即时消息丢失不得导致本地训练事实丢失。

**假如** iPhone 收到一个 Watch 训练对象或事件
**当** iPhone 校验身份、配对 epoch、schema、动作目录、依赖版本和 digest
**那么** 只有全部必要校验通过后，才能把事实、revision、outbox 状态和 invalidation 原子写入 iPhone 数据库
**并且** 必须调用共享 revision reducer 计算有效结果
**并且** 不得由传输适配器自行覆盖已有事实。

**假如** iPhone 正在处理一个传输对象
**当** 处理阶段发生变化
**那么** 必须向 Watch 返回 `received`、`durablyCommitted`、`applied` 或 `rejected(reason)`
**并且** Watch 与 iPhone 都必须保存最近确认状态
**并且** “已收到”不得被当成“已经安全应用”。

**假如** 相同 Watch 事件因为断连、超时或重试而重复到达
**当** iPhone 收到相同 `(pairingEpoch, sourceDeviceId, messageId)`
**那么** 必须返回之前的处理结果
**并且** 该事件对有效事实最多生效一次
**并且** 不得创建重复 Workout Session、Actual Set、revision 或完成记录。

**假如** Watch 事件延迟或乱序到达
**当** iPhone 重新计算 Workout Session
**那么** 结果必须由 revision DAG 的因果关系决定
**并且** 缺少 parent 的事件保持 `pendingMissingParent`，直到依赖到达
**并且** 迟到的旧事件不得回退用户后来在 iPhone 或 Watch 上完成的纠错。

**假如** iPhone 与 Watch 对同一规范字段产生无法安全合并的修改
**当** 两端修订都到达 iPhone
**那么** 必须保留两个用户创作的修订及其来源
**并且** 该字段保持 `conflicted` 或 `pendingResolution`
**并且** iPhone 必须提供 Story 1.8 的明确冲突解决流程，而不是按设备时间选择。

**假如** 两块受支持的 Watch 在断连期间分别开始或恢复训练
**当** 两个场次之后传回同一台 iPhone
**那么** 每个场次必须保留自己的 Workout Session ID、source device ID 和 Start snapshot
**并且** 不得因为时间重叠、动作相同或使用同一个计划而静默合并
**并且** 如果产品需要用户处理并发场次，必须分别展示并让用户明确决定。

**假如** 已撤销的配对 epoch 或旧设备重新发送训练事实
**当** iPhone 检测到来源已经失效
**那么** 内容必须进入隔离状态并保留来源
**并且** 不得自动写入当前有效场次
**并且** 只有明确恢复流程才能重新接纳。

**假如** iPhone 尚未返回 whole-object `applied`
**当** Watch 执行存储清理
**那么** 不得清除唯一的结构化事件、manifest、chunk 或原始文件
**并且** 可以按照有界退避策略继续重试缺失内容
**并且** 断连期间手动训练和本地纠错继续可用。

**假如** iPhone 已返回 whole-object `applied`
**当** Watch 进入传输副本清理流程
**那么** 结构化冗余副本必须至少保留七天安全窗口
**并且** 原始 chunk 只能在 `applied` 后清理
**并且** file、index 与 manifest 的清理必须是原子的、可重试的，并保留 replay tombstone。

**假如** iPhone 已安全应用 Watch 场次
**当** 用户查看该场次结果
**那么** 必须使用 Story 1.9 的实际训练结果和纠错界面
**并且** 展示传送完成、仍在等待、失败或冲突状态
**并且** 未解决事实不得被隐藏或计为已确认。

**假如** 传输遇到缺块、digest 错误、不兼容版本或数据库失败
**当** iPhone 无法安全应用内容
**那么** 必须返回明确失败原因并保留之前有效事实
**并且** Watch 保留可重试副本
**并且** iPhone 与 Watch 的手动训练核心不得因此被阻塞。

**假如** 集成测试模拟断连、重连、重复、延迟、乱序、缺块、应用终止及多 Watch 并发
**当** 比较两端最终有效事实
**那么** 每个已提交用户事件必须恰好生效一次
**并且** 不得丢失用户纠错、生成重复 Actual Set 或错误合并场次
**并且** 两端对相同 revision DAG 产生一致的有效、待确认或冲突状态。

**假如** Story 1.14 完成
**当** 检查其实现范围
**那么** 它只包含 Watch 训练事实回传、iPhone 幂等应用、确认、保留清理、多 Watch 隔离和故障测试
**并且** 不包含账号云同步、AI、Apple Health、自动识别或自动结束提醒。

**追踪范围：** FR-043、FR-046、FR-047、FR-064～FR-066；AD-2～AD-5；NFR-RECOV-001、SM-COMP-001、SM-PRES-001。

## Epic 2: 把获授权的 AI 对话转为获批准的 Plan Revision

训练者可以授权精确的远程数据范围，创建或修改完整的结构化 Plan，解决安全与映射问题，审核每个字段，批准一个与 digest 绑定的 proposal，并原子激活恰好一个 revision；同时，任何失败都会保留之前的 Plan 和手动训练核心。GATE-1 是 prerequisite/evidence Story；GATE-2 和 GATE-3 在关闭前使内置流量与 Health-derived 流量保持技术禁用，同时允许安全脚手架与合格的本地/BYOK 工作继续。

### Story 2.1: 冻结 Safety Rule Pack v1 的数值合同与 Golden Fixtures

作为 Product Owner，
我希望在实现任何 AI Plan 能力之前冻结 Safety Rule Pack v1 的数值边界、判定规则和 Golden Fixtures，
从而实现人员不会自行猜测安全策略，而后续安全检查与 Plan 提交可以依据同一份确定、可审计的合同进行验证。

**验收标准：**

**假如** GATE-1 尚未关闭
**当** Product Owner 尚未提供完整的 Safety Rule Pack v1 决策
**那么** Story 必须保持未完成状态
**并且** 实现人员不得自行补写、推测或采用隐含默认值
**并且** 后续安全相关 AI Plan 实现与全部 proposal commit 必须保持关闭。

**假如** Product Owner 提供 Safety Rule Pack v1 决策
**当** 系统形成冻结的规则清单
**那么** 清单必须至少覆盖单位与数值合法性、日程矛盾、Canonical Exercise 支持状态、训练量、强度、负荷递增、受伤或恢复警示信号，以及允许的明确继续路径
**并且** 每条规则必须拥有稳定的 rule ID、规则版本和简明的非诊断说明
**并且** 不得留下 `TBD`、未定义占位符或依赖实现人员解释的模糊条件。

**假如** 一条规则包含数值或时间边界
**当** 该规则被写入冻结清单
**那么** 必须明确记录输入字段、规范单位、上下限、边界是否包含、适用范围和组合条件
**并且** 必须明确缺失值、不支持单位、异常值及互相矛盾输入的处理方式
**并且** 不得依赖 UI 格式、locale、浮点舍入偶然行为或模型自由文本决定结果。

**假如** 一条规则被触发
**当** 规则清单描述其预期结果
**那么** 结果必须明确属于 `pass`、`clarificationOrCorrectionRequired` 或 `affectedScopeStop`
**并且** 必须指出受影响的 Plan scope、触发原因和允许的下一步操作
**并且** 受影响范围以外的内容不得因为一个局部问题被无依据地扩大阻断。

**假如** 某个安全问题允许用户继续
**当** 规则定义 allowed continuation
**那么** 必须明确继续所需的用户动作、需要补充或纠正的信息，以及继续后仍然禁止的范围
**并且** 普通确认、通用免责声明或继续使用应用不得替代规定的明确 continuation
**并且** 产品不得把该流程描述为诊断或医疗建议。

**假如** 规则依赖 Exercise Catalog、Plan schema、单位合同或其他策略输入
**当** Safety Rule Pack v1 被冻结
**那么** 必须记录每项依赖的版本或 digest
**并且** 规则包自身必须拥有规范版本、生成时间、所有者和完整内容 digest
**并且** 任何相关依赖变化都必须产生新规则包版本，而不是静默改变 v1。

**假如** Golden Fixture Corpus 被建立
**当** 检查其覆盖范围
**那么** 每类规则必须至少包含正常通过、恰好位于边界、边界内外相邻值、缺失或不支持输入，以及应要求纠正或停止的案例
**并且** 涉及多字段关系的规则必须包含矛盾组合案例
**并且** 每个 fixture 必须声明输入、冻结依赖版本、预期 rule ID、预期结果、受影响范围及允许的下一步。

**假如** 同一 fixture 被不同实现或在不同运行中求值
**当** 比较预期结果
**那么** 相同规范输入必须得到完全一致的结果
**并且** 输入字段顺序、设备 locale 或无关字段不得改变判定
**并且** fixture 必须能够被后续纯 domain Safety evaluator 的自动化测试直接消费。

**假如** Safety Rule Pack v1 的清单或 fixture 内容发生任何修改
**当** 修改被保存
**那么** 必须产生新的版本与 digest
**并且** 旧版本保持可审计且不得被覆盖
**并且** 依赖旧版本产生的后续测试证据、proposal review 或 approval 不得被表示为仍对新版本有效。

**假如** GATE-1 的前置输入已完整冻结
**当** Story 2.1 接受验收
**那么** 必须产出并登记三个明确的受控工件：`Safety Rule Pack v1 Manifest`、`Safety Rule Pack v1 Golden Fixture Corpus` 和 `GATE-1 Decision Record`
**并且** Decision Record 必须记录 Product Owner、版本、digest、覆盖范围、仍待完成的 evaluator/evidence 工作及当前 Gate 状态
**并且** 完成此 Story 只表示 GATE-1 前置输入已经冻结，不得声称 evaluator 已实现、证据已通过或 proposal commit 已启用。

**假如** 产品仅进入 Product Owner 测试
**当** 后续确定性实现和证据满足 GATE-1
**那么** 专业评审仍必须被记录为“发布到 Product Owner 测试之外”的独立未决条件
**并且** 不得通过本 Story 的完成状态暗示该专业评审已经发生
**并且** 未获得专业评审不得被包装为面向更广用户的安全发布结论。

**假如** GATE-1 仍然开放、失败或材料不完整
**当** 用户使用现有本地产品能力
**那么** 手动创建或选择 Plan、手动训练、纠错和本地记录必须继续可用
**并且** 不得因为 AI 安全规则尚未就绪而阻断 Epic 1 的手动核心
**并且** 界面不得显示虚假的 AI proposal 可提交状态。

**假如** 检查 Story 2.1 的实现范围
**当** 确认其是否适合单个开发 Agent 完成
**那么** 它只包含把 Product Owner 已批准的规则决策固化为版本化 Manifest、Golden Fixtures、Decision Record 和默认关闭的 Gate 登记
**并且** 不包含 Safety evaluator 实现、AI 对话、Provider 接入、远程发送、proposal review、approval 或 Plan Revision commit
**并且** 实现 Agent 不得代替 Product Owner 作出数值安全决策。

**追踪范围：** FR-087；GATE-1 prerequisite；AD-7、AD-13；NFR-SAFE-001、NFR-AI-006；UX-DR10、UX-DR17、UX-DR19。

### Story 2.2: 实现确定、缩限关闭的 Safety Evaluator

作为一名训练者，
我希望每个结构化 Plan 在生成后和提交前都接受同一套确定性安全检查，
从而不完整、矛盾或触发安全边界的内容不会悄悄生效，同时安全检查失败也不会阻断手动本地训练。

**验收标准：**

**假如** Story 2.1 已冻结 Safety Rule Pack v1
**当** 纯 domain evaluator 初始化
**那么** 必须校验 Manifest、fixture corpus、版本、依赖 digest 与支持的规则类型
**并且** 缺失、不匹配或未知材料必须缩限关闭，而不是被跳过。

**假如** 存在一个规范且不可变的 Plan safety snapshot
**当** 在 `postGeneration` 或 `preCommit` 阶段执行求值
**那么** 必须评估所有适用规则，并记录 stage、input digest、rule-pack version/digest、依赖版本和稳定排序的逐规则结果
**并且** provider prose、chain-of-thought、locale、当前时间和 UI 文字不得决定结果。

**假如** 规则通过、要求纠正或停止某个受影响范围
**当** 汇总结果
**那么** outcome 必须严格为 `pass`、`clarificationOrCorrectionRequired` 或 `affectedScopeStop`
**并且** 必须列出 rule ID、原因、规范字段、受影响范围及任何与版本绑定的 allowed continuation
**并且** 不得修改 Plan，也不得在没有冻结规则依据时扩大停止范围。

**假如** 必要输入缺失、不受支持、互相矛盾或 evaluator 执行失败
**当** 无法产生完整结果
**那么** status 必须明确为 incomplete 或 failed，且 commit eligibility 为 false
**并且** 任何 fallback、重试、异常处理或通用确认都不得伪造 `pass`。

**假如** 相同规范输入和冻结版本被重复求值
**当** 比较结果与 digest
**那么** 无论字段顺序、locale、进程重启或设备如何，必须逐字节稳定
**并且** 任何输入或依赖版本变化都使之前的结果不得复用。

**假如** Story 2.1 golden corpus 在自动化测试中运行
**当** 将实际输出与每个预期边界、矛盾、缺失输入和停止案例比较
**那么** 每个 rule ID、outcome、scope 和 continuation 必须匹配
**并且** 任何不匹配都会使本 Story 失败，同时 GATE-1 和所有 proposal commit 继续禁用。

**假如** evaluator 实现完成
**当** 检查 GATE-1 状态
**那么** 只能记录 `deterministicEvaluatorImplemented`，并在独立证据记录获批准前保持默认关闭
**并且** 任何 evaluator 失败时，现有 Plan、手动训练、纠错和本地记录继续可用。

**假如** 检查 Story 2.2 范围
**当** 评估单个 Agent 尺寸
**那么** 它只包含 safety input 映射、纯规则执行、结构化结果、fail-closed eligibility 和 golden tests
**并且** 不包含 AI UI、provider、远程授权、proposal review、approval、commit 和 Gate 启用。

**追踪范围：** FR-058、FR-087；GATE-1 implementation；AD-7、AD-13；NFR-SAFE-001、NFR-AI-001、NFR-AI-006；UX-DR10、UX-DR17、UX-DR19。

### Story 2.3: 记录 GATE-1 证据并启用符合安全条件的 Proposal 工作

作为 Product Owner，
我希望有一份与版本绑定的 GATE-1 证据记录，独立证明 evaluator 与冻结规则一致，
从而符合安全条件的 proposal 工作可以继续，而不会把一句实现状态声明当成证据。

**验收标准：**

**假如** Stories 2.1 和 2.2 已完成
**当** 组装所属的 `GATE-1 Safety Rule Pack Evidence Record`
**那么** 必须列出 Manifest、fixture corpus、evaluator build、schema/catalog/unit 版本、digests、owners、执行环境和时间戳
**并且** 必须嵌入或链接不可变的机器可读测试输出，而不是只声称测试通过。

**假如** 证据测试执行
**当** 评估阈值
**那么** 100% 冻结 golden fixtures 和必需规则类别必须精确匹配，且跳过、隔离或手工覆盖案例为零
**并且** 确定性重复测试和 fail-closed 故障测试必须通过。

**假如** 证据不完整、不匹配、过期或失败
**当** 计算 Gate 状态
**那么** GATE-1 必须保持禁用并给出字面原因
**并且** proposal commit 继续不可能，而 proposal/schema/review 脚手架与手动本地训练继续可用。

**假如** 所有 owner-testing 证据通过
**当** Product Owner 明确接受精确 evidence digest
**那么** GATE-1 只能针对冻结版本和 Product Owner 测试范围启用
**并且** 任何版本变更都会自动再次关闭，并使依赖安全结果与 approval 失效。

**假如** 考虑发布到 Product Owner 测试之外
**当** 缺少或未通过合格的运动/健康专业评审
**那么** 证据记录必须把该发布条件显示为 open
**并且** 不得把 owner-testing 证据表示为专业安全批准。

**假如** 检查 Story 2.3 范围
**当** 审核其实现
**那么** 它只包含证据捕获、精确阈值、Gate 转换、失效处理和默认禁用强制
**并且** 不包含 AI 对话、provider 流量、proposal approval 和 Plan commit 实现。

**追踪范围：** FR-087；GATE-1 evidence and enabling；AD-7、AD-13；NFR-SAFE-001、NFR-AI-002、NFR-AI-006。

### Story 2.4: 保留不可变、非生效的 AI Proposals

作为一名训练者，
我希望 AI draft 和 revision 在我明确批准前一直是可识别、可审核的 proposal，
从而对话、重新生成、拒绝或延迟事件绝不会改变我的活跃 Plan。

**验收标准：**

**假如** AI create 或 revise 操作开始
**当** 分配 proposal identity
**那么** 必须获得不可变 `proposalId`、target、base revision、creation time、provenance、permitted scope、assumptions、schema/model/rule-pack versions 和 canonical digest
**并且** identity 必须在持久化或传输之前存在。

**假如** proposal 内容通过澄清或重新生成改变
**当** 生成新的结构化内容
**那么** 必须创建新的不可变 proposal identity 和 digest
**并且** 旧 proposal 保持可审计，且不得继承 approval。

**假如** proposal 处于 draft、rejected、expired、invalid 或 under review
**当** 归约有效 Plan state
**那么** proposal 对活跃 Plan、history 或 active Workout Sessions 没有任何影响
**并且** 拒绝不需要补偿性 Plan write。

**假如** 重复、延迟、重试或乱序 proposal events 到达
**当** lifecycle reducer 处理它们
**那么** 稳定 event identity 和因果关系必须使处理幂等
**并且** 旧状态不得回退后来的 rejection、replacement、approval consumption 或 commit result。

**假如** proposal 内容无法表示为完整 typed structure
**当** 它被保存
**那么** status 必须明确为 incomplete 或 invalid，并在允许时保留 raw-provider provenance
**并且** 纯 prose 内容绝不得表示为完整 Plan Draft。

**假如** 检查 Story 2.4 范围
**当** 评估单个 Agent 尺寸
**那么** 它包含 proposal identity、schema-neutral lifecycle states、digests、persistence mapping 和 reducer tests
**并且** 不包含 provider calls、authorization UI、safety UI、approval 和 effective Plan commit。

**追踪范围：** FR-078、FR-083、FR-084；AD-2、AD-7；NFR-AI-002、NFR-AI-005。

### Story 2.5: 建立相互隔离且内置流量禁用的 AI Provider Routes

作为一名训练者，
我希望在允许任何真实内置流量前，AI provider routes 已经相互隔离且可控，
从而我可以在不泄露内容、不把产品绑定到未批准 route 的前提下测试 proposal 行为。

**验收标准：**

**假如** AI domain 请求生成
**当** 它调用 provider
**那么** 必须使用带 typed request/result/error contracts 的 provider port
**并且** domain code 不得依赖 DeepSeek SDK、HTTP、credential 或 vendor-response。

**假如** 本地开发或 contract tests 运行
**当** 选择 fake provider
**那么** 必须在没有网络和 secrets 时可重现确定的 complete、invalid、timeout、duplicate 和 reordered responses
**并且** 不得联系任何 production route。

**假如** 用户提供 device-local BYOK credential
**当** 配置 BYOK adapter
**那么** secret 必须保留在 non-synchronizing Keychain，绝不进入 logs 或 proposal 内容，并使用 route-specific pseudonymous identity
**并且** 切换 route 或 account 必须开始新 identity，且不得复用 conversation history。

**假如** GATE-2 开放时已存在 built-in gateway adapter
**当** 任何代码尝试真实 built-in traffic
**那么** 独立技术 kill switch 必须在内容离开设备前拒绝发送
**并且** UI 必须报告 route 不可用，而不得静默 fallback 到 BYOK 或其他 provider。

**假如** 请求控制已配置
**当** 使用 route
**那么** endpoint allowlists 和 request/time/rate/cost ceilings 必须在 provider prose 之外强制
**并且** audit output 必须不含内容，只包含 route、pseudonymous IDs、versions、status、size class 和 timing。

**假如** 检查 Story 2.5 范围
**当** 审核其内容
**那么** 它包含 provider ports、fake/BYOK adapters、disabled built-in adapter、identity isolation、ceilings、secret handling 和 contract tests
**并且** 不包含 GATE-2 关闭、conversation UI、Health data、proposal approval 和 Plan commit。

**追踪范围：** FR-082、FR-085；GATE-2 enabling；AD-8、AD-13；NFR-PRIV-003、NFR-PRIV-007、NFR-SEC-003、NFR-AI-004。

### Story 2.6: 用可审计的内置 Route 证据记录关闭 GATE-2

作为 Product Owner，
我希望内置 DeepSeek route 只能根据已批准的法务、隐私、安全与运营证据记录启用，
从而真实内置流量不会从未记录的配置或状态声明中启动。

**验收标准：**

**假如** 评估 GATE-2
**当** 创建所属的 `GATE-2 Built-In DeepSeek Route Evidence Record`
**那么** 必须列出 legal entity、runtime provider、processing region、subprocessors、retention/cache、training use、deletion/revocation、disclosure、endpoint、credential owner 和 effective dates
**并且** 记录已批准 request fields 与禁止 categories。

**假如** 记录运营控制
**当** 审核证据
**那么** 必须包含 allowlists、request/time/rate/cost ceilings、key rotation、redacted audit、rollback owner 和 kill switch 的不可变配置 digests
**并且** 包含可执行的反向测试，证明禁止 endpoint、oversized request、缺少授权和 kill-switch 激活时发送内容为零。

**假如** 任何必需决策、测试、owner approval 或当前版本匹配缺失或失败
**当** 计算 Gate 状态
**那么** GATE-2 必须保持禁用并给出精确原因
**并且** fake-provider、合格 BYOK、proposal scaffolding 与手动训练继续可用。

**假如** 所有必需记录与测试通过
**当** Product Owner 批准精确 evidence digest
**那么** built-in traffic 只能针对已记录 endpoint、fields、ceilings、versions、region 和 validity window 启用
**并且** 任何重大证据/配置变化都会自动禁用 route，直到重新批准。

**假如** 发生 runtime incident 或 rollback decision
**当** kill switch 被激活
**那么** 新 send 必须在内容 egress 前停止，in-flight status 保持真实，且最后确认 Plan 继续可用
**并且** 禁用 route 不得禁用 BYOK 或本地手动记录。

**假如** 检查 Story 2.6 范围
**当** 审核其内容
**那么** 它包含 evidence artifact、精确阈值、negative tests、version-bound enablement、expiration 和 rollback
**并且** 不包含 Health-derived remote approval 和普通 conversation behavior。

**追踪范围：** FR-082、FR-085；GATE-2 prerequisite evidence and traffic enablement；AD-8、AD-13；NFR-PRIV-007、NFR-SEC-003、NFR-AI-004。

### Story 2.7: 授权一次精确的远程 AI 发送

作为一名训练者，
我希望为一次远程 AI 请求授权精确的数据类别与时间窗，
从而通用 app consent、Health 权限或之前的对话绝不会授权新的远程使用。

**验收标准：**

**假如** 远程 AI request 已准备
**当** 显示 authorization
**那么** 必须列出 purpose、provider/route、selected data categories、source window、transformations、retention/training policy、destination、request digest 和 expiry
**并且** 未选字段和完整 raw motion/heart-rate 绝不得出现在 payload 中。

**假如** authorization 默认关闭
**当** 用户查看、关闭或编辑 preview
**那么** 不得发送内容，也不得消耗 authorization
**并且** 精确选择必须支持 VoiceOver、Dynamic Type、keyboard 和非颜色语义。

**假如** 用户明确授权精确 preview
**当** send transaction 开始
**那么** 必须原子匹配并消耗一个绑定 route、categories、window、request digest 和 expiry 的 authorization token
**并且** retry 不得扩大 scope 或创建第二个获授权的逻辑请求。

**假如** payload、provider route、policy version、source data、selected category 或 digest 变化
**当** 检查 send eligibility
**那么** 之前授权必须失效，且要求新 preview
**并且** 任何通用确认或 HealthKit permission 都不得替代。

**假如** 用户在消耗前撤销，或 token 过期
**当** 尝试 send
**那么** 必须在 egress 前失败并给出字面原因
**并且** content-free audit 只记录 IDs、versions、categories、digest、status 和 timing，不记录 content、secret 或 chain-of-thought。

**假如** 检查 Story 2.7 范围
**当** 审核其内容
**那么** 它包含 preview、affirmative one-shot authorization、atomic consumption、invalidation、revocation 和 redacted audit
**并且** 不包含 Health summary 创建、AI conversation content、proposal approval 和 Plan commit。

**追踪范围：** FR-086；AD-8、AD-14；NFR-PRIV-007、NFR-SEC-003；UX-DR2、UX-DR10、UX-DR12～UX-DR15、UX-DR18。

### Story 2.8: 在 GATE-3 缩限关闭时预览 Health-Derived AI Scope

作为一名训练者，
我希望 Health-derived AI 数据在证据 Gate 关闭前保持独立可见且禁用，
从而我可以理解可能的请求，却不会意外发送健康信息。

**验收标准：**

**假如** GATE-3 处于 open
**当** 显示 AI authorization surface
**那么** Health-derived categories 必须默认关闭，且与 goals、Plan、confirmed workout facts 和 concise feedback 视觉分离
**并且** preview 必须声明 local Health capability 与 remote Health use 是不同的权限。

**假如** 不存在合格的 local Health summary
**当** 用户打开 preview
**那么** UI 必须显示 unavailable 或 not selected，不得从 raw data 推测值
**并且** AI without Health 和 manual Plan use 继续可用。

**假如** GATE-3 开放时选择 synthetic 或未来合格的 local summary
**当** 用户审核精确 field mapping
**那么** preview 可以显示 category、source window、transformation 和 request field
**并且** 即使用户确认，每次 real send 也必须在 egress 前被拒绝。

**假如** 代码尝试绕过 preview 或复用 non-Health authorization
**当** remote boundary 分类 payload fields
**那么** 任何 Health-derived field 都必须同时具备 matching one-shot token 和 enabled GATE-3 evidence digest
**并且** 缺少分类必须缩限关闭。

**假如** 检查 Story 2.8 范围
**当** 审核其内容
**那么** 它包含 default-off Health rows、exact mapping preview、field classification 和 zero-egress Gate enforcement
**并且** 不包含 HealthKit reads、local summary computation、GATE-3 evidence closure 和 real Health-derived sending。

**追踪范围：** FR-082、FR-086；GATE-3 authorization/fail-closed preview；AD-8、AD-9、AD-14；NFR-HK-001、NFR-PRIV-007；UX-DR2、UX-DR7、UX-DR12。

### Story 2.9: 通过受限文本对话收集 Plan Intent

作为一名训练者，
我希望在受限文本对话中描述训练目标和约束，
从而 AI 可以准备 Plan，而不会隐藏缺失信息、假设或远程使用范围。

**验收标准：**

**假如** 用户开始 Plan creation 或 revision
**当** text intake 打开
**那么** 必须收集 goals、experience、availability、session duration、equipment、preferences 和 mandatory limitations
**并且** 区分 confirmed user input、prior allowed facts、assumptions 和 unanswered required fields。

**假如** 必需信息缺失或互相矛盾
**当** 对话继续
**那么** 系统必须进行受限澄清并保持 gaps 可见
**并且** 不得伪造 constraints 或产生 complete-draft status。

**假如** 用户重新生成、继续、取消或拒绝
**当** conversation state 变化
**那么** 输入必须根据选定动作保留，同时 active Plan 保持不变
**并且** conversation text 不得隐含 proposal、approval 或 remote authorization。

**假如** 请求 remote turn
**当** 准备 payload
**那么** 只能包含 FR-082 允许来源和 Story 2.7 精确授权字段
**并且** 必须排除 raw sensor streams、unselected Health categories、unrelated history、secrets 和 chain-of-thought。

**假如** remote AI 不可用、超时或返回无效内容
**当** 用户返回对话
**那么** 输入文字和最后确认 Plan 必须保持可用，并提供 retry、edit 或 cancel
**并且** 本地 workout capture 不得被阻断。

**假如** accessibility 和 layout settings 变化
**当** 使用 conversation
**那么** 必须支持 light/dark、large Chinese text、VoiceOver、keyboard avoidance、error focus 和 input-preserving Retry，且无水平滚动。

**追踪范围：** FR-054、FR-082、FR-083、FR-085；AD-7、AD-8、AD-14；NFR-AI-004；UX-DR2、UX-DR10、UX-DR13～UX-DR15、UX-DR18～UX-DR19。

### Story 2.10: 请求受证据限定的 Plan Revision

作为一名训练者，
我希望使用仅允许的可靠证据和简洁反馈明确请求 Plan review，
从而 AI 建议会披露它使用了什么，也绝不会把不确定或被排除的记录重新解释为事实。

**验收标准：**

**假如** 用户明确请求 review
**当** 准备 evidence selection
**那么** 只有 confirmed 或 corrected effective workout records、active Plan/base revision 和用户提供的 concise feedback 合格
**并且** pending、conflicted、incomplete、excluded 或 raw high-frequency data 必须被排除，或明确标记为 unavailable。

**假如** 证据已选择
**当** 显示 exact remote preview
**那么** 必须列出 record categories、time window、base revision、exclusions、transformations、assumptions 和 request digest
**并且** 该次单次 send 必须要求 Story 2.7 authorization。

**假如** 证据包含 warning signs 或 safety-sensitive feedback
**当** 评估 revision request
**那么** Story 2.2 safety behavior 必须适用，且任何必需 clarification 或 affected-scope stop 保持明确
**并且** 系统不得作出诊断。

**假如** 用户关闭、拒绝或继续编辑 feedback
**当** 没有 proposal 被批准
**那么** active Plan 和 completed workout facts 必须保持不变
**并且** 不得由 proactive invitation 或之前 authorization 静默发起另一次请求。

**假如** 检查 Story 2.10 范围
**当** 审核其内容
**那么** 它包含 explicit review invocation、evidence selection/exclusion、preview 和 safety handoff
**并且** 不包含 Analysis computation、proactive invitation、proposal approval 和 commit。

**追踪范围：** FR-059、FR-082、FR-083、FR-086；AD-7～AD-9；NFR-AI-005；UX-DR2、UX-DR9、UX-DR12。

### Story 2.11: 验证完整结构化 Plan Draft 与 Exercise Mappings

作为一名训练者，
我希望 AI 输出被转换为带明确映射与假设的完整、已验证 Plan Draft，
从而 prose、未知 Exercise 或局部字段绝不会伪装成可执行 Plan。

**验收标准：**

**假如** provider output 到达
**当** 它进入 untrusted-input boundary
**那么** bounded decoding 必须验证 schema/version、types、counts、units、dates、required fields 和 canonical structure
**并且** prose-only、malformed、oversized、contradictory 或 unknown content 保持 invalid 或要求 clarification。

**假如** 完整 candidate Plan 已解码
**当** 解析 Exercise references 和 equipment
**那么** 每个 Exercise 必须映射到版本化 canonical record，否则保持明确 unmapped
**并且** substitution 必须披露 primary body area、movement pattern、available equipment、secondary/range differences 和 rationale。

**假如** equipment context 在生成前或后添加
**当** draft 被重新生成或修改
**那么** 必须创建新的不可变 proposal 和 digest
**并且** 不得在 active 或 draft Plan 中静默替换 Exercise。

**假如** 所有结构和映射检查通过
**当** 计算 completeness
**那么** draft 必须包含所有 day、session、Exercise、set、repetition、load/unit、optional target RPE state、assumptions、unresolved fields 和 versions
**并且** 任何必需字段或 mapping 未解决时 complete status 必须为 false。

**假如** 完整 draft 已生成
**当** 运行 safety evaluation
**那么** Story 2.2 必须在 `postGeneration` 执行，且完整结果成为不可变 proposal provenance
**并且** validation 或 safety failure 不得改变任何 effective Plan。

**假如** 检查 Story 2.11 范围
**当** 审核其内容
**那么** 它包含 untrusted decoding、complete structured Draft、equipment context、canonical mapping、validation 和 post-generation safety
**并且** 不包含 approval 和 effective commit。

**追踪范围：** FR-055、FR-056、FR-058、FR-078；AD-7；NFR-AI-001、NFR-AI-005～NFR-AI-006；UX-DR2、UX-DR10、UX-DR17、UX-DR19。

### Story 2.12: 解决 Safety Clarifications 与 Affected-Scope Stops

作为一名训练者，
我希望安全与映射问题使用精确的纠正或继续选项呈现，
从而我可以在不接受诊断性声明或隐藏 Plan 变更的情况下解决允许的问题。

**验收标准：**

**假如** proposal 为 `clarificationOrCorrectionRequired`
**当** safety-stop surface 打开
**那么** 必须显示字面规则原因、受影响字段、缺失或无效值、assumptions 和 allowed corrections
**并且** primary action 必须用于纠正或提供信息，而不是批准 proposal。

**假如** proposal 为 `affectedScopeStop`
**当** 显示它
**那么** 必须使用非诊断语言分别标识 stopped 和 unaffected scope
**并且** 只允许冻结的 allowed continuation、edit 或 cancel actions。

**假如** 用户编辑信息或执行 allowed continuation
**当** 形成新 candidate
**那么** 必须创建新 proposal identity/digest，并重新执行 structural validation 与 post-generation safety
**并且** 旧结果与用户动作保持可审计，但不赋予 approval。

**假如** 用户取消或无法解决问题
**当** flow 结束
**那么** 不得改变任何 Plan 字段，且之前的 effective Plan 继续可用
**并且** manual workout capture 继续可用。

**假如** UI 在 VoiceOver、high contrast、Reduce Motion 或 large text 下使用
**当** 错误与动作出现
**那么** focus 必须先到达字面 summary，再到 recovery action，且不截断关键中文文字
**并且** 含义绝不得仅依赖颜色、动效或 haptics。

**追踪范围：** FR-058、FR-083、FR-087；AD-7、AD-14；NFR-SAFE-001、NFR-AI-006、NFR-UX-001；UX-DR2、UX-DR10、UX-DR13～UX-DR15、UX-DR18～UX-DR19。

### Story 2.13: 审核并明确批准一个完整 Proposal

作为一名训练者，
我希望在一次明确批准前审核每个 Plan 字段或 future-scope difference，
从而我准确知道会改变什么，且过期或局部内容无法继承我的同意。

**验收标准：**

**假如** 完整 create proposal 已准备
**当** review 打开
**那么** 每个结构化 Plan field、unit、mapping、assumption、warning、unresolved state、source、versions、Safety result、base、`proposalId` 和 digest 必须可访问
**并且** 任何 collapsed section 都不得向 approval 隐藏重要内容。

**假如** revision proposal 已准备
**当** 显示 diff
**那么** 必须包含每个 addition、removal、changed value/unit 和受影响 future session
**并且** 必须明确声明 completed history 和 active Workout Sessions 位于 mutation scope 之外。

**假如** 存在 unresolved、invalid、incomplete、stopped、stale-base 或 failed-safety content
**当** 计算 approval eligibility
**那么** approval 必须禁用并给出字面 recovery reason
**并且** review 绝不得显示乐观 success。

**假如** 用户选择独立 approval action
**当** confirmation surface 出现
**那么** consent 必须绑定精确 unconsumed `proposalId`、displayed digest、base revision、schema/model/rule-pack/policy versions 和 permitted scope
**并且** 任何相关变化都必须在 commit 前使 consent 失效。

**假如** 用户拒绝、关闭、重新生成或继续对话
**当** review 结束
**那么** proposal 必须保持 non-effective 或明确被 rejected
**并且** active Plan 保持不变。

**假如** review 使用 accessibility modes
**当** fields 和 diffs 重排
**那么** 必须在没有水平滚动时线性化，保留关键中文 values/digests/actions，并提供等价的非颜色与 keyboard/VoiceOver 操作。

**追踪范围：** FR-057、FR-060、FR-078、FR-079、FR-083；AD-7、AD-14；NFR-AI-002、NFR-AI-005；UX-DR2、UX-DR10～UX-DR15、UX-DR18～UX-DR19。

### Story 2.14: 原子提交恰好一个已批准 Plan Revision

作为一名训练者，
我希望已批准 proposal 成为恰好一个完整 Plan Revision，否则不作任何改变，
从而失败、重试、重复或乱序交付绝不会留下局部或回退的 Plan。

**验收标准：**

**假如** 请求 commit
**当** 检查 eligibility
**那么** 系统必须验证 unconsumed proposal、exact approval/digest、unchanged Plan head、permitted scope、complete structural validation、enabled GATE-1 evidence，以及在版本未变时的新鲜 `preCommit` safety result
**并且** 任何不匹配都必须阻断 commit，且不消耗之前 Plan。

**假如** 所有检查通过
**当** local transaction 提交
**那么** 必须使用 `proposalId` 作为 idempotency key，原子持久化一个 append-only Plan Revision、proposal-consumption record、approval provenance、outbox event 和 invalidation
**并且** 只有 transaction 成功后新 revision 才能生效。

**假如** 同一 commit 被重试，或 events 延迟、重复、乱序到达
**当** repository 识别 proposal identity 和 causality
**那么** 必须返回原结果，而不生成另一 revision
**并且** 旧 proposal 不得回退更新的 Plan head。

**假如** validation、safety、database、AI 或 delivery 失败
**当** operation 终止
**那么** 之前的 confirmed Plan 必须完整保持生效，proposal/approval status 保持真实，且不出现 partial revision
**并且** local Plan access 和 workout capture 继续可用。

**假如** commit 成功但 Watch delivery 处于 pending 或 failed
**当** 显示 status
**那么** local commit 与 Watch delivery 必须保持不同的字面状态
**并且** delivery failure 绝不得回退本地 revision，也不得错误报告它本地未交付。

**假如** 自动 invariant 和 fault tests 运行
**当** 模拟 zero approval、stale digest/base、changed policy、failed safety、partial writes、duplicate/retry/out-of-order events 和 delivery failure
**那么** 没有必需 approval 时 effective writes 必须为零，且每个已批准 proposal 最多产生一个完整 revision
**并且** 任何测试都不得阻断 Epic 1 manual core。

**假如** 检查 Story 2.14 范围
**当** 审核其内容
**那么** 它包含 pre-commit validation/safety、atomic idempotent commit、causality、failure degradation 和 distinct delivery truth
**并且** 不包含 Epic 1 已拥有的 Watch transfer implementation 与 Epic 6 拥有的 Health-derived Gate closure。

**追踪范围：** FR-057、FR-060、FR-080、FR-084、FR-085、FR-087；AD-2、AD-7、AD-13；NFR-AI-002～NFR-AI-005；SM-AI-001、SM-AI-002；UX-DR2、UX-DR12、UX-DR15、UX-DR19。

## Epic 3: 在训练中作出由用户掌权的决定

在训练期间，训练者可以在设备不可用时请求 canonical substitute，并接受、编辑或拒绝 next-set load guidance，而不会静默改变当前 Actual Set 或未来 Plan。本 Epic 只消费稳定 Plan snapshots、effective Actual facts、RPE provenance 与 Exercise Catalog ports；它不依赖或调用训练后 Analysis/read-model 实现。

### Story 3.1: 为可用设备请求 Canonical Exercise Substitutes

作为一名训练者，
我希望在计划设备不可用时请求替代动作，
从而我可以继续训练，同时理解每个备选与计划 Exercise 的差异。

**验收标准：**

**假如** active session 使用 immutable Plan snapshot
**当** 用户为当前 Exercise 请求 substitute
**那么** request 必须使用 canonical Exercise ID、primary body area、movement pattern、required equipment 和用户标记的 available equipment
**并且** 不得自动选择 substitute。

**假如** 存在 candidate mappings
**当** 显示 results
**那么** 每个 candidate 必须拥有 canonical ID，并说明 primary-area match、movement-pattern match、equipment fit 及已披露的 secondary-area 或 range differences
**并且** unsupported 或 uncertain mappings 必须保持明确。

**假如** 不存在安全的 canonical candidate
**当** matching 完成
**那么** 系统必须显示 No Supported Substitute 并保留 planned Exercise
**并且** 用户可以返回、手动选择另一个 supported Exercise，或让该项保持 incomplete。

**假如** catalog 或 support versions 与 Start snapshot 不同
**当** 请求 substitution
**那么** 必须使用 session-frozen compatible catalog，否则操作带字面 version reason 失败
**并且** 历史与计划 identities 不得被静默重新解释。

**假如** substitute surface 重排或使用 VoiceOver
**当** 比较 candidates
**那么** mappings 和 differences 必须可读，且没有 color-only ranking、horizontal scrolling 或 hidden critical values。

**追踪范围：** FR-030、FR-031；CAP-13、CAP-14；AD-7、AD-14；UX-DR10、UX-DR14、UX-DR17～UX-DR19。

### Story 3.2: 在不修改 Plan 的情况下明确选择 Session Substitute

作为一名训练者，
我希望为当前训练范围明确选择替代动作，
从而我的实际训练遵循我的决定，却不会静默重写未来 Plan。

**验收标准：**

**假如** Story 3.1 显示 candidates
**当** 用户选择一个 candidate
**那么** 必须预览精确 original Exercise、substitute、rationale、scope 和受影响 remaining planned items
**并且** 仅 selection 不得改变任何 Actual Set 或 Plan。

**假如** 用户确认 session-scoped substitution
**当** local transaction 成功
**那么** 必须保存带 provenance、versions 和 Start-snapshot reference 的 append-only auditable session decision
**并且** 后续适用 set-entry defaults 必须使用选定 Exercise，而之前 Actual Sets 保持不变。

**假如** 用户取消或拒绝
**当** preview 关闭
**那么** original session snapshot 必须继续有效，且不得创建 compensating write。

**假如** 用户请求将变更应用于未来训练
**当** session decision 完成
**那么** 系统只能为普通 Epic 2 review path 创建 non-effective future-Plan proposal
**并且** 绝不得直接编辑 active Plan 或 current Start snapshot。

**假如** 同一 confirmation 被重试
**当** 稳定 action ID 被识别
**那么** 必须返回原决策，不生成 duplicate revisions 或 repeated substitutions。

**追踪范围：** FR-032；AD-2、AD-7、AD-14；SM-PRES-001；UX-DR10、UX-DR12～UX-DR15、UX-DR19。

### Story 3.3: 接受、编辑或拒绝 Next-Set Load Guidance

作为一名训练者，
我希望获得可以接受、编辑或拒绝的 next-set load suggestion，
从而 guidance 可以帮助我，却绝不会声称对我的下一个 Actual Set 拥有权威。

**验收标准：**

**假如** 存在 effective Actual RPE 和 remaining Plan scope
**当** 用户请求或符合 guidance 条件
**那么** deterministic suggestion 必须列出 source Actual Set/RPE provenance、current load/unit、proposed next load、rationale 和 applicable next-set scope
**并且** missing、pending、incomparable 或 untrusted RPE 不得产生伪造 suggestion。

**假如** suggestion 已显示
**当** 用户不采取动作
**那么** 任何 Actual Set、Start snapshot 或 future Plan 都不得改变
**并且** ordinary previous-Actual-Load default 继续权威有效。

**假如** 用户接受或编辑 suggestion
**当** next set-entry draft 打开
**那么** 选定值只能成为下一 Actual Set 的 editable default
**并且** Actual Set 只能在普通 explicit Complete Set commit 后成为事实。

**假如** 用户拒绝 suggestion
**当** rejection 被保存
**那么** 任何 load value 都不得改变，且 rejection 保持可审计，而不影响 completed facts。

**假如** units、equipment、Exercise、session state 或 source RPE 变化
**当** 对 old suggestion 执行动作
**那么** 它必须失效并重新计算，或以精确原因拒绝
**并且** stale guidance 不得覆盖更新的 user edit。

**假如** 在训练中显示 proactive guidance
**当** 检查 interruption eligibility
**那么** 它必须等待 `restSafeForInteraction`，在适用时使用 shared prompt budget，且绝不得移除 manual load entry。

**追踪范围：** FR-027；CAP-14；AD-2、AD-7、AD-14；NFR-RPE-002～NFR-RPE-003；SM-INT-001；UX-DR10、UX-DR16～UX-DR17、UX-DR19。

## Epic 4: 审核 History、Analysis 与未来 Plan 对账

在训练后或训练间隙，训练者可以浏览完整 History，检查与 revision 绑定的每周/每月和选定 Primary Exercise Analysis，如实查看 stale/partial/conflicted exclusions，将历史训练复用为新 draft，并在不改变已完成训练的情况下接受或拒绝精确 future-Plan reconciliation diff。本 Epic 拥有 Analysis/read-model 与 future-Plan reconciliation use cases，只依赖共享稳定 domain contracts，而不依赖 in-session guidance implementation。

### Story 4.1: 浏览完整与不完整的 Training History

作为一名训练者，
我希望浏览全部持久的 planned 和 ad-hoc sessions，
从而 completed、incomplete、corrected、conflicted 和 recovery records 不会从我的 history 中消失。

**验收标准：**

**假如** 存在持久 Workout Sessions
**当** History 加载
**那么** 必须使用 effective revisions 列出 planned 和 ad-hoc sessions，并显示 date、completion state、performed Exercises 和字面 incomplete/corrected/conflicted indicators
**并且** planned content 绝不得替代 missing Actual facts。

**假如** History 处于 loading、empty、offline、failed，或包含 tombstoned/conflicted records
**当** 显示 state
**那么** 每种条件必须具有不同的字面语义与适用的 recovery action
**并且** 不得使用乐观 empty 或 success state 隐藏持久记录。

**假如** 用户过滤或滚动 History 并打开一个 session
**当** 用户返回
**那么** filter、object context、scroll position 和 non-effective input 必须恢复。

**假如** correction 或 recovered transfer 改变 effective session state
**当** History 刷新
**那么** 只能使受影响 rows 失效并重新计算
**并且** row 必须在重新计算完成前标识 pending 或 stale state。

**假如** 使用 large text、VoiceOver、keyboard 或 non-color settings
**当** 浏览 History
**那么** state、date、Exercise 和 recovery actions 必须保持可读可操作，不截断关键中文内容。

**追踪范围：** FR-036；AD-11、AD-14；NFR-UX-001；UX-DR1、UX-DR5、UX-DR12～UX-DR15、UX-DR18～UX-DR19。

### Story 4.2: 检查完整的 Effective Session Record

作为一名训练者，
我希望检查每个持久 Actual Set 及其相关纠错 provenance，
从而完成训练绝不会让字段消失，也不会隐藏哪些值当前有效。

**验收标准：**

**假如** 选择一个 History session
**当** detail 打开
**那么** 必须显示每个 effective Actual Set 的 Exercise、order、repetitions、load/unit/kind、RPE state、timing、completeness、source 和 trained body areas
**并且** missing fields 保持可见缺失。

**假如** values 曾被 corrected、split、merged、inserted、deleted、recovered 或 conflicted
**当** 查看对应 rows
**那么** effective values 必须与 prior revisions 区分，且相关 provenance 可检查
**并且** sibling facts 和 original timing 必须保留。

**假如** fact 处于 pending、incomplete、conflicted、excluded 或 awaiting missing parent
**当** 渲染 detail
**那么** 它不得计为 confirmed，且必须显示精确 resolution 或 waiting state。

**假如** 用户执行允许的 post-completion correction
**当** revision 提交
**那么** detail 必须使用 Epic 1 append-only correction behavior，并将 dependent Analysis 标记为 stale
**并且** 不得原地覆盖 history row。

**假如** detail 在离线或重启后重新打开
**当** local data 可读
**那么** 完整的最后持久记录必须保持可用，无需 cloud 或 AI dependency。

**追踪范围：** FR-040、FR-041；AD-2、AD-5、AD-11；SM-COMP-001、SM-PRES-001；UX-DR5、UX-DR12、UX-DR19。

### Story 4.3: 从 Effective Actual Sets 计算每周与每月 Analysis

作为一名训练者，
我希望每周与每月训练摘要只从 effective Actual Sets 计算，
从而 planned、missing 或 conflicted work 绝不会夸大我的结果。

**验收标准：**

**假如** 用户选择一周
**当** Analysis 计算
**那么** 必须显示从 effective Actual facts 得到的 completed-session count 和 performed Exercises
**并且** incomplete sessions 与 exclusions 必须分别披露。

**假如** 请求 weekly 或 monthly metrics
**当** 推导 volume、intensity、load 和 duration
**那么** formulas、units、time zone/calendar boundary、source revision watermark 和 denominator 必须版本化且可重现
**并且** planned sets 与语义不可比 load kinds 不得静默汇总。

**假如** 存在 corrected effective facts
**当** Analysis 运行
**那么** 必须使用 corrected values 和 applicable RPE provenance
**并且** superseded revisions 不得重复计入。

**假如** 某个 metric 的数据不足
**当** 显示 result
**那么** 必须声明 insufficient、partial、excluded 或 incomparable，而不是返回零或伪造结论。

**假如** 显示 charts
**当** 请求 accessibility alternatives
**那么** 必须以 text 和 table 提供相同精确 values、units、exclusions 和 conclusions，且没有 color-only meaning。

**追踪范围：** FR-037、FR-038、FR-040；AD-11、AD-14；NFR-RPE-002、NFR-UX-001；UX-DR6、UX-DR11～UX-DR15、UX-DR18～UX-DR20。

### Story 4.4: 查看一个明确选定 Primary Exercise 的趋势

作为一名训练者，
我希望选择一个 Primary Exercise 并检查其可比趋势，
从而 substitutions 或名称相似的 movements 不会被静默混入我的进展。

**验收标准：**

**假如** 用户打开 Exercise trends
**当** 没有选定 canonical Primary Exercise
**那么** 不得计算 trend，UI 必须要求明确选择。

**假如** Primary Exercise 已选定
**当** 计算 trend points
**那么** 只能包含映射到该 canonical identity 且 load/unit kinds 语义可比的 effective Actual Sets
**并且** substitutions 必须保持分离，除非存在明确支持的 comparison rule。

**假如** 期间存在 corrected 或 incomplete records
**当** 显示 trend
**那么** 必须使用 corrected effective values，并披露 excluded/pending/conflicted points 及原因。

**假如** 用户改变 Exercise、period、unit 或 filter
**当** Analysis 刷新
**那么** selection 和 source watermark 必须明确变化，旧结果不得显示为 current。

**假如** chart 无法被感知或定位
**当** 用户使用 text、table、VoiceOver 或 keyboard alternatives
**那么** 每个 point、date、value、unit 和字面 conclusion 必须保持可用。

**追踪范围：** FR-039、FR-040、FR-049；AD-11、AD-14；UX-DR6、UX-DR14、UX-DR18、UX-DR20。

### Story 4.5: 通过 Invalidation 与 Recovery 保持 Analysis 真实

作为一名训练者，
我希望 Analysis 在其源事实变更或仍未解决时明确标识，
从而 cached metrics 在纠错、传输或冲突仍在对账时绝不会看起来像 current。

**验收标准：**

**假如** effective fact、mapping、resolution 或 relevant version 变化
**当** atomic mutation 提交
**那么** affected Analysis scope 必须在同一 transaction 中获得 invalidation
**并且** unaffected periods 和 Exercises 继续可用。

**假如** cached output 早于 source watermark
**当** Analysis 打开
**那么** 它必须标记为 stale，并开始 recomputation 或提供 explicit retry
**并且** stale output 绝不得显示为 current。

**假如** sources 处于 pending、partial、conflicted、incomplete、excluded 或 unreadable
**当** recomputation 运行
**那么** results 必须携带对应字面 state、exclusions 和 source counts
**并且** unsafe values 不得按到达时间静默选择。

**假如** recomputation 失败或 app 重启
**当** Analysis 恢复
**那么** durable source facts 必须继续权威有效，prior cache 继续标记 stale，且 retry 是幂等的
**并且** History 和 workout capture 继续可用。

**假如** tests 每次变更一个 revision
**当** 比较 affected read models
**那么** 只有正确 scopes 变化，且确定性 recomputation 从相同 effective facts 产生相同 output。

**追踪范围：** FR-038～FR-041；AD-2、AD-11；NFR-RECOV-001；UX-DR6、UX-DR12、UX-DR15、UX-DR19。

### Story 4.6: 使用精确 Future-Scope Diff 对账 Plan 与 Actual

作为一名训练者，
我希望把重要 Plan-versus-Actual differences 转换为完整 future-Plan proposal，
从而我可以批准或拒绝未来变更，而不改变已完成训练。

**验收标准：**

**假如** session 完成时存在重要 Plan-versus-Actual differences
**当** 请求 reconciliation
**那么** 必须对比 immutable Start snapshot 与 effective Actual Sets，并识别精确 additions、removals 和 changed fields/values/units
**并且** 必须列出 affected future sessions，并排除 completed history 和 active sessions。

**假如** facts 处于 incomplete、pending、conflicted 或 incomparable
**当** 形成 diff
**那么** 这些 items 必须保持明确，且不得被转换为猜测的 future changes。

**假如** 存在 valid reconciliation candidate
**当** review 打开
**那么** 它必须通过 Epic 2 identity、safety、complete-diff 和 approval path 成为 non-effective immutable proposal
**并且** 不得使用特殊 reconciliation shortcut 绕过 digest-bound approval。

**假如** 用户拒绝或关闭 guidance
**当** 保存 action
**那么** Actual facts 必须保留，future Plan 保持不变。

**假如** 用户批准且 commit 成功
**当** 显示 result
**那么** 必须通过 Story 2.14 使恰好一个 future Plan Revision 生效
**并且** completed 和 active Workout Sessions 保持不变。

**追踪范围：** FR-033、FR-034；CAP-14；AD-2、AD-7、AD-11、AD-14；UX-DR2、UX-DR6、UX-DR10、UX-DR12。

### Story 4.7: 将历史 Session 复用为新 Draft

作为一名训练者，
我希望将历史 session 复用为新的可编辑 draft，
从而我可以从实际完成的训练构建未来训练，而不改变 source history 或隐式批准 Plan。

**验收标准：**

**假如** 打开一个 complete 或 incomplete historical session
**当** 用户选择 Reuse as Draft
**那么** preview 必须标识 included effective Actual facts、omitted pending/conflicted fields、mappings、units、source session/revision 和 assumptions
**并且** source session 必须保持不可变。

**假如** 用户确认 draft creation
**当** local transaction 成功
**那么** 必须创建带 provenance 和 digest 的 new stable draft identity，且为 non-effective
**并且** 不得改变 active Plan 或创建 approval。

**假如** 存在 unknown mappings、unsupported units 或 required omissions
**当** 尝试 creation
**那么** draft 必须保持 incomplete 并提供 explicit correction actions
**并且** 系统不得发明 replacements。

**假如** 同一 action 被重试
**当** 识别其 idempotency key
**那么** 必须返回 original draft，不生成 duplicate。

**假如** 用户希望激活 draft
**当** 继续流程
**那么** 它必须进入普通 Epic 2 validation、safety、complete review、approval 和 atomic commit path。

**追踪范围：** FR-035；AD-2、AD-7、AD-11；NFR-AI-001～NFR-AI-002；UX-DR5、UX-DR10、UX-DR12、UX-DR19。

## Epic 5: 把 FitnessAI Plan 安全交换为独立 Draft

训练者可以通过原生 Share Sheet 导出恰好一个受限 FitnessAI Plan，并且只有在完整验证、mapping、omission、duplicate 和 provenance review 创建一个新的 non-effective draft 后才导入文件。Parser 或分享失败不会改变现有 Plan。GATE-7 是 prerequisite/evidence Story：export 可以继续，但在 parser time/memory ceilings 和 failure reporting 冻结前不得接受 Plan import。

### Story 5.1: 通过 Share Sheet 导出一个受限 FitnessAI Plan

作为一名训练者，
我希望审核并将恰好一个 Plan 导出为受限 FitnessAI 文件，
从而我只分享预期 Plan，而不包含隐藏的 history、health、account 或 sensor data。

**验收标准：**

**假如** 用户选择一个 effective Plan 或 non-effective draft
**当** export review 打开
**那么** 必须标识恰好一个 Plan、revision/draft identity、included fields、provenance、schema/catalog versions 和 excluded data classes
**并且** 必须排除 History、Actual Sets、Health data、AI conversation、secrets 和 raw signals。

**假如** export 已确认
**当** 编码 file
**那么** 它必须是 plain uncompressed UTF-8 JSON，包含一个 versioned FitnessAI Plan、canonical units/IDs、provenance 和 whole-file digest
**并且** 文件暴露前必须强制 AD-10 structural limits。

**假如** validation 或 encoding 失败
**当** operation 结束
**那么** 不得分享 partial file，必须显示 exact failure，且所有 existing Plan 保持不变。

**假如** 存在 valid file
**当** 用户选择 Share
**那么** native Share Sheet 只能在明确动作后收到该文件
**并且** 取消 Share Sheet 不得改变任何 Plan 或 export status，除了标记 cancellation。

**假如** export surface 使用 accessibility modes
**当** 审核 scope 和 actions
**那么** 所有 included/excluded categories、file identity、errors 和 single consequential action 必须可读，且不存在 color-only meaning 或 truncated Chinese text。

**追踪范围：** FR-071；AD-10、AD-13、AD-14；NFR-PORT-001、NFR-UX-001；UX-DR8、UX-DR10～UX-DR15、UX-DR18～UX-DR19。

### Story 5.2: 冻结 GATE-7 Parser Resource Budgets 与 Failure Reporting

作为 Product Owner，
我希望在接受 parser 前冻结 Plan-import time 与 memory ceilings，
从而不可信文件无法获得未定义的 resource budget 或模糊的 failure behavior。

**验收标准：**

**假如** GATE-7 处于 open
**当** 创建所属的 `GATE-7 Plan Parser Budget Decision Record`
**那么** 必须记录数值 wall/CPU time 与 peak-memory ceilings、measurement environment、abort behavior、user-visible failure categories、owner、version 和 digest
**并且** 不得包含 `TBD` 或 implementer-invented value。

**假如** AD-10 structural limits 适用
**当** budget record 冻结
**那么** 必须明确将 resource ceilings 叠加在 2 MB、depth 12、one Plan、366 days、30 Exercises/day、20 Sets/Exercise、10,000 Sets 和 2,000 characters/note 之上
**并且** 声明哪些检查在 allocation 或 deep parsing 之前发生。

**假如** parsing 超过任何冻结 ceiling
**当** 指定 abort behavior
**那么** termination 必须受限，不得接受 partial object，temporary state 安全丢弃，并返回字面、非敏感原因
**并且** 不得修改任何 existing Plan。

**假如** record 不完整或发生变化
**当** 评估 Gate state
**那么** GATE-7 必须保持或返回 disabled，且阻断 import acceptance
**并且** Story 5.1 bounded export 继续可用。

**假如** 检查 Story 5.2 范围
**当** 审核其内容
**那么** 它只包含 frozen parser budgets、measurement protocol、failure taxonomy、change control 和 default-disabled Gate registration
**并且** 不包含 parser implementation、preview 和 draft creation。

**追踪范围：** GATE-7 prerequisite；AD-10、AD-13；NFR-PORT-001。

### Story 5.3: 在 Import 禁用时解析并验证不可信 Plan 文件

作为一名训练者，
我希望所选 Plan 文件在启用任何 import action 前都在严格限制内被解析，
从而 malformed 或 hostile content 无法改变我的 Plans 或耗尽 app 资源。

**验收标准：**

**假如** 用户通过 native picker 选择文件
**当** bounded parsing 开始
**那么** 必须使用 AD-10 和 Story 5.2 强制 size、encoding、compression、depth、counts、note length、time 和 memory
**并且** executable、malformed、multi-Plan、unsupported-root 或 limit-exceeding content 必须在 draft creation 前拒绝。

**假如** JSON 结构有效
**当** 运行 schema 和 compatibility validation
**那么** supported/unsupported versions、required/unknown fields、units、dates、canonical Exercise references、duplicates、omissions 和 digests 必须获得明确结果
**并且** unknown data 绝不得被静默发明、执行或合并。

**假如** parsing aborts、crashes、times out 或 exceeds memory
**当** 处理 failure
**那么** 必须显示受限字面 error 和 recovery action，temporary content 不得生效，且 logs 不得包含 imported Plan content。

**假如** 同一文件被重复解析
**当** 比较 canonical results
**那么** 它们必须确定，并携带相同 file digest、mappings、omissions、duplicate findings 和 compatibility state。

**假如** parser implementation 通过 unit 和 fault tests，但没有 GATE-7 evidence
**当** 检查 import eligibility
**那么** parser output 可被预览，但 Create New Draft 必须在技术上保持禁用
**并且** 任何 status assertion 都不得关闭 GATE-7。

**追踪范围：** FR-072、FR-073；GATE-7 implementation；AD-10、AD-13；NFR-PORT-001；UX-DR8、UX-DR19。

### Story 5.4: 在 Draft Creation 禁用时审核 Import Findings

作为一名训练者，
我希望在 draft creation 保持禁用时查看完整 import preview，
从而我可以解决 mappings、omissions、duplicates 和 incompatibilities，而不触碰任何现有 Plan。

**验收标准：**

**假如** bounded parsing 成功
**当** preview 打开
**那么** 必须显示 file identity/digest、source provenance、schema/catalog versions、每个 Plan field、mapping、unknown field、omission、duplicate、warning 和 incompatibility
**并且** partial content 绝不得标记为 complete。

**假如** 必需 unknown Exercises 或 incompatible fields 仍然存在
**当** 用户审核 actions
**那么** 必须根据冻结合同提供 explicit mapping、omission、cancel 或 unsupported outcomes
**并且** 不得发明或静默丢弃 mapping。

**假如** GATE-7 尚未通过其 evidence Story
**当** preview 在结构上变为 complete
**那么** Create New Draft 必须保持技术禁用并显示字面 Gate reason
**并且** preview、correction、cancellation、export 与 existing Plan use 继续可用。

**假如** 用户调整一个允许的 mapping 或 omission decision
**当** preview 重新计算
**那么** original file digest、decision digest、resulting completeness 与每个 changed interpretation 必须可见
**并且** 不得持久化任何 draft、approval 或 effective mutation。

**假如** preview 为 accessibility 重排
**当** 显示较长 Chinese values 和 errors
**那么** critical fields、mappings、digests 和 actions 必须保持完整且可操作，无 horizontal scrolling。

**假如** 检查 Story 5.4 范围
**当** 审核其内容
**那么** 它只包含 complete preview 与 default-disabled create action 下的 non-effective mapping/omission decisions
**并且** 不包含 Gate evidence 与 draft persistence。

**追踪范围：** FR-072、FR-073；GATE-7 preview enabling；AD-10、AD-14；NFR-PORT-001；UX-DR8、UX-DR10、UX-DR13～UX-DR15、UX-DR18～UX-DR19。

### Story 5.5: 证明 Parser Budgets 并启用 GATE-7 Import Acceptance

作为 Product Owner，
我希望获得与冻结 budgets 和 build 绑定的可重现 parser evidence，
从而 Plan import 只有在 malicious 与 boundary files 被证明安全失败后才可接受。

**验收标准：**

**假如** Stories 5.2～5.4 已完成
**当** 生成所属的 `GATE-7 Plan Parser Evidence Record`
**那么** 必须列出 budget record、parser build、schema/catalog versions、fixture corpus、device/environment、digests 和 owner
**并且** 必须嵌入 machine-readable measurements 和 results，而不是通过声明。

**假如** corpus 运行
**当** 评估 thresholds
**那么** 每个 exact-boundary、over-boundary、malformed、deep、duplicate、unknown、incompatible、compressed、executable-content、timeout 和 allocation-pressure case 必须满足冻结 time/memory 和 failure-reporting expectations
**并且** 失败案例创建或修改 Plan 的数量必须为零。

**假如** 任何测试被跳过、不确定、超过 budget、stale 或 failed
**当** 计算 Gate state
**那么** GATE-7 必须保持 disabled，Create New Draft 继续不可用
**并且** export 与 existing Plan use 继续可用。

**假如** 所有 evidence 通过
**当** Product Owner 接受 exact evidence digest
**那么** GATE-7 只能为已记录 parser/schema/build/budgets 启用 import
**并且** 任何相关 version 或 budget 变化都会关闭 Gate，并使之前启用失效。

**追踪范围：** FR-072、FR-073；GATE-7 evidence and enablement；AD-10、AD-13；NFR-PORT-001。

### Story 5.6: 创建一个独立的 Non-Effective Imported Draft

作为一名训练者，
我希望在 GATE-7 通过后由已经完整审核的兼容文件创建一个独立 non-effective draft，
从而 import 绝不合并、覆盖、批准或激活现有 Plan。

**验收标准：**

**假如** GATE-7 已针对精确 parser/schema/build/budgets 启用
**当** 用户返回 complete import preview
**那么** 必须针对当前版本重新验证 file、mapping decisions、compatibility、Gate evidence 与 digests
**并且** 任何 stale 或 changed input 都必须禁用创建并要求 refreshed preview。

**假如** 每个 required field 与 mapping 都已解决
**当** 用户选择 Create New Draft
**那么** 必须原子保存恰好一个带 stable ID、import provenance、source file digest、decision digest、mappings、omissions 与 versions 的 new non-effective draft
**并且** 不得合并、覆盖、批准或激活任何 active 或 existing draft Plan。

**假如** save 失败或 action 重试
**当** 处理 stable action identity
**那么** failure 不得创建 partial draft，retry 必须返回之前唯一 successful draft，不产生 duplicate。

**假如** GATE-7 在 preview 与 commit 之间关闭
**当** transaction 检查 eligibility
**那么** creation 必须在任何 write 前带 exact Gate reason 失败
**并且** existing Plans 与 reviewed preview 保持不变。

**假如** 用户之后希望 activation
**当** 从 imported draft 继续
**那么** 它必须进入 Epic 2 validation、safety、complete review、explicit approval 与 atomic commit
**并且** import 本身不赋予 approval。

**追踪范围：** FR-072、FR-073；GATE-7 enabled import acceptance；AD-2、AD-10；NFR-PORT-001；UX-DR8、UX-DR12、UX-DR15、UX-DR19。

## Epic 6: 在不放弃本地事实权威的前提下使用 Apple Health

训练者可以授予可选、least-privilege Apple Health capabilities，只观察真实 read states，并创建或重试幂等 workout copies，同时 FitnessAI 保持权威，且 external changes 成为 `healthKitDetached`。Health failure 会保留 local Plan、History、Analysis 和 capture。Local capability 独立工作；GATE-3 使每次真实 Health-derived remote send 保持技术禁用，同时允许独立 authorization preview 和 AI without Health data。

### Story 6.1: 管理 Least-Privilege Apple Health Capabilities

作为一名训练者，
我希望每个 Apple Health capability 都被独立请求和显示，
从而我只授予冻结 allowlist 中的访问，并理解哪些能力 unavailable、denied 或 unsupported。

**验收标准：**

**假如** 用户打开 Apple Health settings
**当** capability rows 加载
**那么** 每个冻结 read 或 write type 必须拥有独立 purpose、requested state、observable result、last attempt 和 recovery action
**并且** excluded clinical categories 必须从 entitlements、queries 和 UI 中消失。

**假如** authorization 尚未请求
**当** 用户不采取动作
**那么** 不得出现 Health prompt，Plan、History、Analysis、AI without Health 和 workout capture 继续可用。

**假如** 用户请求一个 capability
**当** HealthKit 返回 observable state
**那么** app 只能报告 API 可以真实确定的内容，不得声称它无法观察的 read authorization
**并且** denial 或 restriction 不得隐含另一 capability 失败。

**假如** HealthKit unavailable、restricted、denied 或 errors
**当** row 更新
**那么** 必须显示字面 state 与安全 retry/settings action，而不显示乐观 success
**并且** local FitnessAI truth 必须保持权威。

**假如** accessibility modes 处于 active
**当** 使用 capability rows 和 explanations
**那么** status 和 actions 不得仅依赖 color、icons 或 gestures，且 large Chinese text 保持完整。

**追踪范围：** FR-088；AD-9、AD-14；NFR-HK-001、NFR-UX-001；UX-DR7、UX-DR10～UX-DR15、UX-DR18～UX-DR19。

### Story 6.2: 构建 Data-Minimized Local Health Summaries

作为一名训练者，
我希望允许的 Health data 在本地转换为明确、受限 summaries，
从而 raw Health records 保留在本地，remote AI 也绝不会收到超出独立审核 summary 的内容。

**验收标准：**

**假如** 允许的 Health read 可用
**当** local summary computation 运行
**那么** 必须只使用冻结 allowlisted types、explicit time window、documented aggregation、canonical units、source-query generation 和 versioned summary schema
**并且** complete raw samples 保持本地。

**假如** data 处于 missing、partial、stale、denied 或 incomparable
**当** 形成 summary
**那么** condition、coverage window、exclusions 和 completeness 必须明确
**并且** 不得猜测值，也不得从 FitnessAI planned content 回填。

**假如** Health data 之后改变
**当** 查看 prior summary
**那么** 它必须绑定 source generation/digest 并标记为 stale，而不得在 authorized request 内静默重新计算。

**假如** 选择 summary 用于 AI preview
**当** Story 2.8 映射其 fields
**那么** 只能暴露 summary categories 和 transformations
**并且** real sending 仍然必须需要 GATE-3 与 matching Story 2.7 one-shot authorization。

**假如** Health summary computation 失败
**当** 用户返回 local features
**那么** Plan、History、从 FitnessAI facts 得到的 Analysis 和 workout capture 必须保持可用。

**追踪范围：** FR-082、FR-088；GATE-3 enabling input；AD-8、AD-9；NFR-HK-001、NFR-PRIV-003、NFR-PRIV-007；UX-DR7、UX-DR12、UX-DR19。

### Story 6.3: 使用 Health-Derived Remote-Use Evidence 关闭 GATE-3

作为 Product Owner，
我希望真实 Health-derived AI traffic 只由完整 compliance、privacy、security 和 field-mapping evidence record 启用，
从而 local Health permission 或 preview 绝不会被误认为 remote-use approval。

**验收标准：**

**假如** 评估 GATE-3
**当** 组装所属的 `GATE-3 Health-Derived Remote-Use Evidence Record`
**那么** 必须列出 health/fitness purpose、Apple compliance basis、processor/contract review、region/cross-border path、disclosure、retention/training、deletion/revocation/user rights、owners、effective dates、versions 和 digest
**并且** 不得把任何 open item 表示为 approved。

**假如** 审核 request mapping
**当** 记录 evidence
**那么** 每个 allowed request field 必须映射到一个 Story 6.2 summary category、source type/window、transformation、unit、purpose 和 retention treatment
**并且** raw samples、excluded clinical types 和 unmapped fields 必须被禁止。

**假如** negative tests 运行
**当** GATE-3 禁用、authorization missing/stale、field unmapped 或 payload 包含 raw/extra data
**那么** egress 必须为零，content-free audit 必须记录 exact rejection
**并且** AI without Health 继续可用。

**假如** evidence 不完整、stale、rejected 或 tests fail
**当** 评估 Gate state
**那么** GATE-3 必须保持 disabled，且 Story 2.8 preview 不得 send
**并且** local Health 和 manual core 继续可用。

**假如** 每个必需 approval 和 test 通过
**当** Product Owner 接受 evidence digest
**那么** GATE-3 只能启用已记录 summary fields、route、purpose、region、versions 和 validity window
**并且** 任何相关变化都会自动关闭 Gate，等待新 evidence。

**追踪范围：** FR-082、FR-086、FR-088；GATE-3 prerequisite evidence and enablement；AD-8、AD-9、AD-13；NFR-HK-001、NFR-PRIV-007。

### Story 6.4: 在 GATE-3 后发送一次已授权 Health Summary

作为一名训练者，
我希望合格 local Health summary 只在我批准其精确 one-shot preview 后发送，
从而 Gate closure 绝不会成为对我健康信息的长期同意。

**验收标准：**

**假如** GATE-3 针对 matching versions 已 enabled
**当** Health-derived remote preview 打开
**那么** Health categories 必须默认关闭，并显示 exact summary fields、source window、transformations、purpose、provider、route、evidence version 和 request digest。

**假如** 用户明确选择 categories 并授权 request
**当** payload 到达 remote boundary
**那么** 必须同时精确匹配 GATE-3 allowlisting 和 fresh Story 2.7 one-shot token
**并且** token 必须为一个 logical request 被原子消耗。

**假如** summary generation、source data、Gate evidence、route、policy、selection 或 request digest 变化
**当** 尝试 send
**那么** authorization 必须失效，且要求新 preview。

**假如** delivery 失败或超时
**当** 显示 status
**那么** sent、not sent、failed 和 retry-needs-authorization 必须保持不同
**并且** 不得有 automatic retry 复用 health authorization 或扩大 payload。

**假如** send 完成
**当** 保存 audit
**那么** 只能记录 IDs、versions、selected categories、digest、status 和 timing，不记录 content、raw Health data、secrets 或 chain-of-thought。

**追踪范围：** FR-082、FR-086；GATE-3 send enablement；AD-8、AD-9；NFR-PRIV-007；UX-DR2、UX-DR7、UX-DR12、UX-DR19。

### Story 6.5: 向 Apple Health 写入幂等 Workout Copy

作为一名训练者，
我希望在 FitnessAI 保存 Finish 后将可选 completed-workout copy 写入 Apple Health，
从而 external interoperability 绝不会控制我的 local workout 是否完成。

**验收标准：**

**假如** Workout Session 已在 FitnessAI 中持久完成
**当** 用户已启用独立 Health write capability
**那么** 必须在 local Finish 后排队带稳定 idempotency metadata 的 export generation
**并且** local completion 绝不得等待或依赖 HealthKit。

**假如** write 处于 pending、written、failed、denied 或 retryable
**当** 显示 status
**那么** 每个 state 必须与 local save 和 session completion 保持不同
**并且** failure 必须在适用时包含 safe explicit retry。

**假如** 同一 export generation 重试
**当** HealthKit 或 app 重复工作
**那么** 不得创建第二个 FitnessAI-owned workout copy
**并且** logs 和 errors 不得包含 workout content。

**假如** effective workout facts 在 correction 后改变
**当** 重新评估 export eligibility
**那么** 必须根据 transition contract 要求新的 explicit export generation
**并且** external copy 绝不得在静默重写时被表示为没发生 correction。

**假如** Health write 永久失败
**当** 用户查看 session
**那么** 完整 FitnessAI workout 必须保持权威，并在 History 和 Analysis 中可用。

**追踪范围：** FR-089；AD-2、AD-9；NFR-HK-001、NFR-HK-002；UX-DR7、UX-DR12、UX-DR15、UX-DR19。

### Story 6.6: 在 Health Copy 分离时保留 Local Truth

作为一名训练者，
我希望将 Health workout copy 的外部删除或变更显示为 detached，
从而 FitnessAI 绝不会静默重建外部数据或改变我的 local workout truth。

**验收标准：**

**假如** FitnessAI 之前写入了 Health workout copy
**当** 之后 reconciliation 无法找到或安全匹配 external object
**那么** export generation 必须变为 `healthKitDetached`，并带 last-known identity、generation 和 observable reason
**并且** local Workout Session 和 Actual Sets 保持不变。

**假如** external Health object 变化
**当** 它与 FitnessAI truth 不同
**那么** FitnessAI 不得将变化导入 local facts、按时间戳选择或重写 history
**并且** detached 或 differing state 必须可见。

**假如** copy 已 detached
**当** background reconciliation 或 app restart 发生
**那么** 系统不得静默重新创建 copy
**并且** 只有 explicit user action 可以创建新 export generation。

**假如** 发生 duplicate、delayed 或 reordered Health callbacks
**当** state machine 处理它们
**那么** generation identity 和 transition rules 必须防止从 detached 回退到 falsely written。

**假如** HealthKit 不可用
**当** 用户继续使用 FitnessAI
**那么** Plan、workout、History、Analysis 和 AI without Health 必须继续可用，local truth 保持权威。

**追踪范围：** FR-090；AD-9；NFR-HK-001、NFR-HK-002；UX-DR7、UX-DR12、UX-DR19。

## Epic 7: 在保留手动 Fallback 的前提下获得证据门控 Watch 辅助

在精确通过资格证明的 device/orientation/handedness/Exercise rows 上，训练者可以获得独立通过资格证明的 recognition、set/rep、opt-in RPE 和保守 Finish assistance，并具有 confidence、abstention、correction、drift recovery、safe-rest prompting 和 shared interruption budget。GATE-4～6 是 evidence Stories；每个 open 或 failed Gate 只会使其命名 automation path 保持禁用，而 Epic 1 manual capture 继续受支持。

### Story 7.1: 在所有 Automation 禁用时捕获 Candidate Watch Signals

作为一名训练者，
我希望 candidate sensing 使手动 Watch 记录保持完全可用，
从而实验性 recognition 绝不会伪造或控制我的 workout facts。

**验收标准：**

**假如** 安装 candidate AD-6 device/orientation/handedness/eight-Exercise row
**当** Watch workout 开始
**那么** automatic Exercise、set-boundary、repetition、RPE 和 forgotten-Finish outputs 必须默认独立禁用
**并且** manual Exercise selection、repetitions、load、Complete Set、correction 和 Finish 继续可用。

**假如** Product Owner 测试已批准 experimental capture
**当** 观察 supported signals
**那么** high-frequency streams 必须保持本地、版本化、session-frozen，并与 durable Actual Set truth 分离
**并且** unsupported devices、orientations、handedness、Exercises、missing signals 或 resource pressure 必须停止 candidate capture，但不阻断 workout。

**假如** candidate 在 Gate 关闭时生成 internal result
**当** result 到达 domain boundary
**那么** 它不得创建、完成、标注或更改 Actual Set
**并且** 不得在 user-facing UI 中显示为 supported automatic result。

**假如** 出现 resource 或 storage pressure
**当** Watch 保护 core records
**那么** optional candidate/raw data 必须在 structured workout facts 之前停止或清理
**并且** 无法保存 core facts 必须在下一次 manual commit 之前说明。

**假如** 检查 Story 7.1 范围
**当** 审核其内容
**那么** 它只包含 candidate signal adapters、local experimental storage、independent default-off switches、support checks 和 manual fallback tests
**并且** 不包含 model qualification 或 automation enablement。

**追踪范围：** FR-007～FR-011、FR-020、FR-047；GATE-4～6 disabled candidate enabling；AD-6、AD-13；NFR-REC-002、NFR-RPE-007、NFR-RES-001；UX-DR17、UX-DR19。

### Story 7.2: 冻结 GATE-4 Recognition Preregistration

作为 Product Owner，
我希望在查看 final holdout results 前冻结 recognition evaluation，
从而 support claims 和 thresholds 无法在知道性能后变动。

**验收标准：**

**假如** GATE-4 处于 open
**当** 冻结所属的 `GATE-4 Recognition Preregistration Record`
**那么** 必须列出 participants/time partitions、untouched holdout、candidate model/build、device/OS、orientation、handedness、eight-Exercise rows、signal eligibility 和 versions/digests
**并且** Exercise classification、set boundary 和 repetitions 必须拥有独立 qualification decisions。

**假如** metrics 已定义
**当** 审核 record
**那么** 必须冻结包含 abstentions/misses 的 denominators、thresholds、confidence intervals、silent misses、false sets、repetition error、correction/recovered-record separation、slices 和 resource protocol
**并且** 任何 unsupported result 都不得计为 success。

**假如** 评估 interaction
**当** 指定 prompts
**那么** 必须使用 prompt/correction counter-metrics 冻结 safe-rest eligibility 和 representative-session shared five-prompt budget。

**假如** 必需值缺失或在访问 holdout 后改变
**当** 评估 Gate state
**那么** GATE-4 必须保持 disabled，或要求新 untouched holdout 与 version
**并且** manual Complete Set 保持 supported path。

**追踪范围：** FR-008～FR-015；GATE-4 prerequisite；AD-6、AD-13；NFR-REC-001、NFR-REC-002、NFR-COMPAT-001、SM-ACC-001、SM-INT-001。

### Story 7.3: 在物理设备上证明 GATE-4 并仅启用通过 Rows

作为 Product Owner，
我希望获得 row-specific physical-device recognition evidence，
从而只有在精确已测配置上独立通过的 functions 被启用。

**验收标准：**

**假如** Story 7.2 已冻结
**当** 生成所属的 `GATE-4 Recognition Physical-Device Evidence Record`
**那么** 必须绑定 preregistration、model/support/catalog builds、physical devices/OS、participants/sessions、immutable predictions、labels、raw result files 和 digests
**并且** 必须嵌入 machine-readable results，而不是 support assertion。

**假如** 评估 untouched holdout
**当** 比较 thresholds 和 slices
**那么** classification、set boundary 和 repetitions 必须使用 preregistered denominators、uncertainty、silent misses、correction burden 和 resource evidence 分别 pass 或 fail
**并且** correction 后的 recovery 不得提高 initial-recognition success。

**假如** function/configuration row 失败、缺失或没有 physical-device evidence
**当** 发布 support state
**那么** 该精确 row 必须保持 `manualOnly` 或 candidate-disabled，并给出字面原因
**并且** 通过的 neighboring rows 不得启用它。

**假如** row 通过且 Product Owner 接受 evidence digest
**当** 应用 enablement
**那么** 只能为冻结版本启用该 function/device/OS/orientation/handedness/Exercise row
**并且** 任何相关变化都会自动禁用它，等待新 evidence。

**追踪范围：** FR-008～FR-015；GATE-4 evidence and row-specific enablement；AD-6、AD-13；NFR-REC-001～NFR-REC-002、NFR-COMPAT-001、NFR-RES-001～NFR-RES-002；SM-ACC-001。

### Story 7.4: 识别并纠正已合格 Exercise

作为一名训练者，
我希望获得带明确纠错路径的合格 ad-hoc Exercise recognition，
从而 supported suggestion 可以减少输入，同时我的 correction 保持权威且可审计。

**验收标准：**

**假如** ad-hoc Watch session 没有 preselected Exercise，且其精确 GATE-4 classification row 已 enabled
**当** eligible signals 产生 result
**那么** UI 必须显示 canonical Exercise、confidence、model/support versions 和 accepted、uncertain、abstained、unsupported 或 manual-only state
**并且** unsupported 或 below-threshold output 绝不得成为 Exercise fact。

**假如** confidence 需要 confirmation
**当** interaction 变为 `restSafeForInteraction`
**那么** 一个 concise prompt 可以使用 shared budget，并提供 confirm、correct 或 manual selection
**并且** workout recording 必须在不阻断的情况下继续。

**假如** 用户确认或手动选择 Exercise
**当** first Actual Set 提交
**那么** user-confirmed canonical identity 和 recognition provenance 必须与 set 原子保存
**并且** recognition 本身绝不得提交 fact。

**假如** 用户在 first Actual Set 后纠正 Exercise
**当** correction 提交
**那么** append-only revision 只能更改 Exercise identity，保留 order/repetitions/load/RPE/timing，并使 later sets 使用 corrected Exercise
**并且** original prediction 和 correction 必须保持可审计。

**假如** recognition 禁用或失败
**当** 用户训练
**那么** manual Exercise selection 和 Complete Set 必须保持完全可用。

**追踪范围：** FR-008、FR-010～FR-014、FR-049；AD-2、AD-6、AD-14；NFR-REC-002；SM-ACC-001、SM-PRES-001、SM-INT-001；UX-DR10、UX-DR16～UX-DR17、UX-DR19。

### Story 7.5: 识别合格 Set Boundaries 与 Repetitions

作为一名训练者，
我希望获得在不确定时 abstain 的合格 set 与 repetition assistance，
从而我可以减少交互，而不会丢失手动控制或接受伪造训练组。

**验收标准：**

**假如** 精确 GATE-4 set-boundary 和 repetition rows 已独立 enabled
**当** 处理 eligible supported signals
**那么** candidate boundary、repetition count、confidence、timing、model/support versions 和 provenance 必须与 committed Actual Set 保持不同
**并且** 每个 function 只能在自己的 row 通过时运行。

**假如** result 在冻结 policy 下为 high-confidence
**当** Watch 提议 completion
**那么** 用户必须保留可见 manual Complete Set path，并可以在 commit 前编辑 repetitions/load/Exercise/RPE
**并且** local commit 保持唯一 saved-fact boundary。

**假如** confidence 较低、signals 缺失、activity 不受支持或 model abstains
**当** assistance 解析
**那么** 不得伪造 set 或 repetition，state 必须为 uncertain、abstained、unsupported 或 manual-only
**并且** 任何 prompt 必须等待 safe rest 并尊重 shared budget。

**假如** 用户纠正 recognized result
**当** correction 提交
**那么** append-only provenance 必须保留 initial prediction 和 user correction，而不修改 sibling facts
**并且** initial-recognition 和 recovered-record success 保持为独立 metrics。

**假如** candidate events 重复或迟到
**当** session reducer 处理它们
**那么** stable identity 必须防止 duplicate sets，且不得回退 later manual correction。

**追踪范围：** FR-009～FR-011、FR-013、FR-015；AD-2、AD-6、AD-14；NFR-REC-001～NFR-REC-002；SM-ACC-001、SM-PRES-001、SM-INT-001。

### Story 7.6: 保持 RPE Opt-In 并区分每个 RPE State

作为一名训练者，
我希望 RPE tracking 在我启用前保持关闭，且每个 RPE 含义保持分离，
从而 target 或 prediction 绝不会被误传为我的 Actual RPE。

**验收标准：**

**假如** 用户尚未启用 RPE tracking
**当** workout 运行
**那么** RPE estimation、verification、calibration、display 和 auto-use 必须处于 inactive
**并且** 可以查看简洁 RPE education，而不启用 tracking。

**假如** 用户明确 opt in
**当** RPE fields 变为可用
**那么** target、predicted、confirmed、auto-used、corrected 和 effective RPE 必须保持不同，并带 source/model/version provenance
**并且** integer values 限制在 1～10。

**假如** model 或 GATE-5 禁用
**当** 用户记录 set
**那么** manual RPE entry 必须保持可用且权威
**并且** 不得显示 prediction 或将其作为 Actual RPE。

**假如** RPE state 跨越 iPhone/Watch、History、Analysis 或 recovery boundaries
**当** 编码或显示
**那么** 必须保留相同 semantic distinction 和 provenance，而不合并 states。

**假如** 用户禁用 RPE tracking
**当** setting 提交
**那么** future estimation 必须停止，同时 previously confirmed/corrected facts 保持可审计
**并且** 其他 workout capture 保持不变。

**追踪范围：** FR-020、FR-026、FR-052；GATE-5 disabled state flow；AD-6、AD-14；NFR-RPE-001～NFR-RPE-002、NFR-RPE-007、NFR-RPE-011。

### Story 7.7: 冻结 GATE-5 RPE Preregistration

作为 Product Owner，
我希望在 final evaluation 前冻结 RPE model、labels、thresholds、burden gates、drift rules 和 holdout，
从而 auto-use 无法通过在已知结果后移动标准来证明正当性。

**验收标准：**

**假如** GATE-5 处于 open
**当** 冻结所属的 `GATE-5 RPE Preregistration Record`
**那么** 必须标识 participants/time splits、untouched holdout、model/build、label reveal 之前的 eligibility、support rows、signals、integer output、confidence threshold、versions 和 digests
**并且** 只有 confirmed/corrected RPE 可作为 label。

**假如** 记录 evaluation criteria
**当** 审核 record
**那么** 必须冻结 simple baselines、participant-held-out 和 later-session metrics、calibration/risk-coverage、exact 与 within-±1 accuracy、all-eligible denominators、subgroup/missing-signal/resource slices 和 confidence intervals。

**假如** 记录 interaction 和 drift criteria
**当** 审核 record
**那么** 必须冻结 first-five chronological eligibility、≥4 within ±1 offer threshold、≥2 wrong recalibration/restart、rolling-five two-correction drift trigger，以及 SM-INT-001 内的 prompt/correction burden gates。

**假如** 任何 criterion 缺失或在访问 holdout 后变更
**当** 评估 Gate state
**那么** GATE-5 必须保持 disabled，或需要新 untouched holdout/version
**并且** RPE 保持默认关闭，manual 或 approved confirmation-only use 继续可用。

**追踪范围：** FR-020～FR-026；GATE-5 prerequisite；AD-6、AD-13；NFR-RPE-003～NFR-RPE-014；SM-INT-001。

### Story 7.8: 证明 GATE-5 并仅启用 Evidence-Bound RPE Use

作为 Product Owner，
我希望获得与精确 model 和 support versions 绑定的可重现 held-out RPE evidence，
从而 confirmation 和 auto-use eligibility 只存在于 accuracy、calibration、burden、drift 和 resource gates 通过的地方。

**验收标准：**

**假如** Story 7.7 已冻结
**当** 产生所属的 `GATE-5 RPE Physical-Device Evidence Record`
**那么** 必须绑定 preregistration、immutable predictions/labels、model/support versions、devices/OS、raw result files、environment 和 digests
**并且** 必须包含 machine-readable outputs，而不是 pass assertion。

**假如** 评估 final holdout
**当** 检查所有 thresholds
**那么** baseline improvement、within-±1 和 exact accuracy、calibration/risk-coverage、subgroup/missing-signal/resource slices 与 prompt/correction burden 必须全部按冻结标准通过
**并且** abstentions 和 misses 保持在 preregistered denominators 中。

**假如** 任何 required slice、burden、resource 或 holdout gate 失败或缺失
**当** 计算 eligibility
**那么** 该 row 的 RPE auto-use 必须保持 disabled，并发布 exact failure
**并且** 通过的 neighboring rows 不得启用它。

**假如** evidence 通过且 Product Owner 接受其 digest
**当** 保存 enablement
**那么** 只有 matching rows 才能符合 verification 和后续 explicit-user auto-use consent 条件
**并且** Gate passage 本身绝不得启用 tracking 或 auto-use。

**假如** model、threshold、eligibility、device/OS、support 或 protocol 变化
**当** 请求 prediction
**那么** previous evidence 必须失效，row 返回 disabled，等待 new evidence。

**追踪范围：** FR-020～FR-026；GATE-5 evidence and eligibility enablement；AD-6、AD-13；NFR-RPE-003～NFR-RPE-014、NFR-COMPAT-001、NFR-RES-001～NFR-RES-002。

### Story 7.9: 完成 Five-Estimate RPE Verification Window

作为一名训练者，
我希望确认或纠正前五个合格 RPE estimates，
从而系统在提议减少确认前证明它理解我的用力程度。

**验收标准：**

**假如** RPE tracking 已启用且精确 GATE-5 row 合格
**当** estimate 在 label 暴露前符合条件
**那么** 它必须进入 first five chronological eligible predictions，并冻结 model/confidence/provenance
**并且** abstention 或 later correction 不得将它从 denominator 中移除。

**假如** eligible estimate 已准备
**当** 到达 `restSafeForInteraction`
**那么** 用户可以在 shared interruption budget 内的 concise prompt 中确认或纠正 integer RPE 1～10
**并且** 只有 confirmed/corrected values 成为 Actual RPE labels。

**假如** 五个 eligible predictions 已解决
**当** 至少四个在 ±1 范围内
**那么** 系统可以提供—但绝不得静默启用—routine-confirmation disablement
**并且** exact-match 和 within-±1 results 必须分别报告。

**假如** 五个 predictions 中至少两个错误
**当** 达到 threshold
**那么** calibration 必须只使用 corrected labels，并开始新 five-estimate window
**并且** auto-use 保持 disabled。

**假如** window 被中断、恢复或 replayed
**当** state 恢复
**那么** prediction order、denominator、labels 和 outcome 必须保持幂等，不产生 duplicate prompts 或 estimates。

**追踪范围：** FR-021～FR-023、FR-025～FR-026；AD-2、AD-6、AD-14；NFR-RPE-005～NFR-RPE-008、NFR-RPE-011～NFR-RPE-012；SM-INT-001。

### Story 7.10: 明确启用带 Abstention 与 Drift Recovery 的 RPE Auto-Use

作为一名训练者，
我希望在 verification 后明确启用 high-confidence RPE auto-use，并在信任 drift 时返回 verification，
从而 automation 保持可纠正，且在 confidence 或 signals 不足时绝不伪造 effort。

**验收标准：**

**假如** Story 7.9 通过且 matching GATE-5 evidence 仍然有效
**当** 用户收到 offer
**那么** auto-use 必须在 separate explicit consent 标识 eligible rows、model/rule versions、correction path 和 revocation 前保持 off
**并且** declining 必须保留 confirmation/manual behavior。

**假如** auto-use 已启用且生成 eligible high-confidence estimate
**当** Actual Set 提交
**那么** predicted、auto-used 和 effective RPE 以及 model/confidence/provenance 必须分别保存
**并且** 用户之后可以纠正该值。

**假如** confidence 较低、signals 缺失、Exercise/configuration 不熟悉、support/evidence stale 或怀疑 drift
**当** estimate 解析
**那么** 系统必须 abstain 或在 safe rest 且 budget 内请求 confirmation
**并且** 绝不得伪造 Actual RPE。

**假如** 任何 rolling five auto-used eligible estimates 中发生两次 corrections
**当** 第二次 correction 提交
**那么** auto-use 必须立即禁用，并开始新 five-estimate verification window
**并且** prior confirmed/corrected labels 保持可审计。

**假如** 用户撤销 tracking 或 auto-use
**当** revocation 提交
**那么** future estimation/use 必须为 selected scope 停止，而不改变 existing Actual facts 或 other workout capture。

**追踪范围：** FR-024～FR-026；AD-2、AD-6、AD-14；NFR-RPE-003、NFR-RPE-006、NFR-RPE-009～NFR-RPE-014；SM-INT-001。

### Story 7.11: 保持 Forgotten-Finish Candidate 禁用

作为一名训练者，
我希望 unqualified 时 forgotten-Finish logic 无法 finish 或 prompt，
从而 long rests、equipment waits 和 low-motion work 绝不会结束我的 session。

**验收标准：**

**假如** GATE-6 处于 open
**当** session 处于 active
**那么** manual Finish 必须正常且权威，并且不存在 automatic Finish path
**并且** candidate reminder switch 必须独立禁用。

**假如** experimental Product Owner testing 已批准
**当** candidate 评估 sustained recovery 与 sustained absence of strength activity
**那么** 两个 signals 必须在冻结 candidate 15-minute window 内继续为 true，missing signals 必须抑制 eligibility，且 output 保持 internal
**并且** 不得显示 prompt 或改变 session state。

**假如** 发生 long rest、equipment wait、low-motion Exercise、disconnect、runtime stop 或 inactivity
**当** candidate 观察到它
**那么** session 必须保持 active 或处于其真实 recovery state
**并且** 任何 event 都不得映射为 completion。

**假如** candidate processing 失败或消耗资源
**当** degradation 发生
**那么** 必须在 manual recording 或 durable session facts 受影响前停止。

**追踪范围：** FR-004、FR-005；GATE-6 disabled candidate；AD-6；NFR-SESSION-001～NFR-SESSION-003、NFR-RES-001；UX-DR17。

### Story 7.12: 冻结 GATE-6 Reminder Preregistration

作为 Product Owner，
我希望在 physical-device results 前冻结 forgotten-Finish protocol 和 false/missed thresholds，
从而 reminder enablement 无法忽略真实 long-rest 和 low-motion failures。

**验收标准：**

**假如** GATE-6 处于 open
**当** 冻结所属的 `GATE-6 Forgotten-Finish Preregistration Record`
**那么** 必须列出 participants/sessions、devices/OS、personalization、signal eligibility、missing-signal behavior、15-minute dual-signal candidate、15-minute Continue cooldown、versions 和 digests。

**假如** 定义 outcome criteria
**当** 审核 record
**那么** false-reminder 和 missed-reminder thresholds、confidence intervals、denominators，以及独立 long-rest、equipment-wait、low-motion、disconnect 和 ordinary-finish slices 必须是数值且完整的
**并且** 不得存在 automatic-Finish success metric。

**假如** 指定 interaction
**当** 冻结 reminder UX
**那么** 只允许 Finish 和 Continue，prompt 必须等待 safe interaction 并参与 shared interruption budget
**并且** missing signals 必须抑制而不是加速 prompt。

**假如** 必需 decisions 缺失或在访问 evidence 后变更
**当** 评估 Gate state
**那么** GATE-6 必须保持 disabled，或要求 new untouched evaluation
**并且** manual Finish 继续可用。

**追踪范围：** FR-005；GATE-6 prerequisite；AD-6、AD-13；NFR-SESSION-002～NFR-SESSION-005；SM-INT-001。

### Story 7.13: 证明 GATE-6 并启用保守 Finish-or-Continue Prompt

作为一名训练者，
我希望仅在 physical-device evidence 通过且两个冻结条件持续为 true 后收到 forgotten-Finish question，
从而我可以选择 Finish 或 Continue，而 app 不会自动结束 workout。

**验收标准：**

**假如** Story 7.12 已冻结
**当** 产生所属的 `GATE-6 Forgotten-Finish Physical-Device Evidence Record`
**那么** 必须绑定 preregistration、build、devices/OS、immutable session outcomes、raw result files、resource measurements、versions、owners 和 digests
**并且** 必须包含 machine-readable long-rest、equipment-wait、low-motion、missing-signal、disconnect、false 和 missed results。

**假如** 任何 frozen threshold、slice、resource criterion 或 physical-device requirement 失败或缺失
**当** 评估 evidence
**那么** GATE-6 必须保持 disabled，且不得有 user-visible reminder
**并且** manual Finish 保持唯一 supported finish path。

**假如** 所有 evidence 通过且 Product Owner 接受其 digest
**当** 启用精确 device/OS configuration
**那么** 只有在所需 signals 存在时，sustained recovery 和 sustained no-strength activity 都持续为 true 15 分钟后 reminder 才能 eligible
**并且** 任何 version/configuration 变化都会禁用它，等待 new evidence。

**假如** eligibility 在 unsafe interaction 期间发生，或 shared prompt budget 已耗尽
**当** UI 考虑 presentation
**那么** reminder 必须 deferred 或 suppressed，且绝不阻断 set recording 或 manual Finish。

**假如** prompt 已显示
**当** 用户选择 Continue 或 Finish
**那么** Continue 必须使 session 保持 active 并启动 15-minute cooldown，而 Finish 进入普通 explicit manual-Finish confirmation
**并且** dismiss、timeout、app termination 或 no response 绝不结束 workout。

**假如** 使用 VoiceOver、large text、reduced motion 或 disabled haptics
**当** reminder 出现
**那么** reason、current session state、Finish 和 Continue 必须保持可读可操作，不存在 color、motion、haptic、gesture 或 Crown-only access。

**追踪范围：** FR-005、FR-011；GATE-6 evidence and enablement；AD-6、AD-13～AD-14；NFR-SESSION-001～NFR-SESSION-005、NFR-COMPAT-001、NFR-RES-001～NFR-RES-002；SM-INT-001；UX-DR10、UX-DR14、UX-DR16～UX-DR20。

## Epic 8: 完成受控训练后审核并重复使用私有 Alpha

在 completed session 之后，Product Owner 可以接受、延后或禁用一个 non-blocking review invitation；当接受时，可以进入现有 authorized diff-and-approval path，而不存在 hidden data use 或 mutation。然后，Product Owner 可以在 accessible native iPhone 与 Watch surfaces 上重复完成从 conversation 到 Plan、workout 和 Analysis 的完整循环；S7 完成 migration、fault、size、privacy、paired-device 和 physical-device evidence，不包含 discoverable deferred placeholders 或 optimistic state claims。

### Story 8.1: 每个 Completed Session 最多提供一次 Review、Later 或 Disable

作为一名训练者，
我希望每次训练后最多获得一个 non-blocking review invitation，
从而我可以选择 Review、Later 或 Disable，而不会触发任何 hidden send、proposal、approval 或 Plan change。

**验收标准：**

**假如** session 已持久完成且 local result 可用
**当** 评估 invitation eligibility
**那么** 最多只有一个 invitation 与该 canonical Workout Session 和 completion revision 关联
**并且** duplicate Finish、transfer replay、correction、restart 或 device reconnection 不得为同一 eligibility event 创建另一个 invitation。

**假如** invitation 被显示或关闭
**当** 没有选择 action
**那么** 不得准备或发送 remote data，也不得创建 authorization、proposal、approval 或 Plan mutation
**并且** completed workout facts 保持不变。

**假如** 用户选择 Later
**当** decision 提交
**那么** 必须幂等保存 bounded non-blocking deferral state，而不创建 AI work
**并且** 任何 later reappearance 必须遵循冻结 cadence，而不是 active-session prompting。

**假如** 用户选择 Disable
**当** preference 提交
**那么** future invitations 必须停止，直到用户在 settings 中明确重新启用
**并且** ordinary user-invoked review 继续可用。

**假如** invitation 在 accessibility settings 下出现
**当** 使用 Review、Later 或 Disable
**那么** 它必须 nonmodal、focus-safe，在 large Chinese text 下可读，且无需 color、motion、haptics、gesture 或 timeout dependence 即可操作。

**追踪范围：** FR-091；AD-2、AD-14；UX-DR9、UX-DR10、UX-DR13～UX-DR16、UX-DR18～UX-DR19。

### Story 8.2: 将已接受 Review 路由至现有 Authorization 与 Approval

作为一名训练者，
我希望接受 invitation 后进入普通 evidence、authorization、proposal、diff 和 approval flow，
从而 proactive entry 绝不会创建 privileged shortcut 或 hidden state。

**验收标准：**

**假如** 用户在 Story 8.1 中选择 Review
**当** review route 打开
**那么** 必须在 source session 可见且没有 preselected remote categories 时开始 Story 2.10
**并且** 仅显示 route 本身不得发送任何内容。

**假如** 选择 source facts
**当** 计算 evidence eligibility
**那么** 只有 confirmed/corrected effective records 和 concise user feedback 符合条件
**并且** incomplete、pending、conflicted、excluded 或 raw data 必须保持省略且被披露。

**假如** 需要 remote request
**当** 用户继续
**那么** 必须要求精确 Story 2.7 one-shot authorization 与任何适用 GATE-3 Health authorization
**并且** prior invitation、HealthKit permission 或 previous consent 不得替代。

**假如** 产生 proposal
**当** 用户审核
**那么** 普通 Story 2.11～2.14 validation、safety、complete diff、explicit approval 和 atomic commit 必须在没有 bypass 时适用
**并且** cancel、rejection、failure 或 timeout 必须保留 active Plan 和 workout facts。

**假如** route 在中断后恢复
**当** app 继续
**那么** non-effective input 和 source context 可以恢复，同时任何 stale authorization 或 proposal 根据其 digest/base/version rules 失效。

**追踪范围：** FR-059、FR-082、FR-086、FR-091；AD-7～AD-9、AD-14；NFR-AI-002、NFR-AI-004～NFR-AI-005；UX-DR2、UX-DR9、UX-DR12、UX-DR15、UX-DR19。

### Story 8.3: 证明无需手工重建的完整 Private-Alpha User Loop

作为 Product Owner，
我希望在受支持 iPhone 和 Watch 硬件上重复完成完整 private-Alpha loop，
从而产品在不进行手工 database repair、payload reconstruction 或使用另一 primary recorder 的情况下证明核心价值。

**验收标准：**

**假如** 全新 private-Alpha installation 和 supported paired devices
**当** 执行所属的 `S7 Private-Alpha End-to-End Evidence Record`
**那么** 必须覆盖 bounded conversation、exact authorization、complete proposal review、explicit approval、atomic Plan commit、compatible Watch delivery、Watch 或 phone execution、durable Actual Set return、correction、History、Analysis 和 explicit evidence-bounded revision
**并且** 任何步骤都不得需要 manual payload、database、Plan 或 transfer reconstruction。

**假如** optional AI、Health、recognition、RPE、reminder 或 network capability 禁用或失败
**当** loop 继续
**那么** last durable Plan 和 Epic 1 manual local capture 必须保持可用
**并且** 每个 unavailable capability 必须报告其字面独立 state。

**假如** 同一 loop 在 declared Alpha migration path 中重复
**当** local stores、schema、catalog、support、model 和 policy versions 通过 supported migrations 变更
**那么** durable facts、identities、provenance、pending/conflicted state、approvals 和 replay tombstones 必须保持可解释
**并且** historical records 绝不得被静默重新解释。

**假如** Product Owner 在 preregistered observation period 中将 Alpha 作为 default recorder 运行
**当** 测量 continuation
**那么** cohort、denominator、exclusions、competing-recorder definition 和 observation window 必须遵循冻结 SM-RET-001 protocol
**并且** 必须记录结果，而不将 single-user observation 转换为更广泛声明。

**假如** 审核 end-to-end record
**当** 任何步骤为 manual-only、pending、stale、partial、conflicted、failed 或 unsupported
**那么** 该 state 必须保持可见，且不得报告为 completed automation 或 success。

**追踪范围：** SM-E2E-001、SM-RET-001、SM-ALPHA-CORE-001；AD-13；NFR-RECOV-001、NFR-COMPAT-002、NFR-AI-003～NFR-AI-004、NFR-HK-001；UX-DR12、UX-DR17、UX-DR19～UX-DR20。

### Story 8.4: 完成 Fault、Compatibility 与 Paired-Device Evidence

作为 Product Owner，
我希望为每个 supported configuration 获得可重现 fault 和 physical-device evidence，
从而 support 依据中断下的持久行为，而不是 simulator 或 happy-path results。

**验收标准：**

**假如** Alpha support matrix 列出 device/OS pair
**当** 组装所属的 `S7 Fault and Compatibility Evidence Record`
**那么** 该精确 physical iPhone/Watch pair 必须执行 start、set save、correction、Finish、Plan delivery、Actual Set return、recovery 和 replay scenarios
**并且** simulator evidence 不得建立 support。

**假如** fault injection 运行
**当** 模拟 termination、restart、battery/sensor interruption、disconnect、partial write、duplicate、delay、reordering、missing chunk、revoked pairing epoch 和 concurrent sessions
**那么** 每个可靠提交事实必须恰好生效一次，不得回退 later correction，unsafe conflicts 保持可见以便 explicit resolution。

**假如** 每个 supported Watch/OS pair 运行冻结 90-minute/20-set protocol
**当** 测量 resource results
**那么** resource termination 和 recorded-information loss 必须为零，p95 Start/correction/Finish interaction 不超过一秒，并报告 battery、thermal、memory 和超过两秒的 interactions
**并且** optional automation 必须在 core recording 受损前禁用。

**假如** configuration 或 requirement 失败
**当** 发布 support state
**那么** 它必须以 exact failed function 和 evidence version 变为 unsupported 或 manual-only
**并且** passing configurations 不得把 support 借给它。

**假如** tests 重新运行
**当** build、device/OS、schema、catalog、model 或 protocol 变化
**那么** prior evidence 必须针对 affected rows 失效，并应用 default-disabled/manual fallback，直到 new evidence 通过。

**追踪范围：** AD-4～AD-6、AD-13；NFR-RES-001～NFR-RES-002、NFR-RECOV-001、NFR-COMPAT-001～NFR-COMPAT-002；SM-COMP-001、SM-PRES-001。

### Story 8.5: 发布 Size、Privacy、Security 与 Release-Control Evidence

作为 Product Owner，
我希望为 bundle size、data handling、secrets、logging 和 Gate state 获得一份与版本绑定的 release-control record，
从而 private-Alpha build 无法带着 hidden media、credentials、remote use 或 unsupported release claims 发布。

**验收标准：**

**假如** candidate Alpha build 已 archived 且 thinned
**当** 生成所属的 `S7 Size Privacy and Security Evidence Record`
**那么** 必须分别报告 iPhone download 和 installed sizes，且 thinned installed variant 不超过 500 MB
**并且** 必须使用 Xcode/App Store Connect thinning evidence 而非 debug/archive size，报告 Watch uncompressed size 小于 75 MB、internal installed target 不超过 25 MB、all Watch ML assets 不超过 6 MB，且 RPE component 不超过 2 MB。

**假如** 检查 bundle contents
**当** size 和 licensing checks 运行
**那么** Watch 不得包含 rich teaching images 或 nonessential media，不得发布 unlicensed media，也不得出现 unsupported wrist-only full-body-form claim
**并且** 每个 bundled model/catalog/support asset 必须具有 version 和 purpose。

**假如** privacy 和 storage checks 运行
**当** 检查 local stores、files、telemetry、diagnostics、backups 和 remote payloads
**那么** data classes 必须按 purpose 分离并最小化，raw motion/heart-rate 默认保持本地，sensitive stores/secrets 必须从 backup/diagnostic 中排除，且 secrets 保留在 device-local non-synchronizing Keychain
**并且** telemetry 必须 opt-in 且 content-free。

**假如** compile、domain、schema、safety、persistence、sync、AI 和 secret checks 执行
**当** 任何 required check 或 Gate 处于 failed/open
**那么** 只有其 named path 必须保持 disabled，release record 必须声明 exact result，且不得产生 optimistic release conclusion
**并且** manual local capture 继续可用。

**假如** 检查 development、private-Alpha 和 future-production environments
**当** 比较 credentials 和 data
**那么** 必须保持隔离，Alpha build 中不得包含 production credential，也不得由 deferred placeholders 暗示 account/cloud feature。

**追踪范围：** AD-13；NFR-SIZE-001～NFR-SIZE-005、NFR-PRIV-001、NFR-PRIV-003、NFR-PRIV-007、NFR-SEC-003、NFR-SAFE-001；FR-047、FR-053；UX-DR17。

### Story 8.6: 验证完整可访问 Native Experience 与 Alpha Feedback Loop

作为 Product Owner，
我希望使用 accessible states 和严谨 feedback evidence 验证完整 native iPhone 和 Watch experience，
从而 Alpha 可以在真实健身房重复使用，且不存在 placeholders、hidden failures 或 inaccessible critical actions。

**验收标准：**

**假如** 所有 private-Alpha surfaces 已构建
**当** 执行所属的 `S7 Accessibility UX and Feedback Evidence Record`
**那么** 必须覆盖 Plan、AI conversation/authorization/review/commit、phone 和 Watch workout、History、Analysis、Health、Plan exchange、proactive review、sync、recovery 和 support-boundary components
**并且** 每个 ready/loading/empty/offline/pending/stale/partial/conflicted/invalid/unsupported/failed/cancelled/incomplete/recovery state 必须具有字面语义，并在适用时提供 recovery。

**假如** 测试 iPhone 11 到更大手机及 supported Watches
**当** 使用 light/dark、Increase Contrast、Differentiate Without Color、Reduce Motion、Reduce Transparency、至少 200% iPhone text、至少 140% Watch text、largest Chinese content、VoiceOver、Full Keyboard Access 和 disabled haptics
**那么** critical values、consequences、digests 和 actions 不得截断或需要水平滚动
**并且** 任何 critical function 都不得仅依赖 color、motion、haptic、gesture 或 Crown。

**假如** 评估 physical gym use
**当** 运行 glanceability、Always On、sweat/one-hand input、Crown/touch equivalence、lighting、P3/sRGB contrast、chart targeting、offline、replay 和 reconnect scenarios
**那么** 每个 supported path 必须满足冻结 acceptance result，否则明确标记为 unsupported/manual-only
**并且** 在要求的地方，必须保留一个 primary consequential action 与至少 44×44 point controls 和 8 point separation。

**假如** 收集 critical 或 recurring core-trust feedback
**当** 更新 feedback record
**那么** 必须在 preregistered SM-FEED-001 protocol 下记录 severity、recurrence、cohort/denominator、cadence、owner、decision、closure evidence 和 affected requirement
**并且** anecdotes 不得被静默转换为 resolved metrics。

**假如** 检查 deferred public-beta、Post-MVP 或 V2 features
**当** 审核 Alpha navigation 和 components
**那么** 不得发布 discoverable placeholder、disabled teaser、account/cloud promise、voice entry、named third-party format 或 link/QR sharing surface
**并且** concise support boundaries 必须标识实际可用内容。

**假如** complete record 通过
**当** 报告 Alpha readiness
**那么** conclusions 必须限于已测 Product Owner scope、devices、versions、Gates 和 evidence
**并且** 任何 failed item 必须保持 open，不得被 overall success language 隐藏。

**追踪范围：** AD-14；NFR-UX-001；SM-FEED-001、SM-ALPHA-CORE-001；UX-DR1～UX-DR20。
