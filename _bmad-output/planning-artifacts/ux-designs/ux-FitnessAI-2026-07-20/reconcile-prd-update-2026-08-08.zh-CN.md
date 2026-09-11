# UX 核对——2026-08-08 PRD 更新

## 结论

**已按阶段约束完成对齐。** 更新后的 UX 在不扩大 MVP 的前提下关闭了此前 FR-071–FR-077 追踪缺口。MVP 保持现有 Apple Watch/iPhone IA；V1.1 获得完整单计划可移植合同；Post-MVP 语音与更广泛计划交换获得非实现边界；基于训练记录的 AI 继续受 DV-006 阻断。

## 需求到 UX 的差异

| PRD 项 | 阶段 | UX 更新 | 实现边界 |
|---|---|---|---|
| FR-071 | V1.1 | Flow 10 导出预览明确一个计划、schema/catalog version、revision/source provenance 与排除的数据类别。 | 仅 contextual iPhone route；MVP 中不存在。 |
| FR-072 | V1.1 | `Training Plan Portability` 在创建新草稿前验证并预览完整内容。 | 不提供 merge、overwrite 或 revise-existing action。 |
| FR-073 | V1.1 | Unknown Exercise、incompatible field/unit、duplicate、omission、newer version、malformed/over-limit、cancel 和 failed-commit 路径保持可见/可恢复。 | DV-007 限制冻结前阻断 Story 验收。 |
| NFR-PORT-001 | V1.1 | 不可信文件状态模型、parser failure boundary、source/version 保留，以及失败时安全不修改。 | Parser 不执行嵌入内容；现有计划保持不变。 |
| FR-074–FR-075、NFR-VOICE-001 | Post-MVP | Future Flow Boundary 11 与 `StructuredInputDraft` 定义用户主动唤起、permission/listening/transcription/draft/conflict/confirm/local-commit/cancel/unavailable 状态。 | 无 MVP route、持续监听、开放式教练、原始音频授权或静默覆盖。 |
| FR-076 | Post-MVP / V2 | Future Flow Boundary 12 通过命名 format/version、单位处理、mapping 和 partial failure 扩展 V1.1 preview/new-draft 规则。 | 不暗示支持任何第三方格式。 |
| FR-077、NFR-SHARE-001 | Post-MVP / V2 | 定义接收方预览、最小化 plan-only scope、新草稿创建，以及明确 expired/revoked/inaccessible/invalid 状态。 | QR 本身不证明真实性/访问/隐私；transport 决策继续受 Gate 约束。 |
| DV-006 | 延后探索 | Architecture invariant 保留 evidence/provenance/proposal/edit/accept/reject/audit 字段。 | 不授权 journey、screen、component instance、service 或 Story。 |

## MVP 合同检查

- Apple Watch 继续是可独立工作的 active-session authority 与 local durable saved boundary。
- iPhone 继续负责完整纠错、Training Plans、history、Analysis、lifecycle、conflict，以及未来文件预览/mapping。
- Active-set silence 与共享 interruption budget 保持不变。
- User-confirmed/corrected fact 优先于 sensor、voice、import、AI、sync 和 recovery output；冲突创建可见 draft，并要求新的成功本地提交。
- MVP navigation 与现有 preview board 不出现 V1.1 或 Post-MVP destination。

## Architecture 交接状态

MVP UX 已可进入 `bmad-architecture`，但仍受 spine 已承载的现有发布/物理设备验证 Gate 约束。Architecture 可以为 source/provenance、draft/conflict、proposal decision、file-version metadata 与 bounded parsing 定义扩展缝，但不得实现延后能力。

V1.1 portability 在 UX contract 层面已可供 Architecture 使用，但在 DV-007 数值 parser limit 冻结前不得进入 Story 验收。Voice、sharing 与 record-informed AI 仍是受 Product Gate 约束的未来边界。
