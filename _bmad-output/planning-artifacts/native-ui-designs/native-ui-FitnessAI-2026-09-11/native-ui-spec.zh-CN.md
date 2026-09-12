# FitnessAI Native UI 规范

## 文档状态

- 阶段：`ND-02 SwiftUI design system`
- 状态：已由 Product Owner 于 2026-09-12 接受并冻结
- 选定方向：`Training Ledger`
- Token 版本：`0.2.0-nd02-accepted`
- 视觉覆盖：本规范取代旧 native UI run 与旧 `DESIGN.md` 的视觉 token、材质、几何和页面构图；PRD 与 `EXPERIENCE.md` 的范围、行为、状态、无障碍和权威边界继续生效。

## 检索输入与裁决

ND-02 按工作流仅运行一次本地 `ui-ux-pro-max` 搜索，并显式传入 SwiftUI、Apple Watch、力量训练、中文用户、低交互、高扫读性、可信本地记录、OLED 与低动效。搜索错误地把产品匹配为 Voice Recorder / Webinar Registration，并返回紫粉 Builder palette、Google Font 和 hover 动画。

接受的候选只有：OLED 深色基底、中文可读性优先、触控清晰度和低动效。拒绝 Webinar/landing 结构、紫粉 palette、Google Font、glow、hover 与 GSAP。它们不符合 watchOS、选定方向或项目需求。

## 设计原则

1. **顺序先于仪表盘。** 左侧 `training-rail` 回答当前组位置；它不是装饰编号。
2. **事实先于推断。** Plan、Actual、durable save 与 iPhone return 使用不同 token 和字面状态。
3. **活动组保持安静。** 识别、RPE 和 Finish 提示只在 `restSafeForInteraction` 出现。
4. **未知优于猜测。** 不确定和不支持进入 pending/manual fallback，不制造成功状态。
5. **一个页面，一个后果动作。** Active Workout 的唯一主操作是 Complete Set；编辑、Finish 与恢复各自独立。
6. **颜色不是证据。** 所有语义颜色都配合文字、图标或结构变化。

## 颜色系统

完整机器映射见 `tokens.json`。

| 语义角色 | Light | Dark | 用途 |
|---|---:|---:|---|
| `canvas` | `#F4F1EA` | `#171510` | 页面基底 |
| `surface` | `#FFFDFA` | `#242119` | 明确内容表面 |
| `textPrimary` | `#3D3929` | `#F4F1EA` | 主要文字和数值 |
| `textSecondary` | `#655E50` | `#BBB3A4` | 次级说明 |
| `planMark` | `#D97757` | `#E08A6B` | Plan 轨道与大面积标记 |
| `planText` | `#94462F` | `#F0A085` | 小字号 Plan 文本 |
| `actualMark` | `#6B5778` | `#AD95B8` | Actual、纠正和 Complete Set |
| `confirmedText` | `#4F623C` | `#BED39D` | 已确认和已持久保存文本 |
| `pendingText` | `#81500E` | `#F0B968` | 不确定、不完整和待处理文本 |
| `destructive` | `#A33D38` | `#F18F83` | 明确破坏性动作与错误 |

`#D97757` 不直接承载白色小字号正文；Filled primary action 使用更深的 `planAction` 或 `actualMark`，保证文本对比。Watch 默认深色，但 Light 主题必须完整可用。Increase Contrast 使用更深/更亮文本角色与 2 pt focus stroke，不只增加饱和度。

## 字体系统

中文使用系统 `SF Pro/PingFang SC`，避免外部字体加载与 glyph fallback。数值采用系统 bold + condensed width；不使用 monospace，以保留器械刻度的紧凑感而不显得像开发者控制台。

| Token | SwiftUI 映射 | 用途 |
|---|---|---|
| `watchExercise` | `.headline.weight(.semibold)` | 当前动作，最多两行 |
| `watchMetric` | `.largeTitle.weight(.bold).fontWidth(.condensed)` | 当前 Actual Load / reps |
| `watchUnit` | `.caption.weight(.semibold)` | `kg`、`次`、RPE 单位 |
| `watchMeta` | `.caption2` | 计划参照、时间与 provenance |
| `watchState` | `.caption2.weight(.medium)` | saved/pending/failed 字面状态 |
| `watchAction` | `.body.weight(.semibold)` | 主按钮与明确恢复动作 |
| `phoneTitle/body/metric` | Dynamic Type 原生 style | iPhone 连续性 |

