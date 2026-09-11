# iPhone 分析与系统页面覆盖

## 范围

适用于完整私有 Alpha Analysis、Apple Health、Exercise Catalog、Sync & Recovery、Account & Privacy 与 Support Matrix。

## 构图

- Analysis 先给出字面结论和证据图表，再展示周期指标、排除项和面向决策的说明。
- Catalog 先展示规范动作身份与支持边界，再展示教学内容。
- 同步、隐私和生命周期页面使用范围化账本行：对象/副本 → 状态 → 后果 → 下一步。
- Support Matrix 使用带文字/符号状态的比较表，不使用只依赖颜色的热力图。
- Apple Health 使用 capability-scoped row，并在视觉上分离 FitnessAI 本地权威、可选 HealthKit copy 与 remote-AI exclusion。

## 图表

- 使用 Swift Charts，提供直接标注、精确点检查、时间粒度控件和数据表替代。
- 实线标记表示有效已确认输入。虚线标记或纹理区域表示待处理/被排除输入。
- 计算失败时，用原因、保留的周期/筛选状态和重试替代图表。
- Reduce Motion 禁用图表绘制；无障碍摘要在点级浏览前播报结论。

## 生命周期与信任

- 绝不能把本地、已同步、Apple Health 所有、研究上传和导出副本合并成一个通用数据状态。
- 导出/删除/恢复行保留已受理、处理中、范围完成、失败和例外状态。
- HealthKit 读取状态绝不宣称用户拒绝；没有可观察数据时使用“暂无可读取数据”。
- 切换账号前预览之前的本地历史和未同步后果。

## 无障碍

- 大号 Dynamic Type 下表格线性化，同时在无障碍标签中保留行/列上下文。
- 图表提供文字摘要和可排序/有序的数据替代。
- 每个生命周期行作为一个焦点组，包含状态、范围、后果和下一步。
- 错误把焦点移到受影响行，并保留用户选择的周期、筛选或对象。

## 预览权威

参见已确认视觉交付中的 `iphone-system-pages-review.png`、`states-review.png` 与 `themes-review.png`。
