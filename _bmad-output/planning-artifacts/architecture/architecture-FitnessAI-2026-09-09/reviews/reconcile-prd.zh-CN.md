# PRD → Architecture Spine 对照审查

## 结论

**REVISE BEFORE FINALIZE**

Spine 对核心架构的覆盖良好，但输入对照尚未完成。Product Owner 的两项后续决定与权威 PRD 直接冲突，另外三项跨领域 PRD 合同缺失或仅被宽泛延后。在解决两处上游矛盾，并将缺失的共享预算/生命周期规则纳入约束或明确延后之前，最终版本不应声称已与 PRD 完全一致。

已审查输入：

- 主要输入：`../../../prds/prd-FitnessAI-2026-07-19/prd.md`
- 翻译校验：`../../../prds/prd-FitnessAI-2026-07-19/prd.zh-CN.md`
- 候选 Spine：`../ARCHITECTURE-SPINE.md`

英文和中文 PRD 在下列全部发现上保持一致；所检查的承重段落中未发现仅存在于翻译版本的差异。

## 最高优先级发现

### F1 — BLOCKER：phone-only 记录是已接受的架构覆盖，但与 PRD 的 Watch 权威合同冲突

**PRD：**§3.1 声明 Apple Watch 是训练中界面和权威端（`prd.md:131`），FR-001 声明计划或自由训练会话在 Apple Watch 上开始（`prd.md:227`）。私有 Alpha 规范性集合包含 FR-001（`prd.md:196`）。中文副本保持相同规则（`prd.zh-CN.md:131`、`:227`）。

**Spine：**AD-3 明确约束 phone-only 会话，并让 iPhone 记录使用相同的 ID、状态、持久化和 Analysis（`ARCHITECTURE-SPINE.md:43-47`）；能力映射再次列出 iPhone 本地 phone-only workout（`:154-165`）。这符合 Product Owner 后续作出的“很多用户没有 Watch”决定，但它与当前 PRD 的产品拓扑并不相同。Spine 在 Deferred 中承认了这项冲突（`:169`），但没有在完成对照前定义实现时应以哪个需求来源为准。

**所需处置：**更新 PRD/UX，将 phone-only 记录设为一等路径，并把“Watch 权威端”重新定义为“仅当配对 Watch 作为活动记录设备时的权威端”；或者从首版 Spine 中删除 phone-only 记录。鉴于 Product Owner 已明确决定，预期应选择前者。继续保留 AD-3 已经要求的 phone-only 与 paired 模式共用一套会话/事实模型。

### F2 — BLOCKER：私有 Alpha 远程使用 Apple Health 摘要，与 PRD 的明确排除冲突

**PRD：**Apple Health 被明确排除为首个可用版本的远程 AI 输入（`prd.md:174`、`:210`）；FR-082 将 Alpha AI 输入限制为对话、个人资料/限制，以及用户明确允许且已经确认/纠正的 FitnessAI 记录（`:341`）；DV-006 将 Apple Health AI 使用延后至 Alpha 之后（`:453`）。中文副本表达相同（`prd.zh-CN.md:174`、`:210`、`:341`、`:453`）。FR-086/NFR-PRIV-007 定义了同意/最小化规则，但没有取消 FR-082 的 Alpha 排除（`prd.md:345`、`:414`）。

**Spine：**AD-8 约束“remote health context”，并在每次远程请求展示精确预览后允许发送（`ARCHITECTURE-SPINE.md:73-77`）；AD-9 将范围较广的 Alpha HealthKit 允许清单作为本地摘要提供给 AD-8（`:79-83`）。这符合 Product Owner 的后续批准，但改变了首版范围和隐私威胁面。Deferred 记录了未解决的来源冲突（`:169`）和服务商政策前置条件（`:170`）。

**所需处置：**更新 FR-082、首版非目标、§6.3 和 DV-006，仅允许在 AD-8 逐次授权下使用用户选定的、本地摘要化 Apple Health 类别；继续禁止原始运动/心率流。在服务商法律主体、地区/跨境路径、保留/缓存、模型训练政策、删除/撤回和披露尚未冻结前，实现必须保持无法发送真实健康摘要，正如现有 Deferred 条目所要求。

### F3 — HIGH：共享主动打断预算被遗漏

