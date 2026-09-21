import ContractFixtureSupport
import Contracts
import Foundation
import Testing

@Suite("Authoritative contract golden corpus")
struct GoldenCorpusTests {
    @Test("Every canonical vector freezes exact UTF-8 bytes and SHA-256")
    func canonicalVectors() throws {
        let corpus = try ContractGoldenCorpus.load()
        #expect(corpus.profile == CanonicalEnvelope.profileIdentifier)
        #expect(corpus.digestAlgorithm == ContractDigest.algorithmIdentifier)

        for vector in corpus.canonical {
            let bytes = try decodeHex(vector.canonicalUTF8Hex)
            #expect(ContractDigest.hash(canonicalBytes: bytes) == vector.digest)
        }
    }

    @Test("The corpus covers strict rejection and load semantics")
    func coverage() throws {
        let corpus = try ContractGoldenCorpus.load()
        let rejectionNames = Set(corpus.rejections.map(\.name))
        let requiredRejections = Set([
            "decimal-exponent", "decimal-nan", "decimal-infinity",
            "decimal-over-28-significant-digits", "malformed-utf8",
            "duplicate-nfc-key", "unknown-required-capability",
            "missing-recoverable-version", "unsupported-version",
            "partial-decoding", "automatic-substitution",
            "uuid-uppercase-normalizes", "pounds-exact-conversion",
        ])
        #expect(rejectionNames.isSuperset(of: requiredRejections))
        #expect(Set(corpus.loads.map(\.kind)) == Set(LoadKind.allCases.map(\.rawValue)))
    }

    @Test("Golden semantic inputs reproduce the frozen canonical bytes")
    func reproduceVectors() throws {
        let corpus = try ContractGoldenCorpus.load()
        let values: [String: CanonicalValue] = [
            "fact-envelope-key-order-optional-extension-baseline": try CanonicalEnvelope(content: .string("fact")).canonicalValue,
            "unicode-nfc-emoji-key-decimal-boundary": .object([
                .init(key: "🏋️", value: .string("力")),
                .init(key: "e\u{301}", value: .string("cafe\u{301}")),
                .init(key: "a", value: .decimal(try CanonicalDecimal("1.20"))),
            ]),
            "signed-epoch-milliseconds-iana-time-zone": try TemporalContract(
                epochMilliseconds: -1_234,
                timeZoneIdentifier: "Asia/Shanghai"
            ).canonicalValue,
        ]
        let serializer = CanonicalSerializer()
        for vector in corpus.canonical {
            let value = try #require(values[vector.name])
            #expect(try serializer.serialize(value) == decodeHex(vector.canonicalUTF8Hex))
        }
    }

    private func decodeHex(_ source: String) throws -> Data {
        guard source.count.isMultiple(of: 2) else { throw HexError.invalid }
        var data = Data()
        var index = source.startIndex
        while index < source.endIndex {
            let next = source.index(index, offsetBy: 2)
            guard let byte = UInt8(source[index..<next], radix: 16) else { throw HexError.invalid }
            data.append(byte)
            index = next
        }
        return data
    }

    private enum HexError: Error { case invalid }
}
