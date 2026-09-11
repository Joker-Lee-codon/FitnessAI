# Watch 训练页面覆盖

## 范围

适用于 Workout Entry、Active Session、Rest Resolution、Watch Recovery 和 Watch Finish Review。除非本文件更具体，否则以 `MASTER.md` 为准。

## 构图

- 使用完整安全显示区域；训练场次进行中不保留持久导航外壳。
- 光学中心只放一个主导事实或问题，靠近下方安全边缘放一个通栏主要操作。
- 使用轨道和对齐，不堆叠卡片。模态边界仅用于破坏性确认或系统要求的权限 UI。
- Active Session、Rest Resolution 和恢复转换之间保持稳定的动作/组标题。

## Watch 专属排版

- 实际负重相关时，它是最大数值；次数作为次级值，但保持独立可读。
- 动作名称允许两行，之后再减少装饰元数据。
- 计时器和同步元数据使用 `.caption2`；不得挤占动作、负重、次数或主要操作。
- 负重、次数、休息时间、组序号和 RPE 始终应用 `monospacedDigit()`。

## 交互

- 高频或后果显著操作至少为 44 × 44 pt。
- Digital Crown 只能调整草稿。触控与无障碍可调节 action 必须提供等价控制。
- 正式训练组状态抑制非关键提示、图表动效、庆祝和同步播报。
- Rest Resolution 仅在 `restSafeForInteraction` 中出现；失去安全状态时关闭，但不能丢失待处理事实。
- 主要操作按压反馈使用透明度/状态填充，不改变边界。

## Always On

- 保留动作、组序号、实际负重、次数和已保存边界。
- 把填充冰蓝控件替换为不可交互的轮廓/标签，并降低非关键轨道亮度。
- 除非平台能耗指南允许，不显示快速更新的秒数；使用分钟级或静态休息上下文。

## 无障碍

- VoiceOver 顺序：上下文 → 主导事实 → 来源/权威 → 持久性 → 主要操作。
- 默认把实际训练组事实分组为一个简洁元素；为字段提供可调节或自定义 action。
- 140% 文字大小时，负重/次数拆分先重排为上下堆叠，再考虑裁切。
- Increase Contrast 将次级轨道提高到 2 pt，并为注意区域增加轮廓。

## 预览权威

参见已确认视觉交付中的 `visual-design-pro-max/previews/watch-pages-review.png` 与 `themes-review.png`。
