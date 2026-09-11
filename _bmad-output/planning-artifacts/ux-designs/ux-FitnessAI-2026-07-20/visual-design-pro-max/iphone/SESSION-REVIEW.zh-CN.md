# iPhone — Session Review / 训练复核

## 1. 目的与权威性

为一个训练场次提供完整字段级复核/纠错、来源、修订历史、完整状态和精确计划对账。

## 2. 进入与退出

- 进入：Watch 完成 Handoff、训练历史、待处理字段 Deep Link、冲突路径。
- 退出：提交纠错、解决必填字段、接受/编辑/拒绝计划差异，并带精确上下文返回。

## 3. 构图

1. 训练场次身份 + 完整/待补全边界。
2. 由实际训练组计算的组数/容量/时长摘要。
3. 按动作分区的 `ActualSetLedgerRow` 数值与来源。
4. 行内待处理/已纠正/冲突边界。
5. 字段编辑器或拆分/合并/插入/删除路径。
6. `PlanDiffReview` 和一个完成操作。

## 4. 组件

`ActualSetLedgerRow`、`FactStateLabel`、`CrownAdjustableValue` 视觉等价、`RPEVerificationPrompt`、`PlanDiffReview`、`SyncBoundaryIndicator`。

## 5. 必需状态

加载；完整；待补全；已纠正；RPE 待处理；RPE 自动采用；冲突；Analysis 待更新；纠错提交中/失败；等待同步。

## 6. 交互与无障碍

除非明确执行拆分/合并/插入/删除，每次纠错只针对一个字段/修订。旧值/来源保持可审计。焦点返回编辑行。固定完成操作预留安全区。没有明确接受，计划不能改变。

## 7. 需求与流程

FR-006–FR-007、FR-026、FR-029、FR-033–FR-035、FR-040–FR-041、FR-061–FR-063；UJ-1、UJ-3、Flow 7、Flow 8。

## 8. 预览与验证

预览：`../previews/iphone-core-pages-review.png`，页面 03。验证全部字段操作、冲突保留、键盘、200% 文字、提交失败和 Analysis 待更新。
