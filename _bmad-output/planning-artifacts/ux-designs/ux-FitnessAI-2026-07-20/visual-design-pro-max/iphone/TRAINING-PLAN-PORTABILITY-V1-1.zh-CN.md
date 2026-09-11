# iPhone — Training Plan Portability（V1.1，非 MVP）

## 1. 目的与权威

定义使用 FitnessAI 自有版本化格式，对一个 Training Plan 进行往返导出与导入。本 surface 属于 FR-071–FR-073 与 NFR-PORT-001 规定的 V1.1 范围；不得出现在 MVP 导航或 Story 中。

## 2. 进入与退出

- 导出入口：一个 Training Plan detail 中的 contextual action。
- 导入入口：V1.1 激活后的 iOS document picker/file open 或 plan-library contextual action。
- 退出：分享/保存导出 artifact、创建一个新的可编辑草稿、取消，或返回精确 validation/mapping failure。

## 3. 组成

1. 阶段与操作边界：Export One Plan 或 Import as New Draft。
2. 来源 identity：file name、format/schema version、Exercise-catalog version、plan revision、producing version 和 provenance。
3. 完整 Training Plan ledger：days、Exercises、sets、repetitions、load/unit、可选 target RPE 与 plan metadata。
4. 明确排除项：Workout Sessions、Actual Sets、健康信息、account credentials 和所选计划之外的数据。
5. Validation ledger：compatible/unsupported/newer/malformed/over-limit、duplicate identity、unknown Exercise、incompatible field/unit、required omission 和 parser diagnostic。
6. Canonical Exercise mapping：显示 original value、proposed mapping；confidence 不作为 authority，并提供 Change、Omit 与 Cancel。
7. 唯一最终 `Create New Draft` action；不提供 merge、replace 或 revise-existing action。

## 4. 组件

`PlanExchangeReview`、plan ledger、`FactStateLabel`、`SupportBoundaryNotice`、`SystemStatePanel`、`TitaniumPrimaryAction`、`DurabilityRail`。

## 5. 必需状态

Export ready/creating/failed；file unopened/validating；compatible；unsupported 或 newer version；malformed/executable/over-limit；duplicate；unknown Exercise；unresolved unit/field mapping；explicit omission；partial preview；ready；creating new draft；committed locally；cancelled；failed preserving review。

## 6. 交互、信任与无障碍

文件属于不可信输入，绝不执行。任何 mutation 前必须预览。不得发明未知 mapping；除非明确接受 omission，不得把部分计划称为完整。Cancel、validation failure 或 local-commit failure 不改变任何现有计划。VoiceOver 顺序为 source/version、validation result、完整 plan summary、issue、consequence，再到 Create Draft 或 Cancel。文本放大 200% 时，mapping row 改为带标签的 stack，并保留 original/source value。

## 7. 需求与流程

FR-071–FR-073（V1.1）、NFR-PORT-001、DV-007；Flow 10。

## 8. 预览与验证

MVP 不推广 production preview。V1.1 Story 进入验收前，冻结 DV-007 parser limit，并验证 compatible export/re-import、malformed 与 compressed-bomb input、newer version、duplicate、unknown Exercise、unit mismatch、explicit omission、cancellation、local-commit failure、VoiceOver、Full Keyboard Access 和最大字号。
