# vivo WATCH GT2 PoC 接入指南

## 目的

本指南用于准备回答一个问题所需的官方工具链：用户零售版 WATCH GT2 上的第三方 BlueOS 应用能否采集原始加速度计和陀螺仪事件，并把完整会话交付给配对的 vivo 手机？安装或预览 BlueOS Studio 不能回答这个问题；必须取得真机部署与 Sensor 证据。

## 已验证的官方入口

- [vivo 开发者专区](https://developers.vivo.com/)
- [BlueOS 开发套件](https://developers.vivo.com/product/blueos/devKit)
- [BlueOS 文档入口](https://developers.vivo.com/product/blueos/doc/common/reference/quickstart/introduction)
- [BlueOS Studio 安装页](https://studio.blueos.com.cn/install/)
- [vivo 开发者支持](https://developers.vivo.com/support/)
- BlueOS 支持邮箱：`blueos@vivo.com`

截至 2026-07-18，公开安装页列出 Windows 版 BlueOS Studio 2.0.5。账号主体要求、实名认证字段、个人开发者资格、设备白名单、签名和零售手表调试无法在未登录状态下公开核验。应以登录后的平台页面为事实来源。

## 阶段 1：账号

1. 打开 vivo 开发者专区并选择 vivo 账号登录入口。
2. 如果没有账号，尽量使用 vivo 手机上正在使用的手机号注册。
3. 只完成登录后页面实际展示的身份或开发者主体步骤。把页面标题和要求记录到 `device-baseline.zh-CN.md`；不得猜测必须是个人还是企业主体。
4. 查找 BlueOS/蓝河应用开发、创建应用、测试分发、证书或设备调试权限入口。
5. 未经确认，不得付费、提交商店应用、重置设备、升级固件或接受仅限企业的协议。

## 阶段 2：Windows 安装

1. 打开 BlueOS Studio 官方安装页。
2. 下载 Windows ZIP。确认下载主机属于 vivo（`vivo.com.cn` 或官方页面当前指向的 vivo 下载域名）。
3. 解压到较短的纯英文本地目录，并把所选位置记录到设备基线中。第一次测试不要放在同步文件夹中。
4. 以普通用户身份运行解压目录中的 Studio 主程序。只有官方安装说明或明确 Windows 错误要求时才使用管理员权限。
5. 把 Studio 和内置 SDK 版本记录到 `device-baseline.zh-CN.md`。

公开下载物是 ZIP，并未确认是 MSI/EXE 安装程序。官方公开页面也没有确定 Windows 最低要求或管理员权限要求。

## 阶段 3：本地冒烟测试

连接手表前：

1. 创建 Studio 提供的最小官方 BlueOS 应用模板。
2. 保持生成的文件名与目录布局不变。
3. 使用当前 Studio 版本展示的构建操作编译模板。
4. 运行 IDE 预览。
5. 保存构建日志、Studio 版本、SDK 版本、模板名称和预览截图。

此处成功只能证明本地工具链可用。

## 阶段 4：登录与真机门禁

1. 保持 `WA2536A` 在手机的 vivo 健康中已配对且处于连接状态。
2. 在手机“关于手机/版本信息”中连续点击“软件版本号”七次以启用开发者选项，然后在“系统管理与升级/开发者选项”中打开“USB 调试”。
3. 使用支持数据传输的 USB 线把手机（不是手表）连接到电脑。如有提示，选择数据传输模式，并在手机上批准这台电脑的 RSA 调试授权。
4. 确认 `adb devices` 中恰好出现一台已授权手机。状态为 `device` 才算手机发现通过；`unauthorized`、`offline` 或空列表都不通过。
5. 不要使用指向 `extension.hapdebug.showWin` 的过期 `Shift+F2` 键位；这是失效的旧绑定，当前安装的调试器没有注册该命令。也不要改用 `extension.hapdebug.start`：该命令只会触发普通编译/模拟器预览流程。真机链路必须使用 BlueOS Studio 顶部工具栏中 tooltip 为 `Debug` 的操作。它会打开“调试设置”、构建 debug RPK，并调用 loader，由 vivo 健康把构建产物中继到已配对手表。
6. 如果 Studio 提示在手机上安装 vivo 调试器/引擎，接受前确认提示来自当前安装的 Studio 与 vivo；不得侧载从其他来源取得的 APK。
7. 保存设备连接结果、构建/安装日志、手表上的应用画面和唯一 build ID。
8. 如果零售版 `WA2536A` 不可见或部署被拒绝，应停止并联系 vivo，不得尝试私有 API、修改固件或重置设备。

## 支持请求模板

主题：`WATCH GT2 WA2536A BlueOS raw IMU feasibility and retail-device debugging`

包含：

- 手表：vivo WATCH GT2 蓝牙版，型号 `WA2536A`
- BlueOS：3.0
- 固件：`DPD2508AB_A_1.44.5`
- 手机：用户报告为 `Vivo12`、OriginOS 4、Android 14；记录后补充准确型号代码
- 已安装的 BlueOS Studio 与 SDK 版本
- 平台页面显示的账号主体
- 问题：零售设备调试资格与配对；原始加速度计/陀螺仪 API；事件时间戳时钟和单位；采样配置；熄屏寿命；本地文件配额；支持的手表到手机文件/RPC 路径

不得在公开工单中附加身份证明文件、密钥、签名材料、Token 或原始 Sensor 数据。

## 完成证据

只有本地模板能够构建/预览，且 vivo 启用或明确拒绝可信的零售设备调试路径时，接入阶段才算完成。只有 `feasibility-report.zh-CN.md` 中的真机验收全部通过，原始 IMU 可行性才得到证明。