**PRD：**SM-INT-001 规定，在约五个动作、二十个正式组的代表性会话中，主动确认/纠错请求不得超过五次；Exercise、rep、load 和 RPE 提示共同消耗同一预算（`prd.md:35`）。FR-011 和 FR-025 明确依赖该预算（`:240`、`:257`），NFR-RPE-005 要求 RPE 负担 Gate 适配该预算（`:374`）。它属于私有 Alpha 规范性验收集合（`:196`）。

**Spine：**AD-6 管理识别、RPE、安全休息提示和 Forgotten Finish，但没有定义共享计数器/预算或仲裁规则（`ARCHITECTURE-SPINE.md:61-65`）。如果缺少单一跨功能规则，识别和 RPE 单元可能各自局部合规，但合计超过产品预算。

**所需处置：**在 AD-6 或一致性约定中约束五次请求的代表性会话预算；定义一个由所有主动 Exercise/rep/load/RPE 提示共享的 session-scoped 预算。Forgotten Finish 应明确归类为预算以内或以外，因为 PRD 当前措辞只列出确认/纠错提示。

### F4 — HIGH：Watch/App/模型体积预算和发布测量缺失

**PRD：**NFR-SIZE-001 至 NFR-SIZE-005 约束 iPhone thinned 安装体积上限（500 MB）、Watch 上限/内部目标（75 MB/25 MB）、Watch ML 总预算（6 MB）、逐组 RPE 预算（2 MB）、排除 Watch 大型媒体，以及使用 App Thinning/TestFlight 测量（`prd.md:362-366`）。中文副本一致（`prd.zh-CN.md:362-366`）。这些规则尤为承重，因为 Watch 存储空间和未来推理范围推动了 phone-first 拓扑。

**Spine：**AD-3 只说 Watch 保留“minimum inference assets”（`ARCHITECTURE-SPINE.md:47`），AD-13 要求真机证据（`:103-107`），但两者都没有约束数值预算或发布体积测量方法。Deferred 提到未来电量预算和 90 分钟存储证据，而不是已经确定的体积限制（`:172`）。

**所需处置：**把现有数值体积上限/目标和 App Thinning 测量加入一致性约定或 AD-13 规则。这些是继承自 PRD 的约束，架构不得静默替换成其他工作点。

### F5 — HIGH：public-beta 账号/云生命周期延后得过于宽泛，无法保护其破坏性数据语义

**PRD：**public-beta 账号范围要求应用云恢复和本地优先同步（UJ-5；§6.2）、可靠的冲突保存（FR-042–048）、防止离线复活的删除墓碑（FR-067）、可观察的恢复状态（FR-068）、退出登录时保留/移除处理（FR-069）、不同账号不合并（FR-070）、30 天删除/去标识化（NFR-PRIV-004）、自助完整账号导出（NFR-PRIV-005）、安全认证/会话撤销/重新认证（NFR-SEC-002）以及中国区治理（`prd.md:109-125`、`:203`、`:283-289`、`:320-323`、`:409-416`）。

**Spine：**AD-2/4 覆盖本地修订和配对 Watch 同步，而不覆盖应用云账号同步。Deferred 延后了中国区账号/同步基础设施的选择和威胁建模，以及“user-rights operations”（`ARCHITECTURE-SPINE.md:173`），但没有保留下列不明显的生命周期不变量。因此，后续云端单元可能选择 last-write-wins 删除、把本地数据合并到另一个账号，或只提供联系支持的导出，同时看起来仍然满足宽泛的 Deferred 措辞。

**所需处置：**继续延后服务商/基础设施选择，但扩展 Deferred 合同，明确列出：本地优先事件同步；不得仅按时间解决冲突；删除墓碑/禁止离线复活；可见恢复状态；退出登录时提供保留/移除选择并披露未同步数据影响；禁止静默跨账号合并；自助完整导出/删除；30 天删除/去标识化；破坏性隐私操作重新认证；以及认证/云端失败时本地记录仍可继续。

## 覆盖矩阵

