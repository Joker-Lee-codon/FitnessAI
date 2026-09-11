# 验证报告 — FitnessAI

- **DESIGN.md：** `/Users/seanlee/Documents/Code/FitnessAI/_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/DESIGN.md`
- **EXPERIENCE.md：** `/Users/seanlee/Documents/Code/FitnessAI/_bmad-output/planning-artifacts/ux-designs/ux-FitnessAI-2026-07-20/EXPERIENCE.md`
- **运行时间：** 2026-07-20T11:21:07+08:00

## 总体结论

这对 spine 作为进行中的快速路径契约为 **adequate，但尚不可定稿**。流程、组件、状态和双语结构覆盖较强；五条来源旅程与 FR-001–FR-070 均可追溯。Token 继承、active-session 行为、无障碍验收标准和破坏性数据生命周期事实仍需形成明确规则。

无障碍和信任评审显著加强了 Rubric 的判断。未发现 critical 缺陷，但 high 问题会影响训练中打扰安全、HealthKit 状态真实性、删除范围、账号隔离、dark-mode 生成，以及原生/自定义继承边界。以下计数保留每位评审者的发现；重叠关注点仍分别列出，因为它们代表不同的下游失败模式。

## 类别结论

- Flow coverage — adequate
- Token completeness — thin
- Component coverage — strong
- State coverage — strong
- Visual reference coverage — strong
- Bloat & overspecification — adequate
- Inheritance discipline — thin
- Shape fit — strong

## 按严重级别排列的发现

### Critical（0）

没有 critical 发现。

### High（13）

**[Rubric R-H1 · Flow coverage] — Active-session 行为尚未形成单一可实施契约**（`EXPERIENCE.md` § Open Questions 2、3、5、7）  
Watch/iPhone 纠正职责、rest-safe 时机、forgotten-Finish 阈值和负重语义仍未解决。  
修复：为每条规则定阶段或作出决定，并同步更新流程、组件行为和状态迁移。

**[Rubric R-H2 · Flow coverage] — HealthKit 副本/删除行为无法闭合 Flow 9**（`EXPERIENCE.md` § Permissions, Privacy, and Sensitive Data；§ Open Questions 6）  
修复：定义 detachment/deletion 范围、provenance、用户选择、完成、失败和重试。

**[Rubric R-H3 · Token completeness] — 组件 token 仅定义 light mode**（`DESIGN.md` frontmatter `components`）  
Dark color 仅存在于正文，machine consumer 可能在 dark appearance 中渲染 light surface。  
修复：添加明确的 dark appearance 属性或其他符合规范的机器可读映射。

**[Rubric R-H4 · Inheritance discipline] — 原生继承与自定义几何冲突**（`DESIGN.md` frontmatter；§§ Shapes、Components）  
修复：把每个组件归类为 native-as-is、native-with-delta 或 fully custom，并移除冲突属性。

**[Accessibility A-H1] — `resting` 不是安全交互契约**（`EXPERIENCE.md` Rest Resolution、State Patterns、Key Flows）  
Superset、circuit、drop set 和 minimal-rest 训练可能在下一正式组中收到提示。  
修复：定义 `restSafeForInteraction`、延后、单操作 Later 行为，以及正式组零提示验收场景。

**[Accessibility A-H2] — 数字编辑依赖未经验证的 Digital Crown 假设**（`DESIGN.md` Components；`EXPERIENCE.md` Component Patterns、Interaction Primitives）  
修复：让 Crown 仅作为可选加速器；提供 touch 和 accessibility-adjustable 等价路径、明确提交和精确字段 iPhone handoff。

**[Accessibility A-H3] — 目标尺寸和间距不可测量**（`DESIGN.md` Components；`EXPERIENCE.md` Accessibility Floor）  
修复：将 44 × 44 pt 作为高频/高后果控件默认点击区域，定义例外和间距，并禁止 Watch 上密集的十按钮 RPE 网格。

**[Accessibility A-H4] — 威胁采集的故障缺少 announcement 和 focus 优先级**（`EXPERIENCE.md` State Patterns、Interaction Primitives、Accessibility Floor）  
修复：区分可延后的 sync 状态与必须立即处理的 local-write/capture 故障；定义合并的多模态提醒和恢复焦点顺序。

**[Trust TPS-01] — HealthKit 读取拒绝被建模为可观察状态**（`EXPERIENCE.md` State Patterns；Permissions, Privacy, and Sensitive Data）  
Apple 不会暴露 HealthKit read access 是否被拒绝。  
修复：拆分权限状态族；HealthKit 读取使用 `data available / no accessible data / query error`。

**[Trust TPS-02] — 删除完成缺少逐副本范围**（`EXPERIENCE.md` Account & Privacy；Flow 9）  
修复：在声称完成前枚举 Watch/iPhone raw data、同步记录、个性化状态、研究数据、离线设备、备份和法律例外。

