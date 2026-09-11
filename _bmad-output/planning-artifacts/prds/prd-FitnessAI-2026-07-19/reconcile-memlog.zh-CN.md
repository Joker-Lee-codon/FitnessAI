# FitnessAI PRD Memlog 对账报告

## 1. 范围与关卡结论

本次审计将 `.memlog.md` 中截至 2026-07-20 的全部 81 条记录与 `prd.md`、`addendum.md` 逐条对账。本次审计未修改任何源文档。

**关卡结论：有条件通过（CONDITIONAL PASS）。** 当前文档已捕获 70 条记录，明确搁置 7 条已被取代或仅属于流程的记录，仍有 3 条未决决策，并且有 1 条数据治理澄清只被部分捕获。目前不存在导致 PRD 同时陈述两条互不兼容产品规则的未解决矛盾，但在最终定稿前必须解决 G-01 至 G-04，或对其作正式延期处理。

| 处置 | 数量 | 含义 |
|---|---:|---|
| 已捕获 | 70 | 有效含义已出现在 PRD、addendum 或两者中。 |
| 已搁置 | 7 | 该记录属于工作流历史，或已被后续明确决策取代。 |
| 未决缺口 | 3 | memlog 明确留下了尚未解决的决策或验证义务。 |
| 部分捕获 | 1 | 大部分澄清已存在，但缺少一项重要边界。 |
| **总计** | **81** | 下文已对每一条 memlog 记录完成分类。 |

## 2. 主要缺口与冲突

### G-01 — 竞争差异化仍未验证

- **Memlog：** M-005 记录 Motra 已经提供中文本地化的 Apple Watch 动作与次数自动识别，并指出差异化必须超越自动识别本身。
- **文档状态：** Vision 通过真实记录完整性、纠错、RPE、计划控制和连续性隐含表达了差异化，但两份文档均未陈述竞争假设及其验证方式。
- **所需处置：** 在定位或发布验证前解决差异化假设，或为其指定产品负责人和重新审视条件后延期。这不是架构阻塞项，但仍是未解决的 PRD 战略事项。

### G-02 — Post-MVP 初学者计划复盘节奏仍未决

- **Memlog：** M-036 未确定训练后、每周和周期结束复盘之间的触发方式与优先级。
- **文档状态：** UJ-4 写明“约每周或周期结束”，保留了这一不确定性，但未解决优先级；FR-059 和 FR-060 也未定义。
- **所需处置：** 由于初学者计划属于 Post-MVP，应在 UJ-4/FR-054–FR-060 进入 epic 或 UX 设计前，为其明确负责人和重新审视条件并正式延期。它不阻塞 MVP 架构。

### G-03 — Pilot 延续使用阈值仍未决

- **Memlog：** M-062 说明必须在 holdout 评估前确定四周延续使用的 cohort 阈值。
- **文档状态：** SM-RET-001 准确暴露了缺失阈值，但未记录负责人或决策日期/重新审视关卡。
- **所需处置：** 指定产品/实验负责人，并在 pilot holdout 评估前设定阈值。在解决前，该指标不能作为发布关卡。

### G-04 — iCloud/CloudKit 健康数据禁用规则仅被部分捕获

- **Memlog：** M-051 将 FitnessAI 应用云同步与 iCloud/CloudKit 区分开，并声明个人健康信息不得存储在 iCloud/CloudKit 中。
- **文档状态：** PRD §6.1 和 FR-044–FR-047 已捕获独立的中国区后端与高频传感器数据本地保存，但 PRD 和 addendum 均未明确保留 iCloud/CloudKit 禁用规则。
- **所需处置：** 在架构交接前，将这一明确禁用规则加入数据治理或架构边界。这是唯一的重要部分捕获问题，也是架构/数据治理阻塞项。

## 3. 已解决的历史冲突

| 冲突 | 较早记录 | 解决记录 | 当前文档状态 |
|---|---|---|---|
| 临时训练动作选择 | M-021 假设通过识别或快速确认动作，但交互边界仍开放。 | M-022 取消预选，要求自动识别并仅在不确定时提示。 | PRD 的 UJ-3 和 FR-008–FR-011 遵循 M-022。 |
| MVP 中的初学者计划 | M-028 将有限 AI 初学者计划放入首个版本。 | M-048 将 AI 初学者计划延期到 Post-MVP。 | PRD 的 §2、§5、§6.2、UJ-4 和 FR-054–FR-060 遵循 M-048。 |
| 动作媒体授权 | M-037 将仓库图片视为待验证的候选来源。 | M-038 确认 MIT license 不涵盖图片和视频。 | Addendum 以及 FR-051/FR-053 遵循 M-038。 |
| 伤病与康复行为 | M-043 提议严重程度分支和康复导向训练。 | M-045 和 M-046 拒绝康复处方，仅保留非诊断筛查。 | Addendum、Non-Goals、UJ-4 和 FR-058 遵循 M-045/M-046。 |
| 未确认 RPE 的真实值地位 | M-055 将每个未确认预测都视为 provisional。 | M-068 明确允许在用户同意后自动使用高置信度结果并保留 provenance。 | UJ-1、§6.1、FR-024–FR-026 和 NFR-RPE-008–NFR-RPE-010 遵循 M-068。 |
| Mac 交付前提 | M-002 要求购置 Mac。 | M-081 记录 Apple Silicon Mac 与 Xcode 已就绪。 | Addendum 将此前提记录为已满足。 |

