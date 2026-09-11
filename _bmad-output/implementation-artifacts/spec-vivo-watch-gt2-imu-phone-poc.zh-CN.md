---
title: '验证 vivo WATCH GT2 原始 IMU 到手机链路'
type: 'feature'
created: '2026-07-18'
status: 'in-progress'
baseline_commit: 'NO_VCS'
review_loop_iteration: 0
context:
  - '{project-root}/_bmad-output/planning-artifacts/research/technical-vivo-huawei-xiaomi-smartwatch-sensor-imu-research-2026-07-17.zh-CN.md'
---

<frozen-after-approval reason="human-owned intent — do not modify unless human renegotiates">

## Intent

**Problem:** 在零售版 WATCH GT2 证明第三方 BlueOS 应用能够采集原始加速度计和陀螺仪事件、熄屏存活并把完整会话交付给配对手机之前，FitnessAI 不能承诺 vivo 路线。

**Approach:** 针对 WATCH GT2（`WA2536A`、BlueOS 3.0、`DPD2508AB_A_1.44.5`）和用户报告的 vivo 手机（`Vivo12`、OriginOS 4、Android 14）执行限时 Spike：接入工具链，再构建最小手表记录器、Android 接收器与离线验证器。

## Boundaries & Constraints

**Always:** 只用已安装官方 SDK 的文档化 API；使用原始 Sensor 而非 Health Kit 记录；先持久化再传输；哈希不可变源文件；记录设备/工具版本；同步英文与 `.zh-CN` 文档；先测固件 `1.44.5`。

**Ask First:** 固件更新；付费账号/证书/硬件/商店操作；安全敏感的调试或重置；未文档化 API；替换官方模板；降低 20 Hz 单流门槛。

**Never:** 外推到未测组合；把 Studio 预览视为设备证明；用派生记录替代原始数据；构建识别、计次、生产 UI、云、发布或训练；虚构 BlueOS API。

## I/O & Edge-Case Matrix

| Scenario | Input / State | Expected Output / Behavior | Error Handling |
|----------|---------------|----------------------------|----------------|
| 完整链路 | 已配对；原始流开放 | 会话持久化、到达手机并验证 | 带证据 `PASS` |
| 仅手表 | 采集/存储可用；手机路径失败 | 会话仍可导出 | `PARTIAL`；不得声称完整链路 |
| 能力失败 | 部署、Sensor、时间戳、>=20 Hz 或熄屏失败 | 不生成虚假回退 | 带证据 `NO-GO` |
| 传输中断 | 蓝牙关闭 30 秒 | 重试完成且无重复；哈希一致 | 保留源文件并暴露错误 |

</frozen-after-approval>

## Code Map

- `poc/vivo-watch-gt2/docs/` — 双语接入、设备基线和可行性证据。
- `poc/vivo-watch-gt2/contracts/session.schema.json` — 厂商无关的会话清单和样本契约。
- `poc/vivo-watch-gt2/watch/` — 官方 BlueOS Studio 手表模板以及记录、只追加存储和传输适配器。
- `poc/vivo-watch-gt2/phone/` — 命名空间为 `com.fitnessai.vivopoc` 的最小 Android 14 接收器。
- `poc/vivo-watch-gt2/tools/verify_session.py` 与 `tests/` — 离线质量验证器和夹具。

## Tasks & Acceptance

**Execution:**
- [x] `poc/vivo-watch-gt2/docs/onboarding.md`、`device-baseline.md` 及 `.zh-CN` 副本 — 记录官方 Studio 2.0.5 安装、账号/调试检查、准确版本和 `blueos@vivo.com` 升级路径。
- [x] `poc/vivo-watch-gt2/contracts/session.schema.json` — 定义会话/设备、流、单调时间戳、序列、轴/单位、分块、字节数和 SHA-256。
- [ ] `poc/vivo-watch-gt2/watch/` — 生成官方模板、映射文件、使用文档化 Sensor/存储/通信 API、保存不可变 ACC+gyro 分块并安全重试传输。
- [ ] `poc/vivo-watch-gt2/phone/` — 接收/去重分块，显示计数/哈希，保留并导出会话。
- [x] `poc/vivo-watch-gt2/tools/verify_session.py` 与 `tests/` — 用通过/失败夹具测试 Schema、哈希、序列、时间戳、中位采样率和间隙。
- [ ] `poc/vivo-watch-gt2/docs/feasibility-report.md` 与 `.zh-CN.md` — 记录三次运行并判定 `PASS/PARTIAL/NO-GO`；2–5 个工作日内无可信路径则停止。

**Acceptance Criteria:**
- Given 已安装 BlueOS Studio/SDK 且账号获准调试，when 部署已签名调试构建，then `WA2536A` 能显示唯一 build ID 启动，并保留安装证据。
- Given 已授予 Sensor 权限，when 手表静置 60 秒再旋转 60 秒，then 原始 ACC 和 gyro 各提供三轴、递增序列、单调时间戳、已知单位、>=20 Hz 中位交付、零倒序、无超过一秒的未解释间隙，且样本不少于 `时长 × 20` 的 95%。
- Given 一次 10 分钟记录，when 第二分钟后熄屏且用户返回表盘，then 采集继续，关闭文件在应用重启后仍存在且哈希通过。
- Given 已保存会话并配对 Android 14 手机，when 传输中关闭蓝牙 30 秒再恢复，then 完整会话仅到达一次、收发端哈希一致且不存在重复会话/分块。
- Given 完整流程已通过一次，when 连续执行三次 10 分钟会话，then 三次均完成且没有静默停止、损坏或哈希冲突。

## Spec Change Log

## Design Notes

`PASS` 要求全部条件。`PARTIAL` 表示手表采集/持久化可用但手机传输不可用。部署、原始流、时间戳、20 Hz、熄屏、持久化或验证交付失败均为 `NO-GO`。发布、设备群兼容、续航和模型准确率仍是独立门禁。

## Verification

**Commands:**
- `python -m unittest discover -s poc/vivo-watch-gt2/tests -v` — 预期：全部验证器测试通过。
- `python poc/vivo-watch-gt2/tools/verify_session.py <exported-session-directory>` — 预期：Schema、序列、时间、采样率、间隙和哈希检查通过并以 0 退出。
- `poc\vivo-watch-gt2\phone\gradlew.bat testDebugUnitTest` — 预期：生成官方工程后 Android 接收器单元测试通过。

**Manual checks:** Studio 创建/构建/预览官方模板；零售手表安装并启动构建；证据覆盖静置/运动、熄屏、返回表盘、蓝牙中断、重启和三次重复运行。
