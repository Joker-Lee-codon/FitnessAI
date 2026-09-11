# iPhone 计划与复核页面覆盖

## 范围

适用于私有 Alpha Plan Home、AI Plan Chat、Remote AI Authorization、Proposal Review、Approval/Commit/Delivery、Training Plans、Training History、Session Review、proactive review 与第一方 Plan Exchange。

## 构图

- 使用稳定的原生导航标题与紧凑宽度 20 pt 内容边距。
- 抬升表面只用于已选计划、阻塞性复核边界或模态编辑器。列表和训练场次事实使用线条、对齐和留白。
- 先放当前计划/操作，再放有序动作事实。绝不能把计划值与实际训练组合并成同一视觉事实。
- Session Review 使用账本：边界状态 → 摘要 → 实际训练组 → 来源/修订 → 计划差异 → 一个完成操作。
- Plan Exchange 使用 source/version header → 完整 plan ledger → mapping/omission ledger → 一个 Create New Draft action。绝不提供 merge 或 replace-existing。
- AI planning 使用 conversation → default-off authorization → 完整 proposal/diff → 独立 approval → local commit → Watch delivery；这些 boundary 绝不共享一个 optimistic success state。
- 固定底部操作为 Home Indicator 安全区和等量滚动内边距预留空间。

## 导航

- Today、History 和 Analysis 是带 SF Symbol 与文字标签的顶层 Tab。
- 计划详情/编辑器和 Session Review 使用 `NavigationStack`；返回时恢复滚动和编辑草稿状态。
- Plan Exchange 由 plan detail 或 iOS file open contextual 进入；绝不是顶层 tab。
- Deep Link 标识精确的训练场次、实际训练组、字段、修订或训练计划。

## 数据与状态

- 实际值使用 `text.primary`；计划参考值降低强调并明确标注“计划”。
- 待处理、已纠正、自动采用、已确认和冲突使用符号 + 字面文字 + 结构标记。
- 冲突和待更新 Analysis 边界使用通栏注意行，不使用 Toast。
- 离线缓存内容保持可用，并指明最后已知/同步状态。

## 无障碍

- 200% 文字大小时，指标组和账本列转换为堆叠字段组。
- 实际训练组行提供分组摘要，以及编辑和字段级自定义 action。
- Full Keyboard Access 顺序跟随账本；焦点返回被编辑的行/字段。
- 破坏性操作与主要完成操作保持空间分离。

## 预览权威

参见已确认视觉交付中的 `iphone-core-pages-review.png` 与 `themes-review.png`。
