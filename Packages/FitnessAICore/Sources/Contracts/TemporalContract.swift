import Foundation

public enum TemporalContractError: Error, Equatable, Sendable {
    case invalidTimeZoneIdentifier
}

public struct TemporalContract: Codable, Equatable, Hashable, Sendable {
    public let epochMilliseconds: Int64
    public let timeZoneIdentifier: String?

    public init(epochMilliseconds: Int64, timeZoneIdentifier: String? = nil) throws {
        if let timeZoneIdentifier,
           TimeZone(identifier: timeZoneIdentifier) == nil {
            throw TemporalContractError.invalidTimeZoneIdentifier
        }
        self.epochMilliseconds = epochMilliseconds
        self.timeZoneIdentifier = timeZoneIdentifier
    }

    public var canonicalValue: CanonicalValue {
        var members = [CanonicalMember(
            key: "epochMilliseconds",
            value: .integer(epochMilliseconds)
        )]
        if let timeZoneIdentifier {
            members.append(.init(
                key: "timeZoneIdentifier",
                value: .string(timeZoneIdentifier)
            ))
        }
        return .object(members)
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            try self.init(
                epochMilliseconds: container.decode(Int64.self, forKey: .epochMilliseconds),
                timeZoneIdentifier: container.decodeIfPresent(String.self, forKey: .timeZoneIdentifier)
            )
        } catch {
            throw DecodingError.dataCorrupted(.init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid temporal contract"
            ))
        }
    }

    enum CodingKeys: String, CodingKey {
        case epochMilliseconds
        case timeZoneIdentifier
    }
}
