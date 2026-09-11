---
title: FitnessAI 原生 UI — ND-01 替代视觉方向
status: selected
stage: ND-01
iteration: 2
updated: 2026-08-08
---

# FitnessAI 原生 UI — ND-01 替代视觉方向

## 1. 决策 Gate

第一组 Quiet Orbit 与 Set Blocks 已被用户明确否决。其渲染仅保留为诊断证据，不再拥有视觉权威。第二组比较包含方向 C 与方向 D。

用户已于 2026-08-08 为早期 comparison run 明确选择 **方向 D — Kinetic Type（动势字场）**。ND-01 保持历史完成状态。2026-09-08，权威双语 `DESIGN.md` 确认 **Titanium Measure 1.1.0** 为私有 Alpha 实现系统，并要求独立的可测试 iPhone 视觉/布局合同。该后续 confirmed spine 在生产实现上取代 Direction D，同时保留本文作为决策历史。

### 1.1 最终私有 Alpha 视觉处置 — 2026-09-09

Titanium Measure 是选定实现方向。其当前表达为极简原生 utility，使用 editorial ledger、明确 provenance、有界 attention rail 与克制的青色用户操作强调。第 3 节中的旧否决诊断只适用于早期密集 telemetry 表达；它不重开或否决已确认的 1.1.0 system。生产 iPhone 布局位于 `previews/iphone-core-alpha-final-v1.html` 与 `native-ui-spec.md`。

## 2. 权威与保留契约

PRD 范围/版本边界与 `EXPERIENCE.md` 行为保持不变。两个候选都保留：

1. Apple Watch 作为训练中权威，iPhone 作为伴随端。
2. 正式组状态保持安静，且只有一个主要操作。
3. 实际事实高于计划、预测、自动化与同步元数据。
4. draft、本机持久化提交、等待同步和已同步状态彼此分离。
5. 用户拥有纠正权威，且不丢失同级事实或 provenance。
6. 离线捕获、中断恢复、可见不完整事实、手动 Finish 和精确字段交接。
7. Dynamic Type、VoiceOver、Reduce Motion、Increase Contrast、Always On、冗余状态线索和 44 × 44 pt 关键目标。
8. FR-001–FR-007、FR-008–FR-027、FR-028–FR-035、FR-042–FR-048、FR-061–FR-070、UJ-1、UJ-3 与 Flow 6。
9. MVP 导航仅包含 Today & Plans、Training History 与 Analysis。V1.1 和 Post-MVP 目的地继续缺席。

## 3. 更新后的否决诊断

### 3.1 旧 Titanium Measure

旧系统把可信等同于密集的遥测账本：黑色场、细轨、低对比微标签、重复行和脱离上下文的青色操作块。它把 Watch 与 iPhone 压平成同一种视觉语法，也让 Today 更像规格表而不是现实中的一天。

### 3.2 被否决的替代组

| 被否决候选 | 原先尝试 | 当前丢弃原因 |
|---|---|---|
| Quiet Orbit | 把 Watch 收敛为一个中心事实，并用连续跑道连接 iPhone 计划。 | 轨道仍是强设计感的工具隐喻。用户必须先接受一个新视觉概念，才能简单阅读训练。 |
| Set Blocks | 把训练组与 Exercise 转化为大型触觉平面。 | 组块语言视觉力量过强，偏海报化；它可能让信息容器显得像设计实验，或暗示每个平面都可交互。 |

### 3.3 修订后的设计目标

下一组同时移除遥测和图解式 UI。方向 C 探索 FitnessAI 需要多小的视觉作者性，才能显得高级且明确原生；方向 D 探索仅依靠 typography 与 rhythm，而不是容器、圆环或 dashboard，能建立多强的运动品牌辨识度。

## 4. 方向 C — Native Breath（原生呼吸）

### 4.1 受众与使用情境

面向重视即时理解、平静信心，以及第一天就觉得原生的常规训练者。它针对快速抬腕、明暗健身房、大号中文，以及不信任“设计感 dashboard”的用户进行优化。

### 4.2 单一主要任务

- **Watch Active Session：**无需解释视觉隐喻即可读取当前 Actual Set 并完成它。
- **iPhone Today & Plans：**在一次自然滚动中看到今日计划、Watch 就绪状态和动作顺序。

