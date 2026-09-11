# 对抗性接缝审查 — FitnessAI 架构脊柱

**审查视角：** 假设两个独立实现单元都遵守每一条已声明的 AD，然后寻找在集成边界仍可能产生分歧的合法选择。

**结论：** **NEEDS FIXES**

该脊柱在所有权、local-first、持久性和批准原则方面基础扎实，但若干协议级不变量仍定义不足。即使两个实现都诚实遵循当前文本，前六项发现仍可能导致静默数据分歧、隐私绕过，或 AI 重复/过期提交。

## 发现

### 1. Critical — AD-2 / AD-4 / AD-11：缺少规范的修订祖先关系、冲突判定和有效值 reducer

- **严重程度：** Critical
- **位置：** AD-2 第 37–41 行；AD-4 第 49–53 行；AD-11 第 91–95 行
- **发现：** 脊柱要求字段级 append-only 修订、不同字段合并、同字段冲突、因果关系和“有效”值，但没有约束因果表示或确定性 reducer。它也没有规定子实体的创建/更新/删除/重排操作如何相互作用、冲突解决修订如何引用所有已解决的 head，以及子项先于父项到达时如何处理。
- **分歧实现：** 单元 A 使用单个 `baseRevisionId`，并将具有相同 base 的编辑视为并发；单元 B 使用逐字段 head 或版本向量。因此，删除与编辑或插入与重排，可能被一个单元合并、被另一个单元显示为冲突。即使双方都不使用设备时间和到达顺序来裁决，它们的 Analysis 视图仍可能纳入不同的“有效”集合。
- **可执行修复：** 在 Contracts 中约束一个平台无关的修订 DAG/reducer：不可变修订/事件 ID、对象 ID、字段路径或操作类型、父项/head 集合、作者设备和解决引用。将冲突定义为对同一规范字段/实体操作的不可比较写入；定义缺失父项、删除/编辑和重排语义的确定性处理；要求解决修订引用每一个已解决的 head。让有效值 reducer 和冲突 fixture 成为 iPhone、Watch、导入及未来 Kotlin 实现共同遵守的规范。

### 2. Critical — AD-7：批准未在事务中绑定当前 base，也不是幂等命令

- **严重程度：** Critical
- **位置：** AD-7 第 67–71 行
- **发现：** proposal 携带 `proposalId`、base revision 和 digest，批准会原子创建 Plan Revision，但规则没有要求在该事务内部对当前 base 执行 compare-and-swap，也没有要求 `proposalId` 的唯一性/消耗状态。“内容变化会使批准失效”不足以处理并发手动编辑或重试/双击批准。
- **分歧实现：** 单元 A 在展示审查时检查 base，之后即使 Plan 已变化也提交；单元 B 在提交时检查。单元 A 可能静默覆盖或从过期上下文分支。另外，一个单元按 `proposalId` 去重批准，另一个单元则每次点击都生成新的 mutation ID，从而把同一 proposal 提交两次。
- **可执行修复：** 要求批准事务验证 proposal 状态尚未消耗、展示 digest 等于规范 proposal digest，并且当前 Plan head 等于已批准 base（否则明确进入可见的冲突/rebase 流程）。对 `proposalId` 强制唯一提交键；重试返回原始结果。base、内容、rule-pack、schema、model 或 permitted scope 的任何变化都使批准失效。

### 3. Critical — AD-8：远程发送许可缺少持久、一次性的授权 artifact

- **严重程度：** Critical
- **位置：** AD-8 第 73–77 行
- **发现：** 每次远程请求都必须预览目的/类别/时间窗口/provider/摘要，但没有不变量规定用户的允许/缩小范围决定必须表示为一次性 artifact，并以加密方式或事务方式绑定确切的出站 body 和目的地。它也没有禁止在数据、账户、provider route 或摘要变化后复用之前的许可。
- **分歧实现：** 单元 A 把“允许”视为整个 session 的许可，后续不再预览便发送摘要；单元 B 只将其视为单次请求。provider adapter 也可能在批准后重新生成摘要，或在仍声称类别未变化的情况下切换内置/BYOK route。
- **可执行修复：** 定义一次性 `RemoteUseAuthorization`，包含稳定 ID、确切 provider/account/route、目的、类别/时间窗口选择、规范出站 body digest、policy version、创建/过期时间和 consumed 状态。发送事务必须将确切 body/目的地与其比较并原子消耗；任何变化都需要重新预览和授权。明确声明 OS/HealthKit permission 和 proposal approval 均不能满足该 artifact。

