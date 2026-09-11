---
name: FitnessAI
description: 面向核心产品私有 Alpha 的统一、可测试原生 Apple Watch 与 iPhone 视觉系统。
status: draft
sources:
  - "{planning_artifacts}/briefs/brief-FitnessAI-2026-07-19/brief.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
  - "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/addendum.md"
  - "{planning_artifacts}/research/market-fitnessai-near-zero-interaction-strength-training-research-2026-07-18.md"
  - "{planning_artifacts}/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.md"
  - "{planning_artifacts}/research/technical-rpe-estimation-from-heart-rate-for-strength-training-research-2026-07-19.md"
updated: 2026-09-10
colors:
  # 映射到已确认 Titanium Measure semantic token system 的兼容别名。
  surface-base: '#F4F7F8'
  surface-raised: '#FFFFFF'
  surface-muted: '#EAF0F2'
  ink-primary: '#0B1115'
  ink-secondary: '#4F626C'
  border: '#B9C6CC'
  action: '#007D9A'
  on-action: '#FFFFFF'
  success: '#0A6E42'
  warning: '#875B00'
  error: '#B42318'
  pending: '#875B00'
  surface-base-dark: '#070A0D'
  surface-raised-dark: '#0D1318'
  surface-muted-dark: '#121A20'
  ink-primary-dark: '#F2F7FA'
  ink-secondary-dark: '#9CAAB2'
  border-dark: '#2B3740'
  action-dark: '#58D7FF'
  on-action-dark: '#07131F'
  success-dark: '#80D6A3'
  warning-dark: '#FFC857'
  error-dark: '#FF8A80'
  pending-dark: '#FFC857'
typography:
  session-value:
    note: '原生 SwiftUI 数值型训练指标样式；数值更新时使用等宽数字。'
  title:
    note: '适配当前平台的原生 SwiftUI large title/title 角色。'
  body:
    note: '支持 Dynamic Type 的原生 SwiftUI body 角色。'
  label:
    note: '支持 Dynamic Type 的原生 SwiftUI headline/callout 角色。'
  meta:
    note: '支持 Dynamic Type 的原生 SwiftUI footnote/caption 角色；绝不作为关键状态的唯一载体。'
rounded:
  sm: 8px
  md: 12px
  lg: 16px
  full: 9999px
spacing:
  '1': 4px
  '2': 8px
  '3': 12px
  '4': 16px
  '5': 24px
  '6': 32px
