import CryptoKit
import Foundation

public enum ContractDigestError: Error, Equatable, Sendable {
    case malformedDigest
    case digestMismatch
}

public struct ContractDigest: Equatable, Hashable, Sendable {
    public static let algorithmIdentifier = "sha256-v1"

    public let algorithm: String
    public let hex: String
    public let canonicalBytes: Data

    private init(hex: String, canonicalBytes: Data) {
        algorithm = Self.algorithmIdentifier
        self.hex = hex
        self.canonicalBytes = canonicalBytes
    }

    public static func create(for envelope: CanonicalEnvelope) throws -> Self {
        let bytes = try CanonicalSerializer().serialize(envelope.canonicalValue)
        let hex = hash(canonicalBytes: bytes)
        return Self(hex: hex, canonicalBytes: bytes)
    }

    public static func hash(canonicalBytes: Data) -> String {
        SHA256.hash(data: canonicalBytes).map { String(format: "%02x", $0) }.joined()
    }

    @discardableResult
    public static func verify(hex supplied: String, for envelope: CanonicalEnvelope) throws -> Bool {
        guard supplied.count == 64,
              supplied.utf8.allSatisfy({
                  (48...57).contains($0) || (97...102).contains($0)
              })
        else {
            throw ContractDigestError.malformedDigest
        }
        let expected = try create(for: envelope).hex
        guard supplied.utf8.elementsEqual(expected.utf8) else {
            throw ContractDigestError.digestMismatch
        }
        return true
    }
}
