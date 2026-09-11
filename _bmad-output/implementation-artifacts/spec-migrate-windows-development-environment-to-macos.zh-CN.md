---
title: '将 FitnessAI 开发环境从 Windows 迁移到 macOS'
type: 'chore'
created: '2026-07-19'
status: 'done'
baseline_commit: 'NO_VCS'
review_loop_iteration: 0
context:
  - '{project-root}/AGENTS.md'
  - '{project-root}/_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## 意图

**问题：**FitnessAI 已从 Windows 转移到 Apple Silicon Mac，但项目仍记录仅适用于 Windows 的 Conda 路径，并包含 Windows Python 缓存。Mac 上已有可用的原生 `BMAD` Conda 环境和已接受许可的 Xcode，但缺少 `uv`、Node.js/npm/npx；空 `.git` 目录是有意状态，因为项目在 Windows 上并未使用 Git。

**方案：**将 Mac 设为权威开发平台，定义可复现的 `BMAD` 环境，把 `uv` 安装到 `BMAD`，把 Node.js/npm/npx 安装到 zsh 默认可用的全局 Conda base 环境，补充 macOS/Xcode 项目卫生规则，以真实 Mac 本地状态替换 Windows 绝对路径，同步更新中英文文档，并删除所有已确认的 Windows Python 缓存。

## 边界与约束

**始终：**使用 `/Users/seanlee/anaconda3/bin/conda`；BMAD Python 保持 3.11.x，`uv` 固定为 0.11.29；在用户级 Conda base 环境安装 Node.js 20.12 或更高版本及 npm/npx，使交互式 zsh 全局可用；每份英文正式文档都同步维护 `.zh-CN.md` 副本；保留历史结论但移除过期 Windows 绝对路径；受限环境使用项目内 uv 缓存；在原生 `arm64` 上验证。

**先询问：**删除已验证 `.uv-python`、`.uv-cache`、`__pycache__` 和 `.pyc` 缓存目标之外的任何内容；删除任一 Conda 安装；初始化 Git 元数据；在用户级 Anaconda 安装之外安装软件。

**绝不：**为未迁移的 Windows 专用产物编造 Mac 路径；编辑安装器管理的 `_bmad/config.toml` 或生成的技能文件；删除 `/opt/anaconda3`；初始化有意保持为空的 `.git` 目录；保留可执行的 Windows Python 缓存。

## 输入/输出与边界场景矩阵

| 场景 | 输入/状态 | 预期输出/行为 | 错误处理 |
|------|-----------|---------------|----------|
| Mac 交互式终端 | zsh 加载 `~/.zshrc` | `conda activate BMAD` 选择原生 arm64 Python 3.11 环境 | 非交互工具使用明确的 Conda 可执行文件 |
| 缺少 BMAD 工具 | 不存在 `uv`、Node.js、npm 和 npx | `environment.yml` 为 `BMAD` 添加固定版本 uv；Conda base 获得受支持的 Node.js 及 npm/npx | 网络或求解失败时停止并报告，不替换 Conda |
| 已接受许可的 Xcode | 用户已接受 Xcode 26.6 许可 | Xcode、Git shim、SDK 和模拟器查询成功 | 准确报告任何残留的首次启动组件阻塞 |
| 复制来的 Windows 缓存 | 存在 Windows `.uv-python`、`.uv-cache`、`__pycache__` 或 `.pyc` 条目 | 删除所有已验证的 Windows/Python 生成缓存 | 校验目标类型并保留源产物 |
| 有意未初始化 Git | `.git` 存在但为空，因为从未使用 Git | 保持不变，并记录版本控制尚未初始化 | 不隐式初始化仓库 |

</frozen-after-approval>

## 代码地图

- `AGENTS.md` —— 权威项目执行规则和 BMAD 环境记忆。
- `environment.yml` —— 可跨机器使用的 `BMAD` Conda 最低工具基线定义。
- `environment-osx-arm64.lock` —— Apple Silicon 上经过精确验证的 Conda 包快照。
- `.gitignore` —— macOS、Python、uv/npm 和 Xcode 生成文件排除规则。
- `.gitattributes` —— 源文件与文档的稳定 LF 规范化规则。
- `scripts/install-node-macos-arm64.sh` —— 固定版本、带校验和且具备幂等性的 Node.js 安装器与链接生命周期工具。
- `scripts/verify-macos-environment.sh`、`scripts/check-bilingual-docs.py` —— 可重复执行的环境与双语结构断言。
- `docs/development-setup.md` —— 英文版 Mac 初始化与验证指南。
- `docs/development-setup.zh-CN.md` —— 结构等价的中文版环境指南。
- `_bmad-output/implementation-artifacts/macos-migration-evidence*.md` —— 双语证据记录和明确的历史证据限制。
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum*.md` —— 双语的当前平台前置条件说明。
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/.memlog.md` —— Mac 购入更新的只追加记录。
- `.uv-python/`、`.uv-cache/`、`**/__pycache__/`、`**/*.pyc` —— 在原生 Mac 使用前需要清理的生成缓存。

## 任务与验收

