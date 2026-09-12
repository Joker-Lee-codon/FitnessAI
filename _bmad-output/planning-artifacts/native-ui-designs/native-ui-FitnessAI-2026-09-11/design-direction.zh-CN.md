# FitnessAI Native UI 方向选择

## 阶段与依据

- 当前阶段：`ND-01 Direction`
- 状态：等待 Product Owner 选择方向
- 权威产品输入：`prd-FitnessAI-2026-07-19/prd.md`、`SPEC.md`、`epics.md`
- 权威行为输入：`ux-FitnessAI-2026-07-20/EXPERIENCE.md` 及 2026-09-08 reconciliation
- 显式视觉覆盖：`prototypes/iphone-trust-ledger/design-direction.md`

Product Owner 已要求不参考既有设计页面。本轮因此不继承旧 native UI run、旧 preview、旧 SwiftUI 页面或旧 design-system 的视觉表达；它们不作为方向依据。产品范围、IA、状态、恢复、信任与无障碍合同继续由 PRD、SPEC 和 `EXPERIENCE.md` 约束。

## 必须保留的不变量

- Watch 是被选记录设备时进行中 Workout Session 和本地持久 Actual Sets 的权威。
- 手动 Start/Finish 保持权威；系统永不自动开始或结束。
- Start 使用固定 Plan Revision 快照；计划事实与 Actual 事实分离。
- 只有本地持久提交成功后才显示已保存；iPhone 回流是独立状态。
- 自动识别、RPE 与结束提醒只在 `restSafeForInteraction` 时出现，并共享主动打断预算。
- 不确定和不支持优先降级到 manual fallback；纠正不能丢失 reps、load、RPE、time 或 order。
- 高频控件至少 44 × 44 pt；Digital Crown 不是唯一输入；颜色、动效和触觉均有文字或 VoiceOver 等价物。

## 可以舍弃的视觉决定

- 旧方向名称、旧颜色、旧材质、旧卡片结构、旧 Watch 页面构图。
- Activity Ring、健身评分、霓虹渐变和把多个指标压在同一仪表盘上的惯例。
- 为了看起来“智能”而持续显示传感器状态或模型动画。

## 共同视觉基础

| 角色 | 值 | 方向用途 |
|---|---:|---|
| Claude 奶油纸 | `#F4F1EA` | 明亮表面与 iPhone 连续性 |
| 深棕墨 | `#3D3929` | 正文、结构与暗色 Watch 基底 |
| Claude 陶土橙 | `#D97757` | Plan、计划轨与主导航语义 |
| Claude 紫灰 | `#6B5778` | Actual、纠正与完成组操作 |
| Claude 苔藓绿 | `#788C5D` | durable saved 与 confirmed |
| Claude 琥珀 | `#BA7517` | uncertain、pending 与 incomplete |

Watch 中文使用系统 `SF Pro/PingFang SC` 映射；重量、次数、计时和组序采用 `Avenir Next Condensed` 风格的窄体数值映射。数值不使用等宽体。Watch 每屏只有一个主要任务和一个 consequential primary action。

## 已选择方向

- 选择：`A — 训练底稿`
- 确认日期：2026-09-12
- 确认者：Product Owner
- 状态：`ND-01 completed`

该选择将“顺序位置优先”确立为 Watch 核心视觉语法：活动训练默认先回答用户进行到第几组，再显示当前 Actual Load、目标 reps/RPE 与 durable-save 状态。重量和次数编辑进入独立 `Edit Actual Set` 页面，以保护活动页的低干扰和单一主操作。

这是一项显式视觉覆盖：它取代旧 native UI run、旧 `DESIGN.md` 视觉 token 和旧 Watch preview 在材质、颜色、几何与页面构图上的权威，但不改变 `EXPERIENCE.md` 的 IA、行为、状态、无障碍与跨设备权威边界。方向 B 保留为已评估但未选择的探索，不进入 ND-02 token 冻结。

## 方向 A — 训练底稿

### 受众与场景

适合已有明确计划、希望在出汗和高心率状态下按组推进、只需要快速确认当前组是否可靠保存的训练者。

### 单一主要工作

在不进入编辑模式的情况下完成当前实际训练组，并确认它已经在 Watch 本地持久化。

### 视觉命题

把 iPhone 的连续训练轨压缩成 Watch 左侧的“组刻度”。每一格只在 durable commit 后填实；当前格用轮廓表示；未完成格保持空白。用户不用读取仪表盘即可知道位置。

