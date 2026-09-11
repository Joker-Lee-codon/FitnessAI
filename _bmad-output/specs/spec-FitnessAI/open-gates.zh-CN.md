# FitnessAI 开放 Gate

以下是仍需人工负责的实施输入或发布证据。它们不会重开已经确认的产品或架构方向。每个 Gate 只阻塞其具名路径；手动本地记录始终可用。

| Gate | Owner | 必须关闭的时间点 | 必需决定或证据 | 未关闭时 |
|---|---|---|---|---|
| GATE-1 — Safety Rule Pack v1 | Product Owner；超出 owner testing 的发布需合格运动/健康 reviewer | 第一条 AI Plan Story 前提供数字 fixtures；超出 Product Owner testing 的发布前完成专业审核 | 针对 units、schedule contradiction、canonical support、volume、intensity、load progression、warning signs 与 allowed continuation 的版本化数字边界和 fixtures | 可以搭建 AI proposal 骨架；没有完整确定性结果时 proposal 不得提交 |
| GATE-2 — 内置 DeepSeek route | Product Owner；architecture/security/privacy owners | 任何内置 Alpha 流量前 | 当前 legal entity、runtime provider、processing region、subprocessors、retention/cache、training use、deletion/revocation、disclosure、隔离 endpoint、短期 owner credential、allowlists、request/time/rate/cost ceilings、key rotation、redacted audit、rollback owner、kill switch | 内置 route 在技术上保持禁用；可以实现 provider port 与 BYOK adapter 并进行本地测试 |
| GATE-3 — 远程 Apple Health 摘要 | Product Owner；Apple compliance、privacy/legal 与 security reviewers | 任何真实 Health-derived 远程流量前 | 书面 health/fitness-purpose 合规、DeepSeek processor/contract 适配性、data-region/cross-border path、disclosure、retention/training use、deletion/revocation/user rights，以及精确 request-field-to-summary-category map | 本地 Health 与不含 Health 的 AI 继续；authorization preview 可以渲染，但 send fail closed |
| GATE-4 — Recognition 证据记录 | Product Owner；model owner | 在 Alpha build 中启用自动 recognition 前 | 冻结 participants/time split、candidate model、eligibility、support matrix、denominators、PRD thresholds、slices、confidence intervals、protocol 与未触碰 final holdout | 准确 AD-6 row 仅为 candidate；手动 Complete Set 仍是 supported path |
| GATE-5 — RPE 证据记录 | Product Owner；model owner | 启用 RPE auto-use 前 | 冻结 model、five-estimate eligibility、confidence threshold、baseline improvement、risk–coverage、prompt/correction burden、drift、subgroup/missing-signal/resource protocol 与 final holdout | RPE 默认关闭，并且在获准实验收集时保持 confirmation-only |
| GATE-6 — 忘记 Finish 发布记录 | Product Owner；UX owner | 在 Alpha build 中启用提醒前 | 冻结 personalization、false-reminder 与 missed-reminder thresholds、真机 protocol，以及长休息、器械等待与低幅度 Exercises 的结果 | 只使用手动 Finish；15 分钟 trigger/cooldown 合同保持 candidate |
| GATE-7 — Plan parser 资源预算 | Product Owner；architecture owner | 接受 Plan import Stories 前 | 在 AD-10 结构限制之上定义 parser time 与 memory ceilings 及 failure reporting | Export 可以推进；import parser 验收保持阻塞 |

## 后续发布 Gate

Public beta 还要求中国区账号/同步基础设施与 threat model、tenant/account isolation、non-clock conflict handling、deletion tombstones、restoration visibility、sign-out retain/remove behavior、cross-account non-merge、self-service export/deletion、30 天 deletion/de-identification、reauthentication、incident response、更广设备证据与 cost/abuse controls。这些不是私有 Alpha 实施需求。