### 4.3 令人记住的视觉命题

**通过呼吸感建立信心。**FitnessAI 使用原生 typography、alignment、separator、control 和 material，并以异常克制的留白组织它们。品牌辨识来自节奏：一个大事实、一条安静证据、一个操作，而不是标志性形状。

### 4.4 视觉姿态

| 维度 | 方向 C 姿态 |
|---|---|
| Typography | 原生 San Francisco 与简体中文 fallback；使用 `.largeTitle`、`.title2`、`.body` 和 tabular figures；层级尺度跳跃大，几乎不使用微型全大写。 |
| Color | 自适应云白/柔炭画布；石墨文字；克制深玉色用于操作与本机持久化确认；琥珀/错误色仅保留语义用途。 |
| Material | 原生 grouped background 与 toolbar material；iPhone 只有一个轻微抬升的训练表面；Watch 保持视觉平面化。 |
| Geometry | 原生矩形、separator、safe area 和一个全宽 Button；小型组进度点是离散且字面的。不使用自定义圆环或相连组块。 |
| Imagery | Active Session 不使用。Today 可用一个小型 SF Symbol 表达 Watch 就绪；不使用动作摄影或装饰插图。 |
| Motion | 原生导航与按压反馈；本机提交后进行短促文字/数值交叉淡化。不使用自定义编舞。 |
| Data display | 实际负重最大，次数与组序为辅助。来源与本机持久化以一句可读证据呈现。iPhone 使用宽松 agenda list。 |

### 4.5 有理由承担的审美风险

极度克制可能显得通用。缓解方式不是添加装饰，而是在事实、证据与操作之间建立一致“呼吸比例”，使用独特的深玉色操作语言、精确中文断行和严格的平台专属 typography。

### 4.6 明确反模式

- 不使用轨道、gauge、遥测 rail、block collage、装饰 gradient、glass card stack 或健身插图。
- 不使用小号低对比信任元数据。
- 原生 SwiftUI control 能表达行为时不自定义控制。
- 不允许没有明确阅读节奏的空白；克制不能变成未完成布局。

### 4.7 代表性表面

#### Apple Watch — Active Session

1. 动作名称与“第 3 / 4 组”组成一个顶部阅读组。
2. `80 kg` 居中并占主导；“8 次”作为独立辅助行跟随。
3. 数值下方放置四个字面组进度点；前三个填充，并配合“3 / 4”，进度不依赖形状单独表达。
4. “已保存到本机 · 负重来自上一组”是一句证据文字。
5. 原生全宽“完成本组”Button 是唯一操作。
6. Always On 移除 Button，保留 Exercise、组序、负重、次数和本机持久化文字。

#### iPhone — Today & Plans

1. 原生大标题“今天”和日期建立当天语境。
2. 所选训练以一个安静的抬升表面呈现，包含标题、时长、动作/组总数、Watch 就绪和一个明确启动操作。
3. “训练顺序”是宽松原生 list，包含序号、Exercise、组 × 次和负重。可选 target RPE 向下重排。
4. Offline cache、stale revision 或 Watch unavailable 作为受影响启动边界旁的 inline 原生状态行出现。
5. Today/History/Analysis 仍是唯一主要目的地。

### 4.8 预览

直接预览：`previews/direction-c-native-breath.png`；可编辑源文件：`previews/direction-c-native-breath.svg`。

## 5. 方向 D — Kinetic Type（动势字场）

### 5.1 受众与使用情境

面向希望 FitnessAI 有能量、有归属感但不游戏化的训练者。它针对发力中的快速识别、明确的汗手操作，以及像当代训练刊物而非系统设置面板的伴随 App 进行优化。

### 5.2 单一主要任务

- **Watch Active Session：**通过醒目的字形节奏识别 Exercise、负重与下一步操作。
- **iPhone Today & Plans：**立即感受当天训练意图，再无需阅读卡片即可扫视序列。

### 5.3 令人记住的视觉命题

**Typography 本身完成动作。**超大数字和裁切的装饰性动作文字形成动势；单一垂直节拍标记连接组序、本机真相与下一操作。iPhone 像训练封面自然流入编辑式计划，同时交互仍保持原生。

### 5.4 视觉姿态

