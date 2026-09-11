---
workflow: bmad-sprint-planning
project: FitnessAI
date: 2026-09-11
status: complete
tracking_file: sprint-status.yaml
source_of_truth: epics.md
readiness: 可进入 Sprint Planning——单个 Sprint 承诺前仍需 refinement
language_copy: sprint-plan.md
---

# FitnessAI Sprint 计划

## 1. 规划结论

FitnessAI 可以进入 Sprint Planning。本计划是有序的 private Alpha 交付台账，不是容量或日历承诺：由于未提供团队规模、velocity 和 Sprint 长度，本计划不虚构这些数据。

现有 Epic 顺序与 S0→S7 交付主线保持不变。Story 只有在满足下述承诺控制后，才能从 `backlog` 进入 `ready-for-dev`。实现完成绝不自动表示证据已通过或功能已启用。

## 2. 权威基线与顺序

实施权威顺序为：当前 PRD、`EXPERIENCE.md`、`DESIGN.md` 加 Titanium Measure、`native-ui-spec.md`、`architecture-handoff.md`，以及在不覆盖更高权威来源时适用的 Architecture Spine。`epics.md` 是完整 Story 清单。

| 切片 | Epic / Story | 退出结果 |
|---|---|---|
| S0 | Epic 1，Story 1.1–1.5 | 可运行 workspace、平台中立契约、revision policy、持久化边界与 canonical catalog |
| S1 | Epic 1，Story 1.6–1.10 | 可信的 iPhone-only 手动训练 |
| S2 | Epic 1，Story 1.11–1.14 | 可信的配对 Watch 手动训练及 exactly-once 回传 |
| S3 | Epic 2，Story 2.1–2.14 | 授权 AI 对话到批准的 Plan Revision；GATE-1–3 fail closed |
| S4A | Epic 3，Story 3.1–3.3 | 用户权威的训练中决策 |
| S4B | Epic 4，Story 4.1–4.7 | 可信 History、Analysis 与未来 Plan 对账 |
| S5A | Epic 5，Story 5.1–5.6 | 有界 Plan 交换；GATE-7 fail closed |
| S5B | Epic 6，Story 6.1–6.6 | 可选 Apple Health 上下文/副本；GATE-3 fail closed |
| S6 | Epic 7，Story 7.1–7.13 | 证据门控的 Watch 辅助与完整手动回退 |
| S7 | Epic 8，Story 8.1–8.6 | 受控 review 与 private Alpha 集成/发布证据 |

13 项后续范围需求继续明确延期，不得在 S0–S7 中以已交付占位符出现：`FR-042`、`FR-044`、`FR-045`、`FR-048`、`FR-051`、`FR-067`–`FR-070` 和 `FR-074`–`FR-077`。

## 3. Sprint 承诺策略

Story 只有在所有适用条件通过后才可承诺：

1. 前置契约存在，且没有引入前向依赖。
2. 任何超大父 Story 已建立具有独立证据的子任务，且父级验收与 traceability 不变。
3. Gate 前置项已针对精确版本与范围关闭；否则对应功能保持 disabled。
4. Story 1.1 在进入 `ready-for-dev` 前已纳入 AD-13 CI 覆盖项。
5. 适用的文档治理动作已在规定边界前关闭。
6. 超出 Product Owner 测试范围的发布继续保留强制 professional safety review。

跟踪文件为每个 Gate 分离三个事实：`implemented`、`evidence_passed` 和 `feature_enabled`。三者初始均为 `false`。

## 4. Enabler、Compliance 与 Evidence 分类

23 个前置/控制 Story 保持现有顺序与用户风险理由，但不得作为普通用户价值交付汇报。

| 分类 | Story ID | 数量 |
|---|---|---:|
| Enabler | 1.1–1.4；2.2；2.5；5.3；7.1；7.11 | 9 |
| Compliance | 2.1；5.2；7.2；7.7；7.12；8.5 | 6 |
| Evidence | 2.3；2.6；5.5；6.3；7.3；7.8；7.13；8.4 | 8 |
| **总计** |  | **23** |

## 5. Fail-Closed Gate 台账

| Gate | 有序归属 | 启用路径 | 打开或失败时的必需行为 |
|---|---|---|---|
| GATE-1 | 2.1 前置 → 2.2 实现 → 2.3 证据 | 符合安全条件的 AI proposal 与 Plan commit | Proposal commit disabled |
| GATE-2 | 2.5 disabled adapter → 2.6 证据 | Built-in DeepSeek traffic | Built-in traffic 技术上 disabled；仅允许本地 fake/BYOK contract 工作 |
| GATE-3 | 2.8 preview → 6.2 本地 summary → 6.3 证据 → 6.4 使用 | 真实 Health-derived remote send | 仅 preview/本地 summary；send fails closed |
| GATE-4 | 7.1 candidate → 7.2 preregistration → 7.3 证据 → 7.4/7.5 使用 | 仅已通过的 recognition rows | 保留手动 Complete Set |
| GATE-5 | 7.6 state flow → 7.7 preregistration → 7.8 证据 → 7.9 verification → 7.10 使用 | 证据绑定且显式启用的 RPE auto-use | RPE 关闭或仅走批准的 confirmation-only 路径 |
| GATE-6 | 7.11 disabled candidate → 7.12 preregistration → 7.13 证据/使用 | 保守的 Finish-or-Continue prompt | 仅手动 Finish；绝不自动 Finish |
| GATE-7 | 5.2 budgets → 5.3 parser → 5.4 preview → 5.5 证据 → 5.6 使用 | Plan import acceptance | 允许 export；禁用 import acceptance 与 draft creation |

