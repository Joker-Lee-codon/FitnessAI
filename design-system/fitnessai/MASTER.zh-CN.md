---
title: FitnessAI 钛衡设计系统
status: confirmed-visual-authority
version: 1.1.0
confirmed_direction: Titanium Measure
stack: SwiftUI
platforms: [iOS 18+, watchOS 11+]
updated: 2026-09-09
---

# FitnessAI 钛衡设计系统

## 1. 权威性与使用方式

本文件是 FitnessAI 的全局视觉权威来源。`pages/` 中的页面覆盖可以细化构图，但不得更改产品行为、范围、安全、隐私、信任语义或平台职责。

行为权威依次为：PRD、Addendum、`EXPERIENCE.md`，以及它们的 accessibility、trust/privacy/safety、validation 和 review 文档。行为与视觉冲突时，以行为为准。BMAD 旧 `DESIGN.md` 与本确认系统在视觉表达上冲突时，以本系统为准。

本系统面向原生 SwiftUI 实现。视觉交付中的 HTML 文件只是评审载体。

## 2. 品牌基础

**方向：** Titanium Measure / 钛衡——一件经过校准的训练仪器，精确、安静、耐久，并尊重用户权威。

**品牌属性：** 校准、安静、技术、可信、耐久、精确、克制。

**视觉前提：** 事实占据稳定且对齐的位置。细轨道、表格数字、明确来源标签和有边界的注意区域，使不确定性可见，同时避免成为传统仪表盘。

**绝不暗示：** 已感知外部负重、已确定主观 RPE、由腕部信号得出精确全身动作判断、尚未同步却已完成云端处理，或自动化凌驾于用户纠错。

## 3. 核心原则

1. 每个 Watch 页面一个主要任务；每个状态一个主要操作。
2. 实际事实高于计划、预测、自动化和同步元数据。
3. 状态通过文字、符号、结构和对比表达，不只依赖颜色。
4. 本地持久提交是已保存边界；云同步是独立状态。
5. 自动化必须可逆，并且不能隐藏原始来源。
6. 正式训练组保持视觉和行为上的安静。
7. iPhone 支持更高密度复核，但不重复相同圆角卡片。
8. 浅色、深色、Always On、Increase Contrast、Dynamic Type、VoiceOver 和 Reduce Motion 一起设计。

## 4. 语义配色系统

原始值位于 `tokens.json`。组件只能消费语义角色。

| 角色 | 深色 | 浅色 | 用途 |
|---|---|---|---|
| `background.canvas` | `#070A0D` | `#F4F7F8` | App 画布 |
| `background.surface` | `#0D1318` | `#FFFFFF` | 抬升工作表面 |
| `background.subtle` | `#121A20` | `#EAF0F2` | 不依赖卡片的分组 |
| `text.primary` | `#F2F7FA` | `#0B1115` | 关键事实和标题 |
| `text.secondary` | `#9CAAB2` | `#4F626C` | 辅助上下文 |
| `text.tertiary` | `#74838B` | `#61737C` | 仅限非关键元数据 |
| `border.standard` | `#2B3740` | `#B9C6CC` | 轨道、账本、分隔线 |
| `action.primary` | `#58D7FF` | `#007D9A` | 用户发起的主要操作 |
| `attention.pending` | `#FFC857` | `#875B00` | 待处理或需要复核 |
| `status.confirmed` | `#80D6A3` | `#0A6E42` | 已确认，并配合勾选/文字 |
| `status.correction` | `#A9B4FF` | `#4B55A5` | 已纠正/修订，并配合铅笔/差异 |
| `status.destructive` | `#FF8A83` | `#B42318` | 破坏性操作或记录完整性威胁 |

规则：

- `action.primary` 不是通用品牌填充色，只标识当前用户操作。
- 琥珀色不表示失败，只表示未解决注意、待确认或已延后后果。
- 绿色不能单独表示已同步；相邻标签必须明确写出“已同步”。
- Increase Contrast 将次级轨道变为 2 pt、提高次级文字对比，并为填充状态区增加轮廓。
- Always On 使用黑色画布、`#D9E0E3` 主内容、`#8B979D` 次内容，以及仅轮廓的操作/状态处理。

