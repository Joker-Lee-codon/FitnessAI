# FitnessAI 钛衡状态矩阵

## 1. 状态编码语法

| 家族 | 状态 | 符号 | 结构 | 必需文案行为 |
|---|---|---|---|---|
| 识别 | 已接受 | `checkmark.circle` | 实心事实线 | 自动结果需显示状态和来源 |
| 识别 | 不确定 | `questionmark.circle` | 琥珀左轨 | 指明不确定性和保留的同组事实 |
| 识别 | 已纠正 | `pencil.and.outline` | 修订标记 | 旧值、当前值、用户权威 |
| 识别 | 未解决 | `exclamationmark.triangle` | 开放轨道 | 待处理字段和精确回退 |
| 注意 | 待处理 | `clock` | 轮廓分段 | 等待事项和仍可用内容 |
| 注意 | 待更新 | `arrow.clockwise` | 依赖输出虚线 | Analysis/建议为何不是当前版本 |
| 注意 | 冲突 | `arrow.triangle.2.circlepath` | 分裂修订行 | 保留两个修订；用户在 iPhone 选择 |
| 持久性 | 已存于本机 | `applewatch` 或设备符号 | 本地轨道完成 | 指明精确本地副本 |
| 持久性 | 等待同步 | `clock` | 同步段待处理 | 本地成功继续成立 |
| 持久性 | 已同步 | `checkmark.icloud` | 同步段完成 | 指明账号范围边界 |
| 支持 | 仅手动 | `hand.tap` | 中性边界行 | 可用手动路径 |
| 支持 | 不支持 | `slash.circle` | 阻塞边界 + 回退 | 指明不支持组合 |
| 完整性 | 失败 | `exclamationmark.triangle` | 破坏性轨道 | 原因、保留数据、重试/恢复 |

## 2. 页面覆盖

| 页面 | 必需视觉状态 |
|---|---|
| Watch Workout Entry | 冷启动；无计划/自由训练；设备/动作不支持；必要能力缺失；离线；开始/本地提交失败 |
| Watch Active Session | 正式组；休息；已接受/不确定/未解决事实；传感器中断；离线；低存储/资源警告；本地写入失败 |
| Watch Rest Resolution | 不安全/延后；安全；无/一个/多个待处理；稍后；已纠正；手动回退；RPE 关闭/验证/漂移；提交失败 |
| Watch Recovery | 可恢复；部分写入；边界不明确；重启；断连；并发训练场次；丢弃确认 |
| Watch Finish Review | 完整；待补全；结束提交中/失败；等待同步；受门槛约束的忘记结束提示 |
| iPhone Today & Plans | 冷启动；无计划；草稿；离线缓存；修订待更新；计划加载失败 |
| iPhone Training Plans | 查看；编辑草稿；字段错误；替代建议；明确接受/拒绝；待更新/冲突；提交失败 |
| iPhone Session Review | 加载；完整；待补全；已纠正；冲突；Analysis 待更新；纠正提交失败 |
| iPhone Training History | 冷启动；空白；离线缓存；恢复中/失败；已删除/Tombstone；修订待处理 |
| iPhone Analysis | 冷启动；周期无数据；就绪；不完整数据被排除/标注；冲突待更新；计算失败 |
| iPhone Exercise Catalog | 冷启动；媒体不可用；支持；有限；仅手动；规范映射未解决 |
| iPhone Sync & Recovery | 无问题；等待同步；离线；延迟/乱序/重复 Replay；冲突；恢复生命周期；并发训练场次 |
| iPhone Account & Privacy | 未登录/已登录；能力专属权限状态；同意生命周期；导出；删除范围；退出选择；账号切换预览 |
| iPhone Support Matrix | 加载；支持；有限；仅手动；不支持；矩阵版本不可用 |
| iPhone Training Plan Portability（V1.1） | export ready/failed；validating；compatible；unsupported/newer；malformed/executable/over-limit；duplicate；unknown Exercise；unit/field mapping；explicit omission；ready；new-draft commit/failed/cancelled |
| iPhone Beginner Plan（Post-MVP） | 采集未完成；披露；警示症状停止；草稿；批准；拒绝建议；安全评审不可用 |
| Future voice input boundary（Post-MVP） | permission；idle/listening/interrupted/offline/unavailable；transcribing；ambiguous；draft；duplicate/conflict；confirmed；local commit/failed；cancelled；manual fallback |
| Future third-party/share boundary（Post-MVP / V2） | format/version；unit/mapping；partial failure；preview；expired/revoked/inaccessible/invalid transport；data minimization；new draft/cancelled |

## 3. 规范高风险文案

| 状态 | 短视觉中文 | 必需后果 |
|---|---|---|
| 自动采用 RPE | 已自动采用 RPE 8 | 仍可编辑；不是用户确认 |
| 模型弃权 | RPE 待确认 | 其他训练数据仍保持已保存 |
| HealthKit 读取 | 暂无可读取数据 | 不声称权限被拒绝 |
| 本地保存失败 | 本机保存失败 | 新内容不安全；之前已保存数据仍在 |
| 等待同步 | 已存于本机 · 等待同步 | 记录成功不会被撤销 |
| 云删除仍有设备待处理 | 云端已受理，1 台设备待处理 | 旧数据不能被重新发布 |
| 研究退出 | 已停止研究上传 | 普通本地记录继续可用 |
| `healthKitDetached` | 已与 Apple Health 断开关联 | FitnessAI 不会静默重写 Apple Health 记录 |

## 4. 状态转换规则

1. 使用成功语言前必须经过 `editing → committing locally → saved locally`。
2. `saved locally → sync pending → synchronized` 独立存在；失败返回等待同步/失败，而不是未保存。
3. 纠正创建新的可审计修订并保留旧值/来源。
4. 不安全或中断的 Watch 纠错返回待处理，不丢失数据。
5. 冲突保留所有相关用户修订，并将依赖 Analysis/建议标为待更新。
6. 不支持语义保留已支持的同组事实，并移交到精确 iPhone 字段。
7. 删除使用 Tombstone/副本范围生命周期；离线 Replay 不能静默恢复已确认删除。
8. Plan import 与未来 source input 只创建 draft。明确审核并成功本地提交前，现有计划与 committed workout fact 继续生效。
9. Voice、link、QR 与 third-party import 状态属于未来边界；不得出现在 MVP navigation 或 preview 中。

## 5. 预览映射

- `previews/states-review.png`：待处理、已确认、已纠正、同步、离线、失败、不支持、恢复。
- `previews/watch-pages-review.png`：Watch 核心状态构图。
- `previews/iphone-core-pages-review.png`：计划/复核/历史状态。
- `previews/iphone-system-pages-review.png`：分析、支持、生命周期和 Post-MVP 门槛。
