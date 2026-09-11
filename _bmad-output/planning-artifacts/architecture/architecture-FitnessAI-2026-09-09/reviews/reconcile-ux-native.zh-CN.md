# UX / 原生输入对照审查

**目标：** `ARCHITECTURE-SPINE.md`  
**对照输入：** `EXPERIENCE.md`、`DESIGN.md`、`native-ui-spec.md`、`architecture-handoff.md`、`design-system/fitnessai/MASTER.md` 以及两份 token 文件  
**审查日期：** 2026-09-10  
**结论：** **NEEDS FIXES BEFORE FINAL**

架构很好地承接了核心事实、所有权、同步、AI 提案/批准、Apple Health 适配器、持久化和分析不变量。现在还不能安全地标记为 final，因为 Product Owner 已接受的两项覆盖决定仍与权威 UX 文本冲突，而且承重的导航及原生视觉/无障碍边界既没有被约束，也没有被明确推迟。

## 覆盖矩阵

| 维度 | 结论 | Spine 中的证据 | 对照结果 |
|---|---|---|---|
| 状态与持久事实 | 通过 | AD-2、AD-4、AD-5、AD-7、AD-11；显式状态 Convention | 重要的已保存/待处理/冲突/过期/错误区分均得以保留。只要将 UX/原生 companion 设为约束，精确的 UI 状态枚举可以继续留在这些 companion 中。 |
| 所有权 | 通过 | AD-3 与 Capability → Architecture Map | iPhone、Watch、HealthKit 适配器、AI 提案和分析的所有权与原生 handoff 一致。 |
| 导航 | 失败 | Stack 提到 `NavigationStack/TabView`，但没有路由/根页面/恢复规则 | 所要求的 tab 集合、上下文目的页、Watch 路线和返回状态恢复可能被实现成互不兼容的版本。视觉权威中还存在 `Today` 与 `Plan/More` 的冲突，而 Spine 没有解决它。 |
| AI 批准 | 通过 | AD-7 与 AD-8 | 完整结构化提案/差异、确定性验证、绑定 digest 的一次性批准、内容变化后的批准失效和原子 revision 提交均得以保留。这正确地允许 AI 填写整份计划，同时禁止静默或未经审查的修改。 |
| 错误与恢复 | 通过，但有一个缺口 | AD-2、AD-4、AD-5、AD-7、AD-11，加上显式状态 Convention | 持久恢复能力很强。但表现层恢复规则——保留输入、将焦点移到错误摘要、只在失败边界重试、保持可用的缓存/本地事实可见——尚未被约束；可通过原生 companion Convention 覆盖，而无须新增 AD。 |
| 无障碍 | 失败 | AD-13 仅要求无障碍测试 | 测试被提及，但被测试的实现不变量没有被约束：iPhone 200%/Watch 140% 文字缩放、非颜色提示、44 pt 触控目标、表冠替代操作、焦点恢复、图表文字/表格替代方案，以及 Reduce Motion/Contrast 行为。没有被约束的测试合同无法让不同实现收敛。 |
| 视觉边界 | 失败 | source 列表包含设计系统，但没有规则对其进行约束 | handoff 明确规定 Titanium Measure 1.1.0 与语义 token 不可变。缺少 Convention/AD 时，不同功能可能嵌入原始颜色、固定尺寸、阴影或相互冲突的状态语义。 |

## 发现

### F1 — 阻断项：已接受的 Apple Health → 远程 AI 覆盖决定与所有当前 UX/原生界面冲突

Product Owner 随后接受了广泛读取与训练相关的 Apple Health 数据，并在第二次授权后允许 AI 按请求使用。Spine 正确承接了这一更新决定：

- AD-8 要求每个远程请求预览准确的目的、类别、时间窗口、提供商和本地摘要，并提供允许/缩小范围/取消选择。
- AD-9 定义版本化的 Apple Health 读取 allowlist，并且只允许通过 AD-8 远程使用，发送本地摘要而不是无限制的原始数据流。

但是，当前 UX/原生权威仍然表达相反的规则：

- `EXPERIENCE.md` 的 Trust/Privacy 规定 Apple Health 不进入 Alpha 远程 AI。
- `native-ui-spec.md` §4 规定 Apple Health 仍被排除在授权类别之外。
- `DESIGN.md` 的 `HK-L01` 要求持续显示“远程 AI 排除”说明面板。

Spine 仅将此作为 Deferred 对照项提及。对实现而言这还不够：遵循 AD-8/9 的工程师会提供限定范围的 Apple Health 摘要，而遵循权威布局的工程师会永久将其标注为排除项。

**final 之前的必需修复：** 将 Product Owner 决定记录为明确且更新的行为覆盖，并同步更新双语 `EXPERIENCE.md`、`DESIGN.md`、原生 UI spec/handoff 以及受影响的预览/布局文案。UI 必须展示两个相互独立的授权：HealthKit capability 访问，以及每次请求将指定本地摘要用于远程 AI。类别默认关闭；缩小范围或取消时不发送任何内容。保留 AD-9 的医疗数据排除范围，且不要把该决定描述成不受限制地访问每一种 HealthKit 类型。

### F2 — 阻断项：纯手机一等路径与 UX foundation 冲突

AD-3 正确地将纯手机记录约束为与配对使用相同的 ID、状态、持久化和 Analysis。这反映了 Product Owner 已接受的要求：许多用户没有 Watch。

