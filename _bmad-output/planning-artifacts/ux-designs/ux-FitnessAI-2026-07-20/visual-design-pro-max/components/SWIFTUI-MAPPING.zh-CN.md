# SwiftUI 实现映射

## 1. 目的

这是实现规格，不是正式 App 代码。它把已确认视觉系统映射到 iOS 18+ 和 watchOS 11+ 原生能力。

## 2. 令牌层

为 `design-system/fitnessai/tokens.json` 中的每个角色创建语义 Color Asset，包括 Any、Dark 和 High Contrast appearance。通过小型 `TitaniumTheme` 值类型暴露；页面代码不能包含原始十六进制值。

主导训练数字使用语义文字样式和 `@ScaledMetric`：

```swift
@ScaledMetric(relativeTo: .largeTitle) private var metricSize: CGFloat = 56

Text(value)
    .font(.system(size: metricSize, weight: .bold, design: .default))
    .monospacedDigit()
```

## 3. 环境输入

```swift
@Environment(\.accessibilityReduceMotion) private var reduceMotion
@Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
@Environment(\.accessibilityContrast) private var accessibilityContrast
@Environment(\.colorScheme) private var colorScheme
@Environment(\.isLuminanceReduced) private var isLuminanceReduced // watchOS
```

Always On 切换语义映射和操作呈现，不创建无关布局。

## 4. 导航

- iPhone：Today、History、Analysis 使用 `TabView`；详情使用带类型安全 `navigationDestination(for:)` 的 `NavigationStack`。
- Watch 训练前：原生导航。活动训练场次：浅层状态驱动页面，不使用探索式 Tab。
- Watch→iPhone Handoff Payload 标识 session、set、field、draft、provenance 和 return context。

## 5. 原生控件映射

| 视觉组件 | SwiftUI 原语 |
|---|---|
| 主要/次级操作 | `Button`、`ButtonStyle`、语义 `role` |
| 可调负重/RPE | `Stepper` 或自定义按钮 + `digitalCrownRotation` + accessibility adjustable action |
| 状态/来源 | `Label`、`accessibilityElement(children: .combine)` |
| 账本行 | iPhone 使用 `Grid`，Watch 使用自适应 `VStack/HStack` |
| 趋势图 | `Chart`、`LineMark`、`BarMark`、`RuleMark`、`PointMark` |
| 加载 | `ProgressView` 或保持几何的骨架 |
| 纠错/恢复 | `sheet`；Watch 空间需要时使用状态驱动的完整页面 |
| 确认 | 破坏性后果使用 `confirmationDialog`/`alert` |
| 设置/生命周期 | 使用 `Form` 语义和钛衡行样式 |

## 6. 状态所有权

UI 状态必须区分 `draft`、`localCommit` 和 `sync` 阶段。推荐 View Model 形态：

```swift
enum LocalCommitState { case editing, committing, saved, failed }
enum SyncState { case notRequired, pending, synchronized, failed, conflict }
```

绝不能用其中一个推导另一个。页面可以同时显示“已存于本机 · 等待同步”。

## 7. 动效与触觉

只使用明确的值驱动动画：

```swift
.animation(reduceMotion ? nil : .easeOut(duration: 0.18), value: state)
```

优先交叉淡化/透明度替换。正式训练组期间，除直接按压反馈或记录完整性警告外，不使用动画。触觉由成功状态转换触发，而不是由点击触发。

## 8. 无障碍

- 使用字面明确的中文 `accessibilityLabel`、`accessibilityValue` 和包含后果的 `accessibilityHint`。
- 默认对紧凑实际训练组行进行分组；为编辑、次数、负重和 RPE 添加自定义 action。
- 纠错/Handoff 后使用 `AccessibilityFocusState` 恢复焦点。
- 图表在单点浏览前暴露摘要，并提供无障碍数据列表。
- 大字号时使用 `ViewThatFits`、字号类别或 Layout Protocol 把网格切换为堆叠布局。

## 9. 规划中的扩展

### V1.1 plan-file 扩展

使用原生 `fileImporter`/`fileExporter` 或 document API，并声明 FitnessAI plan content type。在 DV-007 有界限制下离开 main actor 解析；构造 view state 前拒绝 executable 或 malformed structure。View model 区分 `validation`、`mappingDraft` 与 `localCommit`，且不暴露 merge/replace-existing command。及时释放 security-scoped access；diagnostic 不包含 credentials 或无关 workout data。

### Future structured-input 扩展

预留 source/provenance、draft、ambiguity、duplicate/conflict 与 local-commit state，但不增加 MVP permission 或 voice dependency。如果后续激活 voice，microphone/speech permission 与 audio lifetime 属于 capability-specific adapter；`StructuredInputDraft` 只接收解析后的 structured value，绝不把 raw transcription 当作 committed truth。

## 10. 验证目标

在小/大 iPhone、受支持 Watch 表壳、深浅色、High Contrast、最大内容字号、VoiceOver、Reduce Motion、Always On、离线、本地写入失败和冲突状态下预览和测试。正式验收仍需要实体设备。