**执行：**
- [x] `AGENTS.md` —— 用已验证的 Mac/zsh/Conda 流程替换 Windows 路径和旧终端指令；记录 Node、uv、Xcode、缓存和架构规则。
- [x] `environment.yml` —— 定义 Python 3.11、pip 和 `uv==0.11.29`；更新 `BMAD` 且不清理无关包，然后将 Node.js >=20.12 及 npm/npx 安装到 zsh 默认 Conda base 环境。
- [x] `.gitignore`、`.gitattributes` —— 添加 macOS/Xcode/缓存排除与 LF 规范化，不修改历史内容。
- [x] `docs/development-setup.md`、`docs/development-setup.zh-CN.md` —— 记录初始化、验证、Xcode 已接受许可状态、双 Conda 策略、有意未初始化 Git 和当前尚无 Apple 应用工程的事实。
- [x] `addendum.md`、`addendum.zh-CN.md`、`.memlog.md` —— 将 Mac 前置条件从未来购入更新为已经可用，并保留决策轨迹。
- [x] `poc/vivo-watch-gt2/docs/*.md`、`.uv-python/`、`.uv-cache/`、`**/__pycache__/`、`**/*.pyc` —— 从文档移除 Windows 绝对路径且不编造缺失的 Mac 安装，并删除所有已验证的 Windows/Python 缓存。
- [x] 审查整改 —— 确保 `conda activate BMAD` 后 Node 仍可用；增加精确的 Node/runtime/config/架构断言、干净 Mac 恢复步骤、双语结构检查和可审计验证日志，同时不编造迁移前证据。

**验收标准：**
- Given 已更新的环境，when 检查工具版本，then BMAD Python 为 3.11.x、BMAD uv 为 0.11.29，且交互式 zsh 全局提供 Node.js >=20.12 及 npm/npx。
- Given 用户已经接受 Xcode 许可，when 查询 Xcode、Git shim 和模拟器工具，then 它们不再受到许可阻塞。
- Given 已迁移的工作区，when 扫描项目文本，then 不含 Windows 绝对路径；历史 vivo POC 结论保持真实且明确属于历史记录。
- Given Python POC，when 在 `BMAD` 中运行测试套件，then 现有六项测试全部通过，且 `pip check` 不报告破损依赖。
- Given 任一更新后的英文正式文档，when 检查其中文副本，then 标题结构、命令、路径、结论和需求含义保持一致。

## 规格变更日志

- 2026-07-19 审查整改：已分类返回的 Blind Hunter 与 Edge Case Hunter 发现。修复 Node 激活故障以及验证/文档缺口；增加最低基线与精确锁定快照的区分；把无法取得的迁移前清单与缓存哈希记录为不可重建的证据限制。冻结意图未变，`review_loop_iteration` 保持为 `0`。

## 设计说明

用户目录下的 Anaconda 安装是权威环境，因为它拥有已验证的原生 `BMAD` 环境，并已为 zsh 初始化。它的 base 环境是批准的 Node.js/npm/npx 全局安装位置。单独存在的 `/opt/anaconda3` 安装保持不动。空 `.git` 目录是有意状态。删除所有已验证的 Windows uv/Python 缓存，同时保留历史 POC 结论但移除过期绝对路径。

## 验证

**命令：**
- `scripts/install-node-macos-arm64.sh verify` —— 预期：固定版本的 Node/npm/npx 和原生 arm64 二进制通过验证。
- `scripts/verify-macos-environment.sh` —— 预期：所有可机器验证的 Conda、Node、Python 测试、BMAD 配置、Simulator Runtime、Windows 路径/缓存、二进制架构、敏感文件忽略、Git 未初始化和双语结构断言通过。
- 时间戳、原始输出和退出码见 `_bmad-output/implementation-artifacts/macos-migration-verification.log`。

**人工检查：**
- 对双语章节、表格、代码、链接、标识符和结论进行语义比较；自动结构相等本身不能证明翻译正确。
- 接受明确证据限制：迁移前校验和/目录快照以及已删除缓存哈希无法事后重建。

## 建议审查顺序

**意图与运行模型**

- 首先检查用户批准的迁移边界和平台权威定义。
  [`spec-migrate-windows-development-environment-to-macos.zh-CN.md:15`](spec-migrate-windows-development-environment-to-macos.zh-CN.md#L15)

- 区分最低基线、精确快照与干净 Mac 初始化。
  [`development-setup.zh-CN.md:3`](../../docs/development-setup.zh-CN.md#L3)

- 检查精确的 Apple Silicon Conda 包快照。
  [`environment-osx-arm64.lock:1`](../../environment-osx-arm64.lock#L1)

**工具链生命周期**

- 检查固定 Node 来源、受保护链接和可恢复 unlink 行为。
  [`install-node-macos-arm64.sh:4`](../../scripts/install-node-macos-arm64.sh#L4)

- 确认激活与非交互执行解析到同一 arm64 Node 发行版。
  [`verify-macos-environment.sh:27`](../../scripts/verify-macos-environment.sh#L27)

**验证与可审计性**

- 精确 runtime identifier 和 build 避免模拟器就绪误判。
  [`verify-macos-environment.sh:48`](../../scripts/verify-macos-environment.sh#L48)

- Windows 路径与二进制扫描保护迁移后的源码状态。
  [`verify-macos-environment.sh:54`](../../scripts/verify-macos-environment.sh#L54)

- 明确证据限制；迁移后检查绝不编造历史。
  [`macos-migration-evidence.zh-CN.md:3`](macos-migration-evidence.zh-CN.md#L3)

**文档与项目卫生**

- 双语签名检查捕获结构、链接、代码和标识符漂移。
  [`check-bilingual-docs.py:23`](../../scripts/check-bilingual-docs.py#L23)

- LF 规范化与限定范围的生成文件忽略补齐平台卫生缺口。
  [`.gitattributes:1`](../../.gitattributes#L1)
