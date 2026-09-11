# Blind Hunter 审查提示：macOS 环境迁移

## 审查者指令

对下面的尽力还原差异调用 `bmad-review-adversarial-general` 技能。独立审查并只报告可操作发现，不得假设已有对话上下文。

## 基线限制

`baseline_commit` 为 `NO_VCS`。项目有意未使用 Git，`.git` 为空，因此无法构造统一 Git diff。下面的变更清单就是可审查的尽力还原差异。

## 预期结果

把 FitnessAI 从 Windows 迁移到当前 Apple Silicon Mac，安装缺失的开发工具，用真实 Mac 状态替换 Windows 绝对路径，删除 Windows/Python 缓存，保持双语文档一致，并让 Git 继续保持未初始化。

## 新增文件

- `environment.yml` 定义最低 `BMAD` 基线；`environment-osx-arm64.lock` 记录精确验证过的 Conda 快照。
- `.gitignore` 排除 macOS 元数据、本地 uv/npm 缓存、Python 字节码、环境文件以及 Xcode/Swift 生成状态。
- `.gitattributes` 将基于文本的项目文件规范化为 LF。
- `docs/development-setup.md` 和 `docs/development-setup.zh-CN.md` 记录已验证的 Mac 环境、复现、Node、Xcode、模拟器、测试和迁移流程。
- `scripts/install-node-macos-arm64.sh`、`scripts/verify-macos-environment.sh` 和 `scripts/check-bilingual-docs.py` 提供可重复安装与断言。
- `spec-migrate-windows-development-environment-to-macos.md` 及其 `.zh-CN.md` 副本记录用户已批准的意图与执行任务；本提示发出时的工作流状态为 `in-review`。

## 修改文件

- `AGENTS.md`：将 Windows Conda/PowerShell 路径替换为 `/Users/seanlee/anaconda3`、zsh、原生 arm64、明确的 `conda run`、uv、Node 和 Xcode 规则。
- PRD `addendum.md` 和 `addendum.zh-CN.md`：把“将购买 Mac”更新为 Apple Silicon Mac 和 Xcode 已可用的确认状态。
- PRD `.memlog.md`：追加 Mac 购入/配置变更。
- `poc/vivo-watch-gt2/docs/device-baseline*.md`：移除过期 Windows 绝对路径，并记录 BlueOS Studio/模板产物未迁移到 Mac。
- `poc/vivo-watch-gt2/docs/onboarding*.md`：移除 Windows 盘符示例，同时保留历史 Windows 专用流程。

## 环境变更

- 在 `/Users/seanlee/anaconda3/envs/BMAD` 中安装 `uv 0.11.29`。
- 在 `/Users/seanlee/anaconda3` 下安装官方 Node.js 24.18.0 arm64；校验 SHA-256 后，通过 base 与 `BMAD` 链接提供 `node`、`npm` 和 `npx`。
- 验证 npm 和 npx 11.16.0。
- 验证 Xcode 26.6 许可、Apple Git 2.50.1、iOS/watchOS 26.5 SDK。
- 安装并注册 iOS 26.5 与 watchOS 26.5 Simulator Runtime。
- 保持 `/opt/anaconda3` 和有意为空的 `.git` 目录不变。

## 删除的生成状态

- 包含 Windows x86_64 Python 运行时的 `.uv-python/`。
- `.uv-cache/` 解释器/包缓存。
- POC `tools/__pycache__/`、`tests/__pycache__/` 目录及其 `.pyc` 文件。

## 验证证据

- BMAD Python：3.11.15，原生 arm64。
- uv：0.11.29，原生 aarch64-apple-darwin。
- 交互式 zsh 中的 Node/npm/npx：24.18.0 / 11.16.0 / 11.16.0。
- `pip check`：不存在破损依赖。
- POC 测试：禁用字节码写入后 6/6 通过。
- BMAD 配置解析器：有效合并 JSON，中文沟通、英文文档输出。
- 模拟器注册表：iOS 26.5 和 watchOS 26.5 均已注册。
- 可重复验证器：精确机器断言 Node 路径/架构/类型、Simulator Runtime ID/build/可用状态、BMAD JSON 字段、Windows 路径、二进制架构、Git 未初始化、敏感信息和双语结构。
- 审计产物：带时间戳的原始验证日志、双语迁移证据记录和迁移后 SHA-256 清单；明确不重建缺失的迁移前哈希。

## 待检查文件

- `AGENTS.md`
- `environment.yml`
- `environment-osx-arm64.lock`
- `.gitignore`
- `.gitattributes`
- `docs/development-setup.md`
- `docs/development-setup.zh-CN.md`
- `scripts/install-node-macos-arm64.sh`
- `scripts/verify-macos-environment.sh`
- `scripts/check-bilingual-docs.py`
- `_bmad-output/implementation-artifacts/macos-migration-evidence.md`
- `_bmad-output/implementation-artifacts/macos-migration-evidence.zh-CN.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/.memlog.md`
- `poc/vivo-watch-gt2/docs/device-baseline.md`
- `poc/vivo-watch-gt2/docs/device-baseline.zh-CN.md`
- `poc/vivo-watch-gt2/docs/onboarding.md`
- `poc/vivo-watch-gt2/docs/onboarding.zh-CN.md`
