# macOS 迁移证据

## 证据完整性

证据日期：**2026-07-19**。迁移意图已经用户批准。返回的审查发现完成整改并重新验证后，工作流规格已从 `status: in-review` 推进为 `status: done`。

基线为 `NO_VCS`：Windows 上未使用 Git，`.git` 不含仓库元数据。首次编辑和删除前没有捕获迁移前目录清单或校验和集合。因此，本记录无法证明精确历史变更集，无法证明外部 `/opt/anaconda3` 的字节从未变化，也无法重建已删除缓存的哈希。这些事实被明确记录为限制，不会被重建或推断为证据。

## 现有最佳删除记录

| 目标 | 删除前同期观察 | 证据限制 | 当前防护 |
|---|---|---|---|
| `.uv-python/` | 包含 `cpython-3.11.15-windows-x86_64-none`；约 79 MiB | 未保留逐文件清单或哈希 | 拒绝任何重新出现的 Windows runtime 目录 |
| `.uv-cache/` | 随工作区复制的 uv 解释器/包生成缓存 | 未保留完整删除前清单或架构输出 | 作为生成状态排除；在其外扫描 Windows 路径 |
| `poc/vivo-watch-gt2/tools/__pycache__/` | Python 字节码缓存 | 未保留删除前哈希 | 拒绝排除缓存外残留的 `.pyc` |
| `poc/vivo-watch-gt2/tests/__pycache__/` | Python 测试字节码缓存 | 未保留删除前哈希 | 测试使用 `python -B` 和 `PYTHONDONTWRITEBYTECODE=1` |

这些目标是用户授权删除的生成缓存。本文不会声称当前仍可独立检查缺失的删除前产物。

## 环境与供应链证据

| 项目 | 可审计状态 |
|---|---|
| Conda 基线 | `environment.yml` 定义最低 Python 3.11/pip/uv 0.11.29 工具基线 |
| Conda 快照 | `environment-osx-arm64.lock` 记录 2026-07-19 观测到的精确 Apple Silicon Conda 包 URL |
| Node 归档文件 | `node-v24.18.0-darwin-arm64.tar.gz`，来源为 `https://nodejs.org/dist/v24.18.0/node-v24.18.0-darwin-arm64.tar.gz` |
| Node SHA-256 | 期望值与观测值：`e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1` |
| Node 二进制 | Mach-O 64 位可执行文件 `arm64`；`process.arch` 为 `arm64` |
| Node 暴露位置 | base 链接位于 `/Users/seanlee/anaconda3/bin`；`/Users/seanlee/anaconda3/envs/BMAD/bin` 中的等效链接避免激活环境时被遮蔽 |
| Simulator Runtime | iOS 26.5 `23F77` 与 watchOS 26.5 `23T570`，断言精确 runtime identifier 处于可用状态 |

## 可重复验证

`scripts/verify-macos-environment.sh` 是权威可重复验证器。它把命令记录为可执行断言，并在失败时返回非零退出码。`_bmad-output/implementation-artifacts/macos-migration-verification.log` 包含捕获的原始输出、UTC 开始时间和退出码。`_bmad-output/implementation-artifacts/macos-migration-post-state.sha256` 是迁移后校验和清单；它排除自身以及生成/本地缓存状态。

验证器覆盖：

- 原生 BMAD Python 与 Node 架构、精确 uv/Node/npm/npx 版本、可执行路径、链接和二进制类型；
- 非交互执行以及交互式 `conda activate BMAD` 行为；
- `pip check`、禁用字节码写入的六项 POC 测试，以及机器断言的 BMAD 语言字段；
- 精确的 iOS/watchOS runtime ID、build 和可用状态；
- 使用已记录排除项扫描 Windows 盘符、UNC 和百分号形式环境路径；
- 残留 Windows runtime/字节码、PE 和仅 x86_64 Mach-O 扫描；
- 不存在 `.git/HEAD`，且具备要求的敏感信息/签名文件忽略规则；
- 双语标题层级、表格、代码块、链接、行内代码和需求标识符。

## 双语语义复核

自动相等检查不足以证明翻译正确。本次迁移变更的中英文文件对已按章节目的、表格含义、命令、链接、路径、标识符和结论进行人工比较。审查确认环境指南、迁移规格、PRD 附录、vivo 设备基线和 vivo onboarding 文件对表达相同的需求与结论，并逐字保留代码和路径。

后续变更必须运行 `scripts/check-bilingual-docs.py`，并针对机器无法比较的结论再次进行语义复核。

## 审查分类结果

| 严重程度 | 处置 | 发现与结果 |
|---|---|---|
| 高 | 已修复 | `conda activate BMAD` 后 Node 消失；增加受保护的 BMAD 链接以及激活/非交互断言 |
| 高 | 已修复 | Runtime/config 检查只是摘要而非精确断言；增加精确 ID/build/可用状态与 JSON 字段检查 |
| 中 | 已修复 | 环境复现、Node 供应链/生命周期、干净 Mac 初始化、重试、LF 范围、忽略范围、字节码、架构、路径扫描和双语检查不完整 |
| 中 | 已记录限制 | 不存在迁移前清单或删除哈希；不编造地记录，并增加可重复迁移后证据 |
| 低 | 已修复 | 审查范围遗漏 PRD memlog，且把审查中的规格描述为已完成；审查提示现已写明工作流状态和完整文件范围 |
