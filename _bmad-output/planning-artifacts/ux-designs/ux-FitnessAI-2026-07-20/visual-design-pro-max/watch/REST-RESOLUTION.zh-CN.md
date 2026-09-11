# Watch — Rest Resolution / 休息处理

## 1. 目的与权威性

仅在已验证的 `restSafeForInteraction` 休息中解决不确定性或可编辑事实。它保留同组事实、中断预算和用户延后权。

## 2. 进入与退出

- 进入：已验证安全休息中的一个符合条件待处理事实。
- 退出：确认、更改、稍后处理、安全状态撤回或精确字段 iPhone Handoff。

## 3. 构图

1. 安全休息上下文和休息时间。
2. 琥珀问题标签 + 字面问题。
3. 保留的同组事实。
4. 最短确认、更改和稍后处理。
5. 调节负重/RPE 时的草稿/提交状态。

## 4. 组件

`CorrectionBoundary`、`CrownAdjustableValue`、`RPEVerificationPrompt`、`ActualSetLedgerRow`、`SupportBoundaryNotice`。

## 5. 必需状态

不安全/延后；安全且无/一个/多个待处理；稍后；已纠正；手动回退；RPE 关闭/验证/漂移/弃权；不支持负重语义；提交失败。

## 6. 交互与无障碍

VoiceOver 初始焦点依次为保留事实、问题和选项。Crown/触控更新同一草稿；只有确认才提交。失去安全休息会关闭提示并保留待处理数据。不使用倒计时或密集 RPE 网格。

## 7. 需求与流程

FR-007、FR-011–FR-015、FR-019–FR-027、FR-061–FR-062；UJ-1、UJ-3、Flow 8。

## 8. 预览与验证

预览：`../previews/watch-pages-review.png`，页面 03。验证安全状态撤回、Crown/触控等价、140% 文字、稍后处理和提交失败。
