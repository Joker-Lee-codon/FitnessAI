---
title: FitnessAI UI UX Pro Max — 第一阶段视觉方向
status: awaiting-direction-selection
phase: 1
created: 2026-07-21
stack: SwiftUI
platforms:
  - iOS 18+
  - watchOS 11+
product_behavior_authority:
  - ../../../../../prds/prd-FitnessAI-2026-07-19/prd.md
  - ../../../../../prds/prd-FitnessAI-2026-07-19/addendum.md
  - ../../../EXPERIENCE.md
  - ../../../review-accessibility.md
  - ../../../review-trust-privacy-safety.md
  - ../../../validation-report.md
  - ../../../review-rubric.md
visual_status: exploratory-not-authoritative
---

# FitnessAI UI UX Pro Max — 第一阶段视觉方向

## 1. 状态与范围

本文档用于选择方向，不是最终视觉系统，也不是 App 实现。它包含三个建立在相同已确认产品与体验边界上的独立视觉方向。本阶段不会自动选择任何方向。

本阶段**不会**创建或修改 `design-system/fitnessai/MASTER.md`、最终页面规格、SwiftUI 正式视图、Architecture、Epic 或 Story。`previews/` 中的 HTML/CSS 仅是静态评审载体，不是 Web 实现指导；其中的几何、字体角色、符号、状态和动效意图均按可映射到 SwiftUI 的方式设计。

现有 PRD、Addendum、`EXPERIENCE.md`、`DESIGN.md`、评审、验证和 `.working/` 文件全部只读。旧 `DESIGN.md` 与 `.working/` 文件没有被用作视觉模板。

## 2. 三个方向共同遵守的已确认产品边界

- Apple Watch 是本地优先的进行中训练场次权威端。即使 iPhone、后端或网络不可达，也必须保持可用。
- 正式训练组期间默认安静。主动纠错只能在 `restSafeForInteraction` 中出现，下一正式组开始前必须退出，并始终提供“稍后处理”且不丢失待处理事实。
- Digital Crown 只是可选加速器。触控与原生无障碍可调节操作必须等价；草稿改动未经明确确认不得提交。
- 外部负重只能来自计划、历史、上一组或用户输入；不得表现为 Apple Watch 已感知。
- 目标、预测、用户确认、自动采用、已纠正和有效实际 RPE 必须在视觉和语义上保持区别。
- 本地持久化提交是“已保存”边界。已存于本设备、iPhone 已接收、等待同步、已同步、冲突和失败是不同状态。
- 识别不确定时必须保留同组的其他事实。未知、待处理、不支持和仅手动记录是真实结果，不能作为需要隐藏的视觉失败。
- iPhone 负责完整字段纠错、拆分/合并/插入/删除、版本冲突、长说明和恢复协调。
- 手动结束具有最终权威。忘记结束提醒在通过双信号实体设备发布门槛前保持不可用。
- 状态不能只依赖颜色。每种状态都结合结构、符号、文字和无障碍值。
- 高频或后果显著的触控区域至少为 44 × 44 pt，相邻目标至少相隔 8 pt。禁止在 Watch 上使用密集的 10 按钮 RPE 控件。
- Dynamic Type、VoiceOver、Reduce Motion、Increase Contrast、浅色/深色模式和 Watch Always On 是系统级要求，不是后期润色。

## 3. UI UX Pro Max 与平台规则的综合判断

本次严格使用三轮独立 `--design-system` 检索，并显式指定 `swiftui` 栈复核。补充检索覆盖了健身/可穿戴、高精度仪器风格、编辑式网格、受控动感运动风格、简体中文排版、健身深浅色配色、时间序列图表、状态图标、触控交互、加载、离线恢复和无障碍。

数据库匹配结果经过了有意的二次设计：

| 数据库信号 | 采用的设计判断 | 拒绝的默认方案 |
|---|---|---|
| Fitness/Gym App：鲜明色块 + OLED 深色 | 强对比与清晰训练能量 | 通用橙绿健身语义 |
| Modern Dark + Swiss Modernism | 精密网格、克制氛围、数学化层级 | 影院式环境光斑、装饰模糊、Web 横向旅程 |
| Editorial Grid / Magazine | 非对称构图、直接批注、以排版承载证据 | 翻页效果、长篇 Web 布局、繁体中文字体默认值 |
| Kinetic Brutalism | 大尺度、硬切分节奏、明确按压反馈 | 跑马灯、视差、持续运动、每次点击都触觉反馈 |
| Chinese Simplified + data typography | 原生简体中文系统字与等宽数字 | Google Font 或非原生字体依赖 |
| Trend-over-time charts | 直接标注折线、形状/线型冗余、文字数据摘要 | 只依赖颜色的系列与装饰性图表效果 |

