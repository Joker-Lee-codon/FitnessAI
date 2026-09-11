---
name: FitnessAI 无障碍与运动负荷场景评审
status: complete
reviewed: 2026-07-20
lens: Accessibility & Exertion Context
reviewed_artifacts:
  - DESIGN.md
  - EXPERIENCE.md
  - DESIGN.zh-CN.md
  - EXPERIENCE.zh-CN.md
  - .memlog.md
  - frontmatter 中全部五份 sources
---

# FitnessAI 无障碍与运动负荷场景评审

## 结论

**UX spines 定稿前需要修订。** 当前契约已经具备良好的无障碍基础：active-set silence、原生平台行为、VoiceOver 语义、Dynamic Type、Reduce Motion、非颜色唯一状态线索、手动兜底和 local-first recovery 均已写入。然而，四个 High 缺口使核心 Watch 操作在运动负荷下仍无法形成可测试契约。最重要的问题是：安全休息窗口的定义缺失、对 Digital Crown 的依赖尚未验证、触控目标要求不可量化，以及威胁采集完整性的故障缺少 announcement/focus 策略。

本报告是规范评审，不构成 WCAG 符合性声明。适用于原生 UI 的部分以 WCAG 2.2 AA 为最低基线，并同时采用 Apple 平台无障碍指南。

## 严重级别计数

| 严重级别 | 数量 |
|---|---:|
| Critical | 0 |
| High | 4 |
| Medium | 5 |
| Low | 2 |

## 最高风险

1. set-end detection 在 superset、circuit 或 minimal-rest 训练中可能被错误当作安全纠正窗口，导致 prompt 出现在下一组 active set 中。
2. load、repetition 和 RPE 纠正依赖尚未验证的 Digital Crown 假设，且没有完整定义等价操作路径。
3. “原生 minimum target size”不是验收标准，无法保护用户在汗水、运动、颤抖或精细动作能力下降时使用高频 Watch 控件。
4. sensor gap 与 local-write failure 已列为状态，但契约没有定义哪些故障必须立即打断、哪些应等到休息，也没有定义 VoiceOver focus 和 recovery 行为。

## 发现

### High

#### H1 — “Rest”尚未被定义为安全交互状态

**位置：**`EXPERIENCE.md:31`、`EXPERIENCE.md:81-83`、`EXPERIENCE.md:124`、`EXPERIENCE.md:199-200`、`EXPERIENCE.md:223-226`、`EXPERIENCE.md:338`；`EXPERIENCE.zh-CN.md` 中对应位置。上游约束：`brief.md:28`、`prd.md:37`、`prd.md:192`、`prd.md:306-310`。

**问题：**纠正被安排在检测到的休息期，但 spine 将 rest-safe window 留作开放问题。在 superset、circuit、drop set 或 minimal-rest 序列中，检测到 set end 后可能立即开始下一组 active set。因此 prompt 可能破坏 active-set silence，并在用户已开始运动时要求精细操作。

**可实施修复：**增加独立于 `resting` 的 `restSafeForInteraction` 契约。主动 prompt 只能在安全状态持续成立时出现，并须在下一组开始前消失或延后。提供单动作“稍后”路径；pending fact 不得过期或丢弃；不得使用倒计时；未解决项进入下一安全停顿或 iPhone 批量复核。增加 superset、circuit、drop set、器械等待、长休息和无休息切换的验收场景。验证下一组 active set 开始后不再保留或新 announce prompt，同时继续遵守共享 five-prompt budget。

#### H2 — 核心 Watch 数值编辑依赖尚未验证的 Digital Crown 假设

**位置：**`DESIGN.md:189-190`、`EXPERIENCE.md:82-83`、`EXPERIENCE.md:126`、`EXPERIENCE.md:178`、`EXPERIENCE.md:337`、`EXPERIENCE.md:342`；两份中文 spines 中对应位置。

**问题：**Crown 被描述为 load、repetition 和 RPE 数值的主要 primitive。discoverability、increment、unit、per-side/assisted semantics 和 accidental rotation 均未解决，也没有要求等价可操作路径。这可能阻碍 VoiceOver、Switch Control、AssistiveTouch、精细动作能力下降者，以及运动中无法可靠旋转 Crown 的用户。

**可实施修复：**将 Crown 定义为可选加速方式，而不是更改数值的唯一方式。每个数值控件必须暴露原生 accessibility-adjustable 增减动作和等价触控路径；iPhone handoff 必须保留精确 field 和 draft。Crown 误转不得在未明确确认时 commit。测试两种佩戴方向、两侧 Crown、惯用/非惯用手、VoiceOver、Switch Control/AssistiveTouch、快速运动与编辑恢复。

#### H3 — Target size 与间距不可量化；1–10 RPE 选择尤其容易出问题

**位置：**`DESIGN.md:185-195`、`EXPERIENCE.md:83`、`EXPERIENCE.md:137`、`EXPERIENCE.md:140`；两份中文 spines 中对应位置。

