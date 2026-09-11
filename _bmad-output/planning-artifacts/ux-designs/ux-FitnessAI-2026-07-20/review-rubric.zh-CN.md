# Spine Pair 评审 — FitnessAI

## Overall verdict

这对 spine **作为 in-progress Fast-path contract 是 adequate，但尚不能 finalization**。机械覆盖非常完整：五条来源旅程、FR-001–FR-070、每个 IA surface、每个共享 component 和每个 token reference 均已表示，双语副本也保留相同结构。仍有四个 high-impact 缺口：未解决的 active-session behavior、未解决的 HealthKit copy/deletion behavior、只解析到 light value 的 appearance-mode component token，以及 native inheritance 与 custom component geometry 之间含糊的边界。

Finding 计数：**critical 0 · high 4 · medium 4 · low 1**。

## 1. Flow coverage — adequate

已检查五条 PRD journey、FR-001–FR-070、四条来源强制 closure flow、具名主角、编号步骤、climax beat、failure path，以及 requirements-to-flow/surface mapping。UJ-1 至 UJ-5 名称与来源逐字一致；每个 FR range 至少映射到一条 Key Flow。

### Findings

- **[high]** MVP active-session flow 结构已存在，但尚未形成可单一实现的 contract，因为 Watch-versus-iPhone correction ownership、first-set/rest-safe timing、forgotten-Finish operating threshold，以及 load/unit/per-side/assisted/bodyweight semantics 仍为开放问题。这些选择影响 UJ-1、UJ-3、Flow 6 和 Flow 8，并非只影响视觉润色（`EXPERIENCE.md` § Open Questions 2、3、5、7）。*修复：*解决或明确分阶段处理每项决策，再同步更新受影响的 flow step、component behavior 和 state transition。
- **[high]** 在 Apple Health deletion 与 FitnessAI copy 的关系未定义时，Flow 9 无法闭合 data lifecycle（`EXPERIENCE.md` § Permissions, Privacy, and Sensitive Data；§ Open Questions 6）。这种歧义可能造成不期望的数据复活或意外丢失。*修复：*确定 HealthKit detachment/deletion scope、用户选择、copy provenance 和 failure/retry behavior，再绑定到 Flow 9 和 `lifecycle-request-row`。
- **[medium]** 虽然 UJ-1 使用 regular、progression-focused 的 intermediate lifter，且 PRD 允许所有经验水平，但 primary MVP cohort 仍未决定（`EXPERIENCE.md` § Open Questions 1）。*修复：*声明 primary validation protagonist，并把更广泛 eligibility 保留为 secondary boundary。
- **[medium]** UJ-4 保留来源的 Post-MVP scope，但 post-session、weekly 和 cycle-end proposal precedence 仍未解决（`EXPERIENCE.md` UJ-4；§ Open Questions 9）。*修复：*在 UJ-4 进入 UX 或 epic implementation 前解决 cadence；此前保持该 surface 明确 gated。

## 2. Token completeness — thin

已提取 24 个 color token、五个 typography role、四个 radius、六个 spacing value、11 个 component token object，以及 pair 中 36 个不同的 `{path.to.token}` reference。每个 reference 均可解析，每个 color 均为 hex，light/dark palette pair 均存在，也已说明 contrast target。

### Findings

- **[high]** 每个 component frontmatter object 都只解析到 light token，例如 `actual-set-row.background: {colors.surface-raised}` 和 `session-control.foreground: {colors.on-action}`，dark counterpart 只存在于 prose。遵循 machine contract 的 downstream generator 会在 dark appearance 中渲染 light surface（`DESIGN.md` frontmatter `components`；§ Colors；§ Components）。*修复：*增加明确的 appearance-aware component property，例如 `background-dark`/`foreground-dark`/`border-dark`，或定义另一种符合 spec 的 machine-readable mode mapping，并一致使用。
- **[medium]** palette、radius、spacing extension、visual direction、Crown behavior、haptics 和 portrait posture 均诚实标注为 `[ASSUMPTION]`，但它们仍是 contract 中 load-bearing value（`DESIGN.md` frontmatter 以及 §§ Brand & Style、Colors、Layout & Spacing、Shapes；`EXPERIENCE.md` §§ Interaction Primitives、Responsive & Platform）。*修复：*通过用户/物理设备 evidence 验证，或在改为 `final` 前移除 delta 并继承 native behavior。

## 3. Component coverage — strong