不截断动作名、后果、数值、单位或状态。大字号下隐藏非必要计划说明，保持 Actual 值、单位、状态与主操作；必要时页面滚动，绝不缩小到不可读。

## 间距、几何与材质

- 采用 `4 / 8 / 12 / 16 / 20 / 24 pt` 节奏。
- Watch 高频操作最小 `44 × 44 pt`，主操作建议高度 `48 pt`，相邻目标间距至少 `8 pt`。
- `training-rail` Watch 宽 8 pt，notch 7 pt；完成格只在 durable commit 后填实。
- 圆角只表达容器：状态 7 pt、调节控件 12 pt、主操作 16 pt、sheet 20 pt。训练数据不切成卡片墙。
- Watch 不使用阴影、glass、blur 或透明叠层；采用 OLED 深色、实体填充和结构线。
- iPhone 可使用奶油 canvas 和柔白 surface，但不增加装饰 elevation。

## 图标、图表与内容资产

- 图标仅使用 SF Symbols，默认 monochrome；同一层级保持相同 stroke/rendering。
- 小、中、大图标为 `14 / 18 / 22 pt`，hit target 独立扩展至 44 pt。
- 保存状态使用 `checkmark.circle.fill` 加“已保存在本机”；失败使用 `exclamationmark.triangle.fill` 加具体失败说明。
- Watch Active Workout 不使用图表、Activity Ring、人体插画或传感器波形。
- Analysis 图表只属于 iPhone；必须具备文字/表格等价物。

## 动效与触觉

| 事件 | 视觉 | 触觉 | Reduce Motion |
|---|---|---|---|
| 按压 | 100 ms opacity/tint 反馈，不移动布局 | 原生 selection 可选 | 仍保留即时状态反馈 |
| durable save | 当前 rail notch 在 180 ms 内填实，状态改为“已保存在本机” | commit 成功后 `.success` 一次 | 立即填实 |
| rest resolution 出现 | 240 ms 原生 sheet transition | 仅在 rest-safe 边界一次 notification | 无位移切换 |
| save failed | 错误摘要替换 pending，不抖动 | failure，且有可见/朗读等价物 | 相同 |

没有 page-load choreography、循环模型动画、数字惯性轮或 hover。触觉永远不是唯一信号。

## 状态语法

| 状态 | 视觉和文字合同 | 操作合同 |
|---|---|---|
| `loading` | 保留已有 durable 内容；字面“正在恢复记录…” | 可取消时明确显示 |
| `pending` | 琥珀标记 + “尚未保存/待确认” | 不显示成功；在安全边界解决 |
| `success` | 苔藓标记 + “已保存在本机” | iPhone 回流仍单独显示 |
| `warning` | 琥珀 + 具体后果 | 提供一个恢复动作 |
| `error` | destructive + 失败摘要 | Retry 保留输入和已保存事实 |
| `incomplete` | 琥珀 + 缺失字段数量 | Finish as incomplete 明确命名 |
| `conflict` | “请在 iPhone 处理冲突” | Watch 不擅自裁决 |
| `disabled` | 降低强调 + 字面“已关闭” | Native disabled semantics |
| `unavailable` | 说明能力/设备不支持 | 提供 manual fallback，不提供假开关 |

## 组件合同

### `training-rail`

顺序组件，而不是装饰。`complete`、`current`、`future`、`pending` 四态必须通过填充、轮廓/形状与 accessibility value 同时表达。完成数量来自 durable Actual Sets。

### `durable-state-label`

必须区分：尚未保存、已保存在 Watch、本机保存失败、等待回流 iPhone、iPhone 已接收。不得使用一个“已同步”概括多个边界。

### `actual-set-primary-action`