### 4. Critical — AD-4 / Consistency Conventions：digest 和 wire 等价性不规范

- **严重程度：** Critical
- **位置：** AD-4 第 49–53 行；conventions 第 115–123 行；Stack 第 126–137 行
- **发现：** envelope 和交换/AI 对象携带 digest，但没有约束规范序列化、hash algorithm/version、日期/时间/单位/数字规范化、未知字段处理，以及按字节还是语义计算 digest 的范围。“版本化 schema 和 golden fixture”本身并不能决定这些规则。
- **分歧实现：** 单元 A 对含十进制重量和 ISO-8601 offset 的美化 JSON 计算 hash；单元 B 对规范 CBOR/JSON、二进制浮点数和 UTC 计算 hash。它们会拒绝对方的有效 payload；更糟的是，双方可能在本地计算的 digest 下验证不同的语义内容。批准展示与提交也可能对不同的规范化形式计算 digest。
- **可执行修复：** 增加规范的 canonical-envelope contract：确切 encoding profile、字段排序或 canonicalization algorithm、整数/小数表示、Unicode normalization、UTC/time-zone 语义、单位表示、未知字段 policy、digest algorithm 及 version，以及具体覆盖哪些字节/语义字段。要求 iPhone 与 Watch 的 encode/decode/digest golden vector；在适用位置，同一 canonical digest 必须绑定展示、批准、发送、导入和提交。

### 5. High — AD-4：acknowledgement、chunk 组装和 Plan 激活状态机不完整

- **严重程度：** High
- **位置：** AD-4 第 49–53 行
- **发现：** 接收需要验证、持久提交和 application acknowledgement，但 ack identity/status、重放行为、negative acknowledgement、重试终止、chunk manifest/完整性和原子 Plan 激活均未规定。“最后一个完整兼容的 Plan”没有定义完整性，也没有定义如何协商兼容性。
- **分歧实现：** Watch 单元 A 在每个 chunk 写入文件后确认，并在所有编号 chunk 出现时激活；iPhone 单元 B 将第一个 ack 理解为整条消息已接收并删除 outbox。另一个 Watch 实现可能在依赖的 catalog 条目到达之前激活 Plan，同时仍认为 Plan 本身完整。
- **可执行修复：** 约束一个 transfer 状态机，包含 manifest ID、有序 chunk ID/count/size/digest、整体 payload digest、dependency/support version，以及 ack 状态（`received`、`durablyCommitted`、`applied`、带稳定 reason 的 `rejected`）。只有幂等的 whole-object `applied` ack 才允许发送方清理/激活。规定重放响应、缺失 chunk 恢复、timeout/backoff，并要求 Plan 及其所有必需依赖在一个事务中提交和切换 active revision。

### 6. High — AD-3 / AD-4：设备更换和配对代际无法隔离旧 Watch 写入

- **严重程度：** High
- **位置：** AD-3 第 43–47 行；AD-4 第 49–53 行
- **发现：** 设备更换列在 `Binds` 中，envelope 也标识 source device，但没有规则定义 pairing identity/epoch、信任建立，或旧 Watch 在更换/取消配对后延迟 outbox 是否仍可接受。digest 可以检测损坏，却不能识别当前已授权的对端，也不能防止来自过期配对的重放。
- **分歧实现：** 单元 A 接受来自任何曾见设备、针对该 session ID 的所有有效事件；单元 B 只接受当前 Watch。更换后，旧 Watch 的延迟编辑可能在单元 A 中恢复或与已解决数据冲突，却被单元 B 拒绝。
- **可执行修复：** 在 session 和同步 envelope 中引入持久 pairing generation/trust epoch。定义哪些未处理事实可在取消配对/重新配对后保留、如何显式恢复、何时撤销 epoch，以及旧设备事件如何进入隔离区而非静默应用。将重放保护绑定到 `(pairingEpoch, sourceDeviceId, messageId)`，同时为真正未发送的事实保留可审计的恢复路径。