**问题：**“原生 minimum target sizes 和充分间距”没有数值或例外规则，因此无法在 mockup 或实现中检查。紧凑的十项 RPE 控件、stepper，或相邻的 Finish/Continue 操作，在小尺寸 Watch 上遇到汗水、运动或颤抖时可能难以准确触发。

**可实施修复：**将 44 × 44 pt 设为高频和后果性 Watch/iPhone 控件的默认 hit region；primary workout action 不得低于该值。为次级控件记录明确例外策略，绝不低于 Apple 的 28 × 28 pt 平台下限，并始终满足 WCAG 2.2 SC 2.5.8 的 24 × 24 CSS pixel 基线或其间距/等价例外。定义相邻控件间距，禁止 Watch 上密集的十按钮 RPE 网格；每次使用一个可访问的选择控件。增加最小受支持 Watch 的物理设备测试，覆盖运动、汗水、颤抖/精细动作下降和误触测量。官方参考：[Apple Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)、[W3C SC 2.5.8](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum)。

#### H4 — 威胁采集完整性的故障缺少 announcement、focus 与紧急度策略

**位置：**`EXPERIENCE.md:108-111`、`EXPERIENCE.md:124-130`、`EXPERIENCE.md:134-139`、`EXPERIENCE.md:153-160`、`EXPERIENCE.md:259-269`；`EXPERIENCE.zh-CN.md` 中对应位置。上游完整性约束：`prd.md:181-185`、`prd.md:314-315`、`prd.md:321-323`。

**问题：**Active Session 包含 sensor gap、low-resource warning 和 local-write failure，而 active-set silence 会抑制 announcement。spine 没有区分无害的 sync delay 与意味着新训练内容没有被持久采集的故障。VoiceOver 用户可能错过后者；重复 announcement 又可能打断训练；重新启动后的 recovery focus 也未定义。

**可实施修复：**增加事件优先级矩阵。network/cloud sync 状态等到休息或结束时显示。local-write failure、capture stop 或不可恢复的 sensor state 只发出一次合并的即时多模态警报，保持视觉可见，无需精细动作关闭，并保留可恢复 fragment。快速 rep/timer 变化绝不自动朗读。进入 Watch Recovery 时，初始 accessibility focus 落在 recovered-session identity 与 durable boundary，之后是安全的 `Resume` 操作；sheet 关闭后，focus 返回受影响 set/status。使用 VoiceOver 开/关、wrist down/up、Reduce Motion、app termination 和重复故障事件进行测试。

### Medium

#### M1 — Dynamic Type 已要求支持，但缺少缩放与 reflow 验收标准

**位置：**`DESIGN.md:148-156`、`EXPERIENCE.md:136`、`EXPERIENCE.md:142`、`EXPERIENCE.md:179`；两份中文 spines 中对应位置。

**问题：**文档禁止截断关键文本，但没有命名测试比例、最小设备、reflow 行为，也没有为 `actual-set-row`、`plan-diff-review` 和 lifecycle consequence 等密集组件定义失败标准。

**可实施修复：**按照 Apple 指南，iPhone 至少支持 200% 文本放大，watchOS 至少支持 140%。在最大受支持 accessibility size 下，关键内容不得 clipping、overlap 或要求水平平移；密集 row 应重排为线性阅读顺序，非关键细节可放到明确的 detail action 后。使用中文字符串，在最小受支持 Watch 和 iPhone 上测试每个关键 surface。官方参考：[Apple Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility/)。

#### M2 — VoiceOver 语义未按组件定义 grouping、focus return 与更新节流

**位置：**`EXPERIENCE.md:78-88`、`EXPERIENCE.md:134-135`；`EXPERIENCE.zh-CN.md` 中对应位置。

**问题：**为 object、value、unit、source、state 和 action 命名是良好基线，但每次 focus/update 都朗读全部字段可能产生冗长而重复的语音。spine 没有规定 state chip 是否形成独立 focus stop、sheet 的 initial focus 落点，以及纠正后 focus 回到哪里。

**可实施修复：**增加逐组件 accessibility contract，覆盖 label、value、hint、traits、adjustable/custom actions、grouping、initial focus、focus return 和 announcement cadence。将一个 Actual Set 组合为简短默认摘要；通过 action 暴露 provenance/detail，避免重复 focus stop；合并快速变化；sheet 关闭后将 focus 返回已编辑 field/set。

#### M3 — Permission denial 有 fallback state，但没有无障碍 permission journey

**位置：**`EXPERIENCE.md:107`、`EXPERIENCE.md:118`、`EXPERIENCE.md:130`、`EXPERIENCE.md:141`、`EXPERIENCE.md:164-169`；`EXPERIENCE.zh-CN.md` 中对应位置。

**问题：**文档已规定上下文 permission 与 manual fallback，但没有定义进入和退出 system permission UI 时的 focus 转移、denied/revoked 解释、Settings 路径及防止重复 prompt 的规则。