## 5. 字体与数字

只使用原生 San Francisco 和系统简体中文回退字体。不得引入 Inter、Google Fonts 或自定义字体依赖。

| 角色 | SwiftUI 基线 | 字重 | 行为 |
|---|---|---|---|
| Watch 指标 | 48–64 pt 缩放参考 | Bold | `monospacedDigit()`，一个主导事实 |
| iPhone 指标 | 40–56 pt 缩放参考 | Bold | `monospacedDigit()`，直接显示单位 |
| 页面标题 | `.largeTitle` / `.title` | Bold | 优先换行，不优先截断 |
| 分区标题 | `.title2` / `.headline` | Semibold | 左对齐 |
| 正文 | `.body` | Regular | 字面明确的中文，1.25–1.45 行高 |
| 标签 | `.subheadline` / `.caption` | Medium | 状态或来源标签 |
| 元数据 | `.caption2` | Medium | 不得单独承载必要操作 |

训练值使用表格数字。单位保持视觉连接但降低强调。Dynamic Type 在裁切前把多列重排为线性阅读顺序。无障碍字号下，装饰索引可以隐藏；状态、数值、来源和操作不得隐藏。

## 6. 网格、间距、形状与层次

- 基础节奏：4 pt；优先增量：4、8、12、16、24、32、48。
- iPhone 水平内边距：紧凑宽度 20 pt，常规宽度 24–32 pt。
- Watch 内容边距：根据表壳尺寸使用系统安全的 8–12 pt。
- 高频/后果显著触控目标最小 44 × 44 pt；相邻目标最小间距 8 pt。
- 圆角：紧凑控件 8 pt、工作表面 12 pt、模态/Sheet 边界 16 pt。胶囊仅限原生状态/控件模式。
- 边框：标准 1 pt，聚焦/Increase Contrast 2 pt。
- 阴影：普通分组不使用；只使用原生 Sheet/模态分离。
- 模糊：仅用于系统 Sheet、导航栏或模态背景分离，不作为装饰氛围。

分组优先级：留白 → 对齐 → 轨道/分隔线 → 轻微表面 → 抬升模态。不要把每个分区放进卡片。

## 7. 图标系统

产品 UI 仅使用 SF Symbols。导航和中性状态使用线框符号；填充变体仅用于选中导航或已提交强调。

| 含义 | 首选符号 | 必须相邻的语言 |
|---|---|---|
| 已确认 | `checkmark.circle` | “已确认”/明确事实 |
| 待处理 | `clock` | “待处理”或“等待同步” |
| 已纠正 | `pencil.and.outline` | “已纠正”以及前值/当前值 |
| 同步 | `arrow.triangle.2.circlepath` | 精确同步边界 |
| 已同步 | `checkmark.icloud` | “已同步” |
| 警告 | `exclamationmark.triangle` | 原因与下一步 |
| 不支持 | `slash.circle` | “不支持”以及回退路径 |
| 仅手动 | `hand.tap` | “仅支持手动记录” |
| Watch 路径 | `applewatch` | 目的地/操作标签 |
| 分析 | `chart.xyaxis.line` | 图表标题和摘要 |

符号尺寸令牌为 12、16、20、24 pt。视觉图形可以小于 44 pt，但触控区域不得小于。不得使用 emoji、把 SF Symbols 当作 App Logo，或在正式训练组期间使用 Variable Color 动画。

## 8. 事实、来源与持久性语法

每个记录事实可以按以下顺序暴露四层：

1. **数值：** 实际负重、次数、动作、RPE、时间。
2. **来源：** 计划、上一实际训练组、历史、用户输入、模型预测。
3. **权威：** 预测、自动采用、用户确认、已纠正、未解决。
4. **持久性：** 编辑中、本地提交中、已存于本机、等待同步、已同步、失败。

紧凑视图可以把来源和权威合并为一句话，但不能把持久性合并进去。“已记录”绝不等于“已同步”。

