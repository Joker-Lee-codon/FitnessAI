import Contracts
import Foundation
import Testing

@Suite("Stable identifiers")
struct StableIdentifiersTests {
    @Test("Generated identifiers are UUIDv4 and survive Codable round trips")
    func generatedIdentityRoundTrip() throws {
        let id = PlanID.generate()
        #expect(id.canonicalValue[id.canonicalValue.index(id.canonicalValue.startIndex, offsetBy: 14)] == "4")

        let data = try JSONEncoder().encode(id)
        let decoded = try JSONDecoder().decode(PlanID.self, from: data)

        #expect(decoded == id)
        #expect(String(decoding: data, as: UTF8.self) == "\"\(id.canonicalValue)\"")
    }

    @Test("RFC hexadecimal case decodes to one lowercase canonical identity")
    func caseNormalization() throws {
        let uppercase = "550E8400-E29B-41D4-A716-446655440000"
        let id = try #require(WorkoutSessionID(canonicalValue: uppercase))

        #expect(id.canonicalValue == "550e8400-e29b-41d4-a716-446655440000")
    }

    @Test("Malformed values fail instead of generating a replacement")
    func malformedIdentityFails() {
        #expect(ActualSetID(canonicalValue: "not-an-id") == nil)
    }

    @Test("Nominal APIs retain their specific identity kind")
    func nominalIdentity() throws {
        let plan = try #require(PlanID(canonicalValue: "550e8400-e29b-41d4-a716-446655440000"))
        #expect(acceptsPlan(plan) == plan.canonicalValue)
    }

    private func acceptsPlan(_ id: PlanID) -> String { id.canonicalValue }
}