| PRD 承重领域 | Spine 处置 | 评估 |
|---|---|---|
| 可信本地提交、完整性、纠错保全、不可变 Plan 快照（SM-COMP、SM-PRES、FR-002–007、FR-012–014、FR-029、FR-061–066） | AD-2、AD-5；显式状态约定 | **已覆盖。** 原子修订/outbox/invalidation、可见分支、不可变活动会话快照、不可读存储规则和幂等恢复建立了所需所有权模型。Story 级 pending-fragment UI 继续保留在 PRD 中。 |
| Phone-only 用户和配对设备所有权 | AD-3；能力映射；Deferred | **存在冲突，未完成对照。** 架构包含后续 PO 覆盖，而 PRD 仍把 Watch 设为首版权威端和 Start 界面。见 F1。 |
| Watch 传输、离线队列、确认、重复/乱序（FR-043、FR-046、FR-081、FR-084、NFR-AI-003、NFR-RECOV） | AD-4、AD-2、AD-5 | **已覆盖 iPhone↔Watch。** 可靠 outbox、因果信封、可靠接收确认、最后完整计划激活和稳定 ID 防止主要分歧。 |
| 并发字段编辑和冲突解决 | AD-2、AD-4、AD-11 | **已覆盖。** 不同字段自动合并，同字段分支保持可见，设备时钟/到达顺序不能选择事实；由 iPhone 解决。 |
| 识别支持矩阵、abstention、纠错来源、手动 fallback | AD-6；约定；Stack baseline | **大体覆盖。** Series 11 Alpha 证据行和 Series 6+/watchOS 11+ 安装基线均已明确。但 PRD 的固定可行性指标（75% 分类；±3 秒边界且 precision/recall 达 80%；80% 次数误差在 ±2 内）没有列出。它们可以继续作为 PRD 验收标准，但 AD-6 的“exact operating points”措辞不得暗示无需 PRD 变更即可重新决定这些指标。 |
| 跨功能主动提示负担（SM-INT-001） | 无 | **缺失。** 见 F3。 |
| RPE opt-in、五次估算 Gate、来源、校准、abstention、漂移 | AD-6；predicted/confirmed/corrected 约定 | **在不变量层面已覆盖。** 精确的 ±1 正确判定和滚动五次中两次漂移阈值有所压缩；AD-6 明确约束五次估算 Gate 和漂移，PRD 继续作为详细验收权威。 |
| Forgotten Finish：手动权威、双信号、不自动结束、缺失信号抑制/冷却 | AD-6 | **已覆盖。** 已接受的 15 分钟触发/冷却更强且明确。误报/漏报率验证继续正确地由证据 Gate 约束。 |
| 计划执行默认值、下一组建议、替代动作（FR-016–019、FR-027–035） | AD-2、AD-3、AD-7；规范 Exercise/版本约定 | **部分覆盖。** 用户权威事实和禁止 AI 修改活动会话已约束，但替代动作匹配和下一组建议确认主要留给 PRD/domain stories。仅当 PRD 仍是强制下游输入时才可接受；未发现相互冲突的 Spine 规则。 |
| History/Analysis 事实、陈旧结果、不完整/冲突排除、版本管理 | AD-11；AD-2 | **已覆盖。** PRD 保留详细计算公式（区分自重/助力、不编造 %1RM、保留中断时长、用户选择 Primary Exercise）。 |
| AI-native 完整计划/Diff、一次批准、原子提交、禁止静默变更 | AD-7、AD-2 | **充分覆盖。** AI 不可信但生成完整原生结构；一次 digest-bound 批准提交整个修订，因此不需要逐项重录。 |
| 非诊断安全停止和平衡型确定性规则包 | AD-7；Deferred 专业审核 | **已覆盖。** 受影响范围停止、警示征兆、单位/矛盾/规范支持/个人渐进检查、阻塞结果、版本化和审核 Gate 均已存在。 |
| 内置 DeepSeek gateway 与 DeepSeek BYOK | AD-8、AD-5、AD-12 | **已覆盖。** 产品密钥保留在服务端；BYOK 密钥仅在设备且绕过 FitnessAI 服务端；任意端点被排除；适配器声明能力。 |
| 远程 AI 同意、最小范围、服务商隔离、不含内容/密钥的审计 | AD-8、AD-9；Deferred 服务商政策 Gate | **除来源范围冲突外已覆盖。** 逐次 allow/narrow/cancel 和审计最小化合理。健康摘要资格与 FR-082 冲突；见 F2。 |
| Apple Health 本地访问/副本、读取状态诚实、幂等写入、detachment | AD-9 | **已覆盖。** FitnessAI 本地事实保持权威；读取状态不推断拒绝；副本 identity/revision 和禁止静默重建均已明确。广泛 Alpha 允许清单代表后续 PO 决定，必须同步回上游。 |
| 数据分类、本地保护、禁用 iCloud/CloudKit/备份、原始流本地化、密钥处理 | AD-5、AD-8、AD-9、AD-13 | **已覆盖私有 Alpha。** 研究/模型开发上传仍隐含处于禁用路径之外；如果后续加入，必须明确 NFR-PRIV-003 的独立同意/保留/撤回合同。 |
| 计划文件可移植性和不可信 parser | AD-10 | **已覆盖。** 通用 `.json` 配合内部标记，仍满足有文档的 FitnessAI 自有版本化载荷。边界、完整预览、仅创建新草稿的导入、映射，以及禁止可执行/外部内容都已明确。Parser 时间/内存预算仍然缺失；如果现在不确定，应继续作为 Story 验收前的 Deferred 条目。 |
| 应用/模型体积和 Watch 媒体放置 | 仅 AD-3，定性描述 | **缺失数值不变量。** 见 F4。 |
| 运行时/电量/温度/延迟真机证据 | AD-13；Deferred | **大体覆盖。** 真机测试和 90 分钟证据已存在；PRD 的 Start/correction/Finish p95 ≤1 秒，以及资源终止/丢失为零未列入 Spine，但继续是直接验收约束。 |
| 设备/OS 矩阵和仅凭证据扩展 | AD-6、AD-13、Stack | **已覆盖。** iPhone 11+/iOS 18+ 与 Series 6+/watchOS 11+ 得到保留；自动化主张按证据收窄并保留手动 fallback。扩展不能仅凭模拟器证据。 |
| 环境、密钥隔离、可选功能 fail-closed 控制、禁止意外公开发布 | AD-13 | **已覆盖。** 开发/私有 Alpha/未来生产环境隔离和发布 Gate 均已明确。 |
| Public-beta 账号/云恢复、删除/导出/认证生命周期 | 宽泛 Deferred | **延后不足。** 见 F5。 |
| Post-MVP 服务商、任意/自托管端点、Android、更广分享格式和 HealthKit/医疗类别 | Deferred | **已覆盖。** 正确地延后，同时要求新适配器、合同、披露和证据，而不是削弱 AD。 |
| 私有 Alpha 完整视觉/无障碍/状态合同（NFR-UX-001） | AD-13 提到无障碍；来源清单包含 DESIGN/EXPERIENCE | **通过继承部分覆盖。** Light/dark、Dynamic Type、VoiceOver，以及 error、empty、loading、offline 和 recovery 状态通过 PRD/UX 来源继续构成约束，但 Spine 没有再次列出。未发现相互冲突的 Spine 规则。 |