**可实施修复：**每次系统请求前，用简短文字说明目的以及拒绝后仍可使用什么。返回后恢复到触发上下文，并只 announce 一次结果状态。denial/revocation surface 必须提供一个明确 manual fallback，并在有用时提供一个带 label 的 Settings 操作；不得反复触发系统 prompt。在线和离线状态下，使用 VoiceOver 与大字体验证完整路径。

#### M4 — 中文微文案有原则，但尚未形成可实施的认知负担契约

**位置：**`EXPERIENCE.md:53-70`、`EXPERIENCE.md:134-142`；`EXPERIENCE.zh-CN.md` 中对应位置。

**问题：**示例建立了事实真实性，但尚无覆盖高风险 Watch 状态的发布级文案清单。在运动负荷下或通过语音听取时，技术领域词和多分句 provenance 可能难以理解，尤其是在用户需要快速决策时。

**可实施修复：**增加 active capture、rest correction、permission denial、offline/local-save、sync pending、recovery、conflict 和 incomplete finish 的双语状态文案表。每个状态需要一个简短中文视觉 label、一个完整 spoken label、一个 consequence，以及至多一个 primary next action。要求 glossary 一对一映射，并在心率升高/背景噪声环境下用物理设备做理解度测试；除 glossary 明确要求外，面向用户的中文中不使用技术英语。

#### M5 — WCAG 2.2 AA 基线未映射到发布证据

**位置：**`DESIGN.md:142-144`、`EXPERIENCE.md:132-142`；两份中文 spines 中对应位置。

**问题：**文档提到 contrast、target size、motion 与 VoiceOver，但没有可审计的 surface/state checklist。focus visibility/order、label-in-name、status message、error identification/recovery、替代输入和破坏性数据错误预防等相关要求仍可能遗漏。

**可实施修复：**为每个 IA surface 和关键状态增加原生应用 accessibility acceptance matrix，至少映射 WCAG 2.2 AA 等价期望：结构/顺序、文本与非文本对比度、文本放大/reflow、keyboard/替代输入、可见 focus、label-in-name、target size、错误、status message，以及可逆/破坏性数据操作。记录 device/OS、appearance、text size、assistive technology、pass/fail 证据和 defect link。纳入 VoiceOver、Switch Control、受支持场景下的 Voice Control/AssistiveTouch，以及 iPhone Full Keyboard Access。官方参考：[WCAG 2.2](https://www.w3.org/TR/WCAG22/)。

### Low

#### L1 — 自定义 focus、pressed 与 disabled 状态未一致定义

**位置：**`DESIGN.md:61-121`、`DESIGN.md:144`、`DESIGN.md:183-195`；`DESIGN.zh-CN.md` 中对应位置。

**问题：**对比度目标提到了 focus indicator，但组件 token 没有一致定义自定义 focus/pressed/disabled treatment。只有所有控件始终保持完全原生时才可认为安全。

**可实施修复：**明确规定除非自定义控件记录 focused、pressed、selected、disabled 和 error 行为，否则必须使用原生状态。任何自定义可见 focus/state mark 都必须维持 3:1 non-text contrast 目标，且不依赖颜色即可区分。

#### L2 — Haptic 意图合理，但事件词汇与验证仍是开放项

**位置：**`DESIGN.md:210`、`EXPERIENCE.md:127`、`EXPERIENCE.md:139`、`EXPERIENCE.md:343`；两份中文 spines 中对应位置。

**问题：**Haptic 已被定义为可选并具有 visual/spoken equivalent，但 set boundary、attention 和 local-commit pattern 尚未映射或测试。相似 pattern 在力量训练中可能难以区分。

**可实施修复：**定义一个小型 event-to-haptic 表、用户控制/关闭行为、每个事件的 visual 与 spoken equivalent，以及禁止对同一未解决状态重复 haptic 的规则。在物理设备上的代表性训练中验证可区分性。

## 已确认的优势与通过项

- Active-set silence 与 five-prompt budget 明确且有来源支持。
- 状态从不只依赖颜色；必须同时使用 text、symbol 和 accessibility value。
- 破坏性操作有 label 和 confirmation；禁止 swipe-only deletion 与隐藏 long-press action。
- VoiceOver、Dynamic Type、Reduce Motion、manual fallback、offline recording、recovery 和 cross-device conflict preservation 均存在于双语版本中。
- 已根据 frontmatter token 独立计算所列 light/dark foreground pair。所有已检查 normal-text pair 均超过 4.5:1；最低的是 `{colors.action}` 与白色背景，约为 5.69:1。rendered component state、focus indicator、transparency/material、Always-On dimming 和物理设备输出仍需测量。
- 英文与中文 spines 保持相同章节结构和本次评审涉及的无障碍结论。

## 本评审镜头的退出条件

H1-H4 被纳入 spines，M1-M5 被纳入或记录为有明确 owner 的实现验收工作，并且物理设备无障碍测试至少覆盖以下内容后，本镜头可以通过：最小受支持 Watch、最大受支持字体、VoiceOver、Reduce Motion、替代输入、active set、rest-safe correction、superset/minimal-rest 延后、permission denial、offline recording、local-write failure、interruption recovery 和 incomplete finish。

