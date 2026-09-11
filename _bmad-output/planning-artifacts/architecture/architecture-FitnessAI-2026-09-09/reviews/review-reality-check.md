# FitnessAI Architecture Spine 技术现实性审查

- 审查日期：2026-09-10
- 审查对象：`ARCHITECTURE-SPINE.md`
- 审查方式：逐项核验已承诺技术、版本、Apple 平台限制、DeepSeek 接口与安全边界，并检查绿色项目是否依赖未经核验的 starter/default。
- 最终结论：**NEEDS FIXES**

架构的大部分基础选择能够落地：Xcode/Swift 工具链、SwiftUI、GRDB + system SQLite、WatchConnectivity 四种传输方式、HealthKit 同步元数据、Apple Data Protection、Keychain、标准 JSON 和模块化单体都存在且与目标系统兼容。不过，在正式定稿前仍有 3 个高严重度缺口和 3 个中/低严重度精度问题需要处理。

## 高严重度发现

### H1 — Watch 后台传感器采集没有绑定正确的运行会话

- **位置：** AD-3（第 43–47 行）、AD-6（第 61–65 行）、AD-13（第 103–107 行）、Stack（第 131、135 行）
- **发现：** Spine 承诺 Watch 负责训练期间的本地传感器采集、恢复和推断，但没有规定后台采集必须依靠哪一种 Apple 允许运行的会话。两个实现团队都可以遵守现有 AD，却分别选择 `HKWorkoutSession` 与 `WKExtendedRuntimeSession(.physicalTherapy)`；后者官方时限只有 1 小时，而且 Apple 要求按实际用途选择 session type，无法支撑文档提到的 90 分钟训练证据目标。普通 Watch app 在用户放下手腕后会进入后台并可能暂停，仅有 Core Motion 这一技术名不足以保证持续采集。
- **证据：** Apple 明确说明 active `HKWorkoutSession` 可让 app 在整个 workout 中继续后台运行并继续接收 HealthKit 与 Watch 传感器数据，同时要求启用 `workout-processing` Background Mode；`physical therapy` extended runtime session 的上限为 1 小时，且必须按用途而非能力选择。参见 [Running workout sessions](https://developer.apple.com/documentation/healthkit/running-workout-sessions) 与 [Using extended runtime sessions](https://developer.apple.com/documentation/watchkit/using-extended-runtime-sessions)。
- **可执行修复：** 在 AD-3 或新增 Watch runtime 规则中绑定：计划/自由力量训练的持续后台采集使用 active `HKWorkoutSession` + `workout-processing`；`WKExtendedRuntimeSession` 不作为绕过 workout runtime 的替代方案。补充 session 启动/失败/暂停/恢复/结束与 durable Workout Session 状态之间的映射，并保留 AD-13 的真机 CPU、能耗、90 分钟与系统终止恢复验证。

### H2 — HealthKit 摘要发往 DeepSeek 的 Apple 合规条件没有成为显式阻断门

- **位置：** AD-8（第 73–77 行）、AD-9（第 79–83 行）、Deferred（第 176–177 行）
- **发现：** 逐次预览和用户明确同意是必要条件，但不是 Apple 允许把 HealthKit 数据交给第三方的全部条件。Apple 还要求第三方只能为该用户提供获准的 health/fitness 服务，并要求明确披露用途；App Review Guidelines 同时限制第三方的数据挖掘用途。DeepSeek 当前公开条款把自身定位为通用、基础模型技术服务，并把下游应用的个人信息处理责任交给开发者。现有 Deferred 虽要求冻结 DeepSeek 的实体、区域、留存等信息，却没有明确要求验证“DeepSeek 作为处理方是否满足 Apple 的 health/fitness third-party 条件”以及相应 DPA/隐私披露。两个团队可能一个允许远程 HealthKit 摘要，另一个因 Apple 条款完全禁用，形成发布级分歧。
- **证据：** Apple Developer Program License Agreement 要求事先明确同意，且第三方只能为用户提供获准的 health/motion/fitness 服务；Apple HealthKit 文档要求明确披露并禁止未经许可的第三方披露。参见 [Apple Developer Program License Agreement](https://developer.apple.com/support/terms/apple-developer-program-license-agreement/)、[Protecting user privacy](https://developer.apple.com/documentation/healthkit/protecting-user-privacy) 和 [App Review Guidelines 5.1.3](https://developer.apple.com/app-store/review/guidelines/)。DeepSeek Open Platform Terms 则要求下游开发者自行披露处理规则、取得同意并承担用户权利与安全义务，参见 [DeepSeek Open Platform Terms](https://cdn.deepseek.com/policies/en-US/deepseek-open-platform-terms-of-service.html)。
- **可执行修复：** 把 Deferred 收紧为 fail-closed gate：在 Apple 条款适配、DeepSeek 数据处理身份与合同、明确隐私政策/处理者披露、删除与权利响应路径经书面确认前，任何 HealthKit 派生值（即使本地汇总）都不得发送到 FitnessAI gateway 或 BYOK DeepSeek；本地 HealthKit 分析和不含 HealthKit 的 AI 功能继续可用。

### H3 — Built-in DeepSeek gateway 在 private Alpha 前没有可构建的运行边界

- **位置：** AD-8（第 73–77 行）、AD-13（第 103–107 行）、Deferred（第 177、180 行）、Structural Seed（第 152 行）
- **发现：** Spine 决定产品密钥只存在 FitnessAI gateway 的 secret store，却把 AI-gateway infrastructure 的选择和 threat model 推迟到 public beta。Owner-only private Alpha 已允许真实服务，因此实现 built-in DeepSeek 时仍必须决定 gateway 运行位置、app 到 gateway 的身份验证、配额/速率限制、产品密钥轮换、请求大小/超时、审计日志边界和故障降级。当前规则没有阻止 Alpha 团队临时部署一个无身份验证的转发器，也没有明确允许只先交付 BYOK。
- **证据：** DeepSeek Open Platform Terms 要求 API key 保密，不得暴露在客户端代码，并要求开发者建立用户管理、数据安全、监测、预警和应急措施；参见 [DeepSeek Open Platform Terms](https://cdn.deepseek.com/policies/en-US/deepseek-open-platform-terms-of-service.html)。该问题不是选哪家云的问题，而是任何 server-side product key route 都必需的最小可运行边界。
- **可执行修复：** 二选一写入 AD-13/Deferred：① private Alpha 先只启用 BYOK，built-in route 在 gateway 平台、区域、app authentication、per-account quota/rate limit、secret rotation、egress allowlist、timeout/retry、content-free logs 和 kill switch 冻结前保持关闭；或 ② 现在绑定满足这些条件的 Alpha gateway 最小部署方案。Public-beta 的完整基础设施与账户体系仍可继续 Deferred。

## 中严重度发现

### M1 — GRDB 7.10.0 已不是当前最新版本

- **位置：** Stack 第 134 行；memlog 第 22–23 行
- **发现：** 2026-09-09 的 memlog 将 7.10.0 记录为 current，但 GRDB 官方仓库已经发布 7.11.0 和 7.11.1，7.11.1 是当前 Latest。7.10.0 仍然存在且满足 Swift 6/Xcode 16+、iOS 13+/watchOS 7+，所以这是“版本真实性/维护策略”问题，不是不可用问题。
- **证据：** [GRDB official releases](https://github.com/groue/GRDB.swift/releases) 显示 v7.11.1 为 Latest，v7.10.0 不是最新；GRDB 7 的平台要求仍覆盖本 Spine 的 iOS 18/watchOS 11 基线。
- **可执行修复：** 更新到已核验的 GRDB 7.11.1，并以 SwiftPM exact pin/`Package.resolved` 锁定；如果有兼容性理由必须留在 7.10.0，则把“current”改为“deliberate pin”，记录理由和升级复核日期，避免误称最新。

### M2 — “provider/account conversations are isolated” 尚未成为可测试的 DeepSeek 隔离规则

- **位置：** AD-8 第 77 行；Consistency Conventions 第 117、119、122 行
- **发现：** DeepSeek Responses API 本身是无服务端 conversation state 的，但其磁盘 context cache 默认开启，并支持 `user` 字段用于安全审查、KVCache 和调度隔离。现有规则没有规定 provider-side isolation key 是否使用、如何避免发送邮箱/姓名等 PII，也没有要求切换账号或 built-in/BYOK route 时清除本地历史和 cache identity。单靠“conversations are isolated”无法形成确定测试。
- **证据：** [DeepSeek Responses API](https://api-docs.deepseek.com/api/create-response/) 声明 API stateless，同时说明 `user` 用于 KVCache/调度隔离且不得包含隐私信息；[Context Caching](https://api-docs.deepseek.com/guides/kv_cache/) 说明磁盘 cache 对所有用户默认启用。stateless 不等于 zero retention。
- **可执行修复：** 规定每个 provider route × FitnessAI account 使用不可逆、无 PII、可轮换的 pseudonymous isolation ID；route/account 切换创建新 ID 并不复用本地 conversation history。合同测试验证请求中没有姓名、邮箱、HealthKit 标识或设备标识。继续保留 Deferred 中的 retention/cache 法务冻结。

## 低严重度发现

### L1 — iPhone 500 MB 与 Watch 75 MB 使用了不同的度量含义，容易被实现者误读

- **位置：** AD-13 第 107 行
- **发现：** Watch 75 MB 是 Apple 的 maximum uncompressed app size；iPhone 的 Apple maximum uncompressed app size 实际是 4 GB，500 MB 是 Mach-O `__TEXT` 上限的一部分规则，而 Spine 中的 500 MB 是产品自行设定的“thinned installed target”。当前句子基本正确，但并列写法可能让人误以为两个数字都是 Apple ceiling。
- **证据：** [App Store Connect maximum build file sizes](https://developer.apple.com/help/app-store-connect/reference/app-uploads/maximum-build-file-sizes) 列出 iOS 4 GB maximum uncompressed app size、watchOS 75 MB；iOS 的 500 MB 注释针对 Mach-O `__TEXT`，不是 installed variant 上限。
- **可执行修复：** 明确写成“产品内部目标：thinned iPhone installed variant ≤500 MB；Apple 上传硬限制：watchOS uncompressed app <75 MB；产品内部目标：Watch installed variant ≤25 MB”，并指定使用 Xcode App Thinning/App Store Connect variant 报告作为验收来源。

## 已核验通过的 committed decisions

| 决策 | 核验结果 | 现实依据 |
|---|---|---|
| Xcode 26.6 (17F113) / Swift 6.3.3 | 通过 | 本机 `xcodebuild -version` 和 `xcrun swift --version` 精确匹配；Apple [Xcode 26.6 Release Notes](https://developer.apple.com/documentation/Xcode-Release-Notes/xcode-26_6-release-notes) 证实 Xcode 26.6 含 Swift 6.3 与 iOS/watchOS 26.5 SDK。 |
| iPhone 11+/iOS 18+；Series 6+/watchOS 11+ | 通过 | iPhone 11 在 Apple 的 iOS 18 兼容列表中；GRDB 和所用 Apple frameworks 的最低版本低于项目基线。自动识别仍按每设备 evidence row 限制，没有把 Series 11 证据外推。 |
| SwiftUI + NavigationStack/TabView | 通过 | 均为当前公开 Apple framework，项目基线完整支持；没有依赖 deprecated WatchKit storyboard 架构。 |
| GRDB + system SQLite on iPhone/Watch | 通过（版本需更新） | GRDB 官方支持 iOS 13+/watchOS 7+、Swift 6/Xcode 16+、SPM 和系统 SQLite；与 iOS 18/watchOS 11 基线兼容。 |
| WatchConnectivity transport split | 通过 | Apple 明确区分：`sendMessage` 只适用于 reachable immediate path；`transferUserInfo` 后台排队；`updateApplicationContext` 覆盖旧 latest-state；`transferFile` 传文件。AD-4 额外要求应用级 durable ACK，正确避免把系统 transfer completion 当业务提交。参见 [Transferring data with Watch Connectivity](https://developer.apple.com/documentation/watchconnectivity/transferring-data-with-watch-connectivity)。 |
| HealthKit read-state semantics | 通过 | Apple 明确不向 app 披露用户拒绝读取；无数据与拒绝不可区分。AD-9 的状态建模正确。参见 [HKAuthorizationStatus](https://developer.apple.com/documentation/healthkit/hkauthorizationstatus)。 |
| HealthKit workout copy identity/version | 通过 | `HKMetadataKeySyncIdentifier` + `HKMetadataKeySyncVersion` 正式支持以更高 version 替换同一 sync identity 的对象。参见 [HKMetadataKeySyncIdentifier](https://developer.apple.com/documentation/healthkit/hkmetadatakeysyncidentifier)。 |
| Apple Data Protection + backup exclusion | 通过，需实现测试 | `completeUntilFirstUserAuthentication` 支持首次解锁后继续访问；`isExcludedFromBackupKey` 可排除所有 app-data backups，但 Apple 提醒某些文件操作会重置该值，因此 migration/replace/sidecar 流程必须复验。参见 [FileProtectionType](https://developer.apple.com/documentation/foundation/fileprotectiontype/completeuntilfirstuserauthentication) 与 [isExcludedFromBackupKey](https://developer.apple.com/documentation/foundation/urlresourcekey/isexcludedfrombackupkey)。 |
| DeepSeek structured-output/provider adapter | 通过，需保持 capability tests | 当前 DeepSeek Responses API 支持 OpenAI Responses 格式和 JSON Schema structured output，但兼容是部分兼容，且某些 unsupported 参数会被静默忽略。AD-8 的 capability declaration、typed untrusted output 与 AD-13 contract tests 是必要且合适的防护。参见 [Using the Responses API](https://api-docs.deepseek.com/guides/responses_api/)。 |
| DeepSeek zero-retention 不作承诺 | 通过 | DeepSeek disk context caching 默认开启，公开隐私政策的 retention 不是零；Deferred 明确禁止在合同冻结前声称 zero retention，判断正确。 |
| BYOK key 存入 non-synchronizing device-local Keychain | 通过 | 该方案能避免产品密钥进入二进制；实现必须使用 `ThisDeviceOnly` accessibility，并确保 crash/network diagnostics 与 app logs 不记录 Authorization header。 |
| 标准 `.json`、bounded parser、无外部引用/附件 | 通过 | 不依赖非标准 parser 能力，限制明确且能通过 schema/size/depth tests 强制执行；作为 draft-only import 可避免覆盖本地 truth。 |
| Starter/current defaults | 无未核验 starter | Spine 没有绑定第三方 starter。一个 Xcode workspace、iPhone/Watch targets 与 local Swift Package 是项目结构决策，不声称来自某个 starter；无需核验模板默认值。 |

## 最终判定

**NEEDS FIXES。** H1 会直接影响 60–90 分钟 Watch 训练采集是否可运行；H2 影响 HealthKit 摘要能否合法交给 DeepSeek 并通过 App Review；H3 影响 built-in AI private Alpha 是否存在安全、可部署的服务边界。M1 应在定稿前纠正为 GRDB 7.11.1 或明确为有意旧版 pin。其余命名技术与主要 Apple/DeepSeek 行为已经获得当前官方资料或本机工具链的现实支撑。

## Re-review — 2026-09-10

复核范围仅限原报告的 H1、H2、H3、M1、M2、L1。最新 Spine 已逐项解决：

| 原发现 | 复核结果 | 最新约束 |
|---|---|---|
| H1 Watch 后台 runtime | **已解决** | AD-3 明确绑定 active `HKWorkoutSession` + workout processing，禁止用 `WKExtendedRuntimeSession` 替代，并要求把 runtime 生命周期映射到 durable session states。 |
| H2 HealthKit → DeepSeek 合规门 | **已解决** | Deferred 明确对全部 HealthKit 派生值 fail closed，直到 Apple health/fitness-purpose、DeepSeek processor/contract、披露、删除/撤回和用户权利路径获得书面确认；本地分析与不含 HealthKit 的 AI 保持可用。 |
| H3 Alpha built-in gateway 边界 | **已解决** | AD-8 在 Alpha traffic 前绑定环境隔离 endpoint、短期 owner-auth client/session credential、provider/model/egress allowlist、请求/schema/time/rate/cost ceilings、key rotation、redacted logs、rollback owner 与 kill switch。 |
| M1 GRDB 版本 | **已解决** | Stack 已更新为当前 GRDB 7.11.1，并要求 SwiftPM exact pin 与提交 `Package.resolved`。 |
| M2 DeepSeek route/account 隔离 | **已解决** | AD-8 规定 route × account 使用可轮换、不可逆、无 PII 的 pseudonymous isolation ID；切换时产生新 identity 且不复用 conversation history。 |
| L1 app size 度量含义 | **已解决** | AD-13 明确以 Xcode/App Store Connect thinning reports 验收，区分 iPhone 内部 installed-variant 目标、Apple Watch uncompressed ceiling 与 Watch 内部 installed-variant 目标。 |

**复核结论：PASS。原报告 6 项均已解决，没有剩余技术现实性阻断项。**
