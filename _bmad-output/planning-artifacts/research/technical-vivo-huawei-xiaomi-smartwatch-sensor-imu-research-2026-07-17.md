---
stepsCompleted: [1, 2, 3, 4, 5, 6]
inputDocuments: []
workflowType: 'research'
lastStep: 6
research_type: 'technical'
research_topic: 'Continuous sensor access, sampling quality, and public IMU dataset adaptation for vivo, Huawei, and Xiaomi smartwatches'
research_goals: 'Assess feasibility for long-duration FitnessAI sensing; compare access constraints, sampling and timestamp quality; determine adaptation requirements for public IMU datasets; recommend a device strategy, integration architecture, and validation plan.'
user_name: 'HP'
date: '2026-07-17'
web_research_enabled: true
source_verification: true
---

# From Existing Hardware to Reliable Sensing: vivo, Huawei, and Xiaomi Smartwatch IMU Technical Research

**Date:** 2026-07-17
**Author:** HP
**Research Type:** technical

---

## Research Overview

This research evaluates continuous sensor access, sampling quality, and public IMU dataset adaptation across vivo, Huawei, and Xiaomi smartwatch ecosystems for FitnessAI. It separates four questions that product pages often blur together: whether hardware contains a sensor, whether third-party applications can access it, whether access survives a user-visible long-running session, and whether delivered samples are sufficiently stable for model training or inference.

The evidence base prioritizes current vendor documentation, official platform documentation, original dataset repositories, and physical-test requirements. The central conclusion is now hardware-aware: begin with a short, evidence-gated feasibility spike on the already-owned vivo WATCH GT 2 and vivo phone. If BlueOS exposes deployable continuous raw IMU access with usable timestamps and lifecycle behavior, promote vivo to the first recorder platform; otherwise, preserve the canonical data contract and switch to Xiaomi Watch 2/2 Pro as the documented Wear OS fallback. See the Executive Summary and Technical Research Conclusion for the final decision framework.

Evidence was collected from 2026-07-17 through 2026-07-18. Device-level rate, jitter, loss, clock, axis, background, and energy characteristics remain subject to the physical acceptance suite defined in this report.

---

<!-- Content will be appended sequentially through research workflow steps -->

## Executive Summary

