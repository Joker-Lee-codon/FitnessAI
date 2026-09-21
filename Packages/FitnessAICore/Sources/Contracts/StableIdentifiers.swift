import Foundation

public protocol StableIdentityKind: Sendable {}

public struct StableIdentifier<Kind: StableIdentityKind>: Codable, Equatable, Hashable, Sendable {
    private let uuid: UUID

    public init(uuid: UUID) {
        self.uuid = uuid
    }

    public init?(canonicalValue: String) {
        guard let uuid = UUID(uuidString: canonicalValue) else { return nil }
        self.uuid = uuid
    }

    public static func generate() -> Self {
        Self(uuid: UUID())
    }

    public var canonicalValue: String {
        uuid.uuidString.lowercased()
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        guard let parsed = Self(canonicalValue: value) else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Expected an RFC UUID string"
            )
        }
        self = parsed
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(canonicalValue)
    }
}

public enum PlanIdentity: StableIdentityKind {}
public enum PlanRevisionIdentity: StableIdentityKind {}
public enum WorkoutSessionIdentity: StableIdentityKind {}
public enum ActualSetIdentity: StableIdentityKind {}
public enum RevisionEventIdentity: StableIdentityKind {}
public enum DeviceMessageIdentity: StableIdentityKind {}
public enum ApprovalIdentity: StableIdentityKind {}
public enum ProposalIdentity: StableIdentityKind {}
public enum SourceDeviceIdentity: StableIdentityKind {}

public typealias PlanID = StableIdentifier<PlanIdentity>
public typealias PlanRevisionID = StableIdentifier<PlanRevisionIdentity>
public typealias WorkoutSessionID = StableIdentifier<WorkoutSessionIdentity>
public typealias ActualSetID = StableIdentifier<ActualSetIdentity>
public typealias RevisionEventID = StableIdentifier<RevisionEventIdentity>
public typealias DeviceMessageID = StableIdentifier<DeviceMessageIdentity>
public typealias ApprovalID = StableIdentifier<ApprovalIdentity>
public typealias ProposalID = StableIdentifier<ProposalIdentity>
public typealias SourceDeviceID = StableIdentifier<SourceDeviceIdentity>