### 7. High — AD-3：离线 session identity 和恢复权责不明确

- **严重程度：** High
- **位置：** AD-3 第 43–47 行；Capability Map 第 163–167 行
- **发现：** 在配对使用中，iPhone 创建共享 session identity，而 Watch 拥有离线事实和 active-session 恢复。规则没有说明手机不可用时 Watch 是否可以开始/恢复、临时 identity 如何映射到 iPhone identity，或独立恢复后哪个终止状态获胜。
- **分歧实现：** 单元 A 禁止 Watch 在未收到已下发 session 时开始；单元 B 创建 Watch 本地 session 并稍后导入。如果 iPhone 也启动了替代 session，一个实现会合并训练，另一个会创建两条记录。Finish/Continue 操作同样可能形成两个终止分支。
- **可执行修复：** 约束 session lifecycle contract：允许的开始路径、全局唯一 ID 与临时 ID、一次性 alias/mapping 操作、不可变 Plan snapshot identity、状态转换，以及 start/finish/continue/recovery 的冲突规则。要求每个事实保留其原始 session ID，并禁止按 timestamp 启发式合并。

### 8. High — AD-10：未知内容和重复项处理明确允许不兼容结果

- **严重程度：** High
- **位置：** AD-10 第 85–89 行
- **发现：** “未知内容会被明确映射、省略或拒绝”将确切选择留给各 importer，而“验证重复项”没有说明拒绝、警告还是作为新 draft 导入。这与防止静默省略的目标冲突，也无法仅靠文件格式版本实现互操作。
- **分歧实现：** Importer A 丢弃一个未知的可选 exercise 属性并显示警告；Importer B 拒绝同一文件。Importer A 允许将重复项作为新 draft，Importer B 根据 source identity 阻止。两者都合规，但用户会因实现版本/平台不同而看到不同 Plan 或丢失 metadata。
- **可执行修复：** 将版本化 import decision table 设为规范：不支持的必填字段拒绝；支持的 alias 确定性映射；可选未知字段作为 inert round-trip metadata 保留，或要求在完整预览中逐项明确确认省略；绝不静默省略。定义 duplicate identity/fingerprint 行为，以及确认后是否允许创建另一个 draft。为每个分支增加 golden fixture。

### 9. High — AD-9：HealthKit copy 更正/version/detachment 转换定义不足

- **严重程度：** High
- **位置：** AD-9 第 79–83 行
- **发现：** Session ID/revision 被用作 HealthKit sync identity/version，但文档没有约束非数字或分支 revision 如何映射到 HealthKit 单调递增的 sync version、哪些本地更正会更新 copy，或如何区分预期外部变化与删除/损坏。虽命名了 `healthKitDetached`，却没有其 transition table。
- **分歧实现：** 单元 A 将每次有效更正写为更高的 HealthKit sync version；单元 B 在任何 mismatch 时 detach 并停止更新。分支解决在一个单元中可能映射为更低/不同 version，导致 save 被忽略或重复 workout，而另一个单元成功。
- **可执行修复：** 为每个 FitnessAI session 定义本地单调递增的 HealthKit export generation，仅在有意 export/update 时原子分配。规定 create/update/delete/detach/relink 转换、比较哪些字段、如何识别自身写入的 version，以及外部缺失/变化绝不触发自动重建。为更正、冲突解决、手动 Health 删除和重试增加 fixture。

### 10. High — AD-13 / AD-6：capability kill switch 与证据资格未在 session 边界同步

- **严重程度：** High
- **位置：** AD-6 第 61–65 行；AD-13 第 103–107 行
- **发现：** 每项高风险 capability 都可以 fail closed，自动化也需要 evidence row，但没有不变量定义由谁评估该 row、iPhone/Watch 如何交换 support/evidence/control version，或 active workout 期间资格应冻结还是可变。
- **分歧实现：** iPhone 单元 A 根据缓存 matrix 显示 recognition 已启用，而 Watch 单元 B 有更新的 kill switch，只记录手动数据。另一个实现可能在一组训练中途禁用 model 并丢弃 pending prediction，而另一方将其保留用于确认。面向用户的状态和最终 label 会产生分歧。
- **可执行修复：** 定义 capability handshake，携带 app/schema/model/evidence/control version 和显式协商状态。将允许的自动化集合冻结在 active-session snapshot 中，唯一例外是紧急转为 disabled；定义 disable 时如何处理 pending prediction。Watch 对其 sensor/model 的可执行性拥有权威，iPhone 必须展示协商后的状态，而不是本地预期。