## 9. 组件语言

| 组件 | 视觉形态 | 关键不变量 |
|---|---|---|
| Instrument Readout | 主导表格数值 + 单位 + 来源行 | 不制造不支持的感知声明 |
| State Rail | 细分段进度/持久性轨道 | 始终提供文字替代 |
| Primary Action | 通栏冰蓝操作，每状态一个 | 仅在本地提交后展示成功 |
| Actual Set Ledger Row | 用线条分隔的对齐数值 | 来源/修订与事实保持关联 |
| Fact State Label | 符号 + 字面状态 + 可选来源 | 不只依赖颜色 |
| Correction Boundary | 琥珀左轨 + 保留事实 + 选项 | “稍后处理”保留待处理事实 |
| Crown Adjustable Value | 草稿值 + 来源 + 明确提交 | Crown 旋转不能自行提交 |
| Plan Diff | 前值/当前值/建议值账本 | 指明受影响的未来修订 |
| Sync Boundary | 设备/副本范围 + 状态 + 下一步 | 云失败不能取消本地成功 |
| Trend Evidence | 直接标注折线/柱 + 文字摘要 | 待处理/冲突输入排除或标注 |
| Plan Exchange Review | source/version + 完整 plan ledger + mapping/omission + 一个 Create Draft action | 私有 Alpha；untrusted input 绝不覆盖现有计划 |
| Structured Input Draft | 带 source label 的 draft + parsed fact + ambiguity/conflict + 明确 choice | 仅未来；confirmed replacement 提交前，committed fact 保持权威 |

完整行为与 SwiftUI 契约位于视觉交付 `components/` 目录。

## 10. 图表语言

- 时间趋势 → 折线图，直接标注终值、精确选中点、时间粒度和文字摘要。
- 周/月对比 → 对齐柱图或紧凑表格；精确训练数据不使用装饰性环形图。
- 已确认系列 → 实线；待处理/排除投影 → 虚线；纠正点 → 空心菱形或明确修订标记。
- 网格线降低强调；坐标轴包含单位和粒度。
- 每张图提供 VoiceOver 摘要和数据表替代。
- 可交互点具有 44 pt 有效目标。Reduce Motion 禁用折线绘制和插值动画。

## 11. 动效与触觉

动效只表达提交、替换或导航。

| 令牌 | 时长 | 用途 |
|---|---:|---|
| `motion.press` | 100 ms | 透明度/状态层按压反馈 |
| `motion.replace` | 180 ms | 数值或状态替换交叉淡化 |
| `motion.enter` | 220 ms | 原生 Sheet/详情进入 |
| `motion.exit` | 150 ms | 退出 |

训练期间不使用持续氛围、庆祝、弹跳、视差、跑马灯或装饰性加载。Reduce Motion 使用即时更新或短交叉淡化。

触觉保持克制：有意调节步进使用 selection；本地提交后才使用 success；必要注意使用一次 warning；仅在记录完整性受威胁时使用 notification/error。不得每次点击都触觉。

## 12. 平台构图

### Apple Watch

- 主导层级：动作 → 组/休息上下文 → 实际负重 → 次数 → 一个操作。
- 每屏一个任务。复杂纠错、冲突和不支持语义移交到精确的 iPhone 对象和字段。
- Digital Crown 是可选加速器，并有触控和无障碍可调节等价操作。
- Always On 保留动作、组、负重/次数上下文和持久性状态，同时降低色彩并禁用操作。
- 正式训练组不主动显示提示，除非记录完整性受到威胁。

### iPhone

- 原生顶层导航直接提供今天、历史、分析；Catalog、Sync & Recovery、Account & Privacy 和 Support Matrix 位于下一层。
- 使用编辑式对齐、账本、时间线和直接图表标注，而不是相同卡片。
- 固定底部操作预留安全区和滚动内边距。
- 完整纠错、拆分/合并/插入/删除、冲突、生命周期范围和长说明属于 iPhone。

### 阶段扩展

