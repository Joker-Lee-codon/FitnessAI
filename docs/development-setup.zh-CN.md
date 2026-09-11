# FitnessAI macOS 开发环境

## 目的与支持策略

本指南定义 FitnessAI 的权威 Apple Silicon Mac 环境。`environment.yml` 是最低 BMAD 工具基线；`environment-osx-arm64.lock` 是在当前 Mac 上验证过的精确 Conda 包快照。Node.js 和 Apple Simulator Runtime 分别管理。当前仓库尚不包含 iOS 或 watchOS Xcode 工程。

最低约束为 Apple Silicon `arm64`、Python 3.11.x、uv 0.11.29、Node.js 20.12 或更高版本、已接受许可的 Xcode，以及处于可用状态的 iOS/watchOS 26.5 Simulator Runtime。下表是观测快照，并不承诺每个补丁版本永远不变。

## 观测快照

最后完整验证日期：**2026-07-19**。

| 组件 | 观测版本或位置 | 验证状态 |
|---|---|---|
| 硬件 / macOS | Apple Silicon `arm64` / macOS 26.5.1 | 已验证为原生架构 |
| Xcode / developer directory | 26.6 / `/Applications/Xcode.app/Contents/Developer` | 已安装；许可已接受 |
| iOS Simulator Runtime | iOS 26.5 (`23F77`) | 可用 |
| watchOS Simulator Runtime | watchOS 26.5 (`23T570`) | 可用 |
| 权威 Conda | `/Users/seanlee/anaconda3` | 已通过 `~/.zshrc` 初始化 |
| BMAD 环境 | `/Users/seanlee/anaconda3/envs/BMAD` | Python 3.11.15，原生 `arm64` |
| uv | `BMAD` 中的 0.11.29 | 已安装 |
| Node.js / npm / npx | 24.18.0 / 11.16.0 / 11.16.0 | 官方 macOS arm64 发行版 |
| Git 仓库 | `.git` 不含 `HEAD` | 有意保持版本控制未初始化 |

单独存在的 `/opt/anaconda3` 安装不用于 FitnessAI，本项目工作流不得修改它。

## 干净 Mac 初始化

将 Apple Silicon Anaconda 发行版安装到 `/Users/seanlee/anaconda3`，并将 Xcode 安装到 `/Applications/Xcode.app`。随后选择 Xcode、完成首次启动任务，并安装精确版本的运行时：

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
xcodebuild -license status
xcodebuild -runFirstLaunch
xcodebuild -downloadPlatform iOS -buildVersion 26.5 -architectureVariant arm64
xcodebuild -downloadPlatform watchOS -buildVersion 26.5 -architectureVariant arm64
```

日常维护时从最低基线创建环境：

```bash
/Users/seanlee/anaconda3/bin/conda env create -f environment.yml
scripts/install-node-macos-arm64.sh install
scripts/verify-macos-environment.sh
```

如需精确复现 2026-07-19 的 Conda 快照，先从平台锁文件创建 Conda 包，再添加固定版本的 pip 工具：

```bash
/Users/seanlee/anaconda3/bin/conda create -n BMAD --file environment-osx-arm64.lock
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip install uv==0.11.29
scripts/install-node-macos-arm64.sh install
```

## 终端、BMAD 与幂等更新

交互式 zsh 可以正常激活环境。Node 链接也存在于 `BMAD` 内，因此激活环境不会遮蔽全局安装的 Node 发行版：

```bash
conda activate BMAD
python --version
uv --version
node --version
npm --version
npx --version
```

非交互工具必须使用明确的 Conda 可执行文件。受限执行环境将 uv 状态保存在项目内：

```bash
export UV_CACHE_DIR="$PWD/.uv-cache"
export UV_PYTHON_INSTALL_DIR="$PWD/.uv-python"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python --version
/Users/seanlee/anaconda3/bin/conda run -n BMAD node --version
```

`conda env update` 会保留未声明包，因此它只能验证最低基线，不能证明环境完全精确。通过比较第二次更新前后的完整 Conda 与 pip 状态来审计更新幂等性：

```bash
audit_dir="$(mktemp -d "${TMPDIR:-/tmp}/fitnessai-conda-audit.XXXXXX")"
trap 'rm -rf "$audit_dir"' EXIT
/Users/seanlee/anaconda3/bin/conda env update -n BMAD -f environment.yml
/Users/seanlee/anaconda3/bin/conda list -n BMAD --explicit >"$audit_dir/first.conda"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip freeze >"$audit_dir/first.pip"
/Users/seanlee/anaconda3/bin/conda env update -n BMAD -f environment.yml
/Users/seanlee/anaconda3/bin/conda list -n BMAD --explicit >"$audit_dir/second.conda"
/Users/seanlee/anaconda3/bin/conda run -n BMAD python -m pip freeze >"$audit_dir/second.pip"
diff -u "$audit_dir/first.conda" "$audit_dir/second.conda"
diff -u "$audit_dir/first.pip" "$audit_dir/second.pip"
```

## Node.js 生命周期与供应链记录

安装器具备幂等性，并会拒绝覆盖意外文件或链接。它通过 Conda base 前缀和 `BMAD` 暴露同一个发行版。

| 字段 | 固定值 |
|---|---|
| 归档文件 | `node-v24.18.0-darwin-arm64.tar.gz` |
| 下载 URL | `https://nodejs.org/dist/v24.18.0/node-v24.18.0-darwin-arm64.tar.gz` |
| 官方校验和列表 | `https://nodejs.org/dist/v24.18.0/SHASUMS256.txt` |
| 期望与观测 SHA-256 | `e1a97e14c99c803e96c7339403282ea05a499c32f8d83defe9ef5ec66f979ed1` |
| 发行版目录 | `/Users/seanlee/anaconda3/node-v24.18.0-darwin-arm64` |