### 11. Medium — AD-5：清理 acknowledgement 和保留范围未绑定不可变事实

- **严重程度：** Medium
- **位置：** AD-5 第 55–59 行
- **发现：** “已确认事实保留初始七天窗口”没有说明由哪个 acknowledgement level 启动计时、后续更正是否重置、raw chunk manifest 与文件是否一并删除，也没有说明尽管禁止设备时间决定 truth，清理是否仍使用 wall-clock time。
- **分歧实现：** Watch 单元 A 在 transport receipt 时开始七天计时，并在 iPhone application 之前删除 chunk；单元 B 从 whole-object applied ack 开始计时。时钟校正也可能让一个实现提前删除。数据库 row 可能在文件不存在时保留，或文件在 manifest 不存在时保留。
- **可执行修复：** 将清理资格绑定到发现 5 的不可变 whole-object `applied` acknowledgement，加上本地 monotonic elapsed time；按 artifact class 定义保留期，并说明 superseding fact 是否影响保留期。在可恢复、幂等的清理事务中删除 file/index/manifest，并保留足以回答 replay 的 tombstone/audit metadata。

### 12. Medium — AD-14 / AD-7：“displayed digest”缺少展示完整性不变量

- **严重程度：** Medium
- **位置：** AD-7 第 67–71 行；AD-14 第 109–113 行
- **发现：** 批准绑定完整 displayed digest，但展示 contract 没有要求批准前必须显示每个与安全相关的变更字段、省略项、assumption、unit conversion 或 warning。digest 本身对用户没有意义。
- **分歧实现：** UI 单元 A 汇总“5 个动作发生变化”，并隐藏展开后才能看到的 set/load 变化；UI 单元 B 要求完整 diff。两者批准同一 digest，但单元 A 实际允许了 AD-7 原本要阻止的隐藏 mutation。
- **可执行修复：** 约束 approval-view completeness contract：列举所有变更字段和删除项、原值和建议值/单位、assumption、Safety Rule result、未解决 warning、scope 和 base revision；任何包含未经审查安全相关变更的折叠 section 都不能批准。Accessibility representation 必须暴露相同信息。保存渲染所依据的规范 proposal version/digest，而不是 screenshot 或 prose。

### 13. Medium — AD-8 / AD-13：Alpha gateway 安全约束的推迟时间晚于 gateway 使用

- **严重程度：** Medium
- **位置：** AD-8 第 73–77 行；AD-13 第 103–107 行；Deferred 第 180 行
- **发现：** 内置 DeepSeek 已需要 FitnessAI gateway，但 authentication、request authorization、abuse limit、build/environment binding 和 log redaction 验证被推迟到 public-beta threat review。仅限 owner 的 Alpha 并不能阻止可调用 gateway endpoint 被提取或自动滥用。
- **分歧实现：** Gateway 单元 A 信任静态 app header；client 单元 B 假设存在 device attestation 或经认证的短期 token。修改后的 client 可以消耗产品 key 的 quota 或提交任意数据，同时仍满足所有已声明的 secret-storage 规则。
- **可执行修复：** 将最低 gateway contract 提前到首次 Alpha traffic 之前：environment-isolated endpoint、短期认证 client/session credential、服务器端 provider allowlist 与 payload/schema limit、rate/cost ceiling、禁止 client 选择 policy 之外的 provider URL/model、结构化脱敏日志，以及 secret-leak test。更广泛的 region/account threat model 可继续延后至 public beta。

## 建议的 gate 处置

1. 在把脊柱标记为 final 之前修复发现 1–6；它们定义了下层单元不能安全自行发明的数据、批准、授权、wire 和设备信任不变量。
2. 在脊柱中修复发现 7–10，或分别以首次 paired workout/import/HealthKit/automation 实现 story 之前为硬性回访条件明确 Deferred。
3. 发现 11–13 可以简洁补入相关 AD 或规范 contract seed，但不应继续保持隐含。