components:
  session-control:
    classification: 'native-with-named-delta'
    background: '{colors.action}'
    background-dark: '{colors.action-dark}'
    foreground: '{colors.on-action}'
    foreground-dark: '{colors.on-action-dark}'
    native-state-policy: 'focused、pressed、selected、disabled 和 destructive/error 继承 SwiftUI Button 行为；只覆盖 enabled action colors'
  actual-set-row:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  recognition-state-chip:
    classification: 'fully-custom'
    interaction-policy: 'noninteractive；focused、pressed、selected 和 disabled 不适用'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    radius: '{rounded.full}'
    gap: '{spacing.1}'
    accepted-foreground: '{colors.success}'
    accepted-foreground-dark: '{colors.success-dark}'
    pending-foreground: '{colors.pending}'
    pending-foreground-dark: '{colors.pending-dark}'
    error-foreground: '{colors.error}'
    error-foreground-dark: '{colors.error-dark}'
  quick-correction-sheet:
    classification: 'native-as-is'
    native-state-policy: 'sheet material、geometry、focus、pressed、selected、disabled 和 error presentation 继承 SwiftUI；content 使用其他具名组件'
  load-stepper:
    classification: 'native-with-named-delta'
    value-typography: '{typography.session-value}'
    provenance-typography: '{typography.meta}'
    provenance-foreground: '{colors.ink-secondary}'
    provenance-foreground-dark: '{colors.ink-secondary-dark}'
    native-state-policy: 'geometry、focus、pressed、selected、disabled 和 error presentation 继承 SwiftUI Stepper/Digital Crown 行为'
  rpe-verification-prompt:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  plan-diff-review:
    classification: 'fully-custom'
    interaction-policy: 'container 和 diff row 为 noninteractive；child action 继承原生 SwiftUI state'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.3}'
    changed-border: '{colors.action}'
    changed-border-dark: '{colors.action-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  sync-state-indicator:
    classification: 'fully-custom'
    interaction-policy: 'noninteractive；focused、pressed、selected 和 disabled 不适用'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-secondary}'
    foreground-dark: '{colors.ink-secondary-dark}'
    radius: '{rounded.full}'
    gap: '{spacing.1}'
    pending-foreground: '{colors.pending}'
    pending-foreground-dark: '{colors.pending-dark}'
    error-foreground: '{colors.error}'
    error-foreground-dark: '{colors.error-dark}'
  recovery-choice-sheet:
    classification: 'native-as-is'
    native-state-policy: 'sheet material、geometry、focus、pressed、selected、disabled 和 error presentation 继承 SwiftUI；content 使用原生 action 和其他具名组件'
  support-boundary-notice:
    classification: 'fully-custom'
    interaction-policy: 'notice container 为 noninteractive；任何 child route action 继承原生 SwiftUI state'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    warning-border: '{colors.warning}'
    warning-border-dark: '{colors.warning-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  lifecycle-request-row:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.sm}'
    gap: '{spacing.2}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    pressed-background: '{colors.surface-muted}'
    pressed-background-dark: '{colors.surface-muted-dark}'
    selected-border: '{colors.success}'
    selected-border-dark: '{colors.success-dark}'
    disabled-foreground: '{colors.ink-secondary}'
    disabled-foreground-dark: '{colors.ink-secondary-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  plan-exchange-review:
    classification: 'fully-custom'
    background: '{colors.surface-raised}'
    background-dark: '{colors.surface-raised-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.3}'
    unresolved-border: '{colors.pending}'
    unresolved-border-dark: '{colors.pending-dark}'
    focused-border: '{colors.action}'
    focused-border-dark: '{colors.action-dark}'
    error-border: '{colors.error}'
    error-border-dark: '{colors.error-dark}'
  structured-input-draft:
    classification: 'fully-custom'
    background: '{colors.surface-muted}'
    background-dark: '{colors.surface-muted-dark}'
    foreground: '{colors.ink-primary}'
    foreground-dark: '{colors.ink-primary-dark}'
    border: '{colors.border}'
    border-dark: '{colors.border-dark}'
    radius: '{rounded.md}'
    gap: '{spacing.2}'
    draft-border: '{colors.pending}'
    draft-border-dark: '{colors.pending-dark}'
    conflict-border: '{colors.error}'
    conflict-border-dark: '{colors.error-dark}'
---

# FitnessAI — 设计脊柱

## Brand & Style

FitnessAI 应呈现为值得信赖的训练仪器：训练者发力时保持安静，事实需要关注时保持精确，并明确区分已保存、推断、pending 或 unsupported。来源支持的视觉优先级是运动状态下的 glanceability、真实 provenance、可逆自动化，以及 Watch 与 iPhone 之间的连续性。

**已确认私有 Alpha 视觉方向：**使用 SwiftUI/watchOS/iOS conventions 与现有 Titanium Measure semantic tokens，保持简约、干净、克制的原生工具感。私有 Alpha 要求每个范围内页面具有统一最终风格与完整可测试布局；占位页或仅开发者可用页面不合格。公开发布品牌精修与广泛设备专项优化仍属后续工作。

**已确认 Design System：**继承 `design-system/fitnessai/MASTER.md` 中的 Titanium Measure。本 spine 承载 machine-readable compatibility alias 与 UX-specific component；raw visual value 以 master token file 为准，阶段范围和行为以本 spine 与 `EXPERIENCE.md` 为准。

私有 Alpha 实现范围包含 `EXPERIENCE.md` 中具名的一等纯手机训练记录、AI 计划、Watch 自动识别、可选自动 RPE、结束提醒、完整 Analysis、Apple Health、第一方计划便携/Share Sheet 与训练后主动审核组件。语音、任意第三方格式、服务端链接/二维码分享及账号/云生命周期组件仍是后续阶段兼容注记。

