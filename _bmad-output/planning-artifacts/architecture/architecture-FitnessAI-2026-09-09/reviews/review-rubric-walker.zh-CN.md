# Architecture Spine Rubric Walker 审查

**目标：** `../ARCHITECTURE-SPINE.md`  
**已核对译本：** `../ARCHITECTURE-SPINE.zh-CN.md`  
**审查视角：** BMad Architecture good-spine checklist  
**日期：** 2026-09-10  
**结论：** **NEEDS FIXES**

这份 Spine 拥有强健且少见地连贯的核心：它命名了设计范式，为每个 AD 提供 `Binds` / `Prevents` / `Rule`，将持久事实与适配器分离，保留用户创作的修订，并覆盖设备所有权、本地持久化、AI 批准、HealthKit、分析、环境、展示及未来云端工作。中英文副本的结构、AD ID、限制、技术栈选择、能力行与延后决定一致。它暂时不应定稿，因为其中一句保留规则可能被实现为破坏性删除 iPhone 历史记录，而且仍有若干倡议级接缝可能产生互不兼容的实现。

## 发现

### F1 — CRITICAL — 七天保留规则可能被理解为允许删除 iPhone 历史记录

- **位置：** AD-5 Rule；对照 AD-3 与 Capability → Architecture Map。
- **发现：** AD-5 约束两端数据库，并写道“已确认事实保留初始七天窗口”。它没有说明这只适用于已确认的 Watch 端暂存副本。AD-3 另行说明 iPhone 拥有长期记录，但没有定义保留策略。因此，一个持久化单元可以无限期保留 iPhone 训练事实，另一个则可以在七天后自动删除任何已确认的结构化事实，而两者都能看似合理地声称合规。
- **为何重要：** 这个歧义位于破坏性数据边界，可能抹除 Training History、使 Analysis 失效，并与已声明的 iPhone 长期事实所有权冲突。
- **可执行修复：** 重写保留句，将七天安全窗口明确限定为冗余且已确认的 **Watch 端传输副本**。声明 iPhone 权威 Plans、Workout Sessions、Actual Sets、corrections、approvals 与 effective revisions 绝不会由该清理策略移除。权威事实必须通过明确的用户删除修订或另行绑定的保留策略删除。在中文副本中同步相同措辞。
- **处置：** 定稿前自动修复。

### F2 — HIGH — 引用了已接受的八动作识别种子，但未标明具体动作

- **位置：** AD-6 Rule（“accepted eight-exercise candidate set”）；`.memlog.md` 识别决定。
- **发现：** Spine 既未列出八个动作，也未指向包含该清单的版本化产物。memlog 中已接受的集合为 barbell bench press、incline dumbbell press、assisted pull-up、barbell row、seated row、lateral raise、hammer curl 与 barbell Romanian deadlift。模型单元、onboarding 单元和 UI support-matrix 单元可能选择不同动作，却都声称实现了“已接受的集合”。
- **为何重要：** 支持边界控制产品可以声称识别什么。出现分歧会导致不受支持的自动化、误导性的 onboarding 和不可比较的证据。
- **可执行修复：** 在 AD-6 中列出全部八个动作，或将 AD-6 绑定到已签入、版本化的 support-matrix 产物；其 v1 行必须包含这些准确的 canonical Exercise IDs，并分别验证分类、组边界及次数计数能力。在独立证据形成前，将第二批/仅手动集合保留在 v1 之外。
- **处置：** 定稿前自动修复。

### F3 — HIGH — Watch 离线发起训练缺少 identity 规则

- **位置：** AD-3 Rule；AD-4 Rule；手机/Watch 能力行。
- **发现：** AD-3 说明配对使用时由 iPhone 创建共享 session identity，同时 Watch 拥有离线事实与 active-session recovery。文档未决定拥有缓存 Plan、但无法连接 iPhone 的 Watch 是否可以开始新训练。如果可以，则没有规则定义临时稳定 ID 及后续协调；如果不可以，则没有规则要求 Watch 阻止新训练启动，同时仍允许恢复既有训练。
- **为何重要：** 独立的 iPhone 与 Watch session-state 实现可能创建重复 sessions、把事实附加到不同 snapshots，或静默拒绝产品期望的离线行为。
- **可执行修复：** 明确拓扑。建议：正常配对流程由 iPhone 发起 identity；Watch 始终可以恢复已签发的 active/recoverable identity。然后二选一：(a) 允许断连 Watch 使用 Watch 生成的全局唯一临时 session ID 加缓存 Plan revision 启动，iPhone 幂等接纳且绝不按时间合并；或 (b) 明确将断连新训练启动排除在 Alpha 之外。在中文副本中加入相同规则。
- **处置：** 仅当 memlog 尚未确定断连 Watch 能否启动时讨论；否则根据已接受决定自动修复。

