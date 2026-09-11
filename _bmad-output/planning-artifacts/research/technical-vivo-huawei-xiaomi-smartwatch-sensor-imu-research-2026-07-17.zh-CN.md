---
stepsCompleted: [1, 2, 3, 4, 5, 6]
inputDocuments: []
workflowType: 'research'
lastStep: 6
research_type: 'technical'
research_topic: 'vivo、华为、小米手表的连续传感器访问、采样质量与公开 IMU 数据集适配'
research_goals: '评估 FitnessAI 长时连续感知的可行性；比较传感器访问限制、采样与时间戳质量；明确公开 IMU 数据集的适配要求；给出设备策略、集成架构和验证方案建议。'
user_name: 'HP'
date: '2026-07-17'
web_research_enabled: true
source_verification: true
---

# 从现有硬件到可靠感知：vivo、华为与小米手表 IMU 技术研究

**日期：** 2026-07-17
**作者：** HP
**研究类型：** 技术研究

---

## 研究概述

本研究面向 FitnessAI，评估 vivo、华为与小米手表生态中的连续传感器访问、采样质量和公开 IMU 数据集适配。研究严格区分产品资料中经常被混为一谈的四个问题：硬件是否具有传感器、第三方应用是否能够访问、访问能否在用户可感知的长时会话中持续，以及实际交付样本是否足以支持模型训练或推理。

证据优先采用最新厂商文档、官方平台文档、原始数据集仓库和真机验收要求。最终结论已经结合现有硬件调整：先在已有的 vivo WATCH GT 2 与 vivo 手机上执行短周期、带证据门禁的可行性验证。如果 BlueOS 提供可部署的连续原始 IMU、可用时间戳和生命周期行为，就把 vivo 提升为首个记录器平台；否则保留规范数据契约，并切换 Xiaomi Watch 2/2 Pro 作为文档更完整的 Wear OS 备用路线。最终决策框架参见执行摘要和技术研究结论。

证据收集时间为 2026-07-17 至 2026-07-18。具体设备的频率、抖动、丢样、时钟、轴系、后台和能耗特征仍必须通过报告中定义的真机验收套件确认。

---

<!-- 内容将按研究工作流步骤依次追加 -->

## 执行摘要