同时使用了 Apple 当前平台规则，确保 Watch 交互可扫读且单一任务化，在 Always On 中保持布局与可读性，为颜色提供深浅色和 Increase Contrast 变体，使用 Dynamic Type，并把图标映射到 SF Symbols。参考：[Designing for watchOS](https://developer.apple.com/design/human-interface-guidelines/designing-for-watchos/)、[Always On](https://developer.apple.com/design/human-interface-guidelines/always-on)、[Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility/)、[Color](https://developer.apple.com/design/human-interface-guidelines/color)、[SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols) 和 [Charts](https://developer.apple.com/design/human-interface-guidelines/charts)。

## 4. 方向 A — Titanium Measure / 钛衡

![方向 A — 钛衡](previews/direction-a-review.png)

### 4.1 核心设计概念

FitnessAI 成为一件高精度训练仪器：哑光、安静、可测量，并明确表达每个边界。界面像经过校准的工具，而不是传统仪表盘。精细轨道、对齐读数和有边界的状态区域为事实提供位置，同时避免把每个分区都装进卡片。

### 4.2 品牌关键词与灵感来源

- 关键词：校准、安静、技术、可信、耐久、精确。
- 灵感：精密测量工具、现代工业控制、瑞士信息系统、OLED 运动仪器。
- FitnessAI 二次设计：不做仿硬件拟物，不做发光科幻 HUD，不制造传感能力幻觉。

### 4.3 浅色与深色配色策略

- 评审模式：深色，因为 Apple Watch 训练、健身房暗光、OLED 和 Always On 是最严格的主要环境。
- 深色基础：`Instrument Black #070A0D`、`Titanium #121820`、`Primary Text #F2F7FA`、`Action Ice #58D7FF`、`Attention Amber #FFC857`。
- 浅色伙伴：`Quartz #F4F7F8`、`Graphite #0B1115`、`Action Deep Cyan #007D9A`、`Attention Ochre #875B00`；表面区分主要依靠色调层级和线条。
- Increase Contrast：次级轨道改为 2 pt 实线，次级文字提升至接近主文字的对比度，状态标记同时增强符号、文字和边框。

### 4.4 字体与训练数字排版

- 仅使用原生 `Font` 样式。中文由系统简体中文字体呈现；拉丁字母和数字使用 San Francisco。
- Watch 训练数值使用 `monospacedDigit()` 和表格数字对齐，负重为主值，次数作为独立次级读数。
- 标签紧凑、字面明确；中文不使用全大写。技术英文只出现在评审板注释中，不进入产品文案。
- Dynamic Type 在任何事实被截断前，先把指标网格重排为单列。

### 4.5 信息密度

高密度但有纪律。密度来自对齐、窄状态轨道和数据行，而不是更多容器。Watch 仍是一屏一个任务；iPhone 支持密集复核，但不表现为金融仪表盘。

### 4.6 Watch 页面层级策略

1. 当前动作与组序号。
2. 用户权威的实际负重，其次是次数。
3. 本地记录状态与进度轨道。
4. 一个主要操作。

Rest Resolution 用一个不确定性问题、已保留事实、最短确认、更改和稍后处理替换正式组读数。Always On 保持布局和核心动作/负重/组上下文，弱化次级轨道，并让操作呈现不可用状态而不是直接消失。

### 4.7 iPhone 页面构图策略

- Today & Plans 使用校准式计划区域，随后是纵向动作时间线。
- Session Review 使用账本结构：训练边界状态、指标、字段对齐的实际训练组、来源文字和一个计划差异区。
- Analysis 使用大型证据图、精确批注、虚线待处理段、排除说明和面向决策的解释。
- 发丝线与基线对齐负责分组；抬升表面只保留给当前计划、可操作错误或图表详情。

### 4.8 组件与图表语言

- 组件：状态轨道、仪器读数、来源标签、有边界的警告行、精密训练组账本、计划差异条、本地/同步边界指示。
- 图表：折线与点标记配合直接数值、克制网格线、实线确认段、虚线待处理/排除段，以及文字摘要/数据表替代方案。
- 待处理、自动采用、已确认和已纠正除颜色外，还使用不同文字和线型/形状。

### 4.9 SF Symbols 使用方式

- 工具栏和状态上下文使用线框符号；填充变体只用于选中 Tab 或主要强调。
- 计划映射包括 `applewatch`、`checkmark`、`exclamationmark.triangle`、`arrow.triangle.2.circlepath`、`chart.xyaxis.line`、`clock.arrow.circlepath`、`ellipsis` 和 `chevron.right`。
- 符号字重与相邻系统文字匹配。Watch 小尺寸状态优先使用带包围形的变体增强轮廓。
- SF Symbols 不用于 App Logo 或自定义品牌标志。

### 4.10 材质、层次、动效与触觉

- 使用不透明哑光表面；模糊只用于原生 Sheet 或模态分离。
- 圆角克制（按尺度约 8–14 pt），不做全局药丸/卡片化处理。
- 动效：已提交状态使用 160–220 ms 交叉淡化或短边缘扫过；无持续环境动画，正式训练组期间无庆祝。
- Reduce Motion 用短交叉淡化或即时状态更新替代空间移动。
- 触觉：明确可调节步进使用选择反馈；只有本地提交成功后使用成功反馈；需要注意时合并为一次警告；威胁记录完整性的失败遵循 `EXPERIENCE.md` 已定义的更高多模态优先级。

### 4.11 优点、风险与适用程度

- 优点：Watch 可扫读性最强；事实/来源语义最清楚；暗光健身房连续性优秀；易于扩展同步/恢复状态；视觉噪声风险低。
- 风险：如果正文和空状态不够人性化，可能显得过度技术化；精细轨道需要实体设备 Increase Contrast 验证；浅色模式必须避免冷淡。
- FitnessAI 适用程度：**9.2 / 10**。最符合 Watch 优先权威、可信数据与长期原生实现。

## 5. 方向 B — The Training Folio / 训练刊

![方向 B — 训练刊](previews/direction-b-review.png)

### 5.1 核心设计概念

把每次训练视为一份由用户书写、可以校订的训练记录。排版、长线、边栏批注、期号和直接标注替代大部分圆角卡片。产品像一份当代训练刊物，其中的事实可以被复核、纠正和引用。

### 5.2 品牌关键词与灵感来源

- 关键词：编辑式、反思、聪明、个人、可信、沉着。
- 灵感：现代中文编辑设计、训练笔记、带批注的科学图表、高品质刊物。
- FitnessAI 二次设计：不做怀旧、纸张纹理噱头、翻页转场或手写隐喻。

### 5.3 浅色与深色配色策略

- 评审模式：浅色，因为暖纸对比、中文文案、批注层级和训练后阅读是核心测试。
- 浅色基础：`Paper #F2EFE7`、`Ink #171816`、`Annotation Blue #3157C8`、用于色块和线条的 `Correction Vermilion #C44F2D`、用于小号文字的 `Correction Ink #A83B1F`、`Rule #D9D3C6`。
- 深色伙伴：`Charcoal Paper #151613`、`Bone #F2EFE7`、`Annotation Blue #8EAAFF`、`Correction Coral #FF8A66`，配合清晰分级的哑光表面。
- 颜色只负责编辑式强调，不独自承载状态；编号批注、线条、文字和来源行表达同样含义。

### 5.4 字体与训练数字排版

- 中文标题与正文使用原生系统角色。编辑式拉丁/数字强调可以使用 `Font.system(design: .serif)`；训练值仍使用表格化系统无衬线字，保证快速读取。
- 标题、正文和元信息形成强对比，允许长中文短语有意换行。
- 需要快速比较或 Crown 调节时，训练值绝不使用装饰性衬线字。
- Dynamic Type 把多列重排为线性日志，同时保留批注引用。

### 5.5 信息密度

中等。顶层留白和排版停顿与高效日志行并存。这是最不像仪表盘、也最适合较长说明的方向。

### 5.6 Watch 页面层级策略

动作名像标题，其后是两列事实句和一个操作带。Rest Resolution 像一次边栏校订：一个编号问题、一句字面问句、已保留事实和三个索引操作。Always On 保留动作、负重、次数和组序号，移除阴影，并把纸面区域简化为高对比墨色。

### 5.7 iPhone 页面构图策略

- Today & Plans 使用日期/期号框架、一个通栏精选训练计划和编辑式序列列表。
- Session Review 像带修订的记录：封面事实、红线批注、实际训练组日志和计划脚注。
- Analysis 先用明确中文给出结论，再展示带批注的趋势和带脚注的数据限制。
- 实现仍使用原生 Tab Bar；预览用文字优先标签展示该方向的排版层级。

### 5.8 组件与图表语言

- 组件：期号标记、编辑式操作带、边栏校订、训练日志、来源脚注、计划批注、结论优先的分析标题。
- 图表：直接标注的折线/面积标记、稀疏坐标轴、明确日期和数值、叙述性结论以及带脚注的排除项。
- 卡片只保留给精选计划或模态边界，不重复用于每个分区。

### 5.9 SF Symbols 使用方式

- 符号从属于语言，只克制地用于工具栏、Tab 和后果显著的状态。
- 默认映射与方向 A 一致，但图标绝不替代编号批注或明确操作文字。
- 小型线框符号与文字成对；活动导航可以使用系统首选的填充变体。

### 5.10 材质、层次、动效与触觉

- 不透明哑光纸面，内容分区使用 0–4 pt 圆角，以强线条替代阴影。
- 动效：只在用户操作后使用 160–200 ms 交叉淡化和线条/批注出现；禁止翻页、视差或装饰性滚动运动。
- Reduce Motion 移除线条绘制，使用即时内容替换。
- 触觉语义与方向 A 完全一致；视觉等价反馈是插入批注、线条变化或明确的已提交标签。

### 5.11 优点、风险与适用程度

- 优点：中文阅读品质最强；无需非原生控件也有高度辨识度；Session Review 与 Analysis 的叙事最佳；天然避免卡片堆叠。
- 风险：浅色 Watch 在暗光健身房可能不够舒适；编辑层级在小尺寸 Watch 上需要谨慎压缩；反思式气质在训练中可能显得较慢。
- FitnessAI 适用程度：**8.5 / 10**。iPhone 复核识别度最强，Watch 实现风险中等。

## 6. 方向 C — Controlled Force / 势能

![方向 C — 势能](previews/direction-c-review.png)

### 6.1 核心设计概念

FitnessAI 把力量表现为受控势能：超大数字、硬切分带、突然但有秩序的对比，以及明确反馈。能量被约束在布局和操作状态中，而不是释放成装饰动画。

### 6.2 品牌关键词与灵感来源

- 关键词：有力、受控、自信、动感、直接、当代。
- 灵感：运动器械标记、现代体育出版、力量区导视、构成主义分节节奏。
- FitnessAI 二次设计：不对用户表现攻击性，不制造倒计时压力，不做跑马灯，正式训练组期间不庆祝。

### 6.3 浅色与深色配色策略

- 评审模式：跨模式。Watch 使用深色压低健身房干扰；iPhone 使用浅色放大复核与计划。该组合展示同一品牌跨模式的连续性。
- 核心对色：`Force Black #090A08` 与 `Chalk #F4F1E8`。
- 品牌操作：`Signal Lime #D8F24A`；决策/分析：`Decision Violet #6F55FF`；注意边界：`Boundary Coral #FF603D`。
- 深色 iPhone 和浅色 Watch 反转相同色块但不改变语义角色。Increase Contrast 移除低对比灰条并强化全部分隔线。

### 6.4 字体与训练数字排版

- 使用 Black/Bold 字重的原生系统字体，不引入几何字体包。
- 超大表格数字作为构图锚点。中文标题保持字面清晰，以有意分块换行。
- 标签保持短，但不把含义压缩成无法解释的缩写。
- Dynamic Type 把超大构图转换为堆叠色带；展示数字优先让位给后果说明。

### 6.5 信息密度

中高密度，并以大型视觉锚点组织。同屏概念更少，但每个概念占用更多面积；认知密度低于其大胆外观给人的第一印象。

### 6.6 Watch 页面层级策略

动作/组序号位于硬顶线，实际负重占据中心，次数位于独立色带，主要操作成为通栏信号块。Rest Resolution 使用青柠安全休息带、珊瑚不确定标签、已保留事实以及明确的是/更改/稍后处理。Always On 把填充强调转为轮廓或低填充版本，同时保持相同布局。

### 6.7 iPhone 页面构图策略

- Today & Plans 使用海报式标题区和一个黑/青柠执行块，后接扁平列表行。
- Session Review 使用紫色完成块、珊瑚待处理边界、大型实际训练组等式和硬计划差异线。
- Analysis 使用结论尺度数字、上下文训练量柱、负重趋势线、黑色指标条和青柠决策块。
- 分区直接接触和对齐，几乎完全去除圆角卡片。

### 6.8 组件与图表语言

- 组件：力量标题、信号操作块、安全休息带、待处理边界块、实际训练组等式行、硬差异线、决策块。
- 图表：直接标注、柱线区分、终点形状、明确指标条和文字摘要。任何解释都不只依赖青柠/紫色。
- 待处理行使用高亮填充、索引和字面状态文字；自动采用和已纠正值保留来源文案。

### 6.9 SF Symbols 使用方式

- 符号只是大胆文字色块中的紧凑标点，不作为主要品牌表达。
- 分层或调色板渲染最多使用两种语义色。训练期间不使用 Variable Color 动画。
- 线框图标与字面标签成对；活动 Tab 仅在系统提供时使用填充。

### 6.10 材质、层次、动效与触觉

- 扁平不透明色块、0–4 pt 圆角、硬线条，无环境模糊。
- 动效：100–180 ms 颜色反转、边界插入或短方向边缘移动；禁止跑马灯、弹跳、视差或过冲。
- Reduce Motion 使用即时反转/交叉淡化。
- 触觉保持选择性：已提交主要操作、安全暂停中的必要注意和威胁记录完整性的失败。绝不“每次按压都触觉反馈”。

### 6.11 优点、风险与适用程度

- 优点：品牌第一眼识别最强；Watch 大数字阅读优秀；操作信心明确；避免通用 Apple 卡片美学。
- 风险：Dynamic Type 与本地化重排负担最大；青柠色需要在 P3/sRGB 与健身房强光中监测；如果层级治理不严，大色块可能放大低优先级状态。
- FitnessAI 适用程度：**8.1 / 10**。品牌冲击力最佳，无障碍与实现调优成本最高。

## 7. 方向比较

| 评价维度 | A — 钛衡 | B — 训练刊 | C — 势能 |
|---|---:|---:|---:|
| Watch 两秒理解 | 优秀 | 良好 | 优秀 |
| 正式训练组安静程度 | 优秀 | 良好 | 良好–优秀 |
| 中文长文复核 | 良好 | 优秀 | 良好 |
| 来源/状态扩展性 | 优秀 | 优秀 | 良好 |
| 品牌辨识度 | 良好–优秀 | 优秀 | 优秀 |
| 暗光健身房与 Always On 韧性 | 优秀 | 中等 | 优秀 |
| Dynamic Type 实现风险 | 低–中 | 中 | 高 |
| SwiftUI/原生映射风险 | 低 | 低–中 | 中 |
| 变成传统仪表盘的风险 | 低 | 极低 | 极低 |
| FitnessAI 总体适用程度 | **9.2** | **8.5** | **8.1** |

## 8. 推荐方向

**推荐方向：A — Titanium Measure / 钛衡。**

它最能保护产品最难的约束：Apple Watch 必须在用户运动时保持立即可读、安静、真实且具有本地权威。它也为来源、不完整事实、同步边界、恢复、不支持状态和图表排除提供了最清晰、可扩展的语法。品牌辨识来自校准感、排版和仪器结构，而不是装饰效果。

如果产品希望以反思式训练历史和 iPhone 复核品质为主导，方向 B 是最强替代方案。如果早期品牌记忆度值得承担更高的 Dynamic Type、对比度和实体设备调优成本，方向 C 是最强替代方案。

推荐不等于选择。在用户明确选择 A、B、C 或要求一个具体混合方案前，正式设计系统生成和全页面生产保持阻塞。

## 9. 预览清单

每个方向包含相同五个页面和相同代表性数据：

| 预览 | 页面 | 展示的行为证据 |
|---|---|---|
| 01 | Watch Active Session | 动作、组序号、实际负重来源、次数、本地记录、单一主要操作 |
| 02 | Watch Rest Resolution | `restSafeForInteraction`、不确定性、保留的同组事实、确认/更改/稍后处理 |
| 03 | iPhone Today & Plans | 已选训练计划、Watch 启动路径、动作序列、目标 RPE 已启用、设备同步状态 |
| 04 | iPhone Session Review | 完整/不完整边界、待确认 RPE、已确认/自动采用/已纠正来源、计划差异 |
| 05 | iPhone Analysis | 基于实际训练组的趋势、直接数值、被排除的待处理事实、待更新/重算后果、决策洞察 |

文件：

- `previews/direction-a-review.png`
- `previews/direction-b-review.png`
- `previews/direction-c-review.png`
- `previews/preview-board.html` — 静态评审载体，不是实现
- `previews/preview-board.css` — 静态评审载体样式，不是 SwiftUI Token
- `previews/standalone-direction-a.html`
- `previews/standalone-direction-b.html`
- `previews/standalone-direction-c.html`

## 10. 选择门槛与下一步

到此停止。只有在明确选择方向后，第二阶段才可以：

1. 生成 `design-system/fitnessai/MASTER.md` 与 `MASTER.zh-CN.md`。
2. 定义语义化浅色/深色/Increase Contrast Token。
3. 设计全部 Watch 与 iPhone MVP 页面和关键状态。
4. 生成 SwiftUI 组件规格、无障碍语义、动效/触觉映射和页面级中英文 Markdown。
5. 生成最终高保真预览与 `HANDOFF.md` / `HANDOFF.zh-CN.md`。

本阶段不会开始 Architecture、Epic、Story 或 App 开发。