已批准的 `.working/watch-final-review-v11.html` 只在与当前双语主干一致时作为 Watch 起始参考。其他历史 board 仍为讨论辅助。iPhone 私有 Alpha key-screen 布局已在下述合同中 finalize，并渲染于 `native-ui-designs/native-ui-FitnessAI-2026-08-08/previews/iphone-core-alpha-final-v1.html`；其层级、containment、action placement、navigation、reflow 与 state grammar 对实现具有权威性，而 fixture 数值和由系统拥有的 Share Sheet chrome 仅作示例。

**已确认配色参考：**Titanium Measure 使用校准后的 cyan action role，借鉴训练场景的高能量对比，但不复制 Apple Activity ring element，也不重新分配 Apple 精确的 Move/Exercise/Stand semantic。

Watch 视图是仪表，而不是 dashboard。iPhone 可以承载更密集的 review 和 Analysis，但证据与纠正仍优先于装饰。若底层状态并非如此，任何视觉处理都不得暗示已感知 external load、已确认 RPE、受支持动作覆盖或同步成功。

## Colors

Palette role 映射到已确认的 Titanium Measure system。物理设备测试仍是 rendered contrast、Always On、P3/sRGB 和健身房照明的 release check；它不再是未解决的品牌决策。

- `{colors.surface-base}` / `{colors.surface-base-dark}` 是贴近原生的基础画布。
- `{colors.surface-raised}` / `{colors.surface-raised-dark}` 承载可 review 的事实和 sheet。
- `{colors.ink-primary}` / `{colors.ink-primary-dark}` 承载关键值与操作；`{colors.ink-secondary}` / `{colors.ink-secondary-dark}` 承载 provenance 和次级 sync 文本。
- `{colors.action}` / `{colors.action-dark}` 仅用于 Start、Resume、确认或应用等用户权威操作；它们不表示“AI 已批准”。
- `{colors.success}` / `{colors.success-dark}`、`{colors.warning}` / `{colors.warning-dark}`、`{colors.error}` / `{colors.error-dark}` 和 `{colors.pending}` / `{colors.pending-dark}` 只辅助文字与符号；颜色绝不是唯一状态线索。

对比度目标：普通文本和关键数值相对其渲染 surface 达到 WCAG 2.2 AA 4.5:1；大文本达到 3:1；焦点指示、控件和有意义的非文本状态标记达到 3:1。最终调色板必须重新测量每组承载关键含义的 light/dark 组合。

## Typography

排版继承原生 SwiftUI 角色。本 spine 定义语义使用，而非固定像素大小。

- `{typography.session-value}` 用于变化中的 repetitions、load、rest 和 RPE；重排会损害 glanceability 时使用等宽数字。
- `{typography.title}` 命名当前 surface 或 review 上下文。
- `{typography.body}` 解释操作与后果。
- `{typography.label}` 命名字段和决定性控件。
- `{typography.meta}` 承载 provenance、model/source 标签、时间戳和同步细节，但绝不作为关键状态的唯一指示。

iPhone 必须支持 Dynamic Type；watchOS 暴露等效能力时也必须遵守。不得截断 Exercise 名称、生命周期后果或纠正值；应换行、滚动，或把展开细节移到 iPhone。

## Layout & Spacing

**[假设]** 间距扩展采用 4 点尺度：`{spacing.1}` 至 `{spacing.6}`。原生 safe areas、navigation containers、lists、sheets 和 toolbar placement 仍由平台拥有。

- Watch：每个视图只承载一个主要任务；正式组期间只显示当前 Exercise/Set 事实、下一个权威操作，不提供竞争性导航。
- iPhone：密集信息可使用 grouped lists 和 summaries，但字段级纠正、provenance 和 plan diff 保持线性可读。
- 相关 label/value/provenance 组使用 `{spacing.1}`–`{spacing.2}`；不同纠正选项使用 `{spacing.3}`–`{spacing.4}`；主要 review 区段使用 `{spacing.5}`–`{spacing.6}`。
- 不得仅为避免滚动而压缩 pending、conflict、deletion 或 privacy 后果。

