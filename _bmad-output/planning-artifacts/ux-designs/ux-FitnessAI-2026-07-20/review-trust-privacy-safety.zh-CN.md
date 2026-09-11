---
review: trust-privacy-safety
artifact: FitnessAI UX spines
date: 2026-07-20
verdict: changes-required
critical: 0
high: 5
medium: 3
low: 1
---

# 信任、隐私与安全评审

## 结论

**脊柱定稿前需要修改。** UX 契约在本地持久提交、来源追踪、限定范围的纠正、幂等恢复、不支持/手动降级、负荷诚实性、RPE 弃权、非医疗语言，以及普通记录与研究同意分离方面表现非常扎实。未发现 critical 缺陷。仍有五项 high 严重度缺口：当前契约可能承诺平台无法观测的状态，或让破坏性生命周期操作的范围保持歧义。

严重级别计数：**0 critical · 5 high · 3 medium · 1 low**。

最高风险：通用权限模型为 HealthKit 承诺了 `granted/denied/revoked` 状态，但应用无法判断读权限是否被拒绝；此外，deletion 的“completed”没有覆盖 Watch/iPhone raw 数据、同步数据、紧凑个性化状态、备份/法律例外和离线设备的逐副本定义。

## 范围与证据

已评审：

- `DESIGN.md`、`DESIGN.zh-CN.md`、`EXPERIENCE.md`、`EXPERIENCE.zh-CN.md` 和 `.memlog.md`。
- frontmatter 中的全部五份来源：Product Brief、PRD、市场研究、多厂商 IMU 研究，以及 Apple Watch RPE 研究。
- Apple 当前 HealthKit 授权文档，用于平台可观测性核查。

发现项使用英文脊柱与来源文档的行号；中文脊柱在所评审章节中具有匹配的结构和行号对齐。

## 发现项

| ID | 严重度 | 契约缺口 | 可实施修复 |
|---|---|---|---|
| TPS-01 | High | HealthKit 读权限被建模为可观测的 `granted/denied/revoked` 状态。 | 按能力拆分权限状态模型；绝不声称知道 HealthKit 读权限被拒绝。 |
| TPS-02 | High | “Deletion completed”没有明确逐副本范围，尤其缺少本地 raw HR/IMU 和 PRD 的 30 天账户删除边界。 | 定义删除范围、逐副本进度、保留/法律例外和精确完成语义。 |
| TPS-03 | High | 退出登录后保留的本地数据没有通过契约与其他账户隔离，也未阻止其使用新凭据同步。 | 定义账户绑定加密、可见性、队列暂停和明确的转移资格。 |
| TPS-04 | High | 删除 tombstone 承诺不复活，但没有把本地提交、云端受理、已知设备传播和离线设备待处理暴露为不同状态。 | 让删除采用与 workout 保存/同步相同的多边界事实模型。 |
| TPS-05 | High | forgotten-Finish 已出现在流程中，但缺少来源要求的双信号与发布 gate 不变量。 | 写明不变量、缺失信号行为、冷却时间和“gate 通过前功能不可用”。 |
| TPS-06 | Medium | 研究同意撤回没有说明停止什么、保留哪些本地数据，以及如何处理既有研究/模型产物。 | 增加独立研究生命周期，涵盖前瞻停止、本地保留选择、删除请求和可追溯限制文案。 |
| TPS-07 | Medium | Export 可追踪，但缺少所需机器可读内容和排除项披露。 | 命名导出清单、格式、来源信息及被排除的本地 raw/研究数据。 |
| TPS-08 | Medium | 活跃 session 中权限撤销缺少有序降级契约。 | 保留已提交事实，只停止受影响流，必要时弃权，保留手动记录，并在安全暂停时报告后果。 |
| TPS-09 | Low | 文案矩阵缺少 auto-used RPE、abstention、HealthKit 不可观测读状态和部分删除的规范措辞。 | 为这些最高风险信任状态增加字面明确的中文优先示例。 |

## 详细发现

### TPS-01 — HealthKit 读授权不支持当前承诺的通用状态模型

**严重度：High**

