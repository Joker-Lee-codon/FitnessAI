public enum ContractIssueCode: String, Codable, Equatable, Hashable, Sendable {
    case missingRequiredVersion = "missing_required_version"
    case incompatibleVersion = "incompatible_version"
    case unknownCriticalCapability = "unknown_critical_capability"
    case malformedEnvelope = "malformed_envelope"
    case contradictoryEnvelope = "contradictory_envelope"
    case digestMismatch = "digest_mismatch"
}

public enum ContractRecoverability: String, Codable, Equatable, Hashable, Sendable {
    case retryAfterDependency = "retry_after_dependency"
    case notRecoverable = "not_recoverable"
}

public struct ContractIssue: Codable, Equatable, Hashable, Sendable {
    public let code: ContractIssueCode
    public let fieldPath: String
    public let expectedVersion: String?
    public let actualVersion: String?
    public let recoverability: ContractRecoverability

    public init(
        code: ContractIssueCode,
        fieldPath: String,
        expectedVersion: String? = nil,
        actualVersion: String? = nil,
        recoverability: ContractRecoverability
    ) {
        self.code = code
        self.fieldPath = fieldPath
        self.expectedVersion = expectedVersion
        self.actualVersion = actualVersion
        self.recoverability = recoverability
    }

    public static func rejected(code: ContractIssueCode, fieldPath: String) -> Self {
        Self(code: code, fieldPath: fieldPath, recoverability: .notRecoverable)
    }
}

public enum ContractCompatibility: Codable, Equatable, Hashable, Sendable {
    case compatible
    case pending(ContractIssue)
    case unsupported(ContractIssue)
    case rejected(ContractIssue)
}
