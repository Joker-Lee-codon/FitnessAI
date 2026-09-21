import Contracts
import Foundation
import Testing

@Suite("Versioned contract digest")
struct ContractDigestTests {
    @Test("SHA-256 binds the exact inspectable canonical bytes")
    func exactDigest() throws {
        let envelope = try CanonicalEnvelope(content: .string("fact"))
        let result = try ContractDigest.create(for: envelope)

        #expect(result.algorithm == "sha256-v1")
        #expect(result.hex == "6bf10bd8090860d85ac9e6313f97668cfc15fc62b508a0f5e0dafb58e17354ff")
        #expect(result.hex.count == 64)
        #expect(result.canonicalBytes == #"{"content":"fact","optionalExtensions":{},"profile":"fitnessai-canonical-v1","requiredCapabilities":[]}"#.data(using: .utf8))
    }

    @Test("Every covered-field mutation changes the digest")
    func mutationChangesDigest() throws {
        let original = try ContractDigest.create(for: CanonicalEnvelope(content: .string("fact")))
        let mutated = try ContractDigest.create(for: CanonicalEnvelope(content: .string("Fact")))
        let extended = try ContractDigest.create(for: CanonicalEnvelope(
            content: .string("fact"),
            optionalExtensions: [.init(key: "x", value: .bool(true))]
        ))

        #expect(original.hex != mutated.hex)
        #expect(original.hex != extended.hex)
    }

    @Test("Verification rejects a mismatched or malformed digest")
    func verification() throws {
        let envelope = try CanonicalEnvelope(content: .string("fact"))
        #expect(try ContractDigest.verify(
            hex: "6bf10bd8090860d85ac9e6313f97668cfc15fc62b508a0f5e0dafb58e17354ff",
            for: envelope
        ))
        #expect(throws: ContractDigestError.self) {
            try ContractDigest.verify(hex: String(repeating: "0", count: 64), for: envelope)
        }
        #expect(throws: ContractDigestError.self) {
            try ContractDigest.verify(hex: "not-a-digest", for: envelope)
        }
    }
}