## 复核 — 2026-09-10

**结论：** **NEEDS FIXES — 剩余一个阻断项**

| 原发现 | 状态 | 复核结论 |
|---|---|---|
| 1. Revision DAG/reducer | 已解决 | AD-2 现在约束规范 DAG、因果字段、冲突判定、缺失父项状态、拓扑操作处理、解决引用、reducer 和跨平台 golden fixture。 |
| 2. AI 批准并发/幂等性 | 已解决 | AD-7 现在在事务中验证未消耗 proposal、展示 digest、当前 Plan head 和 policy version，并使用 `proposalId` 作为唯一重试键。 |
| 3. 一次性远程授权 | 已解决 | AD-8 现在将确切目的地/body/目的/scope 绑定到有过期时间且只原子消耗一次的授权。 |
| 4. 规范 digest/wire 等价性 | 已解决 | Consistency Conventions 现在要求统一的 encoding、normalization、semantic coverage、hash-version profile 和跨设备 golden vector。 |
| 5. Transfer/ack/activation 状态机 | 已解决，但下方清理冲突除外 | AD-4 现在约束 manifest/chunk metadata、显式 ack 状态、replay response、缺失 chunk 重试、dependency negotiation 和原子 Plan activation。 |
| 6. Pairing generation/旧设备隔离 | 已解决 | AD-4 现在约束持久 pairing epoch、replay identity、revocation quarantine 和显式 recovery。 |
| 7. 离线 session identity/recovery | 已解决 | AD-3 现在允许具有 cached Plan 的 Watch 创建全局唯一 session ID，并由 iPhone 原样接纳，同时禁止按时间合并；AD-2 覆盖竞争的 completion/topology branch。 |
| 8. 未知/重复导入行为 | 已解决 | AD-10 现在约束版本化 decision table、确定性 alias mapping、禁止静默省略、inert metadata 或逐项确认，以及 duplicate-draft 行为。 |
| 9. HealthKit version/detachment 转换 | 已解决 | AD-9 现在要求原子单调 export generation，以及包含自身写入重试行为的版本化 create/update/delete/detach/relink transition table。 |
| 10. Capability negotiation/session freeze | 已解决 | AD-4 与 AD-6 现在约束 capability handshake、Watch 执行权威、session-frozen eligibility、emergency disable 和 pending-prediction fallback。 |
| 11. 清理 acknowledgement/retention | **仍存在阻断性冲突** | AD-4 规定只有 whole-object `applied` 才允许清理，而 AD-5 规定 raw Watch chunk 在 iPhone durable commit 后删除，这对应更早的 `durablyCommitted` 状态。因此两个实现仍可合法地在不同阶段删除。 |
| 12. Approval-view completeness | 已解决 | AD-7 现在列举批准前的所有 change/deletion、value/unit、assumption、warning、Safety result、scope、base revision 和 accessible presentation。 |
| 13. Alpha gateway 最低安全要求 | 已解决 | AD-8 现在将 endpoint isolation、short-lived authentication、allowlist、limit、rotation、redaction、rollback ownership 和 kill switch 提前到 Alpha traffic 之前。 |

### 剩余可执行修复

- 在 AD-4 与 AD-5 中选择并使用完全一致的规则：raw Watch chunk 要么属于 sender cleanup，因此必须保留到 whole-object `applied`；要么明确作为例外，在已验证 whole-object `durablyCommitted` 后即可删除，因为 iPhone 已持久拥有完整字节并能在本地重试 application。还需声明 file、index 和 manifest 共享同一原子 cleanup eligibility。完成该修正后，原始对抗性审查的其他发现均不再构成阻断。

## 最终复核 — 2026-09-10

**结论：** **PASS**

AD-4 与 AD-5 现在一致要求：任何 Watch raw-chunk cleanup 都必须等到 whole-object `applied`。AD-5 还将 file、index 和 manifest 删除约束为一次幂等原子操作，并保留 replay tombstone。上一轮复核唯一剩余的阻断项已经解决；最初 13 项对抗性接缝发现现已全部关闭。
