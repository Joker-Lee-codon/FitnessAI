# FitnessAI Native UI Architecture 交接

## 文档状态

- 阶段：`ND-04 Handoff`
- 状态：已于 2026-09-12 获 Product Owner 接受并冻结
- 日期：2026-09-12
- 已选方向：`Training Ledger`
- 已冻结设计 Token：`0.2.0-nd02-accepted`
- 范围：iPhone 与 Apple Watch 私有 Alpha 原生 UI，以及 PRD 已要求的明确公开 Beta 边界

## 交接结论

Product Owner 已于 2026-09-12 接受本 Native UI 包。它已通过规范层质量 Gate，可进入 Architecture。不存在阻塞架构工作的未决视觉决定。真机、模型、提醒、安全与后端 Gate 仍需由对应负责人提供发布证据，不能被视为已由 UI 证明。

实现不变量很简单：页面只能把已获权威边界确认的持久事实描述为完成。点击、传感器推断、AI 输出、传输尝试或外部写入，在权威边界确认之前绝不能呈现为完成。

## 权威与数据边界

```text
Plan 提案 ──用户批准──> 本地 Plan Revision ──完整交付──> Watch 快照
                                                        │
Watch 交互/推断 ──本地提交──> Actual Set/Session ──幂等回传──> iPhone
                                                        │
                                  可选且分别确认的副本
                                  ├─ Apple Health
                                  └─ 中国区域应用后端
```

1. 用户确认与用户纠正的值优先于 AI、传感器、语音、导入、同步和恢复草稿。
2. Plan、提案、修订、交付、Start 快照、Actual Set、Workout Session、回传、HealthKit 写入与云端恢复是不同的强类型状态。
3. 活跃训练期间，Watch 本地提交具有权威性。iPhone 接收、HealthKit 写入和云同步都不能撤销它。
4. 提案只有经过完整复核、明确批准、原子本地提交，并单独观测到 Watch 交付后，才可改变有效 Plan。
5. 历史 Actual Sets 与已完成或活跃的 Session 不受后续 Plan 修订影响。
6. 每条持久或派生记录在适用时保留生成它的 schema、App、catalog、support-matrix 与 model 版本。

## 页面与导航合同

| 领域 | 页面 | Architecture 合同 |
|---|---|---|
| Watch 训练 | `WC-01`–`WC-06` | 强类型浅层路由；一个主操作；仅休息安全时提示；本地优先的幂等提交与恢复。 |
| iPhone 复核 | `IR-01`–`IR-03` | Today/Plans、Session Review 与 History 保留 Plan/Actual 来源、不完整事实、筛选器和来源版本。 |
| iPhone 计划 | `PA-01`–`PA-03` | Plan 修订、证据有界的 Analysis 与有界 Exercise catalog 保持领域分离。 |
| 系统 | `SY-01`–`SY-06` | 持久化、交付、账户、授权、HealthKit、导入/导出与能力状态明确指出具体边界。 |
| 其余私有 Alpha IA | AI Plan Chat、Proposal Review、Approval/Commit/Delivery、仅手机 Active Workout、Revision Proposal Review | 按已冻结的闭合合同实现；不可发明新的视觉语法，也不可把批准与生成合并。 |

Architecture 可以选择 iPhone 根容器，但必须保留原生 Back 行为、指向精确失败位置的 deep link、滚动/筛选/草稿上下文恢复，以及上述概念分离。永久 Tab Bar 不是设计要求。

## 功能需求可追溯性

| 需求组 | Native UI 处置 |
|---|---|
| `FR-001–007` | 训练开始、持久 Set/Session 提交、Finish、不完整完成与复核：`WC-01`、`WC-02`、`WC-05`、`IR-02`。 |
| `FR-008–015` | 识别能力、弃权、纠正与提示时机：`WC-02`、`WC-04`、`PA-03`、`SY-06`。 |
| `FR-016–027` | Actual 值、RPE 来源/验证、手动降级与纠正：`WC-02`–`WC-04`、`PA-02`、`SY-06`。 |
| `FR-028–035` | Plan 接收、快照、训练摘要与计划连续性：`WC-01`、`IR-01`、`PA-01`、`PA-03`。 |
| `FR-036–041` | History、Analysis、来源标签、身体部位推导与 Session Review：`IR-02`、`IR-03`、`PA-02`。 |
| `FR-042–048` | 账户与跨设备恢复边界：`IR-01`、`IR-03`、`SY-01`、`SY-02`；私有 Alpha 保持不依赖账户的本地使用。 |
| `FR-049–053` | Exercise catalog 与支持/能力披露：`PA-03`、`SY-06`。 |
| `FR-054–060` | AI 计划对话、安全停止、提案复核、批准与修订：`PA-01`、`SY-03`、其余私有 Alpha IA。 |
| `FR-061–066` | 纠正权威、中断、恢复与恰好一次连续性：`WC-03`、`WC-05`、`WC-06`、`IR-02`、`SY-01`。 |
| `FR-067–070` | 退出登录、删除、墓碑与账户连续性：`IR-03`、`SY-01`、`SY-02`。 |
| `FR-071–073` | 有界 Plan 导出/导入与映射：`PA-01`、`SY-05`。 |
| `FR-074–077` | Post-MVP 语音与分享继续延期，不设置可发现路由或占位入口。 |
| `FR-078–087` | 远程 AI 请求范围、一次性授权、提案完整性与审计：`PA-01`、`SY-02`、`SY-03`、其余私有 Alpha IA。 |
| `FR-088–090` | 可选、最小权限的 Apple Health 读写及本地降级：`IR-02`、`SY-04`。 |
| `FR-091` | 非阻塞的训练后复核邀请：`IR-02`、`PA-02`、`SY-06`。 |

