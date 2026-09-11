---
name: FitnessAI PRD 私有 Alpha UX 对账
status: checkpoint
source: "{planning_artifacts}/prds/prd-FitnessAI-2026-07-19/prd.md"
updated: 2026-09-08
---

# FitnessAI PRD 私有 Alpha UX 对账

## 权威来源与意图

以 2026-09-08 PRD 与 Product Owner 后续澄清为权威。“第一版”现在指可供个人使用的核心产品私有 Alpha，而不是狭窄技术 walking skeleton，也不是 public beta。

## 已解决冲突

| 旧 UX | PRD 权威 | 处理 |
|---|---|---|
| UJ-4 初学者 AI 计划属于 Post-MVP | UJ-4 与 FR-054–060/078–087 属于 first usable build | UJ-4 提升为 Alpha 主旅程 |
| 自动识别、自动 RPE、结束提醒、Analysis、Apple Health、便携、主动审核与最终视觉/布局被移出窄 Alpha | Product Owner 确认它们是个人可用测试的核心 | 以有界实验/手动 fallback 合同恢复至首版 IA |
| Apple Health 范围不明确 | Product Owner 确认必要读取 + 完成训练写入 | 增加能力特定权限、本地权威、幂等写入、失败与 `healthKitDetached` 状态 |
| 计划便携原为 V1.1，分享更晚 | Product Owner 确认 FitnessAI 自有文件 + 原生 iOS Share Sheet | FR-071–073/NFR-PORT-001 与完整预览/新草案流程进入 Alpha；第三方格式及服务端 link/QR 仍延后 |
| 现有 Watch/iPhone mock 可能暗示实现布局 | Alpha 现在要求可测试最终视觉/布局 | Watch v11 在主干一致时作为已接受起始参考；iPhone key-screen 布局仍须提升进两份主干 |
| AI 数据范围只是未来通用边界 | FR-086 与 NFR-PRIV-007 要求类别/时间窗的肯定授权 | 增加默认关闭授权、检查、撤回与真实披露状态 |
| 通用计划批准缺少完整不可变绑定 | FR-057/060/078–080/085 要求完整审核、身份绑定、失效与原子失败安全 | 增加完整 plan/diff 审核、`proposalId` + base revision + digest 绑定、过期 base 与提交失败恢复 |
| Watch 同步只是通用 sync concern | FR-081/084 与 NFR-AI-003 要求最终一致、幂等传递 | 增加 pending/delivered/failed 与最后 delivered revision 回退 |

## 保留不变量

- 原生配对 iPhone + Apple Watch 拓扑。
- Watch 对活动 Workout Session 与本地持久 Actual Sets 的权威。
- 计划事实与 Actual 事实保持分离；用户输入 reps/load 是权威值。
- 手动 Start/Finish、可见 incomplete data、原子本地写入与幂等 replay。
- 非诊断安全语言与禁止 AI 静默修改。

## 明确延后

完整云账号/跨设备恢复、丰富教学媒体、语音、任意第三方计划格式、服务端 link/QR 分享、每周/周期末主动节奏、开放式 coaching、公开发布品牌精修与广泛设备优化。

## Architecture 交接

没有 blocker 阻止精简 Architecture 启动。实现验收前，Product/Architecture 必须冻结识别白名单、RPE/提醒 operating points、计划文件 parser limits、Apple Health capability mapping 与 Alpha Plan Safety Rule Pack v1。真实远程 AI 流量启用前，必须确定 provider/subprocessor、保留、模型训练政策与 request-field 到 authorization-category 的映射。超出 Product Owner 测试的发布前仍须完成专业审核。

## Checkpoint

`prd.md`、`EXPERIENCE.md` 与 `DESIGN.md` 已更新为核心产品 Alpha 双语 draft。尚未运行 Reviewer Gate。iPhone key-screen 视觉/布局完成仍是 implementation readiness 前的必需 UX 后续工作。