## Elevation & Depth

继承原生 material、sheet 和 navigation elevation。层级来自平台 containment、typography 和色调分离，而非装饰性 shadow。

**[假设]** 初始 spine 禁用自定义 shadow。raised surface 使用 `{colors.surface-raised}` 或 `{colors.surface-raised-dark}`；destructive 或 uncertain 含义由文本/状态表达，而非 elevation。

## Shapes

**[假设]** `{rounded.sm}`、`{rounded.md}` 和 `{rounded.lg}` 为自定义 row 和 sheet 提供克制扩展；`{rounded.full}` 仅用于紧凑控件和 state chip。原生控件保留原生 geometry。

形状绝不单独承载状态。即使 pending 和 confirmed 使用相同 radius，也必须通过 label、symbol 和 accessibility value 区分。

## Components

以下名称是与 `EXPERIENCE.md` 共享的 component contract。

分类具有规范性：

- **`native-as-is`** 不含自定义 color、radius、spacing 或 interaction-state token；focused、pressed、selected、disabled 和 error presentation 由 SwiftUI 拥有。
- **`native-with-named-delta`** 继承全部 native geometry 和 interaction state，只覆盖 frontmatter 中明确列出的 machine-readable delta。
- **`fully-custom`** 使用 frontmatter 中的 light/dark 和 state token。noninteractive custom component 明确标注 focused/pressed/selected/disabled 不适用；native child action 仍继承 native state。

