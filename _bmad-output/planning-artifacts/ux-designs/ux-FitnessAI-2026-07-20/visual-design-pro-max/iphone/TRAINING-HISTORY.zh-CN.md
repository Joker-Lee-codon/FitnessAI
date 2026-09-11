# iPhone — Training History / 训练历史

## 1. 目的与权威性

浏览计划/自由训练场次、完整/待补全边界、修订、删除状态和恢复进度，并且不丢失历史事实。

## 2. 进入与退出

- 进入：History Tab、Analysis 下钻、恢复路径。
- 退出：Session Review、复用为新草稿、筛选周期/类型、打开恢复/删除状态。

## 3. 构图

1. 周期/筛选控件。
2. 字面周期摘要：训练场次和动作。
3. 按日期/周分组的时间顺序训练场次账本。
4. 每行：计划/自由、完整/待补全、组数/时长、修订/同步状态。
5. 恢复/删除边界与受影响行内联。

## 4. 组件

训练场次账本行、`FactStateLabel`、`SyncBoundaryIndicator`、`LifecycleRequestRow`、`SystemStatePanel`。

## 5. 必需状态

冷启动；就绪；空白；离线缓存；恢复中/失败；已删除/Tombstone；修订待处理；冲突。

## 6. 交互与无障碍

返回时保留筛选和滚动。需要时，已删除项目保留可见生命周期状态；旧 Replay 不能恢复它们。VoiceOver 对训练场次事实分组，并提供复核/复用 action。

## 7. 需求与流程

FR-035–FR-041、FR-045–FR-046、FR-063、FR-067–FR-068；UJ-2、UJ-3、UJ-5。

## 8. 预览与验证

预览：`../previews/iphone-core-pages-review.png`，页面 04。验证空周期、离线缓存、Tombstone、恢复失败、筛选保留和历史复用。
