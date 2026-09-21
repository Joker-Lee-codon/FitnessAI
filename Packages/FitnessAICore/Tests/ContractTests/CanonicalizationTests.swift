import Contracts
import Foundation
import Testing

@Suite("FitnessAI Canonical Profile v1")
struct CanonicalizationTests {
    private let serializer = CanonicalSerializer()

    @Test("Object order and Unicode composition produce identical bytes")
    func semanticEquivalence() throws {
        let composed = CanonicalValue.object([
            .init(key: "é", value: .string("café")),
            .init(key: "a", value: .decimal(try CanonicalDecimal("1.20"))),
        ])
        let decomposed = CanonicalValue.object([
            .init(key: "a", value: .decimal(try CanonicalDecimal("1.2"))),
            .init(key: "e\u{301}", value: .string("cafe\u{301}")),
        ])

        let expected = #"{"a":1.2,"é":"café"}"#.data(using: .utf8)!
        #expect(try serializer.serialize(composed) == expected)
        #expect(try serializer.serialize(decomposed) == expected)
    }

    @Test("Escaping is fixed while arrays retain their order")
    func escapingAndArrays() throws {
        let value = CanonicalValue.array([
            .string("quote\" slash/ reverse\\ line\n"),
            .bool(true),
            .null,
        ])
        let expected = #"["quote\" slash/ reverse\\ line\n",true,null]"#.data(using: .utf8)!
        #expect(try serializer.serialize(value) == expected)
    }

    @Test("Keys that collide after NFC normalization are rejected")
    func duplicateNormalizedKeys() {
        let value = CanonicalValue.object([
            .init(key: "é", value: .null),
            .init(key: "e\u{301}", value: .null),
        ])
        #expect(throws: CanonicalizationError.self) { try serializer.serialize(value) }
    }

    @Test("Instants use epoch milliseconds and local meaning keeps an IANA zone")
    func temporalContract() throws {
        let instant = try TemporalContract(epochMilliseconds: -1_234, timeZoneIdentifier: "Asia/Shanghai")
        let expected = #"{"epochMilliseconds":-1234,"timeZoneIdentifier":"Asia/Shanghai"}"#.data(using: .utf8)!
        #expect(try serializer.serialize(instant.canonicalValue) == expected)
        #expect(throws: TemporalContractError.self) {
            try TemporalContract(epochMilliseconds: 0, timeZoneIdentifier: "Not/A_Zone")
        }
    }

    @Test("Unknown required capabilities fail while optional extensions stay covered")
    func capabilityHandling() throws {
        #expect(throws: CanonicalizationError.self) {
            try CanonicalEnvelope(
                content: .null,
                requiredCapabilities: ["future-critical"],
                supportedCapabilities: []
            )
        }

        let envelope = try CanonicalEnvelope(
            content: .string("fact"),
            optionalExtensions: [.init(key: "vendor.note", value: .string("kept"))]
        )
        let text = String(decoding: try serializer.serialize(envelope.canonicalValue), as: UTF8.self)
        #expect(text == #"{"content":"fact","optionalExtensions":{"vendor.note":"kept"},"profile":"fitnessai-canonical-v1","requiredCapabilities":[]}"#)
    }

    @Test("Malformed UTF-8 never becomes a partial canonical value")
    func malformedUTF8() {
        let malformedJSONString = Data([0x22, 0xFF, 0x22])
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(String.self, from: malformedJSONString)
        }
    }
}