vivo WATCH GT 2 is not a dead end. vivo officially confirms BlueOS 3.0, accelerometer, gyroscope, an on-watch app store, and application installation/uninstallation. It therefore deserves first priority because the hardware is already available. However, an Android APK cannot simply be installed on the watch: FitnessAI needs a separate BlueOS watch component, and the publicly accessible documentation does not yet prove continuous third-party raw accelerometer/gyroscope access, event-time semantics, requested-rate behavior, or screen-off lifetime. ([vivo WATCH GT 2 specifications](https://www.vivo.com.cn/vivo/param/vivowatchgt2), [vivo WATCH GT 2 product page](https://www.vivo.com.cn/vivo/vivowatchgt2/))

Xiaomi Watch 2/2 Pro remains the strongest technical fallback because Wear OS exposes the Android Sensor Framework and a documented foreground-service model. Huawei is a credible second expansion platform: local HarmonyOS Sensor APIs are the preferred raw path, while Wear Engine officially confirms remote accelerometer, ECG, and PPG but not gyroscope. Xiaomi S4-class closed models, Health Connect, Huawei Health Service, and vivo Health Kit belong to the derived-record plane, not the raw-IMU plane. ([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview), [Huawei Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/), [Health Connect data types](https://developer.android.com/health-and-fitness/health-connect/data-types))

**Final strategic recommendations:**

1. Run a two-to-five-day vivo WATCH GT 2 feasibility gate before purchasing new hardware.
2. Require successful BlueOS deployment, raw ACC+gyro events, usable timestamps, local persistence, and screen-off testing before committing to a vivo recorder.
3. Preserve a vendor-neutral manifest/chunk contract so failure transfers cleanly to Xiaomi Wear OS.
4. Use MM-Fit for gym exercise pretraining, WISDM for consumer-watch/20 Hz robustness, and PAMAP2 for 100 Hz activity representation; then fine-tune and evaluate on target-device data.
5. Treat requested rate as a request, not a guarantee; gate every device/firmware with physical sampling, energy, lifecycle, and model-domain tests.
6. Do not promise multi-vendor raw support or production model accuracy before those gates pass.

## Table of Contents

1. [Technical Research Scope Confirmation](#technical-research-scope-confirmation)
2. [Technology Stack Analysis](#technology-stack-analysis)
3. [Integration Patterns Analysis](#integration-patterns-analysis)
4. [Architectural Patterns and Design](#architectural-patterns-and-design)
5. [Implementation Approaches and Technology Adoption](#implementation-approaches-and-technology-adoption)
6. [Technical Research Recommendations](#technical-research-recommendations)
7. [Final Research Synthesis](#final-research-synthesis)
8. [Technical Research Conclusion](#technical-research-conclusion)

## Technical Research Scope Confirmation

**Research Topic:** Continuous sensor access, sampling quality, and public IMU dataset adaptation for vivo, Huawei, and Xiaomi smartwatches
**Research Goals:** Assess feasibility for long-duration FitnessAI sensing; compare access constraints, sampling and timestamp quality; determine adaptation requirements for public IMU datasets; recommend a device strategy, integration architecture, and validation plan.

**Technical Research Scope:**

- Architecture Analysis - design patterns, frameworks, system architecture
- Implementation Approaches - development methodologies, coding patterns
- Technology Stack - languages, frameworks, tools, platforms
- Integration Patterns - APIs, protocols, interoperability
- Performance Considerations - scalability, optimization, patterns

**Research Methodology:**

- Current web data with rigorous source verification
- Multi-source validation for critical technical claims
- Confidence level framework for uncertain information
- Comprehensive technical coverage with architecture-specific insights

**Scope Confirmed:** 2026-07-17

## Technology Stack Analysis

### Programming Languages

The three vendors do not expose one common smartwatch runtime. The implementation language must therefore follow a device-family split:

- **Huawei smart wearables:** current HarmonyOS smart-wearable applications use **ArkTS**, Huawei's statically constrained TypeScript-derived language. Native components may be introduced when required, but ArkTS is the primary application layer. Huawei's **Lite Wearable** profile is a separate low-power, JavaScript-compatible web-like stack and must not be treated as API-equivalent to smart wearables. ([Huawei ArkTS](https://developer.huawei.com/consumer/en/arkts/), [Huawei wearable development](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/), [Huawei Lite Wearable](https://developer.huawei.com/consumer/cn/multidevice/wearables/lite/))
- **Xiaomi Wear OS models:** Xiaomi Watch 2 and Watch 2 Pro run Wear OS, so the standard stack is **Kotlin/Java** with optional C/C++ through the Android NDK. This is the most portable route for direct access to Android's raw sensor framework. ([Xiaomi Watch 2](https://www.mi.com/global/product/xiaomi-watch-2/), [Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview))
- **Xiaomi non-Wear-OS models:** devices such as the global Xiaomi Watch S4 belong to the Mi Fitness ecosystem and must not be assumed to run third-party Wear OS APKs. Xiaomi's official UK FAQ explicitly states that third-party apps are not supported; the product page's Health Connect interoperability is structured-data exchange, not an open raw-IMU watch-app runtime. ([Xiaomi Watch S4 FAQ](https://www.mi.com/uk/support/faq/details/KA-517264/), [Xiaomi Watch S4](https://www.mi.com/global/product/xiaomi-watch-s4/))
- **vivo BlueOS models:** the public BlueOS development kit describes a web-like JavaScript application model plus JS/native mixed development. BlueOS itself is Rust-based, but that does not mean third-party watch applications are written primarily in Rust. ([BlueOS development kit](https://developers.vivo.com/product/blueos/devKit), [BlueOS kernel](https://developers.vivo.com/product/blueos/kernel))
- **Owned vivo WATCH GT 2:** vivo confirms BlueOS 3.0, accelerometer, gyroscope, an on-watch app store, and app installation/uninstallation. This makes the existing device a valid first feasibility target. It still requires a separate BlueOS watch application rather than reusing an Android APK, and the public product page does not prove that third-party apps receive continuous raw IMU access. ([vivo WATCH GT 2 specifications](https://www.vivo.com.cn/vivo/param/vivowatchgt2), [vivo WATCH GT 2 product page](https://www.vivo.com.cn/vivo/vivowatchgt2/))

_FitnessAI implication:_ isolate the signal-processing core behind a portable contract. Use Kotlin on Wear OS, ArkTS on HarmonyOS, and a BlueOS JS/native adapter only after sensor access is contractually and technically verified.  
_Confidence: High for the platform/language split; medium for the deployability of a common native inference core on every device family._

### Development Frameworks and Libraries

- **Wear OS:** `SensorManager` is the raw accelerometer/gyroscope path. Health Services supplies computed exercise and health metrics and is intentionally optimized for use cases rather than unrestricted raw-IMU capture. `ExerciseClient` is for active workouts, `PassiveMonitoringClient` for long-lived low-frequency results, and `MeasureClient` for short-lived rapid measurements. ([Health Services](https://developer.android.com/health-and-fitness/health-services), [Wear OS compatibility](https://developer.android.com/health-and-fitness/health-services/compatibility))
- **HarmonyOS:** ArkUI, Sensor Service Kit, Background Tasks Kit, ArkData, Network Kit, Remote Communication Kit, and Wear Engine Kit form the relevant framework set. Wear Engine also offers an Android-side SDK for phone-watch communication and advertises accelerometer and ECG/PPG sensor management, but service application and device support must be confirmed. ([HarmonyOS SDK overview](https://developer.huawei.com/consumer/en/harmonyos/develop/), [Wear Engine](https://developer.huawei.com/consumer/en/hms/huawei-wearengine/))
- **BlueOS:** the public SDK overview lists JS/native APIs, file and key-value storage, network capabilities, and cross-device communication. vivo Health Kit is a separate structured health-record exchange surface; its public data inventory does not establish access to raw accelerometer or gyroscope streams. ([BlueOS documentation](https://developers.vivo.com/product/blueos/doc), [vivo Health Kit](https://developers.vivo.com/product/d/healthKit))
- **Public IMU research stack:** MM-Fit is the closest fit for gym exercise and repetition recognition, with dual-wrist 100 Hz accelerometer and gyroscope streams across ten exercise types. WISDM provides consumer-watch accelerometer and gyroscope data from 51 participants at 20 Hz; PAMAP2 provides a dominant-wrist research IMU at 100 Hz plus chest/ankle IMUs and heart rate. These sources are useful for pretraining and pipeline validation, but none is a drop-in calibration source for current consumer watches. ([MM-Fit](https://mmfit.github.io/), [WISDM at UCI](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B), [PAMAP2 at UCI](https://archive.ics.uci.edu/dataset/231/pamap2%2Bphysical%2Bactivity%2Bmonitoring))

_Ecosystem maturity:_ Wear OS is the most open and documented general-purpose route; HarmonyOS is capable but device/service eligibility is material; BlueOS exposes an application SDK, while public raw-sensor guarantees remain incomplete.  
_Confidence: High for Wear OS and published dataset characteristics; medium for Huawei device coverage; low-to-medium for third-party continuous raw IMU on BlueOS._

### Database and Storage Technologies

- **On-watch buffering:** use an append-only binary/columnar session log with monotonic timestamps, sequence numbers, sensor metadata, and checksums. Persist before transmission so Bluetooth or network outages do not destroy training data.
- **Wear OS:** use app-private files or Room for local metadata/session indexes. Google's Data Layer documentation explicitly says Data Layer is a synchronization mechanism, not storage, and recommends keeping an app-owned copy such as a Room database. ([Wear OS data synchronization](https://developer.android.com/training/wearables/data/sync))
- **HarmonyOS:** ArkData and Core File Kit are the native application storage families; Cloud Foundation Kit and Network Kit are available for upstream integration. Exact watch-device support must be checked against the target SDK profile. ([HarmonyOS SDK overview](https://developer.huawei.com/consumer/en/harmonyos/develop/))
- **BlueOS:** public material lists file storage, key-value storage, and data sharing. These are sufficient in principle for a local spool, but capacity, write endurance, quotas, and background flushing behavior require target-device testing. ([BlueOS development kit](https://developers.vivo.com/product/blueos/devKit))
- **Server side:** store immutable raw sessions in object storage and normalized windows/features in an analytical store. Keep raw data, device manifests, labels, and model versions separately versioned to preserve provenance.

_Confidence: High for the recommended architecture; medium for vendor-specific on-watch quotas because public specifications are incomplete._

### Development Tools and Platforms

- **Huawei:** DevEco Studio, HarmonyOS SDK, ArkTS/ArkUI tooling, wearable emulator or target watch, and Huawei's performance-analysis tools. ([Huawei wearable development](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/))
- **Xiaomi Wear OS:** Android Studio, Gradle, ADB, Wear OS emulator, Android Sensor APIs, Health Services samples, and physical Xiaomi Watch 2/2 Pro testing. The emulator is suitable for application flow, not sampling-quality acceptance.
- **vivo:** BlueOS Studio/SDK and a physical BlueOS watch. Public API indexing does not expose enough detail to validate raw IMU behavior without the SDK, account permissions, and hardware. ([BlueOS development kit](https://developers.vivo.com/product/blueos/devKit))
- **Cross-platform data QA:** a common recorder schema plus scripts/notebooks should calculate effective Hz, interval percentiles, timestamp monotonicity, duplicate/out-of-order samples, gaps, saturation, axis orientation, noise floor, and clock drift.

_Testing rule:_ no platform should pass on emulator evidence or product marketing alone; the acceptance artifact must be a captured raw session and reproducible quality report.

### Cloud Infrastructure and Deployment

- **Wear OS:** use direct HTTPS when appropriate or Data Layer for watch-phone synchronization. Data Layer can buffer while disconnected, but a non-urgent `DataItem` can be delayed; it is not the primary network or durable-storage layer. ([Data Layer overview](https://developer.android.com/training/wearables/data/overview), [Data items](https://developer.android.com/training/wearables/data/data-items), [direct network communication](https://developer.android.com/training/wearables/data/network-communication))
- **Huawei:** use Wear Engine/Remote Communication for paired-device exchange and Network Kit or a phone gateway for cloud upload. Wear Engine's official codelab demonstrates application-to-application message/file transfer with matching package identity and certificate configuration. ([Wear Engine codelab](https://developer.huawei.com/consumer/en/codelab/WearEngine/))
- **vivo:** use BlueOS networking/cross-device capabilities or a phone gateway only after throughput, reconnection, background, and quota tests. vivo Health cloud synchronization is appropriate for authorized health records, not assumed to be an arbitrary raw-IMU transport.
- **Recommended topology:** watch recorder → encrypted local spool → resumable phone/cloud upload → immutable raw store → normalization/quality gate → training or inference pipeline. This topology tolerates intermittent connectivity and keeps vendor adapters outside the canonical data model.

_Confidence: High for the architecture and Wear OS behavior; medium for Huawei/vivo transport details pending target-device entitlements and tests._

### Technology Adoption Trends

1. **API abstraction is replacing direct medical/fitness sensor control.** Wear OS Health Services and vendor Health Kits expose curated metrics with power and privacy controls; raw IMU remains a separate, more demanding path.
2. **Background access is becoming more permission-specific.** Wear OS API 36 uses granular health permissions, including `READ_HEALTH_DATA_IN_BACKGROUND` for background body-sensor information. ([Health Services permissions](https://developer.android.com/health-and-fitness/health-services/permissions))
3. **Requested sample rate is not delivered sample rate.** Android explicitly treats the requested delay as a hint, applies rate limits, and requires timestamps to calculate actual delivery rate. ([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview))
4. **Vendor fragmentation remains the dominant engineering risk.** Xiaomi alone spans Wear OS and non-Wear-OS products; Huawei distinguishes smart and lite wearable profiles; vivo's BlueOS model and public sensor documentation are still evolving.
5. **Public datasets are best used for representation pretraining, not final validation.** WISDM's 20 Hz LG G Watch data and PAMAP2's 100 Hz research IMU differ from present watches in sensor transfer function, placement, firmware filtering, timebase, participant population, and activity protocol.

_Decision signal:_ begin with a time-boxed feasibility spike on the already-owned vivo WATCH GT 2. Verify BlueOS development deployment, raw accelerometer/gyroscope subscription, timestamps, local persistence, and screen-off lifetime. If this gate fails, switch to Xiaomi Watch 2/2 Pro as the documented Wear OS fallback. Huawei remains a later parallel vendor-integration track.  
_Overall confidence: Medium-high. The stack comparison is well supported; exact device-level sampling guarantees remain intentionally deferred to the sampling-quality and validation stages._

## Integration Patterns Analysis

### API Design Patterns

FitnessAI needs two deliberately separate API planes:

1. **Raw sensing plane:** session-oriented, high-rate, device-local acquisition of accelerometer/gyroscope events. It must preserve event time, sequence, units, accuracy/status, and gaps.
2. **Health-record plane:** user-authorized exchange of typed workout, heart-rate, step, sleep, and other derived records. It supplies labels and summaries but cannot reconstruct the raw IMU signal.

The raw sensing adapter should expose a small capability-first contract:

```text
queryCapabilities() -> sensors, ranges, resolution, minDelay, batching, permissions
startSession(config) -> sessionId, acceptedConfig
appendEvents(events) -> local durable chunk
stopSession() -> manifest, chunk hashes, quality summary
resumeUpload(sessionId, acknowledgedChunks)
```

Platform implementations are not equivalent:

- **Xiaomi Watch 2/2 Pro:** `SensorManager` is the raw plane; a user-visible health foreground service keeps the workout capture active. Android 9+ does not deliver continuous accelerometer/gyroscope events to an ordinary background app. ([Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview), [foreground service types](https://developer.android.com/develop/background-work/services/fgs/service-types))
- **Huawei smart wearable:** the local Sensor Service Kit / `@ohos.sensor` subscription is the preferred raw plane. Background Tasks Kit supplies constrained execution eligibility; it does not override sensor capability or guarantee indefinite high-rate collection. ([Huawei Sensor API](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-sensor), [Huawei documentation](https://developer.huawei.com/consumer/cn/doc/))
- **vivo BlueOS:** the public portal exposes JS/Native documentation categories, but no publicly verifiable contract was found for raw accelerometer/gyroscope subscriptions, timestamps, requested rates, or background lifetime. This adapter remains a gated integration rather than a committed implementation. ([BlueOS documentation](https://developers.vivo.com/product/blueos/doc))

For cloud integration, use coarse REST resources rather than per-sample requests: `POST /sessions`, resumable chunk upload URLs, `POST /sessions/{id}/complete`, and `GET /sessions/{id}/quality`. gRPC can be used inside the backend, but per-sample watch-to-cloud RPC is rejected because it couples sampling to connectivity and power state.

_Confidence: High for the two-plane design and Wear OS restriction; medium-high for Huawei local integration; low for BlueOS raw-sensor implementation until SDK access._

### Communication Protocols

Four transport patterns cover the realistic paths:

| Path | Best use | Confirmed constraints |
|---|---|---|
| App-local callback | Raw IMU capture | Lowest-latency path; application must buffer and persist events itself. |
| Vendor watch-phone channel | Commands, state, chunk relay | Wear OS Data Layer and Huawei Wear Engine are managed channels, not generic BLE protocols. vivo BlueXLink/RPC lacks publicly verifiable throughput/QoS details. |
| HTTPS from watch/phone | Resumable cloud upload | Decouples backend from vendor phone middleware; schedule uploads to avoid contention with capture. |
| Health platform API | Typed derived records | Health Connect, Huawei Health Service Kit, and vivo Health Kit do not expose a generic raw IMU record type. |

**Wear OS Data Layer:** `DataItem` is synchronized state with a 100 KB payload limit; non-urgent synchronization may be delayed up to about 30 minutes. `Asset` or a channel is more suitable for larger chunks, but Android recommends app-owned storage and existing cloud infrastructure for durable workout history. Data Layer works only with Wear OS and paired Android devices. ([Data items](https://developer.android.com/training/wearables/data/data-items), [Data Layer overview](https://developer.android.com/training/wearables/data/overview), [sync guidance](https://developer.android.com/training/wearables/data/sync))

**Wear OS direct network:** the watch may use HTTP/TCP/UDP; traffic is commonly proxied through the phone while Bluetooth is connected and otherwise uses Wi-Fi/LTE. Google explicitly says not to use Data Layer as the watch's network API. ([Wear OS network communication](https://developer.android.com/training/wearables/data/network-communication))

**Huawei Wear Engine:** the official capability page confirms paired-device status, bidirectional file transfer, and phone-side control/data access for accelerometer, ECG, and PPG. Gyroscope is not listed; it must not be assumed. Service application, Client ID configuration, and user authorization are required. ([Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/), [Wear Engine](https://developer.huawei.com/consumer/en/hms/huawei-wearengine/))

**vivo:** BlueOS publicly advertises file/K-V storage, networking, data sharing, and cross-device capability. The kernel supports TCP/IP and POSIX sockets, but kernel support is not proof that ordinary watch apps receive unrestricted socket access. BlueXLink/RPC must be load-tested before it is assigned a raw-IMU relay role. ([BlueOS development kit](https://developers.vivo.com/product/blueos/devKit), [BlueOS kernel](https://developers.vivo.com/product/blueos/kernel), [BlueOS platform](https://developers.vivo.com/product/blueOS))

_Recommended protocol behavior:_ write 10–60 second chunks locally, hash each chunk, upload asynchronously with idempotency keys, and acknowledge by chunk index. Never hold the only copy in an in-memory message or Bluetooth queue.

### Data Formats and Standards

The canonical raw-event schema should be vendor-neutral and versioned:

```text
session_id, schema_version, device_vendor, device_model, os_version,
app_version, firmware_version, sensor_type, sensor_vendor, sensor_version,
timestamp_device_ns, timestamp_receive_ns, sequence,
x, y, z, unit, accuracy_status, requested_period_us, batch_latency_us
```

- **Manifest:** JSON for inspectability, including permissions granted, wrist side, crown orientation, requested configuration, accepted capabilities, chunk hashes, clock anchors, labels, and missing intervals.
- **Raw chunks:** a compact binary representation such as Protobuf/CBOR or a simple documented packed layout, optionally compressed. CSV is retained only as an export format because its size and weak typing are poor for watch-side persistence.
- **Health records:** preserve the source platform's typed objects and provenance. Health Connect records include UID, modification time, data origin, device metadata, client record ID/version, recording method, and time-zone information. ([Health Connect data format](https://developer.android.com/health-and-fitness/health-connect/data-format))
- **Units:** normalize acceleration to m/s² and angular velocity to rad/s while retaining the original unit/range metadata. Resampling occurs after raw ingestion, never on the acquisition callback.

Health-platform objects remain logically separate from IMU chunks. A workout record may be linked to a raw session by time interval and user/session consent, but a step, pace, or heart-rate record must not be serialized as if it were a raw sensor event.

_Confidence: High for the schema requirements; medium for the specific binary encoding choice, which should be benchmarked on target hardware._

### System Interoperability Approaches

The integration boundary is an **anti-corruption adapter** per device family:

```text
Wear OS SensorManager ─┐
HarmonyOS Sensor API ──┼─> Canonical raw session contract ─> quality gate
BlueOS Sensor API ? ───┘

Health Connect ────────┐
Huawei Health Service ─┼─> Canonical health/workout records ─> label alignment
vivo Health Kit ───────┘
```

- **Xiaomi closed devices:** the publicly supportable path is `watch → Mi Fitness → Health Connect → FitnessAI phone app`. Health Connect stores typed local records, not a table of raw accelerometer/gyroscope samples. Xiaomi's exact record coverage, cadence, and regional behavior require a target-SKU test. ([Xiaomi Watch S4](https://www.mi.com/global/product/xiaomi-watch-s4/), [Health Connect data types](https://developer.android.com/health-and-fitness/health-connect/data-types))
- **Huawei:** Health Service Kit exposes health samples and structured workout/health records, while local Sensor Service is the raw path. Wear Engine is an optional relay whose confirmed remote sensor coverage differs from the local API. ([Huawei Health Service Kit](https://developer.huawei.com/consumer/cn/sdk/health-service-kit/), [Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/))
- **vivo:** the supportable derived path is `watch system algorithms → vivo Health app → Health Service/Health Kit`, under user-granted read/write groups. The public Health Kit inventory includes workouts, steps, distance, pace, heart rate, blood oxygen, ECG, and other records, but not raw tri-axial IMU series. ([vivo Health Kit](https://developers.vivo.com/product/d/healthKit), [vivo Health Kit privacy inventory](https://iot.vivo.com.cn/h5/164/))

Do not build a common abstraction at the vendor API-object level. Normalize only after each adapter has preserved vendor-specific metadata and error states.

### Microservices Integration Patterns

A lean backend can be divided by data responsibility rather than by vendor:

1. **Session service:** consent snapshot, device/app/firmware manifest, lifecycle, labels.
2. **Chunk ingestion service:** signed upload, checksum, deduplication, ordering, quarantine.
3. **Quality service:** rate/jitter/gap/timestamp/axis/saturation checks and acceptance state.
4. **Normalization service:** units, coordinate calibration, clock alignment, resampling, missing mask.
5. **Dataset registry:** subject-safe splits, source licenses, lineage, versioned transformations.
6. **Inference/training service:** model version selection, predictions, and evaluation by device domain.

The external API gateway handles identity, rate limits, and upload issuance. Internal services use idempotent commands and circuit breakers around vendor cloud APIs. There is no distributed transaction across watch, phone, and cloud; session completion is a state machine that tolerates delayed or duplicate chunks.

_Recommended state progression:_ `CREATED → CAPTURING → LOCAL_COMPLETE → UPLOADING → INGESTED → QUALITY_PASSED|QUARANTINED`.

### Event-Driven Integration

Publish immutable domain events after durable state changes:

- `session.created`
- `chunk.received`
- `chunk.verified`
- `session.upload_complete`
- `quality.passed` / `quality.failed`
- `health_record.linked`
- `dataset_version.published`

Consumers must be idempotent using `(session_id, chunk_index, chunk_hash)` and must tolerate out-of-order delivery. Raw object storage is the source of truth; the event stream coordinates processing rather than becoming the only copy of samples. A dead-letter/quarantine path retains corrupt, duplicate-conflicting, consent-invalid, or schema-unknown uploads for investigation.

Real-time WebSocket/MQTT streaming is not the default because FitnessAI's training collection can tolerate seconds of delay and benefits more from integrity and battery efficiency. Live coaching may add a separate, low-bandwidth feature/prediction stream without changing the raw-data durability path.

### Integration Security Patterns

- **Consent and least privilege:** request only the sensor/health scopes needed for the active feature. Health Connect, Huawei Health Service, and vivo Health Kit all require user- or data-type-specific authorization; revocation must stop future reads and trigger retention-policy handling. ([Health Connect data types and permissions](https://developer.android.com/health-and-fitness/health-connect/data-types), [vivo Health Kit](https://developers.vivo.com/product/d/healthKit))
- **Application identity:** Wear OS Data Layer restricts exchange to matching package names and signatures. Huawei Wear Engine requires registered service identity, Client ID, and user authorization. These controls authenticate the application channel but do not replace FitnessAI user/session authorization. ([Data Layer security](https://developer.android.com/training/wearables/data/overview), [Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/))
- **Transport and storage:** use HTTPS/TLS for cloud traffic, app-private encrypted-at-rest session chunks where supported, short-lived scoped upload credentials, per-chunk hashes, and server-side encryption. Do not log raw health payloads or long-lived tokens.
- **Provenance:** retain data origin, device model, firmware, app version, permission state, recording method, and transformation lineage. Health Connect's device field is writer-supplied metadata, not cryptographic attestation.
- **Privacy separation:** keep account identifiers outside raw sample objects; use pseudonymous subject/session IDs and a separately protected linkage table. Enforce deletion and retention at the dataset-registry level so derived datasets and model-training eligibility can be traced.

_Overall integration decision:_ use the existing vivo WATCH GT 2 as the first experimental adapter while keeping the vendor-neutral chunk protocol unchanged. Promote BlueOS to a production raw adapter only if its capability and lifecycle gates pass. Xiaomi Wear OS is the fallback raw-capture baseline; Huawei joins later through a verified local Sensor adapter and optionally Wear Engine.  
_Overall confidence: High for protocol separation and Wear OS behavior; medium for Huawei device-specific coverage; low-to-medium for vivo raw-IMU integration._

## Architectural Patterns and Design

### System Architecture Patterns

The recommended pattern is an **offline-first edge acquisition pipeline**. Sampling must remain correct when the watch has no phone or network connection; local durable storage is the acquisition-time source of truth. This follows Android's offline-first guidance that critical functionality should work without a reliable network and that a persistent local source should own application data. ([Android offline-first architecture](https://developer.android.com/topic/architecture/data-layer/offline-first), [Android data layer](https://developer.android.com/topic/architecture/data-layer))

```text
Watch capability probe
  -> foreground/session-bound raw capture
  -> immutable local chunks + manifest
  -> optional phone gateway or direct HTTPS
  -> immutable raw object store
  -> quality gate
  -> normalization/resampling with lineage
  -> versioned training/evaluation dataset
```

The health-record path is parallel, not embedded in the raw path:

```text
Health Connect / Huawei Health Service / vivo Health Kit
  -> typed record ingestion
  -> provenance and consent checks
  -> interval/session alignment
  -> labels and contextual features
```

**Deployment decision by device family:**

| Device family | Primary architecture | Supported fallback |
|---|---|---|
| Xiaomi Watch 2/2 Pro | `SensorManager → local chunk store → HTTPS or phone gateway` | Health Services and Health Connect summaries |
| Huawei smart wearable | Local Sensor API first; optional Wear Engine relay | Health Service records; Wear Engine accelerometer-only path where appropriate |
| vivo BlueOS watch | Raw path gated by SDK/background/transport verification | vivo Health Kit derived records |
| Xiaomi S4 and other closed models | No public watch-side raw pipeline | `Mi Fitness → Health Connect` records |

_Architectural decision:_ the phone gateway is an optimization and compatibility layer, never the only durable copy. The watch session can complete locally even when the phone disconnects.

### Design Principles and Best Practices

1. **Capability before configuration:** enumerate sensors, ranges, resolution, nominal minimum delay, permissions, and supported background mode before accepting a capture profile.
2. **Event time before arrival time:** keep both device event time and receive time. All resampling, alignment, drift, and gap analysis uses event time.
3. **Persist before transmit:** a chunk becomes uploadable only after it is closed, checksummed, and fsynced/committed to app-private storage.
4. **Raw is immutable:** filtering, axis transformation, resampling, and missing-value treatment create versioned derivatives; they never overwrite raw data.
5. **Vendor adapters preserve differences:** normalize only after retaining device, firmware, sensor vendor/version, units, axis convention, permission state, and error codes.
6. **User-visible capture:** long raw IMU collection is a workout/research session with explicit start/stop and status, not a hidden perpetual background process.
7. **Graceful capability degradation:** support accelerometer-only models and derived-record-only devices rather than fabricating missing gyroscope or waveform inputs.
8. **Single source of truth per layer:** local chunk store during capture, raw object storage after ingestion, and the dataset registry for released training sets. Android's architecture guidance similarly recommends a clearly owned source of truth and unidirectional state changes. ([Android architecture guide](https://developer.android.com/topic/architecture))

The watch application should use hexagonal boundaries: `SensorPort`, `ChunkStorePort`, `UploadQueuePort`, and `HealthContextPort`. Vendor SDK objects remain inside adapters, allowing the capture core and file format to be tested without physical hardware.

### Scalability and Performance Patterns

**On-device performance:**

- Keep the sensor callback minimal: copy timestamp/status/values into a bounded buffer and return.
- Serialize and compress on a worker thread; rotate chunks by time and size.
- Apply backpressure before memory exhaustion. If durable writes fall behind, record an explicit overflow/gap event rather than silently dropping samples.
- Upload outside the sampling critical path, preferably after training, on charging, or under favorable network constraints.
- Maintain separate capture and live-coaching budgets. Live inference may consume short windows, but raw durability remains independent.

**Backend scaling:**

- Upload chunks directly to object storage through short-lived signed URLs, avoiding proxying large payloads through the application API.
- Use multipart/resumable uploads and server-validated checksums for large sessions. Object stores such as S3 support per-part/full-object checksum validation. ([S3 multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html), [presigned upload URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-presigned-url.html))
- Partition processing by `session_id`; quality and normalization jobs are horizontally scalable and deterministic.
- Cache manifests and quality summaries, not raw signal payloads.
- Do not introduce distributed consensus into the sampling path. The session state machine and idempotent chunk keys are sufficient for expected duplication and retry behavior.

**Initial backend topology:** start with a modular monolith for identity/session/manifest APIs, object storage for raw chunks, and a durable task queue for quality/normalization. Split services only when load, ownership, or deployment cadence justifies the operational cost.

### Integration and Communication Patterns

Acquisition and upload use a **store-and-forward** pattern:

1. `startSession` freezes the capability and consent snapshot.
2. Sensor events are appended to the current local chunk.
3. Chunk close writes the header, sample count, time range, missing/overflow markers, and checksum.
4. The upload queue retries with exponential backoff and connectivity/power constraints.
5. Server acknowledgment is persisted locally by `(session_id, chunk_index, hash)`.
6. Local deletion occurs only after the complete session is remotely verified and the retention policy permits it.

Wear OS can drain persistent upload queues with WorkManager, but WorkManager executes after constraints are met and each worker has a bounded runtime; it is an upload scheduler, not a sensor-capture engine. ([WorkManager](https://developer.android.com/reference/androidx/work/WorkManager.html), [offline queue guidance](https://developer.android.com/topic/architecture/data-layer/offline-first))

**Failure handling:**

| Failure | Required behavior |
|---|---|
| Phone/network disconnect | Continue local capture; queue closed chunks. |
| Process/service termination | Recover manifest and last valid chunk boundary; mark session interrupted. |
| Partial/corrupt upload | Reject by checksum and retry the same immutable chunk. |
| Duplicate upload | Return the existing acknowledgment when hash matches; quarantine conflicting content. |
| Clock jump/drift | Preserve raw clocks and anchors; correct only in derived data. |
| Storage pressure | Warn/stop safely before exhaustion; never silently evict unverified sessions. |
| Permission revoked | Stop the affected stream, close the session with a reason, and enforce data policy. |
| Unsupported sensor | Select a declared fallback model or reject the capture profile. |

### Security Architecture Patterns

Security follows **least privilege, short-lived authority, and provenance by construction**:

- Use app-private storage and platform sandboxing for local chunks; encrypt sensitive persisted data where the platform and threat model require it.
- Enforce HTTPS/TLS and explicitly disallow cleartext traffic. Android Network Security Configuration supports cleartext opt-out, trust configuration, and certificate-transparency controls. ([Android Network Security Configuration](https://developer.android.com/privacy-and-security/security-config))
- Issue short-lived, object-scoped upload URLs or tokens; the watch never receives general cloud credentials.
- Bind upload permission to user, device installation, session, chunk index, expected size, and checksum.
- Separate pseudonymous subject/session identifiers from account identity in a more restricted linkage store.
- Persist consent/permission snapshots and data origin with each session. Revocation stops future acquisition/access and triggers the documented retention/deletion workflow.
- Verify app/device integrity where supported, but treat vendor and Health Connect device metadata as provenance claims rather than cryptographic proof.
- Log metadata-level audit events without logging raw signals, health records, or authentication secrets.

### Data Architecture Patterns

Use a provenance-preserving layered data architecture:

- **Raw layer:** immutable vendor-faithful chunks, manifest, consent snapshot, labels as originally received, and hashes.
- **Validated layer:** decoded samples plus quality metrics, with corrupt or policy-invalid sessions quarantined rather than deleted.
- **Normalized layer:** SI units, calibrated axes, clock alignment, explicit missing mask, and chosen resampling rate.
- **Feature/window layer:** model-ready windows, augmentations, and derived features with transformation version.
- **Dataset release layer:** immutable subject-safe train/validation/test splits, source licenses, target-device coverage, and model-use constraints.

Every derived artifact records input object hashes, transformation code/version, parameters, and output hash. Public datasets enter through the same registry and preserve source dataset name, license, subject, sensor position, original sample rate, units, and label ontology.

**Clock model:** retain device monotonic event time, wall-clock anchor, receive time, and synchronization events. Estimate offset and drift per session. Never sort solely by wall time or assume requested rate creates a uniform grid.

**Deletion model:** raw sessions, normalized derivatives, released datasets, and trained-model eligibility must be linked through lineage so that consent or policy changes can be evaluated beyond the first storage layer.

### Deployment and Operations Architecture

Deploy in four controlled stages:

1. **Recorder laboratory build:** local capture/export only; validate sensor capabilities, sampling, timestamps, axes, and battery behavior.
2. **Pilot ingestion:** signed uploads, immutable raw store, automated quality report, no production model decisions.
3. **Multi-vendor adaptation:** Huawei adapter and derived-record connectors; vivo raw adapter only after its gate passes.
4. **Production learning/inference:** dataset release controls, device-domain evaluation, model registry, rollback, and monitoring.

Operational telemetry must track capture duration, expected/observed samples, gap rate, timestamp disorder, buffer overflow, chunk-close latency, local free space, upload retries, checksum failures, battery delta, device/firmware, and permission/background termination reason. It must not contain raw IMU values.

Release gates are device/firmware-specific. A new watch model or firmware is not automatically covered by an existing model; it first runs capability, sampling-quality, energy, interoperability, and model-drift tests.

_Overall architectural recommendation:_ run the first feasibility slice on the already-owned vivo WATCH GT 2, retaining vendor-neutral ports and the canonical session format. If BlueOS exposes usable continuous raw IMU, expand that slice into the first end-to-end recorder. If it does not, preserve the work and move the same contract to Xiaomi Watch 2/2 Pro. Validate Huawei after the first raw adapter is established._  
_Overall confidence: High for the offline-first architecture and failure model; medium for cross-vendor operational portability; low-to-medium for BlueOS raw integration._

## Implementation Approaches and Technology Adoption

### Technology Adoption Strategies

Use a **graduated evidence-gate strategy**, not a simultaneous three-vendor build:

1. **vivo WATCH GT 2 feasibility spike:** use the existing phone/watch pair to verify BlueOS development deployment, raw Sensor APIs, timestamps, local storage, and background/screen-off behavior before buying hardware.
2. **Conditional vivo vertical slice or Xiaomi fallback:** if the spike passes, implement the canonical recorder on WATCH GT 2. If it fails, move the same contract to Xiaomi Watch 2/2 Pro, whose Wear OS raw sensor and foreground-service behavior is publicly testable.
3. **Public-data adaptation:** build importers and lineage for MM-Fit, WISDM, PAMAP2, and optionally WEAR; establish subject-safe baselines before collecting large proprietary data.
4. **Huawei second raw adapter:** validate local Sensor API first, then evaluate Wear Engine as an optional phone relay. Do not make remote gyroscope availability a dependency.
5. **Closed-device support:** connect Xiaomi S4-class devices and other closed watches only through derived health/workout records; do not represent them as raw-IMU-capable.

Each gate has an explicit exit: documented capability, buildable sample, physical-device capture, quality report, energy report, and upload recovery test. A product page or emulator result is insufficient.

### Development Workflows and Tooling

**Wear OS implementation baseline:**

- Kotlin, coroutines, `SensorManager`, a health foreground service, app-private files, Room for session/upload metadata, Protobuf or a benchmarked compact binary chunk, WorkManager for deferred upload, and Health Services for workout context.
- Android Studio emulator for lifecycle/UI/permission tests and a physical Xiaomi watch for sensor and battery tests. Google explicitly notes that physical watches are needed to evaluate hardware-specific features such as sensors. ([Wear OS debugging](https://developer.android.com/training/wearables/get-started/debugging))
- ADB-based export and deterministic desktop quality tooling for early laboratory builds.

**Huawei implementation baseline:**

- DevEco Studio, ArkTS, local Sensor Service adapter, ArkData/app sandbox files, constrained background-task integration, Network/Remote Communication or Wear Engine only where target-device documentation allows.
- Capability probes and captured evidence are checked into a device-compatibility registry by model, API level, and firmware.

**vivo workflow:**

- Maintain an integration-question ledger before coding: API signatures, supported sensor types, timestamp clock, sampling request semantics, background lifetime, local quotas, RPC payload/throughput, distribution approval, and device matrix.
- If access is granted, implement a thin BlueOS adapter against the canonical recorder contract; do not fork the data model around BlueOS-specific objects.

**Repository/CI workflow:**

- Separate modules for the canonical schema, vendor adapters, chunk store, upload queue, quality tooling, public-dataset importers, and model pipelines.
- Schema compatibility tests and golden binary files are mandatory for every chunk-format change.
- Unit tests run on every change; emulator/instrumented tests cover lifecycle and permissions; hardware-in-the-loop suites run on scheduled or release gates.
- Gradle build-managed devices can standardize automated Android instrumented tests, but do not replace physical sensor verification. ([Gradle-managed devices](https://developer.android.com/studio/test/managed-devices))

### Testing and Quality Assurance

Testing is layered:

1. **Unit/property tests:** state machine, monotonic ordering rules, chunk rotation, checksum, resume, duplicate handling, decoder fuzzing, unit conversion, resampling, and label mapping.
2. **Emulator tests:** permissions, foreground notification, process recreation, phone pairing, Health Services states, network loss, and API-level behavior. Wear OS provides synthetic Health Services data for exercise-flow testing, but it does not validate physical IMU quality. ([Health Services simulated data](https://developer.android.com/health-and-fitness/health-services/simulated-data))
3. **Physical-device sampling tests:** request 25/50/100 Hz and run 10-minute, 30-minute, and 2-hour sessions across screen-on/off, wrist raise, low battery, power saving, phone disconnect/reconnect, network recovery, and app/process interruption.
4. **Reference tests:** synchronize a reference IMU for static six-pose calibration, axis/sign checks, clock offset/drift, motion correlation, range saturation, and noise-floor comparison.
5. **Model-domain tests:** split by participant, device model, firmware, and wrist. Evaluate public-only, target fine-tuned, cross-device, ACC-only, and six-axis models separately.

**Provisional FitnessAI engineering gates**—these are proposed product acceptance values, not vendor guarantees:

| Metric | Provisional gate |
|---|---|
| Timestamp monotonicity | 100%; unexplained out-of-order events = 0 |
| Median effective rate | within ±5% of the accepted target |
| Retained samples | ≥99.5% over an accepted session |
| Gaps longer than 2 nominal periods | ≤0.5% of intervals, all explicitly represented |
| Duplicate/conflicting sequence | 0 after ingestion; conflicts quarantined |
| Screen-off/phone-disconnected duration | 2-hour session completes or fails visibly with reason |
| Recovery | interrupted session and upload recover without raw-data mutation |
| Axis/unit verification | known static poses and motions pass expected sign/unit checks |

Battery is first measured as a baseline curve by device, sensor set, rate, screen state, inference state, and transport state. A single universal percentage-per-hour threshold should not be set before these measurements; the product gate is derived from the required workout duration plus safety margin.

### Deployment and Operations Practices

- **Laboratory channel:** local-only build with verbose quality metadata and manual export.
- **Internal pilot:** signed upload, immutable raw store, automatic quality report, strict participant consent, no production feedback loop.
- **Limited beta:** versioned device allowlist, remote configuration for accepted rates/chunk sizes, staged rollout, and rapid recorder rollback.
- **Production:** immutable schema versions, device/firmware gates, model registry, per-domain performance dashboards, deletion/retention workflows, and incident runbooks.

Operational dashboards track sample-rate distribution, gap rate, timestamp disorder, overflow, session termination reason, free storage, upload age/retries/checksum failures, battery delta, and model outcomes by device/firmware. Raw sensor values are not included in logs.

Disaster recovery is straightforward because raw object storage is immutable and derived layers are reproducible from recorded transformations. Back up manifests, lineage, consent state, and dataset registry; routinely test reconstruction rather than assuming it.

### Team Organization and Skills

Minimum pilot team:

- **Wearable/Android engineer:** Wear OS lifecycle, sensors, foreground services, storage, networking, and physical-device debugging.
- **Time-series/ML engineer:** signal processing, resampling, coordinate systems, HAR/rep counting, leakage-safe evaluation, and domain adaptation.
- **Data/backend engineer:** resumable ingestion, object storage, idempotency, quality jobs, lineage, privacy deletion, and observability.
- **Product/privacy owner:** research consent, health-data scopes, retention, device-partner approvals, and user-facing capture behavior.

Huawei and vivo phases additionally need platform-specific engineering and partner-channel capacity. One person can cover multiple roles in a prototype, but sensor QA and ML evaluation must retain independent review criteria.

### Cost Optimization and Resource Management

The dominant early costs are physical devices, repeated firmware tests, labeled target-domain sessions, and partner integration delay—not object-storage bytes.

Cost controls:

- Start with the existing vivo WATCH GT 2 and vivo phone, a small exercise taxonomy, and a local-export feasibility recorder. Buy a Xiaomi Wear OS watch only if the BlueOS raw-sensor gate fails.
- Use emulator/synthetic Health Services data for deterministic application-flow tests, reserving physical watches for sensor, energy, and lifecycle measurements.
- Upload closed compressed chunks after sessions or under favorable power/network conditions; avoid continuous LTE streaming.
- Retain raw data once and reproduce derived layers; do not create uncontrolled duplicate exports.
- Apply lifecycle policies only after legal/research retention requirements and lineage-aware deletion are defined.
- Delay microservice decomposition and multi-cloud infrastructure until scale or organizational boundaries justify them.

### Risk Assessment and Mitigation

| Risk | Impact | Mitigation |
|---|---|---|
| Public API exists but target watch blocks/limits it | Raw capture unavailable or unstable | Capability probe, exact SKU/firmware allowlist, partner confirmation, physical gate |
| Background collection stops | Incomplete sessions | Explicit foreground/research session, local state recovery, visible failure reason |
| Requested rate differs from delivered rate | Model mismatch | Use event timestamps, quality gate, missing mask, measured-rate training augmentation |
| Axis/range/filter differences | Cross-device accuracy loss | Static calibration, metadata retention, rotation/range augmentation, per-device fine-tune |
| Public-data label mismatch | Misleading baseline | Canonical taxonomy with explicit mappings, ignore/unknown class, task-specific evaluation |
| Participant/window leakage | Inflated metrics | Group splits before window generation; report participant/device/firmware holdouts |
| Health platform mistaken for raw data | Impossible model input | Enforce separate raw and health schemas/APIs |
| Vendor approval or BlueOS API gap | Schedule slip | Time-box the vivo spike; preserve the canonical contract and switch to Xiaomi Wear OS when the exit criteria fail |
| Battery/storage pressure | User abandonment or data loss | Rate profiles, chunking, no streaming by default, preflight free-space/battery checks |
| Consent or deletion failure | Privacy/compliance harm | Consent snapshots, lineage-aware registry, access audit, tested deletion workflow |

## Technical Research Recommendations

### Implementation Roadmap

**Phase 0 — two to five days: vivo feasibility gate**

- Update the vivo WATCH GT 2 firmware and vivo Health app; register for BlueOS development and obtain BlueOS Studio/SDK access.
- Build and deploy a minimal watch application to the owned device or the available test-distribution channel.
- Locate and test accelerometer/gyroscope subscription, event timestamps, sampling configuration, local file storage, and screen-off/background behavior.
- Contact `blueos@vivo.com` with the exact unresolved Sensor/background/RPC questions; contact `iotpartners@vivo.com` separately for Health Kit record access.
- Freeze the canonical manifest/chunk schema and provisional quality gates so the work transfers to Wear OS if needed.

**Phase 1A — one to two weeks: vivo raw-capture proof**

- If the feasibility gate passes, build a local-only WATCH GT 2 recorder for ACC+gyro, timestamps, chunk files, export, and desktop quality reporting.
- Run 10-minute, 30-minute, and screen-off tests before committing to the full two-hour matrix.
- Exit to Phase 1B only if raw data, timestamps, deployment, and lifecycle are usable.

**Phase 1B — four to six weeks: production-shaped recorder or Xiaomi fallback**

- If vivo passes, harden the BlueOS recorder and run the complete quality/energy matrix.
- If vivo fails, acquire Xiaomi Watch 2/2 Pro and implement the same canonical contract with Wear OS `SensorManager` and a health foreground service.
- Keep health/workout context separate from raw sampling on either platform.

**Phase 2 — four to six weeks: dataset and baseline models**

- Implement public-dataset importers, units, axes, label ontology, anti-aliased resampling, missing masks, and provenance.
- Train public-only and target-fine-tuned ACC-only/six-axis baselines.
- Evaluate participant, device, wrist, and firmware holdouts.

**Phase 3 — four to eight weeks: robust ingestion pilot**

- Add resumable signed uploads, immutable raw store, automated quality gate, quarantine, dataset registry, consent, and deletion test.
- Pilot with a small consented cohort and selected exercises.

**Phase 4 — vendor expansion by evidence gate**

- Add Huawei local Sensor adapter and compare local and Wear Engine paths after the first raw adapter is stable.
- Add Xiaomi Wear OS as a second platform if vivo succeeded and broader portability is required.
- If vivo raw access failed, retain vivo Health Kit as the derived-record path.
- Add closed Xiaomi models only as derived-record sources.

### Technology Stack Recommendations

- **Wear OS:** Kotlin, coroutines, SensorManager, health foreground service, Room/session metadata, app-private binary chunks, WorkManager upload, Health Services context.
- **Huawei:** ArkTS, Sensor Service Kit, ArkData/file storage, Background Tasks under allowed scenarios, Wear Engine only for verified relay capabilities.
- **vivo:** BlueOS JS/native adapter only after approval; Health Kit connector for supported records now.
- **Backend:** modular session API, signed object upload, immutable object storage, durable job queue, relational metadata/lineage store, Python-based deterministic quality/ML pipeline or the project's established equivalent.
- **Data:** JSON manifest plus versioned binary raw chunks; SI-normalized derived tables; registry-managed datasets and model artifacts.

### Public IMU Adaptation Plan

1. **Inventory and provenance:** record dataset version, license, sensor placement, subjects, rates, units, ranges, missingness, and label protocol.
2. **Dataset priority:** MM-Fit for gym exercise/rep counting; WISDM for consumer-watch and 20 Hz robustness; PAMAP2 for 100 Hz multi-IMU activity/intensity pretraining; WEAR for outdoor/generalization where its accelerometer-only and license constraints fit.
3. **Canonical units without destroying raw:** acceleration m/s² and gyro rad/s in derived data; keep original units and files.
4. **Rate handling:** target 50 Hz only if physical watches deliver it reliably. Downsample 100 Hz with anti-alias filtering; keep WISDM as a genuine 20 Hz branch or upsample only for interface shape while acknowledging no new information is created.
5. **Coordinate handling:** retain raw XYZ and magnitude; apply known static calibration, wrist/crown metadata, axis permutation/sign tests, and rotation augmentation.
6. **Labels:** map sources into a FitnessAI taxonomy with explicit `unknown`, transition, rest, and unsupported classes; never force ambiguous mappings.
7. **Training:** public representation pretraining followed by a smaller target-device fine-tune; include jitter, missing samples, rate variation, rotation, scale/noise, and strap/placement variation.
8. **Evaluation:** split by participant before windowing; add device/firmware/wrist holdouts; compare public-only, fine-tuned, and per-device calibration; report ACC-only and six-axis performance separately.

WISDM contains 51 participants performing 18 activities with 20 Hz smartwatch accelerometer and gyroscope streams and is licensed CC BY 4.0. ([WISDM UCI](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B)) PAMAP2 supplies a dominant-wrist 100 Hz research IMU across 18 activities but with a much smaller participant set and research-grade sensor domain. ([PAMAP2 description](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf)) MM-Fit is the closest public source for gym exercise logging and repetition-oriented work. ([MM-Fit](https://mmfit.github.io/))

### Skill Development Requirements

- Android/Wear OS sensor and lifecycle engineering
- HarmonyOS ArkTS and wearable capability profiling
- Time-series signal processing and clock/timestamp diagnostics
- Human activity recognition, repetition counting, and subject-safe ML evaluation
- Offline-first data synchronization, object storage, and idempotent ingestion
- Health-data privacy, consent, retention, dataset licensing, and provenance
- Physical experiment design and reproducible hardware acceptance testing

### Success Metrics and KPIs

**Platform feasibility:** percentage of target SKUs passing capability, 2-hour lifecycle, quality, energy, and upload-recovery gates.

**Data quality:** retained sample rate, effective-rate error, gap distribution, timestamp disorder, saturation, calibration residual, clock drift, and quarantined-session rate.

**Reliability:** capture completion rate, interrupted-session recovery rate, upload age, retry count, checksum conflict rate, and data-loss incidents.

**Model:** participant-held-out F1/MAE as appropriate, device-held-out degradation, post-fine-tune gain, ACC-only gap versus six-axis, calibration burden, and rejection/unknown performance.

**User/product:** session start success, visible failure rate, battery delta by profile, storage consumed per hour, upload completion time, and permission/consent drop-off.

**Governance:** sessions with complete provenance and consent, reproducible dataset releases, deletion-test pass rate, and unresolved license/vendor-scope exceptions.

_Implementation recommendation:_ authorize a time-boxed vivo WATCH GT 2 feasibility spike first because the hardware is already available. Continue into a vivo recorder only if raw Sensor, timestamp, deployment, and lifecycle gates pass; otherwise switch promptly to the Xiaomi Wear OS fallback. Do not commit to production model accuracy until physical sampling and domain-adaptation gates produce evidence._

## Final Research Synthesis

### 1. Technical Significance and Methodology

FitnessAI's core technical risk is not sensor presence but the full acquisition contract: application deployability, third-party authorization, long-running lifecycle, delivered sampling behavior, timestamp semantics, storage reliability, and cross-device model transfer. The research therefore used a capability-to-evidence ladder:

1. official device specification;
2. official application/runtime documentation;
3. official Sensor/Health/communication API behavior;
4. original public dataset documentation;
5. explicit physical acceptance tests for every unpublished property.

Claims are labeled by practical confidence. High-confidence claims are directly documented by official sources. Medium-confidence claims depend on target-device/API-profile coverage. Low-confidence or gated claims are not converted into product commitments. The absence of publicly indexable BlueOS Sensor details is treated as an unresolved evidence gap, not proof that the API does not exist.

### 2. Cross-Platform Strategic Findings

**vivo:** Existing ownership changes the economics. WATCH GT 2 is the first experiment, not yet the first production platform. Its hardware and app ecosystem are confirmed; raw continuous Sensor access remains the gate. Health Kit can support derived records but cannot be assumed to provide raw tri-axial streams.

**Xiaomi:** Watch 2/2 Pro is the best documented fallback for raw capture. S4 and similar long-battery devices are separate closed-product families and should be integrated only through Mi Fitness/Health Connect unless a private SDK is supplied.

**Huawei:** Separate smart wearable, Lite Wearable, local Sensor, Wear Engine, and Health Service paths. The local Sensor path is the most plausible six-axis route; Wear Engine is a useful accelerometer/phone-relay option but does not publicly guarantee remote gyroscope or sampling SLA.

**All vendors:** Product-level health accuracy or all-day monitoring claims do not establish raw waveform quality. Sampling quality is a measured property of the exact model, firmware, requested configuration, lifecycle state, and transport path.

### 3. Final Platform Decision Matrix

| Platform/path | App deployability | Raw ACC | Raw gyro | Long-session confidence | Current role |
|---|---:|---:|---:|---:|---|
| vivo WATCH GT 2 BlueOS app | Confirmed app ecosystem; developer deployment to verify | Unconfirmed for third parties | Unconfirmed for third parties | Low until screen-off test | First, time-boxed feasibility target |
| vivo Health Kit | Phone/ecosystem integration with approval | No generic raw stream | No generic raw stream | High for authorized records, cadence varies | Derived health/workout records |
| Xiaomi Watch 2/2 Pro Wear OS | High | High | High | Medium-high with explicit foreground session | Raw-capture fallback and portability reference |
| Xiaomi S4-class closed model | No general third-party watch app | No public raw path | No public raw path | Not applicable | Mi Fitness/Health Connect records only |
| Huawei local smart-wearable Sensor API | Target profile/device dependent | Plausible; enumerate | Plausible; enumerate | Medium, physical gate required | Second raw adapter candidate |
| Huawei Wear Engine | Service/authorization required | Officially confirmed | Not publicly confirmed | Medium, transport/device dependent | Phone relay and ACC-only option |
| Huawei Health Service | Authorized structured API | No generic raw stream | No generic raw stream | High for supported records | Labels, history, workout context |

### 4. Final Data and Model Strategy

The canonical target representation is a timestamped, versioned session with raw vendor-faithful chunks. A 50 Hz normalized representation is a candidate, not a fixed assumption. The target is accepted only if physical devices deliver it with adequate retention, jitter, energy, and lifecycle behavior.

Public-data priority is task-specific:

- **MM-Fit:** primary source for gym exercise and repetition-oriented representation.
- **WISDM:** consumer-watch accelerometer/gyroscope at 20 Hz and useful low-rate/jitter robustness; 51 participants and CC BY 4.0. ([WISDM UCI](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B))
- **PAMAP2:** dominant-wrist 100 Hz research IMU for activity/intensity pretraining, with a smaller and less consumer-like domain. ([PAMAP2 description](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf))
- **WEAR:** outdoor activity generalization where accelerometer-only input and its license constraints fit.

The correct learning pattern is public representation pretraining followed by target-device fine-tuning and participant/device/firmware/wrist holdouts. ACC-only and six-axis models are separate product capabilities, not interchangeable evaluation rows.

### 5. Security, Privacy, and Governance Position

Raw motion data and health records are sensitive even when they are not medical-grade. The architecture minimizes collection, uses explicit sessions, separates account identity from pseudonymous sample objects, preserves consent and origin, uses short-lived scoped upload authority, and retains transformation lineage through dataset releases and model eligibility.

Platform authorization protects only its local boundary. Once FitnessAI copies records to its backend, FitnessAI becomes responsible for access, retention, deletion, audit, and derived-data lineage. Health platform device metadata is useful provenance but not cryptographic attestation.

### 6. Implementation Decision and Exit Criteria

**Immediate decision:** proceed with the vivo feasibility gate.

**Continue on vivo only if all are true:**

- a developer/test BlueOS app can be deployed to WATCH GT 2;
- third-party code can subscribe to raw accelerometer and gyroscope events;
- event timestamps and units are usable and documented or empirically stable;
- samples can be durably written to local app storage;
- a screen-off session completes without silent termination;
- the data can be exported or transmitted through an approved path.

**Exit to Xiaomi Wear OS if any critical gate is blocked without a credible short-term vendor resolution.** The schema, chunk store, quality tooling, dataset pipeline, and model work remain reusable.

### 7. Future Technical Outlook and Innovation Opportunities

Near-term opportunity lies in a device-capability registry and adaptive models: select six-axis, ACC-only, or derived-record features according to measured device support. Medium-term opportunity is self-supervised pretraining on consented unlabeled wrist motion, reducing dependence on large labeled cohorts. Longer-term opportunity includes on-device personalization, federated or privacy-preserving adaptation, and combining IMU with platform-derived workout/heart-rate context without conflating their provenance.

Vendor operating systems and permission models will continue to evolve. This favors stable canonical data contracts and replaceable adapters over a single cross-platform framework that hides critical sampling differences.

### 8. Research Quality, Limitations, and Open Questions

**Verified through current public sources:** device operating systems, app-store capability, major SDK families, Wear OS background/rate rules, Huawei Wear Engine listed sensors, health-record API roles, and public dataset characteristics.

**Not publicly established:** exact vivo BlueOS Sensor API availability for WATCH GT 2 third-party apps; BlueOS sampling/timestamp/background/storage/RPC contracts; Huawei per-model ODR and long-session behavior; Wear Engine gyroscope; Mi Fitness/Health Connect record coverage and cadence by SKU/region; exact energy and model transfer results.

These are not editorial omissions. They are the explicit input to the physical/partner validation plan. The report must be updated when target firmware, SDK access, or vendor answers change.

### 9. Primary Technical References

- [vivo WATCH GT 2 specifications](https://www.vivo.com.cn/vivo/param/vivowatchgt2)
- [vivo WATCH GT 2 product and app-store details](https://www.vivo.com.cn/vivo/vivowatchgt2/)
- [vivo BlueOS platform](https://developers.vivo.com/product/blueOS)
- [vivo Health Kit](https://developers.vivo.com/product/d/healthKit)
- [Xiaomi Watch 2](https://www.mi.com/global/product/xiaomi-watch-2/)
- [Android Sensors Overview](https://developer.android.com/develop/sensors-and-location/sensors/sensors_overview)
- [Wear OS Health Services](https://developer.android.com/health-and-fitness/health-services)
- [Wear OS Data Layer](https://developer.android.com/training/wearables/data/overview)
- [Huawei wearable development](https://developer.huawei.com/consumer/en/multidevice/wearables/get-started/)
- [Huawei Wear Engine Kit](https://developer.huawei.com/consumer/cn/sdk/wear-engine-kit/)
- [WISDM at UCI](https://archive.ics.uci.edu/dataset/507/wisdm%2Bsmartphone%2B)
- [PAMAP2 documentation](https://archive.ics.uci.edu/ml/machine-learning-databases/00231/readme.pdf)
- [MM-Fit](https://mmfit.github.io/)

## Technical Research Conclusion

The research does not conclude that vivo is unusable. It concludes that vivo WATCH GT 2 is now the rational first experiment because it is already owned and officially provides BlueOS 3.0, IMU hardware, and an application ecosystem. The decisive unknown is whether third-party BlueOS applications receive continuous raw sensor access with acceptable lifecycle and timing behavior.

FitnessAI should therefore spend days, not weeks, resolving that uncertainty. A successful feasibility spike makes vivo the first recorder platform. A failed or indefinitely blocked spike triggers the Xiaomi Wear OS fallback without invalidating the architecture or data work. Huawei follows after the first raw adapter is stable. Closed watches and health platforms remain valuable derived-record sources but are not substitutes for raw IMU.

**Technical Research Completion Date:** 2026-07-18  
**Research Period:** 2026-07-17 to 2026-07-18  
**Source Verification:** Current official vendor/platform documentation and original dataset sources  
**Overall Confidence:** High for architectural and platform-boundary conclusions; medium for Huawei device-specific raw access; low-to-medium for vivo raw access until the WATCH GT 2 feasibility gate