vivo WATCH GT 2 并非无法使用。vivo 官方确认其运行 BlueOS 3.0，配备加速度计和陀螺仪，并具有手表端应用商店和应用安装/卸载能力。由于设备已经拥有，它应当成为第一优先级验证对象。但 Android APK 不能直接安装到手表：FitnessAI 需要独立的 BlueOS 手表组件，而且公开资料尚未证明第三方应用能够连续读取原始加速度计/陀螺仪，也未给出事件时间语义、采样请求行为或熄屏生命周期。([vivo WATCH GT 2 参数](https://www.vivo.com.cn/vivo/param/vivowatchgt2)、[vivo WATCH GT 2 产品页](https://www.vivo.com.cn/vivo/vivowatchgt2/))

Xiaomi Watch 2/2 Pro 仍是最强技术备用路线，因为 Wear OS 提供 Android Sensor Framework 与文档明确的前台服务模型。华为是可信的第二扩展平台：HarmonyOS 本机 Sensor API 是首选原始路径，Wear Engine 官方确认远程加速度计、ECG 和 PPG，但未确认陀螺仪。Xiaomi S4 类封闭型号、Health Connect、华为 Health Service 和 vivo Health Kit 属于派生记录数据面，不属于原始 IMU 数据面。([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview)、[华为 Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/)、[Health Connect 数据类型](https://developer.android.com/health-and-fitness/health-connect/data-types))

**最终战略建议：**

1. 在购买新硬件前，对 vivo WATCH GT 2 执行两至五天可行性门禁。
2. 只有 BlueOS 部署、原始 ACC+gyro、可用时间戳、本地持久化和熄屏测试全部成功时，才承诺 vivo 记录器。
3. 保留厂商无关的 Manifest/分块契约，使失败时可以平滑迁移到小米 Wear OS。
4. 使用 MM-Fit 做健身动作预训练、WISDM 做消费级手表/20 Hz 鲁棒性、PAMAP2 做 100 Hz 活动表征，然后在目标设备数据上微调与评估。
5. 把请求频率视为请求而不是保证；每个设备/固件必须通过真机采样、能耗、生命周期和模型域测试。
6. 门禁通过前不承诺多厂商原始数据支持或生产模型准确率。

## 目录

1. [技术研究范围确认](#技术研究范围确认)
2. [技术栈分析](#技术栈分析)
3. [集成模式分析](#集成模式分析)
4. [架构模式与设计](#架构模式与设计)
5. [实现方法与技术采用](#实现方法与技术采用)
6. [技术研究建议](#技术研究建议)
7. [最终研究综合](#最终研究综合)
8. [技术研究结论](#技术研究结论)

## 技术研究范围确认

**研究主题：** vivo、华为、小米手表的连续传感器访问、采样质量与公开 IMU 数据集适配
**研究目标：** 评估 FitnessAI 长时连续感知的可行性；比较传感器访问限制、采样与时间戳质量；明确公开 IMU 数据集的适配要求；给出设备策略、集成架构和验证方案建议。

**技术研究范围：**

- 架构分析——设计模式、框架与系统架构
- 实现方法——开发方法、编码模式与最佳实践
- 技术栈——相关语言、框架、工具与平台
- 集成模式——API、协议与系统互操作性
- 性能考量——可扩展性、优化与性能模式

**研究方法：**

- 使用最新网络资料并严格核验来源
- 对关键技术主张进行多来源交叉验证
- 对不确定信息标注置信度
- 提供覆盖全面且面向架构决策的技术分析

**范围确认日期：** 2026-07-17

## 技术栈分析

### 编程语言

三家厂商并未提供统一的手表运行时，因此实现语言必须按设备系列拆分：

- **华为智能穿戴设备：** 当前 HarmonyOS 智能穿戴应用以 **ArkTS** 为主要应用层语言。ArkTS 派生自 TypeScript 并加强了静态约束；必要时可引入 Native 组件。华为 **Lite Wearable** 是独立的低功耗、兼容 JavaScript 的类 Web 技术栈，不能假定它与智能穿戴 API 等价。([Huawei ArkTS](https://developer.huawei.com/consumer/en/arkts/)、[华为穿戴开发](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/)、[Huawei Lite Wearable](https://developer.huawei.com/consumer/cn/multidevice/wearables/lite/))
- **小米 Wear OS 型号：** Xiaomi Watch 2 和 Watch 2 Pro 运行 Wear OS，标准技术栈是 **Kotlin/Java**，并可通过 Android NDK 使用 C/C++。这是直接使用 Android 原始传感器框架时可移植性最好的路线。([Xiaomi Watch 2](https://www.mi.com/global/product/xiaomi-watch-2/)、[Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview))
- **小米非 Wear OS 型号：** 全球版 Xiaomi Watch S4 等设备属于 Mi Fitness 生态，不能假定其能够运行第三方 Wear OS APK。小米英国官方 FAQ 明确说明不支持第三方应用；产品页提到的 Health Connect 互操作性是结构化数据交换，不是开放的原始 IMU 手表应用运行时。([Xiaomi Watch S4 FAQ](https://www.mi.com/uk/support/faq/details/KA-517264/)、[Xiaomi Watch S4](https://www.mi.com/global/product/xiaomi-watch-s4/))
- **vivo BlueOS 型号：** BlueOS 公开开发套件采用类 Web 的 JavaScript 应用模型，并支持 JS/Native 混合开发。BlueOS 系统本身以 Rust 为核心，不代表第三方手表应用主要使用 Rust。([BlueOS 开发套件](https://developers.vivo.com/product/blueos/devKit)、[BlueOS 内核](https://developers.vivo.com/product/blueos/kernel))
- **现有 vivo WATCH GT 2：** vivo 官方确认该设备运行 BlueOS 3.0，具有加速度计、陀螺仪、手表端应用商店及应用安装/卸载能力，因此适合作为第一优先级的可行性验证设备。但它需要独立的 BlueOS 手表应用，不能直接复用 Android APK；产品页本身也不能证明第三方应用能够连续读取原始 IMU。([vivo WATCH GT 2 参数](https://www.vivo.com.cn/vivo/param/vivowatchgt2)、[vivo WATCH GT 2 产品页](https://www.vivo.com.cn/vivo/vivowatchgt2/))

_对 FitnessAI 的含义：_ 将信号处理核心隔离在可移植接口之后；Wear OS 使用 Kotlin，HarmonyOS 使用 ArkTS，只有在传感器访问经过书面确认和真机验证后才实现 BlueOS JS/Native 适配层。  
_置信度：平台和语言划分为高；统一 Native 推理核心在所有设备系列上的可部署性为中。_

### 开发框架与库

- **Wear OS：** `SensorManager` 是原始加速度计/陀螺仪访问路径。Health Services 提供经过计算的运动与健康指标，其设计目标是按用例优化，而非不受限制地采集原始 IMU。`ExerciseClient` 面向主动运动，`PassiveMonitoringClient` 面向长时低频结果，`MeasureClient` 面向短时快速测量。([Health Services](https://developer.android.com/health-and-fitness/health-services)、[Wear OS 兼容性](https://developer.android.com/health-and-fitness/health-services/compatibility))
- **HarmonyOS：** 相关框架包括 ArkUI、Sensor Service Kit、Background Tasks Kit、ArkData、Network Kit、Remote Communication Kit 和 Wear Engine Kit。Wear Engine 还提供 Android 侧 SDK，用于手机—手表通信，并声明可管理加速度计和 ECG/PPG；但仍需确认服务申请和具体设备支持。([HarmonyOS SDK 概览](https://developer.huawei.com/consumer/en/harmonyos/develop/)、[Wear Engine](https://developer.huawei.com/consumer/en/hms/huawei-wearengine/))
- **BlueOS：** 公开 SDK 概览列出了 JS/Native API、文件与键值存储、联网和跨设备通信能力。vivo Health Kit 是独立的结构化健康记录交换接口；其公开数据清单不能证明可获取原始加速度计或陀螺仪流。([BlueOS 文档](https://developers.vivo.com/product/blueos/doc)、[vivo Health Kit](https://developers.vivo.com/product/d/healthKit))
- **公开 IMU 研究栈：** MM-Fit 与健身动作及次数识别最匹配，包含十类动作以及双腕 100 Hz 加速度计和陀螺仪流。WISDM 提供 51 名参与者、20 Hz 的消费级手表加速度计和陀螺仪数据；PAMAP2 提供 100 Hz 的惯用手腕研究级 IMU，并包含胸部、脚踝 IMU 与心率。这些数据适合预训练和数据管线验证，但都不能直接充当当前消费级手表的校准数据。([MM-Fit](https://mmfit.github.io/)、[UCI WISDM](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B)、[UCI PAMAP2](https://archive.ics.uci.edu/dataset/231/pamap2%2Bphysical%2Bactivity%2Bmonitoring))

_生态成熟度：_ Wear OS 是最开放且文档最完整的通用路线；HarmonyOS 能力较强，但设备与服务资格很关键；BlueOS 已提供应用 SDK，但公开资料对原始传感器的保证仍不完整。  
_置信度：Wear OS 和公开数据集特征为高；华为设备覆盖为中；BlueOS 第三方连续原始 IMU 为低至中。_

### 数据库与存储技术

- **手表端缓冲：** 使用只追加的二进制或列式会话日志，记录单调时钟时间戳、序列号、传感器元数据和校验和。传输前先持久化，避免蓝牙或网络中断导致训练数据丢失。
- **Wear OS：** 使用应用私有文件或 Room 保存本地元数据和会话索引。Google Data Layer 文档明确说明 Data Layer 是同步机制而非存储，并建议保留由应用拥有的副本，例如 Room 数据库。([Wear OS 数据同步](https://developer.android.com/training/wearables/data/sync))
- **HarmonyOS：** ArkData 与 Core File Kit 是原生应用存储体系；Cloud Foundation Kit 与 Network Kit 可用于上行集成。具体手表是否支持需要按目标 SDK Profile 核验。([HarmonyOS SDK 概览](https://developer.huawei.com/consumer/en/harmonyos/develop/))
- **BlueOS：** 公开资料列出文件存储、键值存储和数据共享能力。原则上可构建本地暂存队列，但容量、写入寿命、配额和后台刷新行为需要目标设备测试。([BlueOS 开发套件](https://developers.vivo.com/product/blueos/devKit))
- **服务端：** 不可变原始会话进入对象存储，归一化窗口或特征进入分析存储。原始数据、设备清单、标签和模型版本分别进行版本管理，以保留来源链路。

_置信度：推荐架构为高；厂商手表端具体配额因公开规格不完整而为中。_

### 开发工具与平台

- **华为：** DevEco Studio、HarmonyOS SDK、ArkTS/ArkUI 工具、穿戴模拟器或目标手表，以及华为性能分析工具。([华为穿戴开发](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/))
- **小米 Wear OS：** Android Studio、Gradle、ADB、Wear OS 模拟器、Android Sensor API、Health Services 示例和 Xiaomi Watch 2/2 Pro 真机。模拟器适合验证应用流程，不适合采样质量验收。
- **vivo：** BlueOS Studio/SDK 和 BlueOS 真机。公开 API 索引尚不足以在没有 SDK、账号权限和硬件的情况下验证原始 IMU 行为。([BlueOS 开发套件](https://developers.vivo.com/product/blueos/devKit))
- **跨平台数据质检：** 使用统一记录格式和脚本/Notebook，计算实际 Hz、采样间隔分位数、时间戳单调性、重复/乱序样本、间隙、饱和、轴向、噪声底与时钟漂移。

_测试规则：_ 任何平台都不能仅凭模拟器或产品宣传通过验收；验收产物必须包括实际原始采集会话和可复现的质量报告。

### 云基础设施与部署

- **Wear OS：** 适当时使用直连 HTTPS，手表—手机同步可用 Data Layer。Data Layer 可在离线时缓冲，但非紧急 `DataItem` 可能延迟；它不是主要网络通道或持久存储层。([Data Layer 概览](https://developer.android.com/training/wearables/data/overview)、[Data items](https://developer.android.com/training/wearables/data/data-items)、[直连网络](https://developer.android.com/training/wearables/data/network-communication))
- **华为：** 配对设备间使用 Wear Engine/Remote Communication，云端上传使用 Network Kit 或手机网关。Wear Engine 官方 Codelab 演示了应用间消息/文件传输，并要求匹配包身份和证书配置。([Wear Engine Codelab](https://developer.huawei.com/consumer/en/codelab/WearEngine/))
- **vivo：** 只有在吞吐、重连、后台和配额测试通过后，才使用 BlueOS 联网/跨设备能力或手机网关。vivo Health 云同步适合授权健康记录，不能被假定为任意原始 IMU 传输通道。
- **推荐拓扑：** 手表记录器 → 加密本地暂存 → 可恢复的手机/云上传 → 不可变原始存储 → 归一化/质量门禁 → 训练或推理管线。该拓扑能够容忍间歇连接，并把厂商适配器隔离在规范数据模型之外。

_置信度：架构与 Wear OS 行为为高；华为/vivo 传输细节在目标设备资格和测试前为中。_

### 技术采用趋势

1. **API 抽象正在替代直接控制医疗/健身传感器。** Wear OS Health Services 和厂商 Health Kit 通过功耗及隐私控制提供整理后的指标；原始 IMU 是独立且要求更高的路径。
2. **后台访问权限正变得更加细粒度。** Wear OS API 36 对健康权限进行细分；后台身体传感器信息需要 `READ_HEALTH_DATA_IN_BACKGROUND`。([Health Services 权限](https://developer.android.com/health-and-fitness/health-services/permissions))
3. **请求采样率不等于交付采样率。** Android 明确将请求间隔视为建议值，会实施速率限制，并要求通过事件时间戳计算实际交付速率。([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview))
4. **厂商碎片化仍是主要工程风险。** 小米同时存在 Wear OS 和非 Wear OS 产品；华为区分 smart 与 lite 穿戴 Profile；vivo 的 BlueOS 模型和公开传感器文档仍在演进。
5. **公开数据集更适合表征预训练，而非最终验证。** WISDM 的 20 Hz LG G Watch 数据和 PAMAP2 的 100 Hz 研究 IMU 与当前手表在传感器传递函数、佩戴位置、固件滤波、时基、参与人群和活动协议上均有差异。

_决策信号：_ 先在已有的 vivo WATCH GT 2 上执行限时可行性验证，检查 BlueOS 开发部署、原始加速度计/陀螺仪订阅、时间戳、本地持久化和熄屏生命周期。如果门禁失败，再切换 Xiaomi Watch 2/2 Pro 作为文档完整的 Wear OS 备用路线；华为保留为后续并行厂商集成方向。  
_总体置信度：中高。技术栈比较证据充分；具体设备级采样保证将在采样质量和验证阶段处理。_

## 集成模式分析

### API 设计模式

FitnessAI 需要刻意分离两套 API 数据面：

1. **原始感知数据面：** 以会话为中心，在设备本地高速采集加速度计/陀螺仪事件；必须保存事件时间、序列号、单位、精度/状态和数据间隙。
2. **健康记录数据面：** 在用户授权下交换强类型的锻炼、心率、步数、睡眠等派生记录。它可以提供标签与摘要，但无法重建原始 IMU 信号。

原始感知适配器应采用小型、能力优先的接口：

```text
queryCapabilities() -> sensors, ranges, resolution, minDelay, batching, permissions
startSession(config) -> sessionId, acceptedConfig
appendEvents(events) -> local durable chunk
stopSession() -> manifest, chunk hashes, quality summary
resumeUpload(sessionId, acknowledgedChunks)
```

各平台实现并不等价：

- **Xiaomi Watch 2/2 Pro：** `SensorManager` 是原始数据面；用户可见的 health 前台服务负责在训练期间保持采集。Android 9+ 不会向普通后台应用交付连续的加速度计/陀螺仪事件。([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview)、[前台服务类型](https://developer.android.com/develop/background-work/services/fgs/service-types))
- **华为智能穿戴：** 本机 Sensor Service Kit / `@ohos.sensor` 订阅是首选原始数据面。Background Tasks Kit 只提供受约束的运行资格，不会绕过传感器能力，也不保证无限期高频采集。([华为 Sensor API](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-sensor)、[华为开发文档](https://developer.huawei.com/consumer/cn/doc/))
- **vivo BlueOS：** 公开门户提供 JS/Native 文档分类，但尚未找到可公开核验的原始加速度计/陀螺仪订阅、时间戳、请求频率或后台寿命契约。因此该适配器属于带门禁的集成项，不能视为已经承诺的实现。([BlueOS 文档](https://developers.vivo.com/product/blueos/doc))

云端集成应使用粗粒度 REST 资源而不是逐样本请求：`POST /sessions`、可恢复分块上传地址、`POST /sessions/{id}/complete` 和 `GET /sessions/{id}/quality`。gRPC 可用于后端内部，但拒绝手表逐样本云端 RPC，因为它会让采样与网络连接和功耗状态紧耦合。

_置信度：双数据面设计和 Wear OS 限制为高；华为本机集成为中高；在获得 SDK 前，BlueOS 原始传感器实现为低。_

### 通信协议

实际可行的路径可归纳为四种传输模式：

| 路径 | 最适合的用途 | 已确认限制 |
|---|---|---|
| 应用内本地回调 | 原始 IMU 采集 | 延迟最低；应用必须自行缓冲和持久化事件。 |
| 厂商手表—手机通道 | 命令、状态与分块中继 | Wear OS Data Layer 和华为 Wear Engine 是受管理通道，不是通用 BLE 协议；vivo BlueXLink/RPC 缺少可公开核验的吞吐/QoS。 |
| 手表/手机 HTTPS | 可恢复云端上传 | 后端与厂商手机中间件解耦；上传需要避开采集关键路径。 |
| 健康平台 API | 强类型派生记录 | Health Connect、华为 Health Service Kit 和 vivo Health Kit 都没有通用原始 IMU 记录类型。 |

**Wear OS Data Layer：** `DataItem` 是同步状态，载荷上限 100 KB；非紧急同步可能延迟约 30 分钟。`Asset` 或 channel 更适合较大分块，但 Android 建议使用应用自有存储和既有云基础设施保存持久化锻炼历史。Data Layer 仅支持 Wear OS 与配对 Android 设备。([Data items](https://developer.android.com/training/wearables/data/data-items)、[Data Layer 概览](https://developer.android.com/training/wearables/data/overview)、[同步指南](https://developer.android.com/training/wearables/data/sync))

**Wear OS 直连网络：** 手表可以使用 HTTP/TCP/UDP；蓝牙连接时流量通常经手机代理，否则使用 Wi-Fi/LTE。Google 明确说明不能把 Data Layer 当作手表网络 API。([Wear OS 网络通信](https://developer.android.com/training/wearables/data/network-communication))

**华为 Wear Engine：** 官方能力页确认配对设备状态、双向文件传输，以及手机侧对加速度计、ECG、PPG 的控制和数据获取。陀螺仪未被列出，不能假定支持。接入需要服务申请、Client ID 配置和用户授权。([Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/)、[Wear Engine](https://developer.huawei.com/consumer/en/hms/huawei-wearengine/))

**vivo：** BlueOS 公开声明具备文件/K-V 存储、联网、数据共享和跨设备能力。内核支持 TCP/IP 与 POSIX socket，但内核能力不等于普通手表应用拥有不受限制的 socket 权限。在给 BlueXLink/RPC 分配原始 IMU 中继职责前必须进行负载测试。([BlueOS 开发套件](https://developers.vivo.com/product/blueos/devKit)、[BlueOS 内核](https://developers.vivo.com/product/blueos/kernel)、[BlueOS 平台](https://developers.vivo.com/product/blueOS))

_推荐协议行为：_ 本地形成 10–60 秒分块，为每块计算哈希，以幂等键异步上传并按块序号确认。任何内存消息或蓝牙队列都不能保存唯一副本。

### 数据格式与标准

规范原始事件 Schema 应与厂商无关并带版本：

```text
session_id, schema_version, device_vendor, device_model, os_version,
app_version, firmware_version, sensor_type, sensor_vendor, sensor_version,
timestamp_device_ns, timestamp_receive_ns, sequence,
x, y, z, unit, accuracy_status, requested_period_us, batch_latency_us
```

- **Manifest：** 使用便于检查的 JSON，包含授权状态、佩戴手、表冠方向、请求配置、接受的能力、分块哈希、时钟锚点、标签和缺失区间。
- **原始分块：** 使用 Protobuf/CBOR 或有清晰文档的紧凑二进制布局，并可选压缩。CSV 仅作为导出格式保留，因为其体积和弱类型不适合手表端持久化。
- **健康记录：** 保留来源平台的强类型对象和来源信息。Health Connect 记录包含 UID、修改时间、数据来源、设备元数据、客户端记录 ID/版本、记录方式和时区信息。([Health Connect 数据格式](https://developer.android.com/health-and-fitness/health-connect/data-format))
- **单位：** 将加速度统一为 m/s²、角速度统一为 rad/s，同时保留原始单位和量程元数据。重采样应在原始数据入库后进行，不能放在采集回调中。

健康平台对象在逻辑上必须与 IMU 分块分离。锻炼记录可以按时间区间和用户/会话授权关联到原始会话，但步数、配速或心率记录不能被序列化成原始传感器事件。

_置信度：Schema 要求为高；具体二进制编码选择为中，需要在目标硬件上基准测试。_

### 系统互操作方式

每个设备系列通过**防腐适配层**接入：

```text
Wear OS SensorManager ─┐
HarmonyOS Sensor API ──┼─> 规范原始会话契约 ─> 质量门禁
BlueOS Sensor API ? ───┘

Health Connect ────────┐
Huawei Health Service ─┼─> 规范健康/锻炼记录 ─> 标签对齐
vivo Health Kit ───────┘
```

- **小米封闭设备：** 公开可支持的路径是 `手表 → Mi Fitness → Health Connect → FitnessAI 手机应用`。Health Connect 保存强类型本地记录，而不是原始加速度计/陀螺仪样本表。小米具体记录覆盖、写入节奏和地区行为需要按目标 SKU 验证。([Xiaomi Watch S4](https://www.mi.com/global/product/xiaomi-watch-s4/)、[Health Connect 数据类型](https://developer.android.com/health-and-fitness/health-connect/data-types))
- **华为：** Health Service Kit 提供健康采样点和结构化锻炼/健康记录，本机 Sensor Service 才是原始数据路径。Wear Engine 是可选中继，其远程传感器覆盖范围与本机 API 不同。([华为 Health Service Kit](https://developer.huawei.com/consumer/cn/sdk/health-service-kit/)、[Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/))
- **vivo：** 当前可支持的派生路径是 `手表系统算法 → vivo 健康应用 → Health Service/Health Kit`，并受用户读写授权组控制。公开 Health Kit 清单包括运动记录、步数、距离、步频、心率、血氧、ECG 等，但没有原始三轴 IMU 序列。([vivo Health Kit](https://developers.vivo.com/product/d/healthKit)、[vivo Health Kit 隐私清单](https://iot.vivo.com.cn/h5/164/))

不要在厂商 API 对象层建立通用抽象。每个适配器必须先完整保留厂商元数据和错误状态，再进行归一化。

### 微服务集成模式

后端应按数据职责而不是厂商划分：

1. **会话服务：** 授权快照、设备/应用/固件清单、生命周期和标签。
2. **分块接入服务：** 签名上传、校验和、去重、排序和隔离。
3. **质量服务：** 频率、抖动、间隙、时间戳、轴向、饱和检查与验收状态。
4. **归一化服务：** 单位、坐标校准、时钟对齐、重采样和缺失掩码。
5. **数据集注册表：** 受试者安全切分、来源许可、血缘和版本化变换。
6. **训练/推理服务：** 模型版本选择、预测和分设备域评估。

外部 API Gateway 负责身份、速率限制和上传凭据签发。内部服务使用幂等命令，并在厂商云 API 周围设置熔断。手表、手机与云端之间不存在分布式事务；会话完成是一个容忍延迟和重复分块的状态机。

_推荐状态流转：_ `CREATED → CAPTURING → LOCAL_COMPLETE → UPLOADING → INGESTED → QUALITY_PASSED|QUARANTINED`。

### 事件驱动集成

只在持久状态变化后发布不可变领域事件：

- `session.created`
- `chunk.received`
- `chunk.verified`
- `session.upload_complete`
- `quality.passed` / `quality.failed`
- `health_record.linked`
- `dataset_version.published`

消费者必须利用 `(session_id, chunk_index, chunk_hash)` 保持幂等，并容忍乱序交付。原始对象存储是事实来源；事件流只负责协调处理，不能成为样本唯一副本。死信/隔离路径保留损坏、重复冲突、授权失效或 Schema 未知的上传，以供调查。

默认不采用实时 WebSocket/MQTT 流，因为 FitnessAI 的训练采集可以容忍秒级延迟，数据完整性和功耗效率更重要。实时指导可增加独立的低带宽特征/预测流，但不能改变原始数据持久化路径。

### 集成安全模式

- **授权与最小权限：** 只请求当前功能需要的传感器/健康 Scope。Health Connect、华为 Health Service 和 vivo Health Kit 均要求用户或数据类型级授权；撤销授权必须停止后续读取并触发保留策略处理。([Health Connect 数据类型与权限](https://developer.android.com/health-and-fitness/health-connect/data-types)、[vivo Health Kit](https://developers.vivo.com/product/d/healthKit))
- **应用身份：** Wear OS Data Layer 只允许包名和签名匹配的应用交换数据；华为 Wear Engine 要求注册服务身份、Client ID 和用户授权。这些控制认证的是应用通道，不能替代 FitnessAI 用户/会话授权。([Data Layer 安全](https://developer.android.com/training/wearables/data/overview)、[Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/))
- **传输与存储：** 云端流量使用 HTTPS/TLS；在平台支持时使用应用私有且静态加密的会话分块；采用短期、限定范围的上传凭据、逐块哈希和服务端加密。不得在日志中记录原始健康载荷或长期 Token。
- **来源：** 保存数据来源、设备型号、固件、应用版本、权限状态、记录方式和变换血缘。Health Connect 的设备字段由写入者提供，不是密码学证明。
- **隐私隔离：** 账户标识不得写入原始样本对象；使用假名化的受试者/会话 ID，并把关联表单独加固。数据集注册表负责执行删除和保留，使派生数据集及模型训练资格可追溯。

_总体集成决策：_ 先把现有 vivo WATCH GT 2 作为实验性第一适配器，同时保持厂商无关的分块协议不变；只有能力与生命周期门禁通过后，才把 BlueOS 提升为生产原始适配器。小米 Wear OS 是原始采集备用基线；华为后续通过验证过的本机 Sensor 适配器接入，并可选 Wear Engine。  
_总体置信度：协议分离和 Wear OS 行为为高；华为具体设备覆盖为中；vivo 原始 IMU 集成为低至中。_

## 架构模式与设计

### 系统架构模式

推荐采用**离线优先的边缘采集管线**。即使手表无法连接手机或网络，采样仍必须正确进行；采集期间由本地持久化存储充当事实来源。这与 Android 离线优先指南一致：关键功能应在网络不可靠时仍能运行，并由持久化本地数据源持有应用数据。([Android 离线优先架构](https://developer.android.com/topic/architecture/data-layer/offline-first)、[Android 数据层](https://developer.android.com/topic/architecture/data-layer))

```text
手表能力探测
  -> 前台/会话绑定的原始采集
  -> 不可变本地分块 + Manifest
  -> 可选手机网关或直接 HTTPS
  -> 不可变原始对象存储
  -> 质量门禁
  -> 带血缘的归一化/重采样
  -> 版本化训练/评估数据集
```

健康记录是并行路径，不能嵌入原始数据路径：

```text
Health Connect / Huawei Health Service / vivo Health Kit
  -> 强类型记录接入
  -> 来源与授权检查
  -> 时间区间/会话对齐
  -> 标签和上下文特征
```

**按设备系列的部署决策：**

| 设备系列 | 主要架构 | 支持的降级路径 |
|---|---|---|
| Xiaomi Watch 2/2 Pro | `SensorManager → 本地分块存储 → HTTPS 或手机网关` | Health Services 与 Health Connect 摘要 |
| 华为智能穿戴 | 本机 Sensor API 优先，可选 Wear Engine 中继 | Health Service 记录；适当时使用 Wear Engine 加速度计单模态路径 |
| vivo BlueOS 手表 | 原始路径受 SDK/后台/传输验证门禁控制 | vivo Health Kit 派生记录 |
| Xiaomi S4 等封闭型号 | 无公开的手表端原始管线 | `Mi Fitness → Health Connect` 记录 |

_架构决策：_ 手机网关是优化和兼容层，不能成为唯一持久副本。即使手机断连，手表仍能在本地完成会话。

### 设计原则与最佳实践

1. **先探测能力，再接受配置：** 在接受采集 Profile 前枚举传感器、量程、分辨率、标称最小延迟、权限和支持的后台模式。
2. **事件时间优先于到达时间：** 同时保存设备事件时间和接收时间；重采样、对齐、漂移和间隙分析都使用事件时间。
3. **先持久化，再传输：** 分块只有在关闭、计算校验和并提交到应用私有存储后才能进入上传队列。
4. **原始数据不可变：** 滤波、轴变换、重采样和缺失值处理产生新的版本化派生数据，不覆盖原始数据。
5. **厂商适配器保留差异：** 只有在保留设备、固件、传感器厂商/版本、单位、轴系、权限状态和错误码后才归一化。
6. **用户可感知的采集：** 长时原始 IMU 采集是显式开始/停止并显示状态的训练或研究会话，而非隐藏的永久后台进程。
7. **能力优雅降级：** 支持加速度计单模态模型和仅派生记录设备，不能伪造缺失的陀螺仪或波形输入。
8. **每层单一事实来源：** 采集期间是本地分块存储，接入后是原始对象存储，发布训练集由数据集注册表负责。Android 架构指南同样建议明确事实来源和单向状态变更。([Android 架构指南](https://developer.android.com/topic/architecture))

手表应用应采用六边形边界：`SensorPort`、`ChunkStorePort`、`UploadQueuePort` 和 `HealthContextPort`。厂商 SDK 对象只存在于适配器内部，使采集核心与文件格式可以脱离真机测试。

### 可扩展性与性能模式

**端侧性能：**

- 传感器回调只负责把时间戳、状态和值复制到有界缓冲区并立即返回。
- 在工作线程序列化和压缩，按时间及大小轮转分块。
- 在内存耗尽前实施背压。如果持久化跟不上，记录显式溢出/间隙事件，不能静默丢样。
- 上传脱离采样关键路径，优先在训练结束、充电或网络条件较好时执行。
- 分离采集与实时指导预算。实时推理可消费短窗口，但原始数据持久化保持独立。

**后端扩展：**

- 通过短期签名 URL 将分块直接上传到对象存储，避免大载荷经过应用 API 代理。
- 大会话使用可恢复的分段上传和服务端校验和。S3 等对象存储支持分段或整对象校验。([S3 分段上传](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html)、[预签名上传 URL](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-presigned-url.html))
- 按 `session_id` 划分处理任务；质量和归一化任务可水平扩展并保持确定性。
- 缓存 Manifest 与质量摘要，不缓存原始信号载荷。
- 不在采样路径引入分布式共识；会话状态机与幂等分块键足以处理预期的重复和重试。

**初始后端形态：** 身份/会话/Manifest API 使用模块化单体，原始分块进入对象存储，质量/归一化使用持久任务队列。只有当负载、团队所有权或发布节奏证明值得时才拆分服务。

### 集成与通信模式

采集与上传采用**存储转发**模式：

1. `startSession` 固化能力与授权快照。
2. 传感器事件追加到当前本地分块。
3. 分块关闭时写入头部、样本数、时间范围、缺失/溢出标记和校验和。
4. 上传队列结合指数退避及网络/电量约束进行重试。
5. 服务端确认按 `(session_id, chunk_index, hash)` 持久化到本地。
6. 只有完整会话通过远端验证且保留策略允许后，才删除本地数据。

Wear OS 可使用 WorkManager 排空持久上传队列，但 WorkManager 只在约束满足后执行，且单个 Worker 有时长限制；它是上传调度器，不是传感器采集引擎。([WorkManager](https://developer.android.com/reference/androidx/work/WorkManager.html)、[离线队列指南](https://developer.android.com/topic/architecture/data-layer/offline-first))

**故障处理：**

| 故障 | 必须采取的行为 |
|---|---|
| 手机/网络断开 | 继续本地采集，关闭后的分块进入队列。 |
| 进程/服务被终止 | 恢复 Manifest 与最后一个有效分块边界，将会话标记为中断。 |
| 上传不完整或损坏 | 按校验和拒绝并重试同一不可变分块。 |
| 重复上传 | 哈希一致时返回已有确认；内容冲突时进入隔离区。 |
| 时钟跳变/漂移 | 保留原始时钟与锚点，只在派生数据中校正。 |
| 存储空间压力 | 在耗尽前告警或安全停止，不能静默删除未验证会话。 |
| 权限被撤销 | 停止相关数据流，以原因关闭会话，并执行数据策略。 |
| 不支持传感器 | 选择声明过的降级模型或拒绝该采集 Profile。 |

### 安全架构模式

安全遵循**最小权限、短期授权和内建来源追踪**：

- 本地分块使用应用私有存储和平台沙箱；根据平台能力与威胁模型对敏感持久数据加密。
- 云端流量强制 HTTPS/TLS 并显式禁止明文。Android Network Security Configuration 支持禁用明文、配置可信根和证书透明度。([Android Network Security Configuration](https://developer.android.com/privacy-and-security/security-config))
- 签发短期、限定对象范围的上传 URL 或 Token；手表不持有通用云凭据。
- 上传权限绑定用户、设备安装实例、会话、分块序号、预期大小和校验和。
- 假名化受试者/会话 ID 与账户身份分离，关联表放入权限更严格的存储。
- 每个会话保存授权/权限快照和数据来源。撤销授权会停止未来采集/访问，并触发已定义的保留/删除流程。
- 在支持时验证应用/设备完整性，但厂商或 Health Connect 的设备元数据只作为来源声明，不能视作密码学证明。
- 审计日志只记录元数据，不记录原始信号、健康记录或认证秘密。

### 数据架构模式

采用保留来源的分层数据架构：

- **原始层：** 厂商忠实的不可变分块、Manifest、授权快照、原始标签和哈希。
- **验证层：** 解码样本与质量指标；损坏或策略失效的会话进入隔离区而非删除。
- **归一化层：** SI 单位、轴校准、时钟对齐、显式缺失掩码与选定重采样率。
- **特征/窗口层：** 模型输入窗口、增强和派生特征，并记录变换版本。
- **数据集发布层：** 不可变的受试者安全训练/验证/测试切分、来源许可、目标设备覆盖和模型用途限制。

每个派生产物记录输入对象哈希、变换代码/版本、参数和输出哈希。公开数据集通过同一注册表进入，并保留来源数据集名称、许可、受试者、传感器位置、原采样率、单位和标签本体。

**时钟模型：** 保存设备单调事件时间、墙钟锚点、接收时间和同步事件；按会话估计偏移与漂移。不得只按墙钟排序，也不得假定请求采样率天然形成均匀网格。

**删除模型：** 通过血缘关联原始会话、归一化派生数据、发布数据集与训练模型资格，使授权或策略变化可以被评估到第一存储层之外。

### 部署与运维架构

分四个受控阶段部署：

1. **记录器实验室版本：** 只支持本地采集/导出，验证传感器能力、采样、时间戳、轴系和电池行为。
2. **试点接入：** 签名上传、不可变原始存储和自动质量报告，不用于生产模型决策。
3. **多厂商适配：** 加入华为适配器和派生记录连接器；vivo 原始适配器只有在门禁通过后才进入。
4. **生产训练/推理：** 数据集发布控制、设备域评估、模型注册、回滚和监控。

运维遥测应包含采集时长、预期/实际样本数、间隙率、时间戳乱序、缓冲区溢出、分块关闭延迟、本地剩余空间、上传重试、校验失败、电量变化、设备/固件以及权限/后台终止原因，但不能包含原始 IMU 数值。

发布门禁按设备和固件管理。新手表型号或固件不会自动继承现有模型覆盖；必须先通过能力、采样质量、能耗、互操作和模型漂移测试。

_总体架构建议：_ 先在已有的 vivo WATCH GT 2 上运行首个可行性切片，同时保留厂商无关的 Port 与规范会话格式。如果 BlueOS 能够提供可用的连续原始 IMU，就把它扩展为首个端到端记录器；如果不能，保留已有工作并把相同契约迁移到 Xiaomi Watch 2/2 Pro。在首个原始适配器稳定后再验证华为。  
_总体置信度：离线优先架构与故障模型为高；跨厂商运维可移植性为中；BlueOS 原始集成为低至中。_

## 实现方法与技术采用

### 技术采用策略

采用**渐进式证据门禁策略**，不同时开发三家平台：

1. **vivo WATCH GT 2 可行性验证：** 使用现有手机与手表，在购买新硬件前验证 BlueOS 开发部署、原始 Sensor API、时间戳、本地存储以及后台/熄屏行为。
2. **条件式 vivo 纵向切片或小米备用路线：** 如果验证通过，在 WATCH GT 2 上实现规范记录器；如果失败，把相同契约迁移到原始传感器与前台服务行为公开可测的 Xiaomi Watch 2/2 Pro。
3. **公开数据适配：** 为 MM-Fit、WISDM、PAMAP2 和可选的 WEAR 建立导入器与血缘，在大规模自采之前建立受试者安全基线。
4. **华为第二个原始适配器：** 先验证本机 Sensor API，再评估 Wear Engine 作为可选手机中继；不得把远程陀螺仪可用性作为前置依赖。
5. **封闭设备支持：** Xiaomi S4 类设备和其他封闭手表只通过派生健康/锻炼记录接入，不能描述为具备原始 IMU 能力。

每个门禁都有明确出口：文档化能力、可构建示例、真机采集、质量报告、能耗报告和上传恢复测试。产品参数页或模拟器结果不足以通过。

### 开发工作流与工具

**Wear OS 实现基线：**

- Kotlin、coroutines、`SensorManager`、health 前台服务、应用私有文件、用于会话/上传元数据的 Room、Protobuf 或经过基准测试的紧凑二进制分块、用于延迟上传的 WorkManager，以及提供锻炼上下文的 Health Services。
- Android Studio 模拟器用于生命周期/UI/权限测试，Xiaomi 真机用于传感器和电池测试。Google 明确说明依赖传感器等硬件功能时需要在物理手表上评估。([Wear OS 调试](https://developer.android.com/training/wearables/get-started/debugging))
- 早期实验室版本使用基于 ADB 的导出和确定性的桌面质量工具。

**华为实现基线：**

- DevEco Studio、ArkTS、本机 Sensor Service 适配器、ArkData/应用沙箱文件、受约束的后台任务集成，以及仅在目标设备文档允许时使用 Network/Remote Communication 或 Wear Engine。
- 按型号、API 级别和固件把能力探测与实测证据写入设备兼容性注册表。

**vivo 工作流：**

- 编码前维护集成问题清单：API 签名、支持传感器、时间戳时钟、采样请求语义、后台寿命、本地配额、RPC 载荷/吞吐、分发审批和设备矩阵。
- 如果获得权限，实现对规范记录器接口的轻量 BlueOS 适配器；不能围绕 BlueOS 专有对象分叉数据模型。

**代码库/CI 工作流：**

- 模块化分离规范 Schema、厂商适配器、分块存储、上传队列、质量工具、公开数据集导入器和模型管线。
- 每次分块格式变更都必须包含 Schema 兼容测试和黄金二进制文件。
- 每次修改运行单元测试；模拟器/仪器测试覆盖生命周期和权限；硬件在环测试按计划或发布门禁运行。
- Gradle 托管设备可以标准化 Android 自动化仪器测试，但不能替代物理传感器验证。([Gradle 托管设备](https://developer.android.com/studio/test/managed-devices))

### 测试与质量保证

测试分层如下：

1. **单元/属性测试：** 状态机、单调排序规则、分块轮转、校验和、恢复、重复处理、解码器模糊测试、单位换算、重采样和标签映射。
2. **模拟器测试：** 权限、前台通知、进程重建、手机配对、Health Services 状态、网络中断和 API 级别行为。Wear OS 提供 Health Services 合成数据用于锻炼流程测试，但不能验证物理 IMU 质量。([Health Services 合成数据](https://developer.android.com/health-and-fitness/health-services/simulated-data))
3. **真机采样测试：** 请求 25/50/100 Hz，在亮屏/熄屏、抬腕、低电量、省电、手机断连/重连、网络恢复、应用/进程中断下运行 10 分钟、30 分钟和 2 小时会话。
4. **参考测试：** 同步外部参考 IMU，执行静态六姿态校准、轴/符号检查、时钟偏移/漂移、动作相关性、量程饱和和噪声底对比。
5. **模型域测试：** 按参与者、设备型号、固件和佩戴手切分；分别评估仅公开数据、目标微调、跨设备、ACC-only 和六轴模型。

**FitnessAI 暂定工程门槛**——这些是建议的产品验收值，不是厂商保证：

| 指标 | 暂定门槛 |
|---|---|
| 时间戳单调性 | 100%；无法解释的乱序事件 = 0 |
| 实际中位采样率 | 与接受的目标偏差不超过 ±5% |
| 样本保留率 | 通过会话内 ≥99.5% |
| 大于两个标称周期的间隙 | ≤0.5%，并全部显式表示 |
| 重复/冲突序列 | 接入后为 0；冲突进入隔离区 |
| 熄屏/手机断连时长 | 2 小时会话完成，或以可见原因失败 |
| 恢复 | 中断会话和上传可恢复且不修改原始数据 |
| 轴/单位验证 | 已知静态姿态和动作通过预期符号/单位检查 |

电量首先按设备、传感器集、采样率、屏幕状态、推理状态和传输状态建立基线曲线。在测量完成前不应规定统一的每小时耗电百分比；产品门槛应由目标锻炼时长和安全余量推导。

### 部署与运维实践

- **实验室渠道：** 本地模式，输出详细质量元数据并支持手工导出。
- **内部试点：** 签名上传、不可变原始存储和自动质量报告，严格执行参与者授权，不形成生产反馈闭环。
- **有限 Beta：** 版本化设备白名单、远程配置接受采样率/分块大小、分阶段发布和记录器快速回滚。
- **生产：** 不可变 Schema 版本、设备/固件门禁、模型注册表、分设备域性能看板、删除/保留流程和事故手册。

运维看板跟踪采样率分布、间隙率、时间戳乱序、溢出、会话终止原因、剩余存储、上传积压/重试/校验失败、电量变化，以及按设备/固件划分的模型结果。日志不得包含原始传感器值。

由于原始对象存储不可变，且派生层可根据记录的变换重建，灾难恢复较直接。应备份 Manifest、血缘、授权状态和数据集注册表，并定期测试重建，而非默认其可用。

### 团队组织与技能

最小试点团队：

- **穿戴/Android 工程师：** Wear OS 生命周期、传感器、前台服务、存储、网络和真机调试。
- **时序/机器学习工程师：** 信号处理、重采样、坐标系、HAR/次数识别、无泄漏评估和域适配。
- **数据/后端工程师：** 可恢复接入、对象存储、幂等、质量任务、血缘、隐私删除和可观测性。
- **产品/隐私负责人：** 研究授权、健康数据 Scope、保留策略、设备合作审批和面向用户的采集行为。

华为和 vivo 阶段还需要相应平台工程与合作渠道能力。原型阶段可由一人承担多个角色，但传感器质量与模型评估应保留独立审查标准。

### 成本优化与资源管理

早期主要成本是真机、固件重复测试、目标域标注会话和厂商合作等待时间，而不是对象存储字节数。

成本控制：

- 从已有的 vivo WATCH GT 2 和 vivo 手机、小型动作分类及本地导出可行性记录器开始；只有 BlueOS 原始传感器门禁失败时才购买小米 Wear OS 手表。
- 使用模拟器/Health Services 合成数据执行确定性应用流程测试，把真机用于传感器、能耗和生命周期测量。
- 会话后或在电量/网络较好时上传关闭并压缩的分块，默认避免 LTE 连续流式传输。
- 原始数据只保留一份并重建派生层，避免无控制的重复导出。
- 只有在法律/研究保留要求和血缘感知删除机制确定后才应用生命周期策略。
- 在规模或组织边界证明必要前，不拆分微服务或引入多云基础设施。

### 风险评估与缓解

| 风险 | 影响 | 缓解措施 |
|---|---|---|
| 公开 API 存在但目标手表限制 | 原始采集不可用或不稳定 | 能力探测、精确 SKU/固件白名单、厂商确认、真机门禁 |
| 后台采集停止 | 会话不完整 | 显式前台/研究会话、本地状态恢复、可见失败原因 |
| 请求频率与交付频率不一致 | 模型域不匹配 | 使用事件时间戳、质量门禁、缺失掩码、实测速率训练增强 |
| 轴/量程/滤波差异 | 跨设备准确率下降 | 静态校准、保留元数据、旋转/量程增强、分设备微调 |
| 公开数据标签不匹配 | 基线误导 | 规范分类法、显式映射、ignore/unknown 类和任务专项评估 |
| 参与者/窗口泄漏 | 指标虚高 | 窗口生成前按组切分，报告参与者/设备/固件留出结果 |
| 把健康平台误当原始数据 | 模型输入无法获得 | 强制分离原始与健康 Schema/API |
| 厂商审批延迟或 BlueOS API 缺口 | 进度延期 | 对 vivo 验证设置时间上限；保留规范契约，并在退出条件失败时切换小米 Wear OS |
| 电池/存储压力 | 用户流失或数据丢失 | 速率 Profile、分块、默认不流式上传、采集前检查空间/电量 |
| 授权或删除失败 | 隐私/合规损害 | 授权快照、血缘注册表、访问审计、经测试的删除流程 |

## 技术研究建议

### 实施路线图

**阶段 0——两至五天：vivo 可行性门禁**

- 更新 vivo WATCH GT 2 固件与 vivo 健康 App，注册 BlueOS 开发者并获取 BlueOS Studio/SDK。
- 在现有设备或可用的测试分发渠道上构建并部署最小手表应用。
- 查找并测试加速度计/陀螺仪订阅、事件时间戳、采样配置、本地文件存储以及熄屏/后台行为。
- 向 `blueos@vivo.com` 提交尚未解决的 Sensor/后台/RPC 问题；Health Kit 记录访问另行联系 `iotpartners@vivo.com`。
- 固化规范 Manifest/分块 Schema 与暂定质量门槛，使成果在需要时可以迁移到 Wear OS。

**阶段 1A——一至两周：vivo 原始采集证明**

- 如果可行性门禁通过，为 WATCH GT 2 构建 ACC+gyro、时间戳、分块文件、导出与桌面质量报告的本地记录器。
- 在承诺完整两小时矩阵前，先完成 10 分钟、30 分钟和熄屏测试。
- 只有原始数据、时间戳、部署与生命周期可用时才进入阶段 1B。

**阶段 1B——四至六周：生产形态记录器或小米备用路线**

- vivo 通过时，强化 BlueOS 记录器并运行完整质量/能耗矩阵。
- vivo 失败时，购置 Xiaomi Watch 2/2 Pro，并用 Wear OS `SensorManager` 和 health 前台服务实现同一规范契约。
- 无论哪种平台，都将健康/锻炼上下文与原始采样分离。

**阶段 2——四至六周：数据集与基线模型**

- 实现公开数据导入、单位、轴系、标签本体、抗混叠重采样、缺失掩码和来源追踪。
- 训练仅公开数据和目标设备微调的 ACC-only/六轴基线。
- 评估参与者、设备、佩戴手和固件留出。

**阶段 3——四至八周：稳健接入试点**

- 增加可恢复签名上传、不可变原始存储、自动质量门禁、隔离区、数据集注册表、授权和删除测试。
- 在小规模授权人群与精选动作上试点。

**阶段 4——按证据门禁扩展厂商**

- 第一个原始适配器稳定后，加入华为本机 Sensor 适配器并比较本机与 Wear Engine 路径。
- 如果 vivo 成功且需要更广泛的可移植性，再把小米 Wear OS 作为第二个平台加入。
- 如果 vivo 原始访问失败，则保留 vivo Health Kit 作为派生记录路径。
- 小米封闭型号仅作为派生记录来源接入。

### 技术栈建议

- **Wear OS：** Kotlin、coroutines、SensorManager、health 前台服务、Room/会话元数据、应用私有二进制分块、WorkManager 上传、Health Services 上下文。
- **华为：** ArkTS、Sensor Service Kit、ArkData/文件存储、允许场景内的 Background Tasks，以及只承载已验证中继能力的 Wear Engine。
- **vivo：** 获批后才实现 BlueOS JS/native 适配器；当前接入 Health Kit 支持的记录。
- **后端：** 模块化会话 API、签名对象上传、不可变对象存储、持久任务队列、关系型元数据/血缘存储、Python 确定性质量/ML 管线或项目既有等价方案。
- **数据：** JSON Manifest + 版本化二进制原始分块；SI 归一化派生表；由注册表管理的数据集与模型产物。

### 公开 IMU 适配计划

1. **清单与来源：** 记录数据集版本、许可、传感器位置、参与者、频率、单位、量程、缺失和标签协议。
2. **数据优先级：** MM-Fit 用于健身动作/次数识别；WISDM 用于消费级手表与 20 Hz 鲁棒性；PAMAP2 用于 100 Hz 多 IMU 活动/强度预训练；WEAR 仅在其加速度计单模态与许可限制适合时用于户外泛化。
3. **不破坏原始数据的单位规范：** 派生数据中加速度统一为 m/s²、陀螺仪为 rad/s；保留原始单位和文件。
4. **频率处理：** 只有在真机可靠交付时才把目标设为 50 Hz。100 Hz 数据先抗混叠再降采样；WISDM 保留为真实 20 Hz 分支，或只为接口形状上采样并明确没有创造新信息。
5. **坐标处理：** 保留原始 XYZ 和模长；应用已知静态校准、佩戴手/表冠元数据、轴置换/符号测试和旋转增强。
6. **标签：** 映射到带显式 `unknown`、过渡、休息和不支持类别的 FitnessAI 分类法；不强制歧义映射。
7. **训练：** 先公开表征预训练，再用较小目标设备数据微调；加入抖动、缺失、频率变化、旋转、幅值/噪声和表带/位置变化。
8. **评估：** 窗口化前按参与者切分；增加设备/固件/佩戴手留出；比较仅公开数据、微调和分设备校准；分别报告 ACC-only 与六轴性能。

WISDM 包含 51 名参与者执行 18 类活动的 20 Hz 手表加速度计和陀螺仪流，采用 CC BY 4.0 许可。([UCI WISDM](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B)) PAMAP2 为 18 类活动提供惯用手腕 100 Hz 研究级 IMU，但参与者更少且与消费级手表存在传感器域差异。([PAMAP2 说明](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf)) MM-Fit 是最接近健身动作记录与次数任务的公开来源。([MM-Fit](https://mmfit.github.io/))

### 技能发展需求

- Android/Wear OS 传感器与生命周期工程
- HarmonyOS ArkTS 与穿戴能力探测
- 时序信号处理和时钟/时间戳诊断
- 人体活动识别、次数识别和受试者安全机器学习评估
- 离线优先数据同步、对象存储和幂等接入
- 健康数据隐私、授权、保留、数据集许可和来源追踪
- 物理实验设计和可复现硬件验收测试

### 成功指标与 KPI

**平台可行性：** 目标 SKU 通过能力、2 小时生命周期、质量、能耗和上传恢复门禁的比例。

**数据质量：** 样本保留率、实际频率误差、间隙分布、时间戳乱序、饱和、校准残差、时钟漂移和隔离会话比例。

**可靠性：** 采集完成率、中断恢复率、上传积压时长、重试次数、校验冲突率和数据丢失事故。

**模型：** 视任务采用参与者留出 F1/MAE、设备留出性能下降、微调增益、ACC-only 与六轴差距、校准负担和拒识/unknown 表现。

**用户/产品：** 会话启动成功率、可见失败率、各 Profile 电量变化、每小时存储量、上传完成时间和权限/授权流失。

**治理：** 来源与授权完整的会话比例、可复现数据集发布、删除测试通过率以及未解决的许可/厂商 Scope 例外。

_实现建议：_ 先批准有时间上限的 vivo WATCH GT 2 可行性验证，因为硬件已经具备。只有原始 Sensor、时间戳、部署与生命周期门禁通过时才继续建设 vivo 记录器；否则迅速切换小米 Wear OS 备用路线。在物理采样和域适配门禁形成证据之前，不承诺生产模型准确率。

## 最终研究综合

### 1. 技术意义与研究方法

FitnessAI 的核心技术风险不是传感器是否存在，而是完整采集契约：应用可部署性、第三方授权、长时生命周期、实际采样行为、时间戳语义、存储可靠性和跨设备模型迁移。本研究使用以下能力—证据阶梯：

1. 官方设备规格；
2. 官方应用/运行时文档；
3. 官方 Sensor/Health/通信 API 行为；
4. 原始公开数据集文档；
5. 对所有未公开属性制定显式真机验收测试。

研究结论按实际置信度表达。高置信结论由官方资料直接支持；中等置信结论依赖目标设备/API Profile；低置信或门禁项不会转化为产品承诺。BlueOS Sensor 细节无法通过公开索引完整读取，被视为待解决的证据缺口，而不是接口不存在的证明。

### 2. 跨平台战略发现

**vivo：** 现有设备改变了经济性。WATCH GT 2 是第一实验对象，但尚不是第一生产平台。其硬件与应用生态已经确认，连续原始 Sensor 访问仍是门禁。Health Kit 可提供派生记录，但不能假定其包含原始三轴序列。

**小米：** Watch 2/2 Pro 是文档最完整的原始采集备用路线。S4 等长续航型号属于独立的封闭产品系列，除非厂商提供私有 SDK，否则只应通过 Mi Fitness/Health Connect 接入。

**华为：** 必须区分智能穿戴、Lite Wearable、本机 Sensor、Wear Engine 和 Health Service。本机 Sensor 是最可能的六轴路径；Wear Engine 是可用的加速度计/手机中继方案，但未公开保证远程陀螺仪或采样 SLA。

**所有厂商：** 产品级健康精度或全天监测宣传不能证明原始波形质量。采样质量是具体型号、固件、请求配置、生命周期状态和传输路径共同决定的实测属性。

### 3. 最终平台决策矩阵

| 平台/路径 | 应用可部署性 | 原始 ACC | 原始 gyro | 长时会话置信度 | 当前角色 |
|---|---:|---:|---:|---:|---|
| vivo WATCH GT 2 BlueOS 应用 | 应用生态已确认；开发部署待验证 | 第三方未确认 | 第三方未确认 | 熄屏测试前为低 | 第一限时可行性对象 |
| vivo Health Kit | 需要审批的手机/生态集成 | 无通用原始流 | 无通用原始流 | 授权记录较高，节奏因类型而异 | 派生健康/锻炼记录 |
| Xiaomi Watch 2/2 Pro Wear OS | 高 | 高 | 高 | 显式前台会话下中高 | 原始采集备用与可移植性参照 |
| Xiaomi S4 类封闭型号 | 无通用第三方手表应用 | 无公开原始路径 | 无公开原始路径 | 不适用 | 仅 Mi Fitness/Health Connect 记录 |
| 华为智能穿戴本机 Sensor API | 依赖目标 Profile/设备 | 可行，需枚举 | 可行，需枚举 | 中，必须真机门禁 | 第二原始适配器候选 |
| 华为 Wear Engine | 需要服务与授权 | 官方确认 | 未公开确认 | 中，依赖传输/设备 | 手机中继与 ACC-only 选项 |
| 华为 Health Service | 授权结构化 API | 无通用原始流 | 无通用原始流 | 支持记录下较高 | 标签、历史和锻炼上下文 |

### 4. 最终数据与模型策略

规范目标形式是带时间戳、版本化的会话和忠实保留厂商数据的原始分块。50 Hz 归一化表示只是候选，不是固定假设；只有真机在样本保留、抖动、能耗和生命周期上可靠交付时才接受。

公开数据优先级按任务划分：

- **MM-Fit：** 健身动作与次数表征的主要来源。
- **WISDM：** 20 Hz 消费级手表加速度计/陀螺仪，可用于低频和抖动鲁棒性；51 名参与者，CC BY 4.0。([UCI WISDM](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B))
- **PAMAP2：** 100 Hz 惯用手腕研究 IMU，适合活动/强度预训练，但参与者更少且消费域较弱。([PAMAP2 说明](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf))
- **WEAR：** 在加速度计单模态及许可约束适合时用于户外活动泛化。

正确学习模式是公开表征预训练，再进行目标设备微调，并执行参与者/设备/固件/佩戴手留出。ACC-only 与六轴模型是不同产品能力，不能作为可互换的评估行。

### 5. 安全、隐私与治理立场

即使不属于医疗级数据，原始运动数据和健康记录仍然敏感。架构通过最小化采集、显式会话、账户身份与假名样本对象分离、授权/来源保留、短期限定上传权限和贯穿数据集/模型资格的变换血缘降低风险。

平台授权只保护其本地边界。一旦 FitnessAI 把记录复制到后端，FitnessAI 必须负责访问、保留、删除、审计和派生数据血缘。Health 平台的设备元数据是有价值的来源信息，但不是密码学证明。

### 6. 实施决策与退出条件

**立即决策：** 执行 vivo 可行性门禁。

**只有以下条件全部满足才继续 vivo：**

- 开发者/测试 BlueOS 应用可以部署到 WATCH GT 2；
- 第三方代码可以订阅原始加速度计和陀螺仪事件；
- 事件时间戳和单位可用，并有文档或实测稳定性；
- 样本能够可靠写入应用本地存储；
- 熄屏会话不会静默终止；
- 数据可以通过获批路径导出或传输。

**任何关键门禁在短期内没有可信厂商解决方案时，退出到小米 Wear OS。** Schema、分块存储、质量工具、数据集管线和模型工作仍然可复用。

### 7. 未来技术展望与创新机会

近期机会是建设设备能力注册表与自适应模型：根据实测设备支持选择六轴、ACC-only 或派生记录特征。中期机会是对授权的未标注腕部运动进行自监督预训练，降低对大规模标注人群的依赖。长期机会包括端侧个性化、联邦或隐私保护式适配，以及在不混淆来源的前提下融合 IMU 与平台锻炼/心率上下文。

厂商操作系统和权限模型会继续变化，因此稳定的规范数据契约与可替换适配器优于隐藏关键采样差异的单一跨平台框架。

### 8. 研究质量、局限与开放问题

**已通过当前公开资料验证：** 设备操作系统、应用商店能力、主要 SDK 家族、Wear OS 后台/速率规则、华为 Wear Engine 列出的传感器、健康记录 API 角色和公开数据集特征。

**尚未通过公开资料建立：** vivo WATCH GT 2 第三方 BlueOS Sensor API 的确切可用性；BlueOS 采样/时间戳/后台/存储/RPC 契约；华为逐型号 ODR 与长时行为；Wear Engine 陀螺仪；Mi Fitness/Health Connect 按 SKU/地区的记录覆盖和节奏；确切能耗与模型迁移结果。

这些不是编辑遗漏，而是物理/合作验证计划的显式输入。目标固件、SDK 权限或厂商答复变化时必须更新报告。

### 9. 主要技术参考

- [vivo WATCH GT 2 参数](https://www.vivo.com.cn/vivo/param/vivowatchgt2)
- [vivo WATCH GT 2 产品与应用商店说明](https://www.vivo.com.cn/vivo/vivowatchgt2/)
- [vivo BlueOS 平台](https://developers.vivo.com/product/blueOS)
- [vivo Health Kit](https://developers.vivo.com/product/d/healthKit)
- [Xiaomi Watch 2](https://www.mi.com/global/product/xiaomi-watch-2/)
- [Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview)
- [Wear OS Health Services](https://developer.android.com/health-and-fitness/health-services)
- [Wear OS Data Layer](https://developer.android.com/training/wearables/data/overview)
- [华为穿戴开发](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/)
- [华为 Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/)
- [UCI WISDM](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B)
- [PAMAP2 文档](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf)
- [MM-Fit](https://mmfit.github.io/)

## 技术研究结论

本研究并未得出 vivo 无法使用的结论。由于 vivo WATCH GT 2 已经拥有，而且官方确认其具备 BlueOS 3.0、IMU 硬件和应用生态，它现在是最合理的第一实验对象。决定性未知是第三方 BlueOS 应用能否获得连续原始 Sensor 访问，以及生命周期和时间行为是否可接受。

FitnessAI 应使用数天而非数周解决这一不确定性。可行性验证成功时，vivo 成为首个记录器平台；失败或长期受阻时，切换小米 Wear OS 备用路线，而不会推翻架构和数据工作。第一个原始适配器稳定后再扩展华为。封闭手表和健康平台仍是有价值的派生记录来源，但不能替代原始 IMU。

**技术研究完成日期：** 2026-07-18  
**研究期间：** 2026-07-17 至 2026-07-18  
**来源核验：** 最新官方厂商/平台文档与原始数据集来源  
**总体置信度：** 架构与平台边界结论为高；华为设备级原始访问为中；vivo 原始访问在 WATCH GT 2 可行性门禁前为低至中
