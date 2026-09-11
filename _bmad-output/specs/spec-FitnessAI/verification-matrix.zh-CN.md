# FitnessAI 验证矩阵

## Capability Coverage

| Capability | 主要自动化与人工检查 | 绑定参考 |
|---|---|---|
| CAP-1 | Schema/mapping rejection；Safety outcomes；完整 diff accessibility；digest/base/policy invalidation；duplicate approval replay；commit 与 delivery fault injection | FR-054–060、FR-078–087；NFR-AI-001–006；AD-2、AD-7、AD-8 |
| CAP-2 | Offline Start/Finish；local commit failure；App 终止、Watch 重启、sensor loss、disconnect、partial write、repeated/reordered transfer；不可变 Start snapshot | FR-001–007、FR-028–035、FR-061–066；NFR-RECOV-001；AD-3–5 |
| CAP-3 | 计划/自由 iPhone 场次一致性；纠错/恢复；可选服务中断；不存在 Watch-only 状态或第二 reducer | FR-001–007、FR-016–019、FR-029、FR-036–041、FR-061–066；AD-2、AD-3 |
| CAP-4 | 冻结 holdout：classification ≥75%，分母含 abstentions/misses；boundary precision/recall ≥80% 且 ±3 s 匹配；≥80% reps 在 ±2 内并报告 MAE；macro/micro/slices/CIs | SM-ACC-001、SM-PRES-001；FR-008–015；NFR-REC-001/002；AD-6 |
| CAP-5 | Opt-in 隔离；前五个 chronological eligible predictions；±1 正确度及 exact match；≥4 时 offer；≥2 时 recalibration；滚动 two-of-five drift；prediction 不作为 label | FR-020–027；NFR-RPE-001–014；AD-6 |
| CAP-6 | 15 分钟 AND Gate；missing-signal suppression；只有 Finish/Continue；15 分钟 cooldown；长休息/器械等待/低幅度真机场次；false/missed rates | FR-004/005；NFR-SESSION-001–005；AD-6 |
| CAP-7 | Golden revision DAG/reducer vectors；并发同/不同字段修改；topology conflicts；missing parent；replay；epoch quarantine；deletion/cleanup retention | SM-COMP-001、SM-PRES-001；FR-003、FR-043、FR-046、FR-061–070；AD-2–5 |
| CAP-8 | PRD 公式 fixtures；correction invalidation；stale/pending labels；incomplete/conflicted exclusion；bodyweight/assisted/timed separation；chart text/table parity | FR-036–041；AD-11；AN-L01 |
| CAP-9 | Capability-specific permissions；observable read states；idempotent export generations；detach/relink table；禁止 silent recreate；one-shot remote preview；禁用真实 send | FR-088–090；NFR-HK-001/002、NFR-PRIV-007；AD-8、AD-9 |
| CAP-10 | 每个 size/depth/count limit 的 boundary corpus；malformed/executable/external input；unknown required/optional fields；aliases；duplicate；omission；new-draft-only commit | FR-071–073；NFR-PORT-001；AD-10 |
| CAP-11 | Once-per-session trigger；Review/Later/Disable persistence；display/dismiss 时无 network/auth/proposal；进入正常 authorization 与 approval | FR-091；AD-7；RV-L01 |
| CAP-12 | 全部具名 screen states；light/dark；最大中文 Dynamic Type；VoiceOver 顺序；Full Keyboard Access；Reduce Motion/contrast；44 pt controls；error/back focus restoration | NFR-UX-001；AD-13/14；DESIGN 与 EXPERIENCE |
| CAP-13 | Canonical mapping 与 substitution fixtures；明确 support boundary；licensed/owned asset provenance；无禁止的全身或医疗 claims | FR-030–032、FR-049–053；AD-6；UX support components |
| CAP-14 | Planned/Actual separation；计划/历史/上一组 load provenance；明确 accept/edit/reject；canonical substitute attribute comparison；准确 future-plan diff；拒绝后保全 | FR-016–019、FR-027–035；AD-2、AD-7；UJ-1 与 Flow 2 |

## Cross-Cutting Release Checks

| Check | 通过条件 |
|---|---|
| Truth and completeness | 每项 recorded、entered、corrected 或 confirmed 内容持久且存在；缺失数据保持明显 incomplete |
| Interruption burden | 约 20 组代表性场次中 Exercise/rep/load/RPE 主动 prompt 最多五次；计数与 completeness、accuracy 一起报告 |
| Performance and resources | 每个受支持真机 Watch/OS 组合的 90 分钟/20 组场次中资源终止为零、已提交数据丢失为零；Start/correction/Finish p95 ≤1 s；报告 battery、thermal、memory 与 >2 s interaction |
| Size | App-thinning 证据满足 iPhone installed ≤500 MB、Watch uncompressed <75 MB 且 installed target ≤25 MB、Watch ML ≤6 MB、RPE ≤2 MB |
| Secrets and diagnostics | Product/BYOK key、body、free text、Health value、raw signal 或 Exercise/load/RPE content 均不进入不允许的 storage、logs、backup、synchronization 或 diagnostics |
| Degradation | 独立 fail-closed controls 可以关闭 AI、recognition、RPE、Finish assistance、Health 或 exchange，而不删除事实或阻塞手动本地记录 |
| Alpha outcome | Product Owner 完成重复端到端训练并达到 `SM-E2E-001` 与 `SM-ALPHA-CORE-001`，无需退回其他主要 recorder |

## Evidence Package

每个 candidate build 都要归档准确版本、support matrix、environment、golden-fixture results、automated reports、真机 protocol/results、counter-metrics、known exclusions、open Gate states 与 Product Owner verdict。Simulator 结果可以验证逻辑或布局，但不能使 sensors、HealthKit、background execution、file delivery、battery、recovery、recognition、RPE、Finish assistance 或 supported device row 合格。