## 非功能需求可追溯性

| 需求组 | 实现与证据边界 |
|---|---|
| `NFR-SIZE-001–005` | 使用原生组件和符号、延迟加载有界媒体，并在 CI 与发布候选中测量裁剪后的 iPhone/Watch/model 产物。 |
| `NFR-RPE-001–014` | `WC-04`、`PA-02` 与 `SY-06` 呈现来源、同意、验证、纠正、弃权与漂移；model owner 提供版本冻结的 holdout 证据。 |
| `NFR-SESSION-001–005` | `WC-05` 保留手动 Finish 与双信号提醒选择；Product/UX owner 在真机验证前预注册工作阈值。 |
| `NFR-RES-001–002` | 活跃训练视图避免装饰动画与高频更新；QA 提供 90 分钟真机资源证据。 |
| `NFR-REC-001–002` | 不支持或低置信识别明显降级为手动/待处理；model owner 提供白名单证据。 |
| `NFR-RECOV-001`、`NFR-COMPAT-001–002` | 稳定事件标识、幂等重放、版本保留与真机支持矩阵是 Architecture 与 QA 的义务。 |
| `NFR-PRIV-001–007`、`NFR-SEC-001–003` | `SY-02` 与 `SY-03` 呈现范围和后果；Architecture 必须落实数据分类、中国区域边界、安全存储/认证、审计及排除 consumer cloud backup。 |
| `NFR-SAFE-001`、`NFR-AI-001–006` | 完整 diff、明确批准、schema/安全验证、原子幂等提交、不可变审计数据与本地降级均为强制要求。专业评审仍是发布 Gate。 |
| `NFR-PORT-001` | `SY-05` 将文件视为不可信的有界输入，并只在验证后原子创建新草稿。 |
| `NFR-VOICE-001`、`NFR-SHARE-001` | 仅限 Post-MVP；首版无路由。保留需求供未来重新进入。 |
| `NFR-HK-001–002` | `SY-04` 让每项 HealthKit 能力与写入结果可观测；没有 HealthKit 时本地 FitnessAI 记录仍保持完整。 |
| `NFR-UX-001` | 所有私有 Alpha 页面继承 Light/Dark、Dynamic Type、VoiceOver、Reduce Motion、非颜色状态、加载、空、离线、失败、不完整、冲突与恢复合同。 |

## SwiftUI 与设计系统合同

- 从 `tokens.json` 生成 `Color`、字体、间距、圆角、动效、触觉与平台别名；功能视图中不可复制原始十六进制颜色值。
- 保留语义组件：`training-rail`、`durable-state-label`、`actual-set-primary-action`、`metric-stepper`、`rest-resolution-banner` 与 `recovery-action-group`。
- 优先使用 `NavigationStack`、强类型路由、原生 Sheet、原生文件选择器、Share Sheet、标准控件和语义无障碍操作。
- 使用稳定领域标识作为列表标识。持久对象绝不能以显示顺序、单独时间戳或本地化文案作为 key。
- 状态转移由领域确认驱动。视图不能根据经过时间推断提交、接收、授权、HealthKit 完成或冲突解决。
- Crown 输入只作为可选加速；可见控件与 accessibility adjustable action 提供等效操作。
- 动画必须有因果、可中断且非必要。Reduce Motion 以即时状态变化或短透明度过渡取代空间移动。

## 可复用状态机

每个持久操作都应可表达为：

```text
idle → editing → submitting → locallyCommitted
                  └─ failed(inputRetained, exactBoundary, retryToken)

locallyCommitted → deliveryPending → delivered
                         └─ deliveryFailed(localTruthRetained, retryToken)
```

冲突、不完整、权限不可用、不支持、外部副本脱离与恢复是强类型状态，而非消息字符串。Retry 必须幂等且只作用于失败边界。破坏性操作需点明精确对象和同步后果、要求明确确认，并且绝不能复用批准操作的样式。

## 无障碍与本地化验收

- Dynamic Type 必须重排，不能截断 Exercise 名称、Actual 值、单位、未解决数量或破坏性后果。
- VoiceOver 阅读顺序为：上下文 → 持久状态 → 当前值/不确定项 → 后果 → 操作。普通传感器或待处理更新不能抢夺焦点。
- 每种状态使用明确文字加形状/符号；颜色与触觉仅作冗余信号。
- iPhone 最小触控目标为 44×44 pt。Watch 操作使用实际可用的全宽目标，并在所有支持方向中可触达。
- 英文与简体中文必须承受真实文本扩展；度量和日期按 Locale 格式化，存储的规范值保持不变。
- Reduce Motion、Increase Contrast、Differentiate Without Color、Bold Text 与 Voice Control 行为必须纳入 Preview 与真机验证。

