---
title: 核心产品私有 Alpha 范围对账
status: checkpoint
updated: 2026-09-08
---

# 核心产品私有 Alpha 范围对账

## 变更信号

Product Owner 明确：供个人测试的第一版必须包含产品核心能力，而不是只提供技术端到端 skeleton。

## 已确认范围变化

| 能力 | 私有 Alpha 决定 | 边界 |
|---|---|---|
| 自动识别 | 冻结 Exercise/device/signal 白名单内必需 | abstention、纠正、手动 fallback 与真实初始准确率报告仍为硬要求 |
| 自动 RPE | 作为 opt-in 实验辅助必需 | 适用五次估算验证、provenance、abstention、drift、纠正与明确 auto-use 同意 |
| 智能 Finish | 作为保守提醒必需 | 两信号 eligibility；只提供 Finish/Continue；绝不 auto-end |
| 完整 Analysis | 必需 | 从 effective Actual Sets 派生周/月场次、Exercises、volume、intensity、Actual Load、duration 与所选 Primary Exercise 趋势 |
| Apple Health | 必需 | 必要最小权限读取 + 完成训练写入；FitnessAI 本地记录保持权威；不授权远程 AI 使用 |
| 计划交换 | 必需 | FitnessAI 自有版本化文件导入/导出 + 原生 iOS Share Sheet；第三方格式与服务端 link/QR 延后 |
| 主动 AI 审核 | 必需 | 一次非阻塞训练后邀请；接受前无请求/提案；仍需完整 Diff 与批准 |
| 视觉/布局 | 必需 | 每个 Alpha 页面的统一、可测试最终合同；公开发布精修延后 |

## 稳定需求影响

FR-071–073 与 NFR-PORT-001 在不重编号的情况下进入私有 Alpha。FR-088–090 定义 Apple Health 互操作。FR-091 定义训练后主动邀请。NFR-HK-001–002 与 NFR-UX-001 定义降级、完整性与视觉完成度。

## 继续延后的范围

完整应用云账号/跨设备恢复、语音、丰富教学媒体、任意第三方计划格式、服务端 link/QR 分享、每周/周期末主动节奏、开放式 coaching 与公开发布精修。

## Checkpoint

双语 PRD 结构一致并保持 `status: draft`。尚未运行 Reviewer Gate 与 editorial polish。