| Component | Classification | 视觉规范 | Focused / pressed / selected / disabled / error contract |
|---|---|---|---|
| `ai-conversation` | `native-as-is` | 原生 SwiftUI text editor、scroll container 与 action。本文不规定 chat-bubble 布局或最终内容 composition。 | 原生 focus、pressed、disabled、keyboard 与 error behavior。Send 在视觉与语义上均与 approval 区分。 |
| `remote-ai-authorization` | `native-as-is` | 原生 list/form section、toggle、disclosure text 与 time-window control。所有类别初始为关闭。 | 原生状态；获得焦点或滚动不能改变选择。披露缺失时禁用 Allow，并显示文字错误。 |
| `proposal-approval-gate` | `native-as-is` | 原生 review section 与完整 plan/diff 之后一个明确标注的 approval action。不规定 sticky 或 chat-inline approval 表现。 | 原生状态；校验通过前 disabled。批准失效后返回审核并显示文字原因。 |
| `safety-stop` | `native-as-is` | 原生 alert/inline notice，使用直白非诊断文案与明确允许的继续动作。 | 原生状态；warning/error 含义以文字命名，绝不只靠颜色。 |
| `forgotten-finish-prompt` | `native-as-is` | 原生 Watch prompt，包含一段摘要和两个文字标注动作：Finish 与 Continue。不使用庆祝或催促表现。 | 原生状态；永不自动触发结束，Continue/dismiss 与 Finish 保持视觉区分。 |
| `analysis-summary` | `native-as-is` | 原生 Swift Charts 与 grouped-list summary；本次更新不引入自定义 chart geometry 或 palette。每个图表都有相邻文字等价物。 | 原生 selection/focus 状态；stale/pending/error 保持明确标签，绝不只靠颜色。 |
| `healthkit-capability-row` | `native-as-is` | 原生 settings row 与 status detail，表达能力特定的 Apple Health 读取/写入状态。 | 原生状态；系统图标仅辅助明确的 not-requested/no-data/pending/written/failed/detached 文字。 |
| `proactive-review-invitation` | `native-as-is` | 原生非模态 iPhone card/sheet，包含 Review、Later 与 Disable；每个完成场次最多出现一次。 | 原生状态；Review 使用 authoritative action role，Later/Disable 保持次级且完全无障碍。 |
| `session-control` | `native-with-named-delta` | 原生 SwiftUI Button；仅覆盖 light/dark appearance 下 enabled authoritative-action 的 foreground/background。Finish 使用文字标签。geometry 保持原生。 | 全部 interaction state 和 destructive/error variant 继承 SwiftUI；没有自定义 state color 或 geometry。 |
| `actual-set-row` | `fully-custom` | Actual Set 数值使用 `{typography.session-value}`，标签使用 `{typography.label}`，provenance 使用 `{typography.meta}`；raised surface、border 和 `{rounded.md}` 均有明确 light/dark token。 | focused 使用 action border；pressed 使用 muted surface；selected 使用 success border；disabled 使用 secondary ink；error 使用 error border。text/symbol 仍明确命名状态。 |
| `recognition-state-chip` | `fully-custom` | 用紧凑 text + symbol 表达 accepted、uncertain、corrected、unresolved、pending 或 stale，并提供明确 light/dark neutral 与 semantic token。 | Noninteractive：focus/press/select/disabled 不适用。accepted、pending、error foreground token 仅辅助而不替代 label 与 symbol。 |
| `quick-correction-sheet` | `native-as-is` | 原生 SwiftUI sheet。已保留捕获事实和具名 child component 构成 content；没有自定义 sheet material、radius 或 spacing contract。 | sheet 和 child native action 继承全部 native state。没有隐藏 destructive action。 |
| `load-stepper` | `native-with-named-delta` | 原生 Stepper/Digital Crown editing；delta 为 value 使用 `{typography.session-value}`，provenance 使用 `{typography.meta}` 和 appearance-aware secondary ink。 | geometry、focus、press、selection、disabled 和 error presentation 继承 SwiftUI。prefill source 使用文本，而非 custom state color。 |
| `rpe-verification-prompt` | `fully-custom` | 组后 prompt 使用明确 light/dark surface、text、border 和 `{rounded.md}`；prediction、integer response、provenance 和 uncertainty 保持可见。 | focused/action、pressed、selected/confirmed、disabled 和 error 具有明确 border/surface/ink token；native choice control 保留其 native state behavior。 |
| `plan-diff-review` | `fully-custom` | 线性字段级 comparison，具有明确 light/dark surface 和 border。变化字段使用 appearance-aware action border；未变化上下文被弱化。 | container 和 diff row 为 noninteractive。error 使用 error border；child accept/edit/decline action 继承 native state。 |
| `sync-state-indicator` | `fully-custom` | 用 text + symbol 表达 saved locally、syncing、restored、conflict 或 failed，并具有明确 light/dark neutral、pending 和 error token。 | Noninteractive：focus/press/select/disabled 不适用。pending/error token 辅助明确的 state label。 |
| `recovery-choice-sheet` | `native-as-is` | 原生 SwiftUI sheet，命名 recovered session/time；content 使用 native action 和具名 child component。没有自定义 sheet geometry 或 color。 | sheet 和 Resume/Finish/discard action 继承 native state 与 destructive/error treatment。 |
| `support-boundary-notice` | `fully-custom` | Inline notice 具有明确 light/dark surface、text、border、warning 和 error token，以及 `{rounded.md}`。 | container 为 noninteractive；warning/error 有 label。任何 child route action 继承原生 focused/pressed/selected/disabled behavior。 |
| `lifecycle-request-row` | `fully-custom` | request scope、time 和 accepted/in progress/completed/failed state 使用明确 light/dark surface、border 和 text token。 | focused 使用 action border；pressed 使用 muted surface；selected/completed 使用 success border；disabled 使用 secondary ink；failed 使用 error border。 |
| `plan-exchange-review` | `fully-custom` | V1.1 file identity、version、source、plan ledger、mapping、omission 与 new-draft consequence 使用 raised ledger surface。pending mapping 使用 amber rail + literal text；invalid input 使用 error rail。 | focused 使用 action border；unresolved/error state 保持 text label；只有 review 完成后才显示唯一 primary action Create Draft。 |
| `structured-input-draft` | `fully-custom` | 面向未来的 voice/third-party input draft boundary。使用 muted surface、source label、parsed field、ambiguity/conflict rail 与明确 Confirm/Edit/Reject/Cancel action。 | draft 使用 pending treatment；conflict 使用 error rail，但不替换 committed fact；原生 child action 负责 interaction state。任何 MVP page 都不得实例化该组件。 |