### F4 — HIGH — 负重语义对于产品自己的动作集合过于狭窄

- **位置：** Consistency Conventions（“Loads preserve entered value and kg/lb”）；AD-7 Safety Rules；AD-10 exchange；AD-11 Analysis。
- **发现：** Spine 保留数值和 kg/lb，却未绑定负重种类或录入基准。辅助引体向上已经属于 v1 识别种子，PRD 也区分外部负重、自重、辅助、计时及其他不可比较训练。实现可以把辅助重量编码为正负重、负数、体重扣除或自由文本；哑铃/器械数值也可能代表总重量或单侧重量。
- **为何重要：** 即使原始数值和单位被忠实保留，不兼容的负重语义仍会破坏 Safety Rule 检查、Plan 交换、下一组建议、历史比较及训练容量 Analysis。
- **可执行修复：** 增加平台中立的负重契约，保留权威录入数值/单位，**并且**保留明确的负重 kind 与 basis（至少包括 external、bodyweight、assisted、unloaded/timed/non-comparable，以及适用时的 total 与 per-side）。派生规范值必须保留来源，且不得把 assisted/bodyweight/timed 训练折叠进外部负重容量。具体 schema 细节可以放在 Spine 下游，但这些语义区别必须在此绑定。
- **处置：** 定稿前自动修复。

### F5 — HIGH — 必需的内置 AI 路线缺少可运行的私有 Alpha gateway 边界

- **位置：** AD-8；AD-13；Deferred 第 2 与第 5 项。
- **发现：** AD-8 要求内置 DeepSeek 使用 FitnessAI gateway，AD-13 则说明私有 Alpha 拥有独立 endpoints、identities 与 credentials。然而，该 gateway 的托管、地区、调用者认证、部署、回滚及滥用控制被延后到 public beta。服务商政策延后项只阻止真实远程 **health** 流量，不阻止普通 AI Plan 生成，因此私有 Alpha 内置路线仍需要运行上连贯的 gateway。
- **为何重要：** 第一个实现单元无法知道内置路线是否启用、运行于何处、仅 owner Alpha 如何认证，以及哪些失败必须 fail closed。两个单元可能在遵守当前文本的同时选择不兼容的地区/认证/部署方案。
- **可执行修复：** 定稿前选择以下两个明确契约之一：(a) 私有 Alpha 只提供 BYOK，内置路线在 gateway Gate 关闭前保持 feature-disabled；或 (b) 绑定最小私有 Alpha gateway runtime/region、仅 owner 认证、secret store、endpoint 分离、request-size/rate ceilings、脱敏日志、部署/回滚 owner 及 kill switch。生产服务商选择与规模化工程继续延后。
- **处置：** 讨论；这会改变第一个可运行 Alpha 中“内置默认”的含义。

### F6 — HIGH — Public-beta 云端延后项仍遗漏不可协商的生命周期不变量

- **位置：** Deferred 第 5 项；AD-2 与 AD-13。
- **发现：** 扩展后的延后项现在保留 tenant isolation、禁止跨账号合并、export、30 天删除、tombstones、incident response、deployment 与 rollback。它仍未保留本地优先事件同步、可见的恢复进度/失败、带未同步数据警告的 sign-out retain/remove 选择、破坏性隐私操作的重新认证，以及 auth/cloud failure 期间持续本地记录。
- **为何重要：** 这些不是服务商选择，而是决定破坏性行为以及云端/账号单元能否覆盖或搁置本地事实的规则。把它们留在宽泛的“选择并威胁建模”项目中，会允许下一层出现不兼容的云端设计。
- **可执行修复：** 继续延后 backend/provider 细节，但把这些生命周期语义作为后续设计必须保留的不变量加入同一 Deferred 项。声明 application-cloud sync 继承 AD-2 修订/冲突规则，不得引入只按时钟判断的 last-write-wins。
- **处置：** 定稿前在 Deferred 中自动修复。

### F7 — MEDIUM — 合并规则未明确覆盖结构性和破坏性修订