## 真机与发布 Gate

| Gate | 负责人 | 通过标准 |
|---|---|---|
| Watch 布局矩阵 | iOS UI owner + QA | 每个支持的 Watch 尺寸、手腕/Crown 方向、外观、无障碍设置及 OS 均无事实/后果截断，所有主操作与退出操作可触达。 |
| 训练耐久性 | Architecture owner + QA | 每个支持 Watch/OS 组合的 90 分钟/20 个工作组 Session 均无资源终止、无已提交数据丢失，Start、纠正和 Finish 的 p95 ≤1 秒，并报告规定遥测。 |
| 恢复故障矩阵 | Architecture owner + QA | 终止、重启、电池中断、传感器丢失、断连、部分写入、重复传输、延迟/乱序交付后，每条已提交记录恰好恢复一次，最新用户纠正有效。 |
| 识别白名单 | Model owner + Product Owner | 版本冻结的设备/Exercise/支持行分别通过已注册的分类、边界与重复次数阈值；其他情况明确降级为手动/待处理。 |
| RPE 资格 | Model owner + Product Owner | 已注册的 holdout、弃权、纠正、提示负担、漂移与自动使用 Gate 通过后，才可启用已验证的自动使用。 |
| Finish 提醒 | Product Owner + UX owner + QA | 已注册的双信号阈值通过长休息、等待器械、低动作、缺失信号、冷却、误报与漏报测试；任何路径都不会自动结束。 |
| 无障碍 | iOS UI owner + QA | 关键流程可在 VoiceOver、支持的最大 Dynamic Type、Reduce Motion、Increase Contrast、Differentiate Without Color 下完成，且无 Crown-only 操作。 |
| 尺寸/资源预算 | Architecture owner | 裁剪后产物与嵌入模型符合 PRD 预算；有界资产与运行测量附入发布记录。 |
| 隐私/安全 | Product Owner + security/privacy owner | 目标版本所需的数据目的、同意、驻留、保留、删除/导出、远程 AI、认证、加密与事件响应记录已获批准。 |
| AI 计划安全 | Product Owner + qualified reviewer | 版本化的筛查、警示、计划安全、继续路径与升级处置包，在超出 Product Owner 测试前完成专业评审及验收测试。 |

## 仍开放的 Architecture 决策

Architecture 负责以下决策，但不得改变 UI 合同：

1. App/module 边界、依赖注入、观察策略与领域状态机实现。
2. 本地持久化技术、event/revision schema、迁移、幂等 key、tombstone 与事务边界。
3. Watch Connectivity 传输、排队、重放、去重、交付回执与冲突存储。
4. 公开 Beta 的中国区域账户/后端架构；私有 Alpha 必须不依赖它而保持本地可用。
5. HealthKit 查询/写入适配器、授权状态观测、幂等 Retry 与脱离副本审计。
6. 远程 AI gateway、请求/digest 绑定、超时/降级、安全/schema 验证、审计存储与 provider policy 执行。
7. Model 打包、更新策略、端侧执行预算、support-matrix 版本化与 feature flag。
8. iPhone 根导航容器与 deep-link registry；已冻结的概念路由和恢复行为不可被合并。
9. 首条冻结证据行以外的精确 OS/device 支持矩阵及 CI/真机实验室覆盖。

## 明确延期的产品决策

- `DV-001`–`DV-003`：试点延续、竞争定位与后续复核节奏。
- `DV-004`–`DV-006`：提醒、RPE 与扩展远程 AI 的工作点。
- `DV-007`：有界 Plan 文件解析器限制必须在 Story 验收前冻结。
- `DV-008`–`DV-009`：后续 AI 对话形式与解释密度；完整复核和批准仍是不变量。
- `DV-010`–`DV-012`：识别白名单、RPE 自动化模式与后续 AI 性能阈值。

## 实现启动顺序

1. 建立领域标识、权威规则、状态机与 Token 生成。
2. 在引入传感器或 AI 之前，实现 Watch 持久训练主干（`WC-01`–`WC-06`）、本地持久化与恢复。
3. 针对真实边界状态实现 iPhone 接收、Session Review、History 与 Sync & Recovery。
4. 添加计划、提案批准、交付、Analysis、catalog 与有界 Plan exchange。
5. 在能力与授权 Gate 后添加可选 HealthKit、账户/后端与远程 AI 适配器。
6. 在启用自动识别、RPE 自动使用或提醒候选之前，执行无障碍、本地化、故障、资源与真机矩阵。

## 交接接受 Gate

Product Owner 已于 2026-09-12 接受本交接，并将其冻结为 Architecture 的 Native UI 合同。`ND-04` 与 `bmad-native-ui-design` 工作流现已完成。本次接受并不豁免上述任何已分配负责人的真机、模型、隐私/安全、安全性或发布 Gate。下一工作流为 `bmad-architecture`。