## iPhone 私有 Alpha Key-Screen 布局合同

紧凑宽度参考 frame 为 390 × 844 pt，content inset 为 20 pt。同一合同必须在 iPhone 11 至当前更大 iPhone 上 reflow，且不出现水平滚动。在 accessibility 字号下，metric grid 转为垂直 fact group，diff column 转为依次排列的“当前 / 建议”组，底部 action 始终可在 home indicator 上方触达。

| Layout ID | 最终 composition | Primary action placement | 必需代表状态 |
|---|---|---|---|
| `AI-L01` Plan Home | effective revision 与 Watch delivery truth 优先；随后是今日有序 session ledger；AI revision entry 为次级。四个原生 destination 为 Plan、History、Analysis 与 More。 | 上下文 Start 属于 Watch；iPhone 在当前 plan facts 之后提供“与 AI 调整计划”。 | 无计划、本地计划 ready、Watch pending/delivered/failed、offline last-delivered revision。 |
| `AI-L02` AI Plan Chat | 原生 navigation；一个 inline missing-answer/assumption summary；线性 text conversation；持久 native composer；structured draft 在视觉上独立并明确标注未生效。 | Send 保持在 composer 内，绝不能批准。 | empty、composing、generating/cancellable、retained-input failure、safety stop。 |
| `AI-L03` Remote AI Authorization | purpose 与 provider policy 位于 default-off category row 之前；record category 显示必选 time-window control；排除项使用全宽 attention panel。 | 一个 bottom-safe“授权并继续”，在披露与选择完整前禁用并显示文字原因。 | required、partially selected、authorized、withdrawn、expanded-scope blocked、disclosure incomplete。 |
| `AI-L04` Proposal Review | proposal identity 位于完整 new-plan ledger 或完整 field-level diff 之前；Safety Rule Pack 结果、mapping、assumption、unresolved field 与 non-mutation scope 位于 digest 前。 | bottom-safe 成对操作：继续对话/拒绝为 secondary，继续批准为 primary。 | valid complete plan、valid diff、unmapped、contradictory、safety-blocked、base stale、approval invalidated。 |
| `AI-L05` Approval / Commit / Delivery | 独立 approval 页面重复 `proposalId`、base revision、digest、validation、consequence 和 future-session scope。批准后，local commit 与 Watch delivery 使用独立 state panel。 | 一个明确“批准并创建 Revision N”；后续页面只在失败 boundary 提供 Retry。 | approval ready/disabled/invalidated、commit pending/failed/succeeded、Watch pending/delivered/failed。 |
| `PW-L01` Phone-only Active Workout | 原生 iPhone 训练页面表达共享场次事实而不模仿 Watch：不可变 Plan snapshot、当前 Exercise/Set ledger、planned 与 Actual 值、本地保存事实，以及一条手动 Complete Set 路径。 | 根据当前状态仅提供一个 bottom-safe Complete Set 或 Finish 操作；编辑保持 inline/contextual。 | planned/ad-hoc、ready/active/paused、local save pending/failed/succeeded、unsupported automation absent、offline、recovery available。 |
| `PW-L02` Phone-only Set Edit & Recovery | 原生 sheet/review 使用与 Session Review 相同组件暴露 reps、Actual Load、provenance、pending fragment、split/merge/insert/delete 与准确 recovered session identity。 | 仅在输入有效后以 Save Correction 或 Resume 为 primary；Finish Incomplete 与确认 Discard 是明确分离的后果。 | edit valid/invalid、correction commit failed/succeeded、recovered、pending fragment、incomplete、discard confirmation。 |
| `HX-L01` Training History | period 与 filter 优先；随后是精确 period summary；chronological row 保持 Complete/Incomplete、revision 与 sync truth 附着。 | row 打开 Session Review；reuse 是具名 secondary row action。 | ready、empty、offline cache、incomplete、conflict、tombstoned、restoration pending/failed。 |
| `AN-L01` Analysis | 每个视图以直白 conclusion 开头，随后是 exact metric、一个 evidence chart、相邻文字等价内容、exclusion 与 table alternative。Week/month 与 Primary Exercise 是明确选择。 | Analysis 不强制 CTA；stale input 提供“解决记录”。 | weekly、monthly、Primary Exercise trend、empty、loading、stale/conflicted、calculation failure、partial data。 |
| `HK-L01` Apple Health | 每个 read/write purpose 使用一个原生 capability row；每行命名 scope 与 observable state。FitnessAI 本地权威持续可见。独立 panel 说明 HealthKit 访问本身不会远程发送，并把符合条件、由用户选择的本地摘要路由到默认关闭的逐请求授权预览；服务商/合规 Gate 关闭前，该 route 显示阻塞理由并禁用。 | capability toggle/route 由 row scope；Retry/Re-write 只出现在受影响副本；“预览 AI 使用”永不暗示已经授权。 | not requested、no accessible data、available、write pending/written/failed、`healthKitDetached`、HealthKit unavailable、AI summary ineligible/previewable/gate-blocked。 |
| `PX-L01` Plan Exchange | export review 在创建文件前显示所选 plan 与 included/excluded data。Import 显示 source/version、有界 validation、完整 plan、mapping/omission 与 new-draft consequence。原生 Share Sheet 仍由系统拥有。 | Export：“创建文件并分享”。Import：“创建新草稿”，仅在每个 unresolved item 已映射或明确省略后启用。 | export ready/failed/share cancelled；import loading/valid/unresolved/duplicate/invalid/unsupported/commit failed。 |
| `RV-L01` Proactive Review | 一个原生非模态 sheet 只在完成的 Session Review 上覆盖一次；明确尚未发送数据且不存在 proposal。Review 路由到显式 evidence authorization，再进入现有 complete diff 与 approval path。 | Review 为 primary；Later 与 Disable 为 secondary 且非 destructive。 | available、later、disabled、authorization required、generating、valid diff、AI unavailable/invalid。 |