- **位置：** AD-2 Rule。
- **发现：** AD-2 定义了不同字段修改的自动合并和同一字段修改的可见分支，但其约束的修改集合还包括组边界 split/merge、insert、delete、completion state 与 Plan revision changes。这些是图/结构修改，而不是普通字段修改。规则没有说明它们是否可以与并发子项编辑自动合并，也没有说明 delete-versus-edit 如何保持可见。
- **为何重要：** 面向字段的实现可能在并发 Watch/iPhone 纠正中丢失次数或复活已删除 Sets，同时仍然遵循已声明的字段规则。
- **可执行修复：** 增加一句可执行规则：当因果分支重叠时，破坏性或结构性冲突（split/merge、insert/delete、completion、Plan topology）绝不自动折叠；保留每个用户创作的分支与依赖事实，将结果标为 pending/stale，并要求确定性安全解决或 iPhone 明确选择。Story 级合并算法可以留在 Spine 之外。
- **处置：** 定稿前自动修复。

### F8 — MEDIUM — 尽管 AD-13 声称约束日志，却未绑定 Alpha 诊断/telemetry 隐私

- **位置：** AD-13 Binds/Rule；AD-5；AD-8 audit rule；PRD NFR-PRIV-003 与 NFR-SEC-003。
- **发现：** AD-13 在 `Binds` 中列出 logs，但其 Rule 只要求 secret checks。AD-8 保护 AI audit 内容，却没有跨领域规则阻止普通 logs/crash diagnostics 包含 workout facts、Exercise/load/RPE、health summaries、free-text notes、raw signals 或 request bodies。Public-beta incident-response 延后项没有解决私有 Alpha diagnostics。
- **为何重要：** 否则，独立的适配器与展示单元会记录不同 payloads，造成隐私泄漏，并使后续 telemetry 清理不可靠。
- **可执行修复：** 增加 Alpha observability 约定：只允许 structured identifiers/state codes/versions/timing；operational logs 或 automatic diagnostic payloads 中不得包含 secrets、request/response bodies、free text、HealthKit values、raw signals 或 Exercise/load/RPE content。私有 Alpha 的远程 telemetry 应为 opt-in 或禁用，并明确本地 export/support 处理方式。
- **处置：** 定稿前自动修复。

### F9 — LOW — Mermaid 围栏被转义，无法渲染为图表

- **位置：** 两种语言副本中的 Structural Seed。
- **发现：** 文档包含字面量 `\`\`\`mermaid` 与 `\`\`\`` 标记。它们是被转义的 Markdown 文本，不是 Mermaid fenced block。
- **为何重要：** 结构种子是唯一承载依赖形状的图；将其渲染成标点会降低产物可用性，并且不满足技能的有效 Mermaid 要求。
- **可执行修复：** 从两份副本的开始和结束围栏中移除反斜杠，然后渲染或解析检查 Mermaid block。
- **处置：** 自动修复。

## Good-Spine Checklist 评估

| Checklist 项目 | 评估 | 备注 |
|---|---|---|
| 为下一层固定真正的分歧点 | **Needs fixes** | 核心事实、同步、AI、HealthKit、分析、UI 与发布 Gate 很强；F1–F8 仍是跨单元接缝。 |
| 每个 AD Rule 均可执行并真正防止其所述分歧 | **Needs fixes** | 大部分满足。AD-5 保留规则存在危险歧义；AD-6 指向未命名集合；AD-13 约束日志却没有日志规则。 |
| Deferred 中没有会让两个单元分歧的事项 | **Needs fixes** | Public-beta 账号生命周期与私有 Alpha gateway 边界需要更强的保留不变量。 |
| 已验证命名技术为当前版本 | **Pass with implementation check** | memlog 记录了本地 Xcode/Swift 验证和当前 GRDB 检查。项目存在后，准确 GRDB pin 仍需正常项目解析验证。 |
| 认可而非反驳 brownfield 代码库 | **Pass / not applicable** | 原生实现为 greenfield；既有规划/设计产物被视为来源。没有替换生产约定。 |
| 覆盖驱动规范的能力 | **Needs fixes** | 整体覆盖很强。负重语义、离线发起、诊断及若干延后的账号生命周期不变量尚未保留。已明确标出已知的纯手机与 Apple Health 覆盖决定，等待上游对齐。 |
| 未削弱继承的父级 Spine | **Not applicable** | 未声明父级 Spine。 |
| 每个倡议级维度均已决定、延后或开放 | **Needs fixes** | 已命名部署/环境，但必需的私有 Alpha AI gateway 既未进行最小绑定，也未禁用。运行诊断也保持沉默。 |
| 中英文副本保留相同契约 | **Pass** | 两者均为 182 行，具有相同 frontmatter fields、AD-1…AD-14 顺序、数字限制、技术栈、能力映射与延后清单。未发现决定级翻译分歧。修复必须同步。 |

