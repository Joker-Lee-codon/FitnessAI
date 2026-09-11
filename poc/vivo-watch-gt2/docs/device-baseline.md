# vivo WATCH GT2 PoC Device Baseline

## Baseline Status

Captured on: 2026-07-18

| Component | Recorded value | Evidence state |
|---|---|---|
| Watch name | vivo WATCH GT2 9C9 | User-reported; screenshot not yet stored |
| Watch edition | Bluetooth | User-reported |
| Watch model | `WA2536A` | User-reported device screen |
| Hardware | `MP_0.1` | User-reported device screen |
| Software | `DPD2508AB_A_1.44.5` | User-reported device screen |
| OS | BlueOS 3.0 | User-reported device screen |
| Phone name | `Vivo12`; model `V2162A`; product `PD2162` | Name user-reported; model/product returned by authorized ADB discovery |
| Phone OS | OriginOS 4 / Android 14 | User-reported |
| vivo Health App | Version not yet recorded | User action required before pairing tests |
| BlueOS Studio | 2.0.5 (archived Windows `user setup`) | Was installed on the previous machine; not migrated or installed on the current Mac; About-page screenshot recorded |
| BlueOS SDK | Bundled with Studio; exact SDK version not yet exposed | Record from build log or SDK manager |
| Developer account | Real-name verification completed | User-confirmed on 2026-07-18 |
| Retail debug access | Phone discovery passed; watch deployment not established | Authorized ADB state `device` recorded on 2026-07-18 |
| Local template | `my-application-1` (archived Windows workspace) | Not present on the current Mac; archived preview displayed `你好，世界`; physical device was not selected |

## Evidence to Add Without Changing the Baseline

Store screenshots outside source control if they contain account or device identifiers. Record only their sanitized filenames and SHA-256 values here. Required evidence is: phone About-device page, watch About-device page, vivo Health App version, Studio About page, SDK version, local build/preview result, account subject/permission result, device discovery result, and any vivo support case ID.

Current Studio evidence: `codex-clipboard-ee93e7c4-0b17-40f2-b78b-7034ff804bff.png`, SHA-256 `523A61C96E9DD07A36DD88D57DB761DB5FCC93F4EC7CC89CB434034CFB07B3E4`. It records BlueOS Studio 2.0.5, simulator `fa8f1c2`, JsFramework `4ef0f2`, and a successful square-watch preview. It does not show a connected phone or watch.

## Firmware Rule

Keep firmware `DPD2508AB_A_1.44.5` for the first run. A firmware update is a separate test baseline and requires approval before installation. Never overwrite results from this baseline with results from another firmware.

## Phone-Name Resolution

The string `Vivo12` is preserved exactly as reported. Authorized ADB discovery identifies the phone as model `V2162A`, product/device `PD2162`; the marketing name still needs confirmation from the phone's About-device page. Android 14 is sufficient for planning the minimal receiver, but it is not a substitute for the confirmed marketing name in final evidence.