共享 fixed-bottom action 使用原生 safe-area inset，并预留等量 scroll padding。它只允许用于当前页面唯一有后果的下一步；浏览、chart selection、field expansion 与普通 navigation 保持 inline。Error focus 落在 error summary，Retry 保留 input 与 selection，原生 back 保留未生效 chat/draft work，local commit 成功后将 focus 恢复到精确结果 state panel。

## Do's and Don'ts

| Do | Don't |
|---|---|
| 将 saved、inferred、user-confirmed、pending 和 synchronized 显示为不同概念 | 用一个绿色勾号折叠所有 trust state |
| 保持 active-set 视觉安静且可扫读 | 正式组期间提示、动画或庆祝 |
| 保持纠正范围和已保留事实可见 | 仅一个字段变化时替换整个 Set |
| 将 load 标注为 planned、historical、previous-set 或 user-entered | 暗示 Watch 感知了 external load |
| semantic color 与文字、符号、accessibility value 配对 | 依赖红绿色辨识 |
| 保留原生 Dynamic Type、VoiceOver、Reduce Motion 和平台导航 | 为视觉新奇覆盖原生行为 |
| 使用原生 iPhone 控件，把纯手机记录呈现为同一可信场次模型 | 为无 Watch 用户伪造 Watch 自动能力或建立第二套记录模型 |
| 在 unsupported/manual-only 行为造成意外前明确命名 | 把 catalog size 当成自动覆盖范围 |
| 把 dark mode 和健身房/户外可读性作为 release check | 认为 simulator 调色板已足够 |

**剩余发布验证：**物理设备 dark/light/Always On 调校、haptic discernibility、SF Symbol optical weight、最长中文文本和受支持设备 geometry。这些项目验证已确认的 Titanium Measure system；它们不重开阶段范围，也不授权延后 surface。
