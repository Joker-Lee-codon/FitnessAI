# 项目级 BMAD 输出约定

- 与用户沟通、解释工作流和汇报结果时统一使用中文。
- BMAD 正式文档保留默认英文版本，文件名和默认输出位置遵循 BMAD 工作流约定。
- 每生成或更新一份英文文档，必须在同一目录同步生成一份完整中文副本。
- 中文副本在扩展名前添加 `.zh-CN`，例如 `product-brief.md` 对应 `product-brief.zh-CN.md`。
- 两个版本必须保持章节结构、表格、代码、链接、需求编号和结论一致；更新任一版本时同步更新另一版本。
- 代码标识、命令、路径、API 名称和无法准确翻译的专有名词保留原文。
- 当前统一在 Apple Silicon Mac 上开发；macOS、zsh 和 Python 3 默认使用 UTF-8，不再设置 Windows 专用的 `PYTHONUTF8`。
- 在受限执行环境中，将 `UV_CACHE_DIR` 指向 `{project-root}/.uv-cache`，将 `UV_PYTHON_INSTALL_DIR` 指向 `{project-root}/.uv-python`。

## BMAD 运行环境记忆

- 本项目所有 BMAD 工作流统一使用名为 `BMAD` 的 Conda 环境。
- 权威 Conda 安装路径为 `/Users/seanlee/anaconda3`；不要把另一个 `/opt/anaconda3` 安装用于本项目。
- 环境路径为 `/Users/seanlee/anaconda3/envs/BMAD`，当前 Python 版本为 3.11.15，架构为原生 `arm64`。
- Conda 程序路径为 `/Users/seanlee/anaconda3/bin/conda`。
- 每个新对话在执行任何 BMAD 命令或 Python 脚本前，必须先确认正在使用 `BMAD` 环境。
- 交互式 zsh 已通过 `~/.zshrc` 初始化 Conda，优先运行 `conda activate BMAD`。
- 如果 Codex 工具调用无法可靠保留激活状态，必须使用 `/Users/seanlee/anaconda3/bin/conda run -n BMAD <command>` 执行命令；这与激活该环境后执行等价且更稳定。
- 首次执行前用 `/Users/seanlee/anaconda3/bin/conda run -n BMAD python --version` 验证环境，预期为 Python 3.11.x。
- `uv` 已安装，当前版本为 0.11.29；BMAD 脚本如果声明额外依赖，优先交给 `uv` 管理，不要无依据地向 Conda 环境预装第三方包。
- Node.js、npm 和 npx 安装在 `/Users/seanlee/anaconda3` 的 base 前缀中，由交互式 zsh 默认提供；`/Users/seanlee/anaconda3/envs/BMAD/bin` 中保留指向同一发行版的受控链接，确保激活 `BMAD` 后命令不会消失；Node.js 必须为 20.12 或更高版本。
- Node 工具链安装与自检统一使用 `{project-root}/scripts/install-node-macos-arm64.sh`；完整环境复验统一使用 `{project-root}/scripts/verify-macos-environment.sh`。
- Xcode 安装在 `/Applications/Xcode.app`，Apple 许可已由用户接受；涉及 Apple SDK、模拟器或 Git shim 的任务仍需在首次使用时验证工具可运行。