`EXPERIENCE.md` Foundation 仍将 Alpha 描述为在“已配对的 iPhone 和 Apple Watch”上运行的原生 SwiftUI App，而且主要执行旅程都从 Watch 开始。Spine 推迟了对照，但没有 companion 定义纯手机的完整开始/记录/编辑/结束/恢复页面与状态。

**final 之前的必需修复：** 更新 UX/原生 companion，使纯手机记录成为范围内的一等旅程；或者明确约束一项实现前 UX 交付物，并在该交付物完成前阻止纯手机 story。不要删除 AD-3，也不要把纯手机使用视为降级错误路径。

### F3 — 高：Titanium Measure 与无障碍只是 source 链接，不是架构约束

原生 handoff 规定架构**必须保留** Titanium Measure 1.1.0 的语义名称和原生实现规则。`MASTER.md` 还约束了事实/来源/权威/持久性的视觉语法、每个状态一个主要操作、活跃组保持安静、语义颜色、原生文字缩放、非颜色提示和平台行为。Spine 只是将这些文件列为 source 并指定 SwiftUI；AD-13 仅说明要运行无障碍测试。

因此，两个功能团队可能选择不兼容的 token 名称、状态语义、焦点行为、触控尺寸或自定义样式，同时仍然满足所有当前 AD。

**final 之前的必需修复：** 添加一个承重的 Convention（如有需要也可使用 AD），约束：

1. `design-system/fitnessai/MASTER.md` 与 `tokens.json` 是视觉语义权威；使用 Titanium Measure 1.1.0 和语义 asset，而不是原始值。
2. 展示顺序为事实 → 来源/权威 → 持久性 → 后果/操作；本地保存永远不等于同步。
3. 原生 Dynamic Type/VoiceOver/Full Keyboard Access、非颜色/非动作/非触觉/非表冠的替代方式、44 × 44 pt 的重要/常用触控目标，以及图表文字/表格替代方案。
4. 原生合同中的错误焦点/输入保留和返回/handoff 焦点恢复。

原始 token 值和组件样式应继续留在设计系统 companion 中，不要复制到 Spine。

### F4 — 高：导航图被遗漏，而且视觉 source 对顶层导航存在分歧

最终原生 handoff 和布局合同要求：

- iPhone `TabView`：Plan、History、Analysis、More；Plan 是 root。
- AI Chat、Remote Authorization、Proposal Review、Approval、Delivery、Session Review、Apple Health 和 Plan Exchange 是带类型的上下文 `NavigationStack` destination。
- 原生返回会恢复对象身份、筛选条件、滚动状态和未发送/未生效输入。
- Watch 使用浅层任务型导航，并将复杂纠正/隐私/冲突工作 handoff 到准确的 iPhone 对象/字段。

Spine 的 Stack 行只写了 `NavigationStack/TabView`，因此以上内容都有发生漂移的可能。此外，`MASTER.md` §12 仍规定顶层导航包含 Today、History 和 Analysis，而较新的最终原生合同则规定 Plan、History、Analysis、More。

**final 之前的必需修复：** 根据已接受的最终原生 handoff 解决输入冲突（或者取得新的 Product Owner 决定），必要时更新 `MASTER.md`，并将最终导航/root/恢复规则作为 Convention 加以约束。完整页面树不属于 Spine；根 tab、上下文路由所有权和恢复不变量属于 Spine。

### F5 — 中：训练后的主动复盘在 Spine 中缺失

UX/原生 handoff 将主动复盘邀请定义为承重的隐私边界：每次完成的训练最多出现一次；显示它或选择 Later 都不会发送任何内容，也不会创建授权、提案或批准；Disable 持续有效直到用户重新启用；Review 进入正常的授权/差异/批准流程。

AD-8 会保护任何实际发送的请求，但邀请的触发/状态和“不产生隐藏状态”的行为未出现在 AD、Convention、capability map 或 Deferred 中。不同实现可能产生重复提示或隐式授权。

**final 之前的必需修复：** 添加简洁的 Convention，或扩展 AD-8，以约束邀请的不发送/不授权语义以及进入既有批准生命周期的路线。布局继续留在 UX/原生文档中。

## 已确认一致的部分

- AD-7 与 AI/App 深度融合兼容：AI 可以创建完整可执行 Plan 或字段 diff，用户无须重新输入每个动作/组；只禁止提供商绕过验证、绑定 digest 的一次批准和原子 commit。
- AD-2/3/4 忠实保留了本地保存与已送达/已同步边界、活跃 session 快照不可变性、幂等性、因果冲突处理和 Watch 离线持久性。
- AD-6 承接了已接受的 Series 11 46 mm/方向证据起点、安全休息时的识别确认、RPE 验证和 15 分钟双信号 Forgotten Finish 行为，且未夸大更广泛的支持范围。
- AD-9 正确保留了 FitnessAI 本地权威、HealthKit 可观察读取限制、幂等 workout copy，以及 detachment 后的显式重新写入。
- AD-10 反映了 Product Owner 后来使用普通 `.json` 而非自定义文件扩展名的决定，同时保留了有界解析和仅创建 draft 的导入。
- AD-11 保留了 Analysis 合同：只有生效的 Actual Set 才进入确定性聚合，过期/冲突输入保持可见。

## Finalize 建议

在 F1–F4 解决前，不要 finalize Spine。F5 可以在同一轮修复。最精简的修复方式是添加两个简洁的 Consistency Convention——原生/导航和主动复盘隐私——同时为两项 Product Owner 覆盖决定更新上游双语 UX/原生产物。不要将 Spine 扩展成页面规格，也不要复制 token 表。
