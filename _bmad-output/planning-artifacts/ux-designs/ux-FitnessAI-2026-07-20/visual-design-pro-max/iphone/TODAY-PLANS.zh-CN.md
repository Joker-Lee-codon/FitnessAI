# iPhone — Today & Plans / 今天与计划

## 1. 目的与权威性

展示今天选定的训练计划、开始 Watch 路径，并提供计划管理入口，但不能成为活动训练场次权威。

## 2. 进入与退出

- 进入：App 打开、Today Tab、恢复的导航状态。
- 退出：在 Watch 开始、计划详情/编辑、从历史创建、打开同步/支持问题。

## 3. 构图

1. 日期和“今天训练”标题。
2. 已选计划工作表面，包含动作、组数、时长和目标 RPE 启用状态。
3. 通栏“在 Watch 上开始”操作。
4. 带计划标签的有序动作时间线。
5. 设备/同步边界靠近受影响计划，不作为全局 Toast。

## 4. 组件

`TitaniumPrimaryAction`、计划账本、`SyncBoundaryIndicator`、`SupportBoundaryNotice`、空白/加载 `SystemStatePanel`。

## 5. 必需状态

冷启动；已选计划；无计划；草稿；离线缓存；计划修订待更新；计划加载失败；Watch 不可用。

## 6. 交互与无障碍

开始操作明确写出 Watch。离线缓存计划保持可读。200% 文字时动作行堆叠计划字段。VoiceOver 在单个动作前读取计划身份和总量。

## 7. 需求与流程

FR-028、FR-035、FR-043–FR-045；UJ-1、UJ-2、UJ-3。

## 8. 预览与验证

预览：`../previews/iphone-core-pages-review.png`，页面 01；主题见 `../previews/themes-review.png`。验证无计划、离线缓存、修订待更新和 Watch 不可用。