```text
┌──────────────────┐
│ 18:42       结束 │
│ 杠铃深蹲          │
│ ●                │
│ ●      80 kg     │
│ ●      目标 5 次  │
│ ◇      RPE 8     │
│ 已保存 3 组       │
│ [   完成本组   ]  │
└──────────────────┘
```

### 设计姿态

- 排版：主要数值居中，动作和状态左对齐；组刻度保持非对称。
- 色彩：暗深棕 OLED 基底；奶油文字；陶土橙为 Plan 刻度，紫灰为 Actual 操作，苔藓绿为已保存。
- 材质：无玻璃、无阴影；只使用 OLED 黑、实体色块和 1 pt 结构线。
- 几何：组刻度使用方形缺口而非圆环；主按钮顺应 Watch 底部宽度。
- 动效：本地提交成功时当前刻度一次性填实；Reduce Motion 下立即变化。
- 数据：一次只强调 Actual Load；reps 与 target RPE 为次级事实。
- 美学风险：用左侧非对称刻度换取顺序识别，主动放弃常见的居中圆形运动构图。
- 禁止：连续传感器动画、自动完成暗示、仅以绿色表达保存、在活动组中弹出识别问题。

### iPhone 连续性

对应 iPhone Today & Plans 的垂直训练轨。Watch 的四段组刻度映射到 iPhone 的动作内 Actual Set 行，颜色和事实语义保持一致，但 Watch 不复制手机的信息密度。

## 方向 B — 动作台

### 受众与场景

适合训练经常根据当天状态调整重量或次数、需要在 Watch 上迅速修改 Actual 值，同时仍希望保持计划值可见的训练者。

### 单一主要工作

在同一页面检查或调整 Actual Load 与 reps，然后完成当前组。

### 视觉命题

把 Watch 当成器械上的双参数调节台：左侧是重量，右侧是次数。点击一个数值后 Digital Crown 加速调整；同一操作必须提供屏幕上的 `−` / `+` 与 accessibility adjustable action。

```text
┌──────────────────┐
│ 杠铃深蹲   第 4/4 │
│                  │
│  重量       次数  │
│  80         5    │
│  kg         次    │
│ 计划 80   计划 5  │
│ 已保存 3 组       │
│ [   完成本组   ]  │
└──────────────────┘
```

### 设计姿态

- 排版：动作和组次在顶部左右对齐；两个 Actual 数值形成稳定双列；主操作在底部。
- 色彩：奶油表面；深棕文字；紫灰表示可编辑 Actual 值，陶土橙只标计划参照，苔藓绿表示已保存。
- 材质：像设备铭牌的平面表面；不使用独立圆角卡片包裹每个数值。
- 几何：中部由一条粗分隔线形成两个调节区；选中区以轮廓和文字“正在调整”共同表示。
- 动效：焦点切换只改变结构线与标签；不做数字滚轮惯性动画。
- 数据：Actual 与 Plan 紧邻但不合并；单位永远可见。
- 美学风险：允许用户在主页面直接编辑两个权威 Actual 值，提高控制密度，但不增加第二个 consequential action。
- 禁止：把计划预填说成传感器识别、用 Crown 作为唯一编辑方式、把双列变成四张小卡片。

### iPhone 连续性

对应 iPhone Session Review 与 Analysis 的 planned/actual 对照行。Watch 使用同一陶土橙/紫灰语义，但只保留当前组的两个可编辑事实；完整纠错仍交给 iPhone。

## 方向差异摘要

| 维度 | 方向 A：训练底稿 | 方向 B：动作台 |
|---|---|---|
| 首要认知 | 我进行到第几组 | 这组实际做了多少 |
| 核心结构 | 左侧顺序刻度 + 单一主数值 | 双列 Actual 调节台 |
| 默认操作 | 直接完成组 | 检查/修改后完成组 |
| 更适合 | 计划执行稳定 | 现场调整频繁 |
| 主要风险 | 编辑入口较深 | 主屏控制密度更高 |

## 选择 Gate

Product Owner 已选择 `A 训练底稿`，本 Gate 已关闭。下一阶段 `ND-02` 将运行一次 `ui-ux-pro-max` 搜索并冻结 SwiftUI semantic tokens；获得系统与代表页面确认后，才能展开完整 Watch core 批次：Approved Plan、Active Workout、Edit Actual Set、Rest Resolution、Watch Recovery、Finish & Local Save。
