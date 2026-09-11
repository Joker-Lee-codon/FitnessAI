# Watch — Finish Review / 结束复核

## 1. 目的与权威性

确认手动结束边界，展示完整或待补全结果，保留未解决事实，并区分本地完成与同步。

## 2. 进入与退出

- 进入：用户有意手动结束；Forgotten-Finish 问题仅在发布门槛通过后出现。
- 退出：提交结束、返回训练场次或打开精确 iPhone 复核。

## 3. 构图

1. “结束训练？”边界和训练场次时长。
2. 完整/待补全摘要，包含组数和训练部位。
3. 可见的待处理字段/训练组。
4. 本地与同步边界。
5. 一个结束确认；继续保持明确。

## 4. 组件

`ActualSetLedgerRow`、`FactStateLabel`、`DurabilityRail`、`SyncBoundaryIndicator`、`TitaniumPrimaryAction`。

## 5. 必需状态

完整；待补全；结束提交中；本地结束失败；已存于本机/等待同步；已同步；受门槛约束的 Forgotten-Finish 问题。

## 6. 交互与无障碍

手动结束具有最终权威。必填字段未解决时创建可编辑待补全场次，绝不能丢弃或表示完整。只有本地提交后才显示成功。不使用庆祝动效；成功触觉短促且绑定提交。

## 7. 需求与流程

FR-004–FR-007、FR-029、FR-033–FR-034、FR-062–FR-063；UJ-1、UJ-3、Flow 6。

## 8. 预览与验证

预览：`../previews/watch-pages-review.png`，页面 05。验证待补全结果、本地成功后同步失败、返回/继续，以及发布门槛前不出现 Forgotten-Finish。