使用以下生命周期命令：

```bash
scripts/install-node-macos-arm64.sh install
scripts/install-node-macos-arm64.sh verify
scripts/install-node-macos-arm64.sh unlink
```

`unlink` 只会移除脚本拥有的链接，并保留发行版目录以便恢复。升级时，先取消当前版本链接，在安装器中一起更新版本、归档文件、URL 和 SHA-256，再执行安装与验证。回滚时恢复这些固定值并运行 `install`；保留的旧发行版可避免重新下载。永久删除保留的发行版属于单独的破坏性操作，需要明确检查目标。

## Xcode 与 Simulator Runtime 恢复

验证已选中的 developer directory 和精确注册的运行时：

```bash
xcode-select -p
xcodebuild -version
git --version
xcrun simctl list runtimes
```

如果下载中断，重新运行同一条精确版本命令；不要手工删除 Xcode 管理的部分资产。分别重试两个平台，最后运行项目验证器；验证器要求运行时 ID 与 build 为 `iOS 26.5 (23F77)` 和 `watchOS 26.5 (23T570)`，且不带 `unavailable` 标记：

```bash
xcodebuild -downloadPlatform iOS -buildVersion 26.5 -architectureVariant arm64
xcodebuild -downloadPlatform watchOS -buildVersion 26.5 -architectureVariant arm64
scripts/verify-macos-environment.sh
```

## 项目验证与审计证据

从项目根目录运行可重复验证器，并保留时间戳、退出码和原始输出：

```bash
started_at="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
scripts/verify-macos-environment.sh 2>&1 | tee _bmad-output/implementation-artifacts/macos-migration-verification.log
exit_code="${pipestatus[1]}"
printf 'started_at=%s\nexit_code=%s\n' "$started_at" "$exit_code" | tee -a _bmad-output/implementation-artifacts/macos-migration-verification.log
test "$exit_code" -eq 0
```

验证器使用 `python -B` 和 `PYTHONDONTWRITEBYTECODE=1`，断言 BMAD JSON 字段，验证 Node 路径/架构/二进制类型，要求精确的 Simulator Runtime ID/build，扫描 PE 与仅 x86_64 的 Mach-O 产物，检查敏感文件忽略范围，确认不存在 `.git/HEAD`，并比较可机器验证的双语结构。Windows 路径扫描只排除 `.git`、`.npm-cache`、`.uv-cache`、`.uv-python`，以及自身包含扫描表达式的验证器源文件。

自动结构检查无法证明翻译语义。迁移证据记录对章节、表格、命令、链接、标识符和结论所做的必要人工语义复核。

## 迁移证据限制

迁移前不存在版本控制基线或清单，因此无法事后证明精确历史差异，也无法证明外部 `/opt/anaconda3` 内容完全未变。被删除缓存的完整删除前哈希同样受此限制。证据文档记录现有的同期观察和迁移后校验和清单，不会编造缺失历史。

Windows Python、uv 和字节码缓存属于生成状态，不得保留。历史 vivo POC 结论保持真实，但过期 Windows 绝对路径会替换为迁移状态，不会编造 Mac 路径。vivo 路线不在首发范围内；当前路线是 Apple Watch 加 iPhone。空 `.git` 目录保持未初始化，直到用户明确要求设置 Git。
