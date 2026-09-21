public enum VersionValueError: Error, Equatable, Sendable {
    case invalidSyntax
}

public struct VersionValue: Codable, Equatable, Hashable, Sendable {
    public let canonicalValue: String

    public init(_ source: String) throws {
        let allowed = source.utf8.allSatisfy { byte in
            (48...57).contains(byte) ||
                (65...90).contains(byte) ||
                (97...122).contains(byte) ||
                byte == 43 || byte == 45 || byte == 46 || byte == 95
        }
        guard !source.isEmpty,
              source.utf8.count <= 64,
              allowed,
              source.first?.isLetter == true || source.first?.isNumber == true
        else {
            throw VersionValueError.invalidSyntax
        }
        canonicalValue = source
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let source = try container.decode(String.self)
        do {
            try self.init(source)
        } catch {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected a safe ASCII version identifier"
            )
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(canonicalValue)
    }
}

public enum VersionKind: String, Codable, CaseIterable, Sendable {
    case app
    case schema
    case exerciseCatalog
    case model
    case supportMatrix
    case safetyRulePack
    case algorithm
    case canonicalProfile
}

public struct ContractVersions: Codable, Equatable, Hashable, Sendable {
    public let app: VersionValue?
    public let schema: VersionValue?
    public let exerciseCatalog: VersionValue?
    public let model: VersionValue?
    public let supportMatrix: VersionValue?
    public let safetyRulePack: VersionValue?
    public let algorithm: VersionValue?
    public let canonicalProfile: VersionValue?

    public init(
        app: VersionValue? = nil,
        schema: VersionValue? = nil,
        exerciseCatalog: VersionValue? = nil,
        model: VersionValue? = nil,
        supportMatrix: VersionValue? = nil,
        safetyRulePack: VersionValue? = nil,
        algorithm: VersionValue? = nil,
        canonicalProfile: VersionValue? = nil
    ) {
        self.app = app
        self.schema = schema
        self.exerciseCatalog = exerciseCatalog
        self.model = model
        self.supportMatrix = supportMatrix
        self.safetyRulePack = safetyRulePack
        self.algorithm = algorithm
        self.canonicalProfile = canonicalProfile
    }

    public subscript(kind: VersionKind) -> VersionValue? {
        switch kind {
        case .app: app
        case .schema: schema
        case .exerciseCatalog: exerciseCatalog
        case .model: model
        case .supportMatrix: supportMatrix
        case .safetyRulePack: safetyRulePack
        case .algorithm: algorithm
        case .canonicalProfile: canonicalProfile
        }
    }

    enum CodingKeys: String, CodingKey {
        case app
        case schema
        case exerciseCatalog
        case model
        case supportMatrix
        case safetyRulePack
        case algorithm
        case canonicalProfile
    }
}

public struct VersionRequirement: Codable, Equatable, Hashable, Sendable {
    public let kind: VersionKind
    public let expected: VersionValue
    public let missingIsRecoverable: Bool

    public init(kind: VersionKind, expected: VersionValue, missingIsRecoverable: Bool) throws {
        self.kind = kind
        self.expected = expected
        self.missingIsRecoverable = missingIsRecoverable
    }

    public func evaluate(actual versions: ContractVersions) -> ContractCompatibility {
        let path = "versions.\(kind.rawValue)"
        guard let actual = versions[kind] else {
            let issue = ContractIssue(
                code: .missingRequiredVersion,
                fieldPath: path,
                expectedVersion: expected.canonicalValue,
                recoverability: missingIsRecoverable ? .retryAfterDependency : .notRecoverable
            )
            return missingIsRecoverable ? .pending(issue) : .unsupported(issue)
        }
        guard actual == expected else {
            return .unsupported(ContractIssue(
                code: .incompatibleVersion,
                fieldPath: path,
                expectedVersion: expected.canonicalValue,
                actualVersion: actual.canonicalValue,
                recoverability: .notRecoverable
            ))
        }
        return .compatible
    }
}
