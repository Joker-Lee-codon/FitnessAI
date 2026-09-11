# vivo WATCH GT2 PoC Onboarding

## Purpose

This guide prepares the official toolchain needed to answer one question: can a third-party BlueOS application on the user's retail WATCH GT2 capture raw accelerometer and gyroscope events and deliver an intact session to the paired vivo phone? Installing or previewing BlueOS Studio does not answer that question; physical-device deployment and Sensor evidence do.

## Verified Official Entry Points

- [vivo Developer Portal](https://developers.vivo.com/)
- [BlueOS Development Kit](https://developers.vivo.com/product/blueos/devKit)
- [BlueOS documentation entry](https://developers.vivo.com/product/blueos/doc/common/reference/quickstart/introduction)
- [BlueOS Studio installation page](https://studio.blueos.com.cn/install/)
- [vivo developer support](https://developers.vivo.com/support/)
- BlueOS support email: `blueos@vivo.com`

The public installation page listed BlueOS Studio 2.0.5 for Windows on 2026-07-18. Account-subject requirements, real-name fields, individual-developer eligibility, device whitelisting, signing, and retail-watch debugging were not publicly verifiable without logging in. Treat the logged-in portal as the source of truth.

## Stage 1: Account

1. Open the vivo Developer Portal and select the vivo-account login entry.
2. If no account exists, register with the phone number used on the vivo phone where practical.
3. Complete only the identity or developer-subject steps actually shown after login. Record the page title and requirements in `device-baseline.md`; do not infer whether an individual or enterprise subject is required.
4. Look for BlueOS/Blue River application development, application creation, test distribution, certificate, or device-debug access.
5. Do not pay, submit a store application, reset a device, update firmware, or accept an enterprise-only agreement without asking first.

## Stage 2: Windows Installation

1. Open the official BlueOS Studio installation page.
2. Download the Windows ZIP. Confirm the download host belongs to vivo (`vivo.com.cn` or the official page's current vivo download host).
3. Extract to a short ASCII-only local directory and record the selected location in the device baseline. Do not place the first test copy under a synchronized folder.
4. Start the Studio executable from the extracted directory as a normal user. Use administrator privileges only if the official installer or a specific Windows error requires it.
5. Record the Studio and bundled SDK versions in `device-baseline.md`.

The public download is a ZIP, not a confirmed MSI/EXE installer. The official public page did not establish Windows minimum requirements or a need for administrator privileges.

## Stage 3: Local Smoke Test

Before connecting the watch:

1. Create the smallest official BlueOS application template offered by Studio.
2. Keep its generated filenames and directory layout unchanged.
3. Build the template using the Studio action shown by the installed version.
4. Run IDE preview.
5. Save the build log, Studio version, SDK version, template name, and a preview screenshot.

Success here proves only that the local toolchain works.

## Stage 4: Login and Physical-Device Gate

1. Keep `WA2536A` paired and connected in vivo Health on the phone.
2. On the phone, enable Developer options by tapping Software version seven times under About phone/Version information, then enable USB debugging under System management and upgrade/Developer options.
3. Connect the phone, not the watch, to the PC with a data-capable USB cable. Select a data-transfer mode if prompted and approve the computer's RSA debugging authorization.
4. Confirm exactly one authorized phone appears in `adb devices`. A `device` state passes phone discovery; `unauthorized`, `offline`, or an empty list does not.
5. Do not use the obsolete `Shift+F2` binding to `extension.hapdebug.showWin`; it is a stale binding and the installed debugger does not register that command. Do not substitute `extension.hapdebug.start`: that command only triggers the ordinary compile/emulator-preview flow. For the physical-device path, use the BlueOS Studio top-toolbar action whose tooltip is `Debug`. It opens Debug Settings, builds a debug RPK, and invokes the loader, which uses vivo Health to relay the build to the paired watch.
6. If Studio offers to install its vivo debugger/engine on the phone, verify that the prompt originates from the installed Studio and vivo before accepting it. Do not sideload an APK obtained elsewhere.
7. Capture the device connection result, build/install log, application screen on the watch, and unique build ID.
8. If the retail `WA2536A` is not visible or deployment is rejected, stop and contact vivo rather than trying private APIs, firmware changes, or device resets.

## Support Request Template

Subject: `WATCH GT2 WA2536A BlueOS raw IMU feasibility and retail-device debugging`

Include:

- Watch: vivo WATCH GT2 Bluetooth, model `WA2536A`
- BlueOS: 3.0
- Firmware: `DPD2508AB_A_1.44.5`
- Phone: user-reported `Vivo12`, OriginOS 4, Android 14; include the exact model code after recording it
- Installed BlueOS Studio and SDK versions
- Account subject shown by the portal
- Questions: retail-device debug eligibility and pairing; raw accelerometer and gyroscope APIs; event timestamp clock and units; sampling configuration; screen-off lifetime; local file quota; supported watch-to-phone file/RPC path

Do not attach identity documents, secrets, signing keys, tokens, or raw sensor data to a public ticket.

## Completion Evidence

Onboarding is complete only when the local template builds/previews and vivo either enables or explicitly rejects a credible retail-device debugging path. Raw-IMU feasibility remains unproven until the physical acceptance runs in `feasibility-report.md` pass.