`EXPERIENCE.md:118` 为 Account & Privacy 提供了“permission not determined/granted/denied/revoked”状态，而 `EXPERIENCE.md:164` 将上下文权限行为同时应用于 HealthKit 和其他权限。对于 HealthKit 读权限，Apple 有意不透露访问是否已授予或拒绝；读权限被拒绝时表现为没有匹配数据。`HKAuthorizationStatus` 描述的是保存/共享授权，而不是可观测的读授权状态。参见 [Apple：HKAuthorizationStatus](https://developer.apple.com/documentation/healthkit/hkauthorizationstatus) 和 [Apple：Authorizing access to health data](https://developer.apple.com/documentation/HealthKit/authorizing-access-to-health-data)。

这是信任缺陷，因为“HealthKit access denied”之类的文案可能断言产品并不知道的事实，并把“无数据”误判为拒绝。

**修复：**定义不同状态族：

- HealthKit share/write：在 API 支持的范围内使用 `not determined / authorized / denied / restricted/error`。
- HealthKit read：使用 `not requested / request presented / data available / no accessible data / limited-window access / query error`；不得区分“denied”和“no matching data”。
- Motion、notification、account 和 research consent 分别保留自己的可观测状态，不继承一个通用 enum。

### TPS-02 — 账户删除没有定义是否擦除本地 raw sensor 数据

**严重度：High**

`EXPERIENCE.md:165` 规定完整高频 HR/IMU 默认留在本地，而 `EXPERIENCE.md:167` 和 Flow 9（`297-305`）规定账户删除显示 completion/failure。契约没有说明删除账户是否也会删除 Watch/iPhone 上的 raw chunk、保留的加密本地账户数据、紧凑个性化状态或本地排队的结构化记录。它还遗漏了 PRD 的要求：账户关联生产数据和同步的紧凑个人模型状态须在 30 天内删除或不可逆去标识化，但已披露的法律例外除外（`prd.md:327-335`）。

因此，当前“completed”标签可能在敏感本地数据仍存在时过度承诺已擦除。

**修复：**确认前至少枚举：这块 Watch、这部 iPhone、中国区同步记录、紧凑个性化状态、研究上传、备份/法律例外，以及其他离线设备。为本地 raw sensor 删除定义独立选择/状态。“Completed”必须命名已完成的范围和任何保留例外；不得把账户删除作为设备擦除的简称。

### TPS-03 — 退出登录后的保留数据没有与账户切换安全隔离

**严重度：High**

`EXPERIENCE.md:168` 和 Flow 9（`300-302`）允许保留加密本地账户数据并禁止静默合并历史，但没有规定退出后数据不可访问、其上传队列被暂停，或新账户凭据绝不能授权旧账户操作。“eligible explicit transfer/merge”也没有资格约束。

**修复：**规定保留数据继续在加密和逻辑上绑定旧账户，其他账户活跃时隐藏，且只有同一账户重新认证后才可同步。切换账户前显示旧账户未同步记录数量，以及保留/移除的影响。只有另有获批的产品/法律契约定义了合格数据、目标、来源信息和可逆性时，才显示跨账户转移；否则不提供。

### TPS-04 — 删除需要与保存和同步同等的边界诚实性

**严重度：High**

记录契约正确地区分 local save、phone receipt 和 cloud acknowledgement（`EXPERIENCE.md:85, 100, 146, 155`）。删除只有通用的 `accepted / in progress / completed / failed`（`101, 160, 167, 297-305`），同时又承诺离线设备或旧队列不会复活数据。无法到达的设备不能被诚实地描述为已经执行删除，“cloud completed”也不等于“all devices completed”。

**修复：**定义 `committed on this device`、`cloud tombstone accepted`、`other device pending`、`applied on known device`、`retention/legal exception` 和 `failed/retry` 等删除边界状态。旧的排队 mutation 和恢复 snapshot 在变得可见之前，必须被 tombstone/revision 顺序拒绝。如果离线设备在请求后重新连接，必须先应用删除，再允许其旧 outbox 发布。用户状态必须区分“已防止复活”和“已在所有设备上物理擦除”。

### TPS-05 — Forgotten-Finish 缺少强制双信号安全 gate

**严重度：High**

脊柱正确禁止自动结束（`EXPERIENCE.md:78, 202`），并把提醒阈值记录为开放问题（`340`）。但它把资格简化为“if eligible”，没有继承来源不变量：必须同时存在朝向用户非训练状态的持续恢复，和力量训练活动持续缺失；单独任何一个信号都不充分（`prd.md:304-310`）。缺失信号、低动作 Exercise、长休息、等待器械、superset/circuit、cooldown 以及 false/missed threshold 尚未在行为上解决。

**修复：**即使数值阈值尚未确定，也要立即把双信号规则加入 component/state 契约。信号缺失或不可靠时不提醒。提醒只能在安全暂停时出现，只提供 Finish/Continue，遵守 cooldown，并在预注册物理设备 gate 通过前保持发布禁用。数值窗口继续作为开放的 gated decision。

### TPS-06 — 研究同意撤回会停止收集，但没有下游生命周期

**严重度：Medium**

普通记录与研究同意的分离是正确的（`EXPERIENCE.md:164-165`）。缺失的是撤回旅程：capture/upload 是否立即停止、未发送 raw chunk 是保留在本地还是删除、已经上传的材料是否删除，以及如何处理已经进入衍生数据集或模型发布的数据。多厂商研究要求可追溯的保留/删除，RPE 研究把未来 raw 上传视为独立治理的 opt-in。

**修复：**增加与账户/HealthKit 权限不同的研究同意生命周期：consented、upload pending、withdrawn locally、server withdrawal accepted、deletion in progress/completed/limited by disclosed lawful or irreversible-derived constraints。撤回不得禁用普通本地记录。产品必须前瞻解释哪些内容可以停止或删除，且不得暗示已发布模型总能被“反训练”。

### TPS-07 — Export 有状态，但含义定义不足

**严重度：Medium**

Flow 9 追踪 export request，但没有命名来源要求的内容或格式。PRD 要求提供有文档的机器可读导出，其中包含 Training Plans、Workout Sessions、Actual Sets、corrections、带 provenance 的 effective RPE 和 account metadata（`prd.md:327-332`）。本地 raw sensor chunk、研究上传和 HealthKit record 具有不同所有权并可能被排除；不说明会产生错误的完整性承诺。

**修复：**请求前显示 export inventory 和格式，包含 revision/provenance 语义，并明确列出排除数据和独立导出路径。“Export completed”必须链接到真实 artifact 及其范围，不能只表示 job success。

### TPS-08 — 活跃 session 中权限撤销没有有序降级契约

**严重度：Medium**

脊柱包含 permission-revoked 和 sensor-gap 状态（`EXPERIENCE.md:108, 118, 141, 164`），并禁止在已开始 session 中使用阻断性 prompt（`130`），但没有说明 HealthKit 或 motion access 在 session 中途消失时发生什么。

**修复：**保留全部已提交 Actual Set 事实，只停止受影响的信号，标记第一个受影响边界，强制依赖它的 RPE/recognition abstain 或 pending，保留手动 set/reps/load 记录，并在休息或其他安全暂停时显示后果。绝不把已经 confirmed 的事实改回 inferred value。权限修复可在 session 后引导；不得占用 active-set UI。

### TPS-09 — Microcopy 矩阵缺少风险最高的复合状态

**严重度：Low**

现有示例良好（`EXPERIENCE.md:55-70`），但没有覆盖：auto-used model RPE 与 user-confirmed RPE、model abstention、HealthKit “no accessible data”而不声称拒绝、cloud deletion 已完成但另一设备仍 pending、研究撤回，或账户删除后本地 raw 数据仍保留。

**修复：**增加中文优先规范示例，命名 value source、affected copy、surviving facts 和 next action。除非底层精确状态支持，不得使用“已全部删除”“权限被拒绝”或“RPE 已测得”。

## 已通过的控制项

- **保存与同步：**local durable commit 始终是 saved boundary；phone/cloud replication 保持正交，不能撤销 recording success（`EXPERIENCE.md:57, 85, 100, 146, 155`）。
- **来源与纠正：**plan、detected、predicted、historical、user-entered、confirmed、auto-used 和 corrected value 可区分；纠正有明确范围且可审计（`79-84, 96-101, 147-151`）。
- **恢复与幂等：**app/device interruption、partial write、duplicate/delayed/reordered replay、revision conflict 和 concurrent session 均有明确保留路径（`153-160, 259-281`）。
- **不支持与低置信度：**unsupported device/signal/Exercise 和 low-confidence result 降级为 manual 或 pending 记录；已捕获的同组事实保留（`87, 141, 283-293`）。
- **RPE 边界：**RPE 是 opt-in、uncertainty-aware、保留 provenance、可纠正且非诊断；user-confirmed value 保持权威（`60, 68-69, 83, 99, 140, 147`）。
- **负荷诚实性：**load 来自 planned/historical/previous-set/user-entered，绝不声称由手腕感知（`59, 82, 147, 199-201`）。
- **训练安全：**active-set silence、safe-pause prompting、明确 destructive confirmation、不自动变更计划，以及不作伤病诊断/康复声明均已存在（`68-69, 78, 124-130, 234-246`）。
- **双语一致：**所评审的英文和中文脊柱保持相同章节顺序、表格、需求映射、状态结论和行号对齐的流程结构。

## 定稿前所需处置

在脊柱中解决 TPS-01 至 TPS-05，或明确将受影响功能标记为在契约解决前不可用。TPS-06 至 TPS-08 只有在脊柱命名 gate、owner/decision point 和安全临时行为时才可继续保持 gated。TPS-09 属于 polish，但应在 key-screen mock 或 implementation handoff 前完成。
