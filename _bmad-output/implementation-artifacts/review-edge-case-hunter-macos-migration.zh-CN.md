# Edge Case Hunter 审查提示：macOS 环境迁移

## 审查者指令

对下面的尽力还原差异调用 `bmad-review-edge-case-hunter` 技能。遍历每条相关路径和边界条件，只报告未处理的边界情况，不得假设已有对话上下文。

## 基线限制

`baseline_commit` 为 `NO_VCS`。项目有意未使用 Git，`.git` 为空，因此无法构造统一 Git diff。下面的变更清单就是可审查的尽力还原差异。

## 预期结果

把 FitnessAI 从 Windows 迁移到当前 Apple Silicon Mac，安装缺失的开发工具，用真实 Mac 状态替换 Windows 绝对路径，删除 Windows/Python 缓存，保持双语文档一致，并让 Git 继续保持未初始化。

## 变更清单

- 新增 `environment.yml` 作为最低 BMAD 基线，并新增 `environment-osx-arm64.lock` 作为精确验证过的 Conda 快照。
- 新增 `.gitignore`，覆盖 macOS、uv/npm、Python、环境、Xcode、Swift 和编辑器生成文件。
- 新增 `.gitattributes`，为 Markdown、Python、shell、JSON、TOML、YAML、Swift 和 Xcode 工程文件设置 LF 规范化。
- 新增双语 `docs/development-setup*.md`，并提供机器可验证结构和必要语义复核。
- 新增受保护的 Node 生命周期脚本和完整迁移验证脚本。
- 将 `AGENTS.md` 从 Windows 路径更新为已验证的 Mac/zsh/Conda 执行模型。
- 更新双语 PRD addendum 和只追加 memlog，记录 Mac 前置条件已满足。
- 更新双语 vivo 基线/接入文档，移除盘符路径且不编造 Mac 安装。
- 删除 `.uv-python/`、`.uv-cache/`、POC `__pycache__/` 和 `.pyc` 生成状态。
- 安装 BMAD uv 0.11.29。
- 在权威用户 Anaconda 前缀下安装经校验的官方 Node.js 24.18.0 arm64 及 npm/npx 11.16.0，并向 zsh 提供。
- 安装并注册 iOS 26.5 和 watchOS 26.5 Simulator Runtime。
- 保持 `/opt/anaconda3` 和有意为空的 `.git` 目录不变。

## 验证证据

- 原生 arm64 Python 3.11.15 和 uv 0.11.29。
- 交互式 zsh 在 `conda activate BMAD` 前后都能解析 Node/npm/npx；非交互式明确 Conda 执行也正常。
- Xcode 26.6、Apple Git 2.50.1、iOS/watchOS SDK 26.5。
- 精确的 iOS 26.5 `23F77` 与 watchOS 26.5 `23T570` runtime identifier 处于可用状态。
- `pip check` 通过；禁用字节码写入后六项 POC 单元测试通过。
- BMAD 配置 JSON 可解析，且语言字段由机器断言。
- 使用明确排除项的可复现 Windows 盘符/UNC/环境路径、二进制架构、敏感信息忽略和 Git 未初始化扫描通过。
- 清理后缓存目标均不存在。

## 需要遍历的边界情况

- 交互式 zsh 与非交互式 Codex 执行。
- Node 从用户 Anaconda 前缀暴露后再激活 `BMAD`。
- 对现有环境重复运行 `conda env update`。
- 清理后 uv 重新创建项目内缓存目录。
- Xcode SDK 存在与 Simulator Runtime 注册之间的区别。
- 模拟器下载中断与恢复。
- Apple Silicon 架构与残留 Windows x86_64 产物。
- 未来更新后的双语文档漂移。
- 历史 Windows 专用 vivo 事实与当前 Mac 文件系统声明。
- 有意为空的 `.git` 目录与意外初始化仓库。
- 密钥/环境文件忽略规则和 Xcode 用户状态忽略覆盖。

## 待检查文件

- `AGENTS.md`
- `environment.yml`
- `.gitignore`
- `.gitattributes`
- `docs/development-setup.md`
- `docs/development-setup.zh-CN.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.md`
- `_bmad-output/implementation-artifacts/spec-migrate-windows-development-environment-to-macos.zh-CN.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.md`
- `_bmad-output/planning-artifacts/prds/prd-FitnessAI-2026-07-19/addendum.zh-CN.md`
- `poc/vivo-watch-gt2/docs/device-baseline.md`
- `poc/vivo-watch-gt2/docs/device-baseline.zh-CN.md`
- `poc/vivo-watch-gt2/docs/onboarding.md`
- `poc/vivo-watch-gt2/docs/onboarding.zh-CN.md`
