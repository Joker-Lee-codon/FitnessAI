# 无障碍与实体设备验证规格

## 1. 必需模式

每个主要页面都要测试深色/浅色、Increase Contrast、Differentiate Without Color、Reduce Motion、VoiceOver 和最大支持 Dynamic Type。Watch 页面还必须测试 Always On/亮度降低输出。

## 2. 数值验收

| 检查 | 验收 |
|---|---|
| 普通文字对比度 | 至少 4.5:1 |
| 大号文字/非文字数据标记 | 至少 3:1 |
| 高频/后果显著目标 | 至少 44 × 44 pt |
| 相邻目标间距 | 至少 8 pt |
| iPhone 文字放大 | 至少 200%，不损失必要内容 |
| Watch 文字放大 | 至少 140%，不损失必要内容 |
| 按压反馈 | 100 ms 内可见 |
| 微状态替换 | 150–220 ms；Reduce Motion 下即时/交叉淡化 |

## 3. 焦点与播报

- Active Set 保持安静；非关键识别/同步更新等待安全休息。
- 纠错焦点顺序：保留事实 → 问题 → 选项；关闭后返回受影响事实。
- 恢复焦点顺序：恢复身份/持久边界 → 继续 → 以待补全结束 → 丢弃。
- iPhone 纠错后焦点返回编辑字段/训练组。冲突解决后返回选中的修订。
- 轮询进度不反复播报。边界变化只播报一次，并说明范围和下一步。

## 4. 实体设备矩阵

| 区域 | 设备/条件 |
|---|---|
| Watch 扫读 | 小/大受支持表壳；明亮健身房、暗光健身房、手臂运动、流汗 |
| Watch 输入 | 触控、Digital Crown、VoiceOver 可调 action、单手、误触 |
| Watch 连续性 | Always On、App 终止、重启、断开/重连、低资源 |
| iPhone 布局 | 小/大受支持手机；竖屏和适用横屏；键盘出现 |
| 跨设备 | 精确字段 Handoff、离线队列、延迟/乱序传输、冲突 |
| 色彩 | sRGB/P3、深浅色、Increase Contrast、灰阶/颜色区分 |
| V1.1 plan file | Document picker、source/version 播报、完整 preview、mapping focus return、omission disclosure、cancellation、Full Keyboard Access、200% 字号 |
| Future voice boundary | Contextual permission、listening/transcription state、noise/offline/interruption、draft/conflict reading order、等效非语音路径；仅在阶段激活后测试 |

## 5. 已知门槛

- RPE 中文锚点需要经过验证的发布证据；字面整数仍是安全临时方案。
- 批准 Watch 子集之外的负重语义保持待处理，并移交到精确 iPhone 字段。
- Forgotten-Finish 在 PRD 的实体设备信号门槛通过前保持不可用。
- 必须在部署目标中检查 SF Symbol 可用性和光学字重。
- 静态预览不能证明 Dynamic Type、VoiceOver、触觉、Always On 或真实设备光照行为。
- V1.1 portability surface 进入 Story 验收前必须冻结 DV-007 parser limit。
- Future voice 与 sharing state 保持非实现；Product 激活并限定功能前，不得声称已完成无障碍验证。