Gate 关闭与版本和范围绑定。后续版本变化、证据缺失、切片失败或紧急禁用，只会让受影响功能返回 fail-closed 行为，不得阻断本地手动训练记录。

## 6. 超大 Story Refinement

以下父 Story 保留在 canonical 清单中，但在写出下列子任务边界前禁止承诺进入 Sprint。每个子任务必须产生独立完成证据，且合计保留父 Story 的全部验收标准和 traceability link。

| 父 Story | 场景数 | 必需子任务边界 |
|---|---:|---|
| 1.6 | 11 | 本地 Plan 创建与 validation；immutable Start snapshot；iPhone entry/UI 与 atomic start failure recovery |
| 1.7 | 11 | Actual Set domain contract；atomic persistence/idempotency；iPhone capture UI 与 accessibility/error states |
| 1.8 | 13 | Field correction/revision；incomplete/pending fact behavior；active-session UI、recovery 与 preservation evidence |
| 1.9 | 12 | Manual Finish state transition；post-Finish derivation/review；failure/idempotency 与 accessibility evidence |
| 1.10 | 12 | Startup recovery；offline/partial-write replay；conflict/incomplete presentation 与 fault evidence |
| 1.11 | 12 | Compatibility handshake/manifest；chunked durable delivery/acknowledgement；activation、retry、cleanup 与 UI truth |
| 1.12 | 15 | Watch Start snapshot/runtime；manual set capture 与 local persistence；interruption/accessibility/failure evidence |
| 1.13 | 14 | Watch recovery state machine；correction 与 manual Finish；reconnect/restart/fault 与 UI evidence |
| 1.14 | 15 | iPhone receive/durable commit；exactly-once apply 与 revision reduction；acknowledgement/cleanup/conflict evidence |
| 2.1 | 13 | Numeric rule manifest；golden fixture corpus；decision record/versioning 与 professional-review boundary |

Refinement 优先级为 1.12 → 1.13 → 1.14 → 1.8 → 1.9 → 1.10 → 1.11 → 1.6 → 1.7 → 2.1。

## 7. AD-13 Apple Silicon/macOS CI 覆盖项

Story 1.1 负责早期质量流水线。在并行功能开发前，其验收契约必须包括：

- 使用已绑定 Xcode 26.6 与 Swift 6.3.3 工具链的可复现 Apple Silicon/macOS runner。
- 每次变更强制执行 compile、domain、schema、safety、persistence、sync、AI contract 和 secret checks。
- 完整 iPhone 与 Watch build job、确定性 dependency resolution，以及已提交的 `Package.resolved`。
- 保留测试 artifacts，使用 privacy-safe logs，并提供 secretless pull-request path。
- 任一 mandatory check 失败或缺失时阻止 merge 的 required-check policy。

这是 Sprint 验收覆盖项，不是新 Epic，也不改变 Story 顺序；Story 1.1 继续作为第一个 Enabler。

## 8. 文档治理行动

| ID | 行动 | Owner | 阻断边界 |
|---|---|---|---|
| GOV-01 | 修正 `native-ui-spec.md`：只有匹配 GATE-3 证据和 one-shot authorization 后才允许 Apple Health summaries；raw/unselected Health data 继续排除 | Product Owner + UX | Story 2.8 或 6.4 实现验收前 |
| GOV-02 | 统一权威 PRD、UX 与 Native UI 的 status/frontmatter；移除过期 `draft` 和 reviewer-gate 歧义，但不改变需求内容 | Product Owner | 并行功能 Sprint 承诺前 |
| GOV-03 | 每次 refinement 均执行已记录的权威顺序；历史 Direction D 和过期 addendum 表述不具规范性 | Product Owner + Delivery Lead | 每次 Story refinement |
| REF-01 | 完成第 6 节中 10 项保留父契约的拆分 | Delivery Lead | 每个受影响 Story 承诺前 |

这些行动以 open `action_items` 写入 `sprint-status.yaml`；Sprint Planning 不会静默改写源文档。

## 9. 首个可执行工作项

首个工作项是 **Enabler Story 1.1 — Launch the Runnable iPhone, Watch, and Shared-Contract Workspace**。

立即执行顺序：

1. 对 1.1 运行 Create Story，并将第 7 节 AD-13 CI 覆盖项写入其验收契约。
2. 确认未加入 speculative feature tables 或未来功能占位符。
3. 仅在 Story 文件包含完整覆盖项后，将 1.1 标为 `ready-for-dev`。
4. 实现可运行的 iPhone/Watch/shared-package seed 和 CI required checks。
5. 按 `in-progress` → `review` → `done` 推进；完成 1.1 仍不会关闭任何 GATE-1–7 功能。

## 10. 已生成状态摘要

- 跟踪文件：`sprint-status.yaml` 与 `sprint-status.zh-CN.yaml`
- Epic 总数：8
- Story 总数：69
- 进行中 Epic：0
- 已完成 Story：0
- 检测到的 Story 文件：0
- 开发状态：所有 Epic 与 Story 均保持 `backlog`；所有 retrospective 均保持 `optional`