| 维度 | 方向 D 姿态 |
|---|---|
| Typography | 原生 bold/rounded display 角色搭配有意裁切的装饰副本；所有语义文字保持完整、未裁切且 Dynamic Type 安全。Tabular values 保持精确。 |
| Color | 近黑墨色、矿物白文字、高能朱红操作和冷调长春花蓝次级 accent；语义 pending/error 仍通过文字与 symbol 区分。 |
| Material | 仅使用不透明场与原生 modal material。代表性表面不使用 blur 或伪深度。 |
| Geometry | 大型字形场、窄垂直节拍标记和通栏编辑式 section。Button 保持原生圆角矩形，绝不成为斜向 hit region。 |
| Imagery | Typography 就是图像。不使用摄影、身体剪影、mascot 或合成运动员图像。 |
| Motion | 本机提交后，装饰字形轻移几个点，语义数值交叉淡化；Reduce Motion 移除位移。 |
| Data display | 数值依靠尺度而不是容器分离。iPhone 计划使用带强 baseline 的编号编辑式 section，不使用卡片。 |

### 5.5 有理由承担的审美风险

超大裁切 display type 可能威胁可读性或无障碍。它只允许作为 `accessibilityHidden(true)` 的装饰层，置于完整、未裁切的语义阅读顺序之后；在大号 Dynamic Type 下装饰层消失。

### 5.6 明确反模式

- 不使用励志口号、streak、火焰、badge、confetti 或攻击性 copy。
- 语义文字不倾斜、不裁切。
- 正式组期间不使用饱和色装饰非交互内容。
- 发力前与发力中不播放动画；motion 只发生在已确认的本机提交之后。

### 5.7 代表性表面

#### Apple Watch — Active Session

1. 安静语义标题说明“杠铃卧推 · 第 3 / 4 组”。
2. 大型装饰性“80”位于前景 Actual Load 后方；前景 `80 kg` 继续完整可读。
3. 次数作为强次级行：“8 次”。
4. 细垂直节拍标记包含三个实心停点和一个轮廓停点；字面“第 3 / 4 组”继续可见。
5. “已保存到本机”附着在最后完成停点，而不是只用颜色编码。
6. 朱红原生“完成本组”操作锚定下方安全边。Always On 移除装饰与饱和色。

#### iPhone — Today & Plans

1. 编辑式 masthead 组合字面标题“今天训练”、训练名称与超大装饰星期文字。
2. 明确的 Watch 启动操作紧跟训练摘要，并命名设备就绪状态。
3. Exercise 形成由强 baseline 分隔的编号通栏 section；不使用 card 或 table enclosure。
4. 每项旁的窄节拍标记承载本机状态、stale/pending 边或支持限制，并配合字面 copy。
5. 计划管理在序列后作为原生 text action 出现，不与启动竞争。
6. 原生 Today/History/Analysis 导航保持不变，未来目的地继续缺席。

### 5.8 预览

直接预览：`previews/direction-d-kinetic-type.png`；可编辑源文件：`previews/direction-d-kinetic-type.svg`。

## 6. 结构对比

| 问题 | 方向 C — Native Breath | 方向 D — Kinetic Type |
|---|---|---|
| Watch 结构 | 带离散组点的原生字形堆叠 | 带垂直节拍标记的分层字场 |
| iPhone 结构 | 安静训练表面后接原生 agenda | 编辑式 masthead 后接编号通栏 section |
| 情绪特征 | 平静、高级、熟悉、近乎隐形 | 有能量、有辨识度、当代、受控 |
| 品牌机制 | 留白、节奏、中文 typography、深玉色操作 | 字形尺度、节拍、朱红操作、编辑式 baseline |
| 主要风险 | 可能过于通用 | Display type 可能压过语义内容 |
| 最适合 | 追求最大清晰度和 Apple 原生信心 | 不依赖 dashboard 隐喻的更强品牌身份 |

## 7. 选择结果

选定视觉方向：

- **方向 D — Kinetic Type（动势字场）**

已纳入选择时的澄清：此前右侧设备框比例过宽，视觉上不够明确。修正版预览使用清晰的竖向 iPhone 轮廓，并加入 Dynamic Island、iOS 状态栏、原生 Tab Bar 和 Home Indicator。该修正只改变呈现方式；代表性表面仍为 iPhone Today & Plans，且尚未开始任何 ND-02 系统工作。
