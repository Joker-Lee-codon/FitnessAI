public struct CanonicalMember: Codable, Equatable, Hashable, Sendable {
    public let key: String
    public let value: CanonicalValue

    public init(key: String, value: CanonicalValue) {
        self.key = key
        self.value = value
    }
}

public indirect enum CanonicalValue: Codable, Equatable, Hashable, Sendable {
    case null
    case bool(Bool)
    case string(String)
    case integer(Int64)
    case decimal(CanonicalDecimal)
    case array([CanonicalValue])
    case object([CanonicalMember])
}

public enum CanonicalizationError: Error, Equatable, Sendable {
    case duplicateNormalizedKey(String)
    case unsupportedRequiredCapability(String)
}

public struct CanonicalEnvelope: Equatable, Hashable, Sendable {
    public static let profileIdentifier = "fitnessai-canonical-v1"

    public let content: CanonicalValue
    public let optionalExtensions: [CanonicalMember]
    public let requiredCapabilities: [String]

    public init(
        content: CanonicalValue,
        optionalExtensions: [CanonicalMember] = [],
        requiredCapabilities: [String] = [],
        supportedCapabilities: Set<String> = []
    ) throws {
        if let unsupported = requiredCapabilities.first(where: { !supportedCapabilities.contains($0) }) {
            throw CanonicalizationError.unsupportedRequiredCapability(unsupported)
        }
        self.content = content
        self.optionalExtensions = optionalExtensions
        self.requiredCapabilities = requiredCapabilities
    }

    public var canonicalValue: CanonicalValue {
        .object([
            .init(key: "profile", value: .string(Self.profileIdentifier)),
            .init(key: "content", value: content),
            .init(key: "optionalExtensions", value: .object(optionalExtensions)),
            .init(
                key: "requiredCapabilities",
                value: .array(requiredCapabilities.map(CanonicalValue.string))
            ),
        ])
    }
}