相同的 11 个 component name 同时出现在 `DESIGN.md` Components 和 `EXPERIENCE.md` Component Patterns 中，并包含 visual 与 behavioral rule，而非 placeholder。英文和中文 component set 完全一致。

### Findings

没有 component coverage 缺口。

## 4. State coverage — strong

已逐一检查五个 Apple Watch surface 和九个 iPhone/Post-MVP surface。适用位置均覆盖 cold load、empty、active/rest、incomplete、offline、local-write failure、permission denied/revoked、sensor loss、recovery、conflict、stale Analysis、restoration、deletion 和 lifecycle request state。

### Findings

没有机械 state coverage 缺口。§1 中未解决的 behavior 仍须在 finalization 前确定。

## 5. Visual reference coverage — strong

`imports/` 为空；不存在 `mockups/` 或 `wireframes/` artifact。`EXPERIENCE.md` 明确将全部 Watch、iPhone 和 Post-MVP surface 分类为 spine-only，并只声明一次 spines-win-on-conflict rule。

### Findings

没有 orphan 或不具体的 visual reference。缺少视觉验证是有意的 Fast-path 选择，而非链接损坏。

## 6. Bloat & overspecification — adequate

210 行的 DESIGN spine 和 344 行的 EXPERIENCE spine 与一个双表面、70 项需求、health-adjacent 产品相称。大多数重复 mapping 由表格承载，且整体避免精确 pixel layout。

### Findings

- **[low]** 多项 trust invariant——local commit 是 saved boundary、user authority、no silent overwrite、visible pending state——在 Voice and Tone、Component Patterns、State Patterns、Trust、Offline/Sync 和 Key Flows 中重复出现（`EXPERIENCE.md` §§ Voice and Tone 至 Key Flows）。*修复：*下次 polish 时，在相关 product-specific section 中保留一条 normative rule，其他位置使用更短的 cross-reference。

## 7. Inheritance discipline — thin

五个 `sources` entry 均能在 `{planning_artifacts}` 下解析；UJ name 逐字一致；FR range 保留；component name 和 token reference 匹配；英中两版具有一致的 frontmatter structure、section order、component table、flow heading、requirement ID、结论和 open question。

### Findings

- **[high]** Native inheritance 与 custom delta 在内部存在歧义。`DESIGN.md` 表示 native control 保留 native geometry，但 `components.session-control` 同时强制 `{rounded.full}` 和 custom action color；多个“native sheet”component 也强制 custom radius（`DESIGN.md` frontmatter `components`；§§ Layout & Spacing、Shapes、Components）。由于 frontmatter 获胜，downstream consumer 无法判断应保留哪些 native default。*修复：*将每个 component 分类为 native-as-is、native-with-named-delta 或 fully custom；从 native-as-is component 中移除冲突的 token property。
- **[medium]** Contract 要求一对一中文 terminology，但任一 spine 都没有所承诺的 canonical English↔Chinese glossary（`EXPERIENCE.md` § Voice and Tone）。结构上的双语 parity 很强，但 downstream localization 仍需推断 Complete/Incomplete、pending/stale 和 RPE provenance 等状态的翻译。*修复：*增加一张共享双语 terminology table，并在两个版本中将其作为 localization authority。

## 8. Shape fit — strong

`DESIGN.md` 使用 canonical order：Brand & Style → Colors → Typography → Layout & Spacing → Elevation & Depth → Shapes → Components → Do's and Don'ts。`EXPERIENCE.md` 包含全部 required default，以及已触发的 Responsive & Platform 和 Inspiration & Anti-patterns section。新增的 trust、synchronization/recovery、privacy、coverage 和 open-question section 都符合本产品需要。

### Findings

没有 shape-fit 缺口。

## Mechanical notes

- 四份 spine 文件的 YAML frontmatter 均可解析；全部保持 `status: in-progress`，并列出相同五个 source。
- 全部 36 个 token reference 均能根据 `DESIGN.md` 解析；全部 24 个 color value 均为 hex。
- Component set 精确一致：DESIGN、EXPERIENCE 和两个双语副本中均为 11 个。
- Key Flow set 在两种语言中精确一致：UJ-1–UJ-5 加 Flow 6–Flow 9。
- FR-001–FR-070 由紧凑 range mapping 连续覆盖，没有编号缺口。
- 英中两版行数以及 H2/flow/component 结构一致，但 semantic localization 仍需解决上方 glossary finding。
- 没有 Mermaid 或 visual-artifact syntax 需要验证。