## 4. 逐条审计

| ID | 类型 | 处置 | 文档映射或搁置原因 |
|---|---|---|---|
| M-001 | change | 已捕获 | Addendum，“Rejected first route: vivo watch + vivo phone”。 |
| M-002 | decision | 已捕获 | Addendum，“Initial delivery route”；前提状态由 M-081 更新。 |
| M-003 | decision | 已捕获 | PRD Vision 和 addendum 均标识中国大陆 Apple Watch 用户。 |
| M-004 | decision | 已搁置 | Coaching path 是工作流过程历史，不属于产品内容。 |
| M-005 | event | 未决缺口 | Motra 差异化义务未被明确解决；见 G-01。 |
| M-006 | decision | 已搁置 | Journey-led 入口是工作流过程历史，不属于产品内容。 |
| M-007 | decision | 已捕获 | UJ-1 persona 与 Target User。 |
| M-008 | decision | 已捕获 | UJ-1 entry state 以及对正式训练阶段的聚焦。 |
| M-009 | decision | 已捕获 | Vision 和 UJ-1 已涵盖 Watch/iPhone 切换痛点；无需点名 Xunji。 |
| M-010 | decision | 已捕获 | UJ-1、FR-028/FR-029 和 RPE requirements 保留计划值与实际值的区分。 |
| M-011 | decision | 已捕获 | UJ-1 的 quiet-default 行为与 SM-INT-001 打扰预算。 |
| M-012 | decision | 已捕获 | FR-006 与 FR-041。 |
| M-013 | decision | 已捕获 | FR-002、FR-026、FR-028 与 FR-029。 |
| M-014 | decision | 已捕获 | UJ-1 与 FR-027。 |
| M-015 | decision | 已捕获 | UJ-1 与 FR-033/FR-034。 |
| M-016 | decision | 已捕获 | MVP Scope 与 FR-036–FR-039。 |
| M-017 | decision | 已捕获 | UJ-2 与 FR-036–FR-039。 |
| M-018 | decision | 已捕获 | Emotional JTBD 与 UJ-2 Resolution。 |
| M-019 | decision | 已捕获 | UJ-3 与 FR-001/FR-008。 |
| M-020 | decision | 已捕获 | UJ-3 与 FR-035。 |
| M-021 | assumption | 已搁置 | 已被 M-022 取代。 |
| M-022 | change | 已捕获 | UJ-3 与 FR-008–FR-011。 |
| M-023 | decision | 已捕获 | UJ-3 与 FR-012。 |
| M-024 | decision | 已捕获 | UJ-3 与 FR-013。 |
| M-025 | decision | 已捕获 | UJ-1 与 FR-030/FR-031。 |
| M-026 | change | 已捕获 | Target User 将适用范围扩大到所有经验水平。 |
| M-027 | decision | 已捕获 | Target User 将产品负责人旅程定义为种子旅程而非边界。 |
| M-028 | change | 已搁置 | 已被 M-048 取代。 |
| M-029 | decision | 已捕获 | Addendum 的教学资产边界与 FR-051/FR-053。 |
| M-030 | event | 已捕获 | Addendum，“What wrist data can and cannot support”。 |
| M-031 | decision | 已捕获 | Non-Goals、addendum 与 FR-053。 |
| M-032 | decision | 已捕获 | UJ-4 与 FR-054。 |
| M-033 | decision | 已捕获 | UJ-4 与 FR-056。 |
| M-034 | decision | 已捕获 | UJ-4 与 FR-057。 |
| M-035 | decision | 已捕获 | UJ-4 与 FR-059/FR-060。 |
| M-036 | assumption | 未决缺口 | 复盘节奏与优先级仍未解决；见 G-02。 |
| M-037 | assumption | 已搁置 | 经授权验证后被 M-038 取代。 |
| M-038 | change | 已捕获 | Addendum 的教学资产边界与 FR-053。 |
| M-039 | decision | 已捕获 | Addendum 区分 code/data/text/media provenance 与 professional review。 |
| M-040 | decision | 已捕获 | UJ-4 与 FR-055。 |
| M-041 | decision | 已捕获 | UJ-4 的设备边界与 FR-030/FR-031 原则。 |
| M-042 | decision | 已捕获 | UJ-4 与 FR-054。 |
| M-043 | assumption | 已捕获 | Addendum 将提议分支保留为被否决的理由；由 M-045/M-046 解决。 |
| M-044 | event | 已捕获 | Addendum 的监管理由与已确认 guardrail。 |
| M-045 | change | 已捕获 | Non-Goals、addendum 与 FR-058。 |
| M-046 | decision | 已捕获 | UJ-4、addendum 与 FR-058。 |
| M-047 | decision | 已捕获 | Vision 与 Target User。 |
| M-048 | change | 已捕获 | Target User、Non-Goals、MVP Scope、UJ-4 与 FR-054–FR-060。 |
| M-049 | decision by user | 已捕获 | UJ-5、MVP Scope、FR-003/FR-043/FR-044。 |
| M-050 | decision by user | 已捕获 | UJ-5 与 FR-042–FR-047。 |
| M-051 | clarification | 部分捕获 | 独立的中国区后端和传感器数据本地保存已捕获；缺少明确的 iCloud/CloudKit 禁用规则。见 G-04。 |
| M-052 | decision by user | 已捕获 | NFR-SIZE-001。 |
| M-053 | requirement | 已捕获 | NFR-SIZE-002–NFR-SIZE-004。 |
| M-054 | event | 已捕获 | Addendum 的 RPE 证据边界与 NFR-RPE-001。 |
| M-055 | decision | 已搁置 | 已被 M-068 的明确自动使用 override 取代；其余 multimodal 边界已捕获。 |
| M-056 | decision | 已捕获 | FR-025 与 NFR-RPE-003。 |
| M-057 | requirement | 已捕获 | NFR-RPE-004/NFR-RPE-005。 |
| M-058 | decision | 已捕获 | SM-COMP-001、SM-ACC-001、SM-RET-001 与 SM-FEED-001。 |
| M-059 | decision | 已捕获 | SM-COMP-001。 |
| M-060 | decision | 已捕获 | SM-ACC-001 与 SM-PRES-001。 |
| M-061 | decision | 已捕获 | SM-RET-001。 |
| M-062 | assumption | 未决缺口 | 阈值已在 SM-RET-001 中显示，但仍未决定且无负责人；见 G-03。 |
| M-063 | decision | 已捕获 | SM-INT-001 及其 counter-metric。 |
| M-064 | change | 已捕获 | UJ-1、FR-021/FR-022/FR-024 与 NFR-RPE-008/NFR-RPE-009。 |
| M-065 | change | 已捕获 | UJ-1、FR-023 与 NFR-RPE-008。 |
| M-066 | decision | 已捕获 | FR-020 与 NFR-RPE-007。 |
| M-067 | assumption | 已搁置 | 已由 M-068/M-071 解决。 |
| M-068 | override | 已捕获 | UJ-1、§6.1、FR-024–FR-026 与 NFR-RPE-009。 |
| M-069 | decision | 已捕获 | UJ-1、FR-021/FR-023 与 addendum 中的验证状态。 |
| M-070 | decision | 已捕获 | FR-025 与 NFR-RPE-010。 |
| M-071 | decision | 已捕获 | FR-024/FR-026 与 NFR-RPE-009。 |
| M-072 | decision | 已捕获 | Non-Goals 与 FR-019。 |
| M-073 | decision | 已捕获 | UJ-1 与 FR-016/FR-018。 |
| M-074 | decision | 已捕获 | UJ-3 与 FR-017/FR-018。 |
| M-075 | decision | 已捕获 | UJ-1、FR-005 与 NFR-SESSION-001–NFR-SESSION-003。 |
| M-076 | assumption | 已捕获 | NFR-SESSION-002/NFR-SESSION-004 和 addendum 保留 AND gate 与验证条件。 |
| M-077 | decision | 已捕获 | FR-005 与 NFR-SESSION-002。 |
| M-078 | decision | 已捕获 | FR-004/FR-005 与 NFR-SESSION-001/NFR-SESSION-003。 |
| M-079 | event | 已捕获 | PRD 包含 FR-001–FR-060，其中 FR-054–FR-060 标记为 Post-MVP。 |
| M-080 | decision | 已捕获 | NFR-RES-001。 |
| M-081 | change | 已捕获 | Addendum 将 Mac/Xcode 前提记录为已满足。 |

## 5. 最终对账结论

PRD 与 addendum 在实质上与 canonical memlog 一致，不存在仍然生效的产品规则矛盾。只有在恢复明确的 iCloud/CloudKit 禁用规则（G-04），并且解决 G-01 至 G-03 或为其指定负责人和重新审视条件后，才应继续最终定稿。§3 中列出的历史冲突均已按照最新 memlog 决策完全解决，无需进一步修改产品规则。