Active Workout 唯一主操作。点击后进入 pending；只有 commit 成功才填实 rail 并宣布保存。重复点击/重放保持幂等。

### `metric-stepper`

提供可见 `−` / `+`、tap target ≥44 pt、Digital Crown 加速与 accessibility adjustable action。用户输入是 Actual 权威事实，计划预填必须标为 Plan。

### `rest-resolution-banner`

只在 `restSafeForInteraction` 出现；先显示已保留事实，再显示不确定字段，最后提供 Confirm、Correct 或 Later。一次只解决一个主要问题。

### `recovery-action-group`

Resume 为默认主操作；Finish as incomplete 与 Discard 分开。Discard 必须二次明确确认并说明本地未回流事实范围。

## Watch 与 iPhone 差异

| 能力 | Watch | iPhone |
|---|---|---|
| Active Session | 当前组、快速 Actual 编辑、休息期解决、本地保存 | 纯手机等价路径或回流复核 |
| 计划 | 只显示最后完整 delivered revision | 创建、AI 提案、Diff、批准与传递状态 |
| 纠错 | 当前组 reps/load/exercise 快速纠正 | split、merge、insert、delete 与冲突解决 |
| 分析 | 不提供图表 | 周/月与 Primary Exercise 趋势 |
| 状态密度 | 一屏一个任务 | 可线性审核完整事实与后果 |

## 代表页面合同

### Active Workout

层级：结束入口 → Exercise → `training-rail` + Actual Load → target reps/RPE → durable state → Complete Set。唯一主操作是 Complete Set。Active movement 期间不弹出识别/RPE prompt。

```text
┌──────────────────┐
│ 18:42       结束 │
│ 杠铃深蹲          │
│ ●                │
│ ●      80 kg     │
│ ●      目标 5 次  │
│ ◇      RPE 8     │
│ 3 组已保存在本机  │
│ [  完成第 4 组  ] │
└──────────────────┘
```

### Rest Resolution

先说明“次数 5 已保留”，再询问不确定的 Exercise 或 RPE。Confirm 是主操作；Correct 与 Later 是次级操作。提示计入共享打断预算。

### Edit Actual Set

一次编辑一个字段。计划值作为参照，Actual 值使用 `metric-stepper`；保存成功前不返回 Active Workout 的成功状态。

### Local Save Failed

保留用户输入与此前已保存的三组；错误焦点先到“第 4 组尚未保存”，再到 Retry。不得填实第四格，不得声称 iPhone 已接收。

### iPhone 连续性

iPhone Today & Plans 的动作轨映射到 Watch 组刻度；Session Review 的 Actual Set 行接收 Watch 已提交事实。颜色与术语一致，密度和操作不镜像复制。

## SwiftUI 映射

| Token/组件 | SwiftUI 建议 |
|---|---|
| semantic colors | Asset Catalog light/dark named colors + `Color` extension；View 内禁止 raw hex |
| Dynamic Type | 语义 `Font` style；数值使用 `.fontWidth(.condensed)`，不固定缩放正文 |
| `training-rail` | `Canvas` 或轻量 `Shape`，每个 notch 提供合并后的 accessibility value |
| primary actions | 原生 `Button` + `.buttonStyle`，pressed 状态只改 opacity/tint |
| sheets/navigation | typed `NavigationStack` / native sheet；不自制 Web modal |
| Digital Crown | `.digitalCrownRotation` + 屏幕 stepper + `.accessibilityAdjustableAction` |
| Reduce Motion | `@Environment(\.accessibilityReduceMotion)` 切换即时状态更新 |
| Differentiate Without Color | 形状、填充、文字和 symbol 同时变化 |
| focus | 失败时聚焦错误摘要；成功时聚焦 durable result；普通状态更新不抢焦点 |

## ND-02 接受 Gate

Product Owner 已于 2026-09-12 接受 Claude 色彩在 Watch 深浅主题中的映射、`training-rail`、字体层级、主按钮、状态语法、动效/触觉和代表页面。ND-02 已冻结；ND-03 Watch core 页面批次已就绪。