## 处置摘要

- **已由 AD/Convention 覆盖：**本地事实和修订语义；iPhone↔Watch 因果同步；恢复和保留；证据 Gate 自动化；RPE/结束安全；AI 提案/批准/提交；DeepSeek gateway/BYOK；HealthKit 副本/读取状态规则；有界 JSON 计划交换；修订绑定 Analysis；模块化代码边界；环境和真机 Gate。
- **已通过充分重访条件明确延后：**真实远程健康流量之前的服务商法律/政策细节；Safety Rule Pack 数值 fixtures/专业审核；更广自动化证据；SQLCipher 威胁评审；Post-Alpha 服务商/端点/Android/分享/医疗类别。
- **已经明确延后但仍过于宽泛：**public-beta 账号/云生命周期（F5）。
- **尚未落位：**五次请求共享打断预算（F3）；应用/模型数值体积预算和发布测量（F4）。
- **已作为架构决定落位但与当前 PRD 冲突：**phone-only 记录（F1）；私有 Alpha 远程使用 Apple Health 摘要（F2）。

## Finalize Gate 建议

在解决 F1–F4 前，不要把 Spine 的 `status: final` 标记为“已完成 PRD 对照”。只有明确列出 F5 不可妥协的生命周期语义后，F5 才可以继续保留在 Deferred 中。推荐的解决方式是保留 Product Owner 后续决定对应的 AD-3/AD-8/AD-9，并更新 PRD 的两个语言版本，使下游 Story 生成获得一致的事实来源。