- 私有 Alpha Training Plan portability 是 contextual iPhone route，不是新 tab。它使用 `Plan Exchange Review`，把文件视为不可信输入，预览完整内容与 provenance，导出时调用原生 Share Sheet，导入时只创建新草稿。
- 私有 Alpha 文字 AI planning 使用原生 conversation、默认关闭的 remote-data authorization、完整 plan/diff review、独立 digest-bound approval、atomic local commit 与最终一致的 Watch delivery。最终布局 ID 为 `DESIGN.md` 中的 `AI-L01`–`AI-L05` 与 `RV-L01`。
- Post-Alpha voice、third-party import、QR/link sharing、weekly/cycle proactive cadence 与 open-ended coaching 只能在各自 Product Gate 通过后复用该 grammar。不暗示 continuous listening 或 first-build affordance。

## 13. 无障碍契约

- iPhone 支持至少 200% 文字放大；Watch 支持至少 140%。
- VoiceOver 顺序跟随视觉优先级，而不是实现嵌套顺序。
- 状态更新合并播报；正式组期间延后播报，除非记录完整性受威胁。
- Increase Contrast 有明确令牌映射；Reduce Transparency 移除非必要模糊。
- iPhone 复核和纠错支持 Full Keyboard Access。
- 图表提供摘要、选中值和表格替代。
- 任何必要区别不得只依赖色相、动效、手势或 Digital Crown。

## 14. SwiftUI 实现规则

- 使用带 Any/Dark/High Contrast appearance 的语义 `Color` Asset。
- 使用语义 `Font` 角色和 `@ScaledMetric`，避免固定正文尺寸。
- 使用 `NavigationStack` 和类型安全的 `navigationDestination(for:)`。
- 行为匹配时优先使用原生 `Button`、`Toggle`、`Picker`、`Stepper`、`Gauge`、`Chart`、`sheet`、`alert` 和无障碍 action。
- 仅在原生 API 无法表达轨道或图表标记时使用 `Canvas`/自定义绘制。
- 按需读取 `accessibilityReduceMotion`、`accessibilityDifferentiateWithoutColor`、`accessibilityContrast` 和 `isLuminanceReduced`。
- 视觉成功由本地提交状态驱动；网络状态只能更新独立同步指示器。

## 15. 页面覆盖路由

- `pages/watch-training.md`：所有 Watch 训练页面。
- `pages/iphone-planning-review.md`：Plan Home、AI planning/review/approval/delivery、Training Plans、History、Session Review、proactive review 与 Plan Exchange。
- `pages/iphone-analysis-system.md`：完整 Analysis、Apple Health、Catalog、Sync & Recovery、Account & Privacy 与 Support Matrix。

页面级产品规格位于已确认视觉交付的 `watch/` 与 `iphone/` 下。

## 16. 禁止模式

- Web/Tailwind 组件、依赖 hover 的行为、GSAP、Google Fonts 或把 CSS Token 名称当作实现指南。
- 影院式发光、环境光斑、装饰性玻璃拟态、遮挡数据的渐变或仿硬件拟物。
- 通用橙绿健身语义、emoji 图标、密集 Watch 仪表盘或十按钮 RPE 网格。
- 无证据的“检测到负重”“你的 RPE 是”“已完全同步”，或隐藏不完整事实。
- 自动修改计划、自动结束训练场次或不可逆自动化。

## 17. 实体设备验证门槛

发布前在受支持的小/大 Watch 表壳和 iPhone 尺寸上验证：

- 明亮/暗光健身房中的两秒扫读；
- 流汗/单手触控、Crown 调节、误触防护和触觉辨识；
- Always On 亮度降低和防烧屏输出；
- 最长批准中文字符串与最大支持字号；
- Watch↔iPhone 移交后的 VoiceOver 焦点恢复；
- P3/sRGB 色彩表现与 Increase Contrast；
- 图表点选择、安全区、离线/恢复和本地写入失败状态。

## 18. 变更控制

视觉变更必须同时更新本文件、`tokens.json`、受影响的页面覆盖、页面规格、预览以及中英文文档。行为变更必须先更新权威产品/体验文档；本视觉系统不能静默重新定义行为。