**[Trust TPS-03] — 保留的本地数据未与新账号密封隔离**（`EXPERIENCE.md` Permissions, Privacy, and Sensitive Data；Flow 9）  
修复：要求与原账号绑定的加密、其他账号下不可见、队列暂停，以及明确的转移资格。

**[Trust TPS-04] — 删除 tombstone 合并了多个事实边界**（`EXPERIENCE.md` Offline, Synchronization, and Recovery；Flow 9）  
修复：区分 device commit、cloud acceptance、known-device application、offline-device pending、retention exception 和 failure/retry。

**[Trust TPS-05] — Forgotten-Finish 缺少来源要求的双信号发布门**（`EXPERIENCE.md` `session-control`、UJ-1、Open Questions 5）  
修复：同时要求持续生理恢复与持续无力量训练活动；信号缺失/不可靠时不提醒；physical-device 阈值验证通过前保持关闭。

### Medium（12）

**[Rubric R-M1] — Primary MVP 验证人群未声明。** 修复：将重视进阶的常规 Apple Watch 训练者设为 primary，或明确选择其他人群，同时保留更广泛准入。

**[Rubric R-M2] — Post-MVP plan-proposal cadence 未解决。** 修复：在训练后、每周和周期末 proposal 优先级定义前保持 UJ-4 门控。

**[Rubric R-M3] — Load-bearing 视觉和交互假设仍未验证。** 修复：实机验证，或移除自定义 delta 并继承原生行为。

**[Rubric R-M4] — 承诺的双语 canonical glossary 缺失。** 修复：添加 English↔Chinese 状态和 provenance 术语表。

**[Accessibility A-M1] — Dynamic Type 缺少缩放/重排验收标准。** 修复：定义实机尺寸、放大目标、线性重排和不裁切要求。

**[Accessibility A-M2] — VoiceOver 分组、sheet focus、focus return 和 update throttling 未按组件定义。** 修复：添加逐组件无障碍语义和 announcement cadence。

**[Accessibility A-M3] — 权限 fallback 缺少无障碍旅程。** 修复：定义请求前目的文案、返回焦点、一次性结果宣告、fallback、Settings 路由和防重复请求。

**[Accessibility A-M4] — 高风险中文 Watch 微文案不是可实施清单。** 修复：为关键状态添加短视觉标签、完整朗读标签、一个后果和一个 primary next action。

**[Accessibility A-M5] — WCAG 2.2 AA floor 未映射到可审计发布证据。** 修复：添加逐 surface/state 验收矩阵，包含设备、OS、appearance、text size、assistive technology、证据和 defect link。

**[Trust TPS-06] — Research-consent withdrawal 缺少下游生命周期。** 修复：定义 capture/upload 停止、未发送本地 chunk、server withdrawal、删除限制和普通记录连续性。

**[Trust TPS-07] — Export 状态存在，但导出清单和排除项缺失。** 修复：命名 format、Plans、Sessions、Actual Sets、revision、RPE provenance、account metadata，以及排除的 raw/research/HealthKit data。

**[Trust TPS-08] — 训练中权限撤销缺少有序降级。** 修复：保留已提交事实，仅停止受影响 stream，让依赖 inference abstain，保留手动记录，并在安全暂停时解释后果。

### Low（4）

**[Rubric R-L1] — 信任不变量在多个章节重复。** 修复：润色时保留一条规范陈述，其他位置使用交叉引用。

**[Accessibility A-L1] — 自定义 focus、pressed、selected、disabled 和 error 状态不完整。** 修复：继承原生状态，或记录每个自定义状态的非颜色线索和对比度。

**[Accessibility A-L2] — Haptic 词汇与验证仍未完成。** 修复：添加小型事件映射、用户控制、等价线索、防重复和实训验证。

**[Trust TPS-09] — 最高风险复合状态缺少 canonical 中文优先文案。** 修复：添加 auto-used/confirmed RPE、abstention、HealthKit no-accessible-data、partial deletion、research withdrawal 和 retained local raw data 文案。

## 评审文件

- `review-rubric.md`
- `review-rubric.zh-CN.md`
- `review-accessibility.md`
- `review-accessibility.zh-CN.md`
- `review-trust-privacy-safety.md`
- `review-trust-privacy-safety.zh-CN.md`

## 评审后处置

Spine 修订后的聚焦复验确认 **没有残留 High blocker**。11 个 High finding 已解决；`R-H1` 和 `TPS-05` 被安全门控，因为未批准的 load semantics 与 Forgotten-Finish 在明确的实机/发布门通过前保持不可用。以上原始严重级别计数描述首次评审状态，为审计保留。Medium 和 Low finding 已并入验收契约，或仍作为有明确责任归属的实机验证与润色工作。