## 推荐 Gate 处置

1. 在两种语言副本中直接应用 F1、F2、F4、F6、F7、F8 与 F9。
2. 根据产品期望的断连 Watch 行为解决 F3；不得从“通常由 iPhone 启动”推断答案。
3. 将 F5 作为唯一可能需要产品/架构选择的事项解决：私有 Alpha 仅 BYOK，或提供最小约束的仅 owner gateway。
4. 重新运行 `lint_spine.py`，确认 Mermaid 围栏可以渲染，并在设置 `status: final` 前比较双语 AD/限制结构。

## Re-review — 2026-09-10

**结论：** **NEEDS ONE REMAINING FIX**

本次复核仅针对最新中英文 Spine 检查原始发现 F1–F8。对于检查的每项修复，两份副本仍保持决定等价。

| 原始发现 | 状态 | 复核证据 |
|---|---|---|
| F1 — 七天保留范围 | **Resolved** | AD-5 现在将该窗口限定为 whole-object `applied` 后的冗余 Watch 端结构化传输副本，并要求权威 iPhone 事实只能通过明确删除修订或另行绑定的策略删除。 |
| F2 — 未命名的八动作种子 | **Resolved** | AD-6 在两种语言中列出准确的八个 v1 候选动作，并将分类、组边界与次数计数验证分开。 |
| F3 — 断连 Watch 发起 | **Resolved** | AD-3 允许持有完整缓存 Plan 的断连 Watch 创建全局唯一 session identity，由 iPhone 原样接纳；事实保留来源 session 与 snapshot identity，且不按时间合并。 |
| F4 — 不完整的负重语义 | **Resolved** | Consistency Conventions 现在绑定权威 value/unit 以及 load kind 与 basis，包括 assisted/bodyweight/timed/non-comparable 和 total/per-side 区别。 |
| F5 — 私有 Alpha gateway 边界 | **Partially resolved; one high issue remains** | AD-8 现在绑定 Alpha 流量前的 owner authentication、secret storage、allowlists、ceilings、rotation、redacted logs、rollback ownership 与 kill switch。它仍未固定或建立前置流量 Gate 来确定 **非 Health** AI 流量的 gateway deployment runtime/provider 与 processing region。Deferred 下的 region Gate 适用于远程 HealthKit 派生值，而普通 Plan 生成流量仍然启用。请在 AD-8 的“before Alpha traffic”发布记录中加入 provider/runtime/processing-region，或明确延后并 fail-close 全部内置 gateway 流量，直到这些字段冻结。 |
| F6 — Public-beta 云端生命周期 | **Resolved** | Deferred 现在保留 AD-2 同步语义、禁止仅时钟 LWW、auth/cloud failure 期间继续本地记录、可见 restore state、带未同步警告的 sign-out retain/remove，以及破坏性操作重新认证。 |
| F7 — 结构性/破坏性冲突 | **Resolved** | AD-2 现在定义规范 revision DAG/reducer，并禁止自动折叠相互重叠的 split/merge、insert/delete、reorder、completion 与 Plan-topology 分支。 |
| F8 — 诊断/telemetry 隐私 | **Resolved** | AD-13 将 logs/diagnostics 限制为结构化 metadata，排除敏感 payload 类，并在未明确 opt in 时禁用私有 Alpha 远程 telemetry。 |

**必需的最终修复：** 在两份副本中修改 AD-8，使 pre-Alpha gateway Gate 明确冻结 deployment runtime/provider 与 processing region（连同版本化发布记录），或使整个内置路线保持禁用，直到这些字段冻结。原始 F1–F8 中没有其他阻断项。

### Final Re-review — 2026-09-10

**结论：PASS**

AD-8 现在要求在任何内置 Alpha 流量开始前冻结并记录 gateway runtime provider 与 data-processing region，并明确要求该 Gate 关闭前内置路线保持禁用。中英文规则等价。这解决了 F5 最后剩余的部分；全部原始 F1–F8 发现均已解决，此审查视角下没有剩余阻断项。
