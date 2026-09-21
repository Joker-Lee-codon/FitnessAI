import Foundation

public struct GoldenCanonicalVector: Codable, Equatable, Sendable {
    public let name: String
    public let canonicalUTF8Hex: String
    public let digest: String
}

public struct GoldenRejectionVector: Codable, Equatable, Sendable {
    public let name: String
    public let expectedError: String
}

public struct GoldenLoadVector: Codable, Equatable, Sendable {
    public let kind: String
    public let basis: String
    public let expectedOutcome: String
}

public struct ContractGoldenCorpus: Codable, Equatable, Sendable {
    public let profile: String
    public let digestAlgorithm: String
    public let canonical: [GoldenCanonicalVector]
    public let rejections: [GoldenRejectionVector]
    public let loads: [GoldenLoadVector]

    public static func load() throws -> Self {
        guard let url = Bundle.module.url(
            forResource: "contract-golden-v1",
            withExtension: "json"
        ) else {
            throw CorpusError.missingResource
        }
        return try JSONDecoder().decode(Self.self, from: Data(contentsOf: url))
    }
}

public enum CorpusError: Error, Equatable, Sendable {
    case missingResource
}
