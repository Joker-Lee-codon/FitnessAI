import Contracts
import Foundation
import SyncContracts
import Testing

@Suite("Sync message identity")
struct MessageIdentityTests {
    @Test("Decode and replay preserve supplied identities")
    func replayPreservesIdentity() throws {
        let source = #"{"messageID":"550E8400-E29B-41D4-A716-446655440000","sourceDeviceID":"7d444840-9dc0-4f4a-b2f0-6b0c885c067f"}"#
        let decoded = try JSONDecoder().decode(MessageIdentity.self, from: Data(source.utf8))
        let replayed = MessageIdentity(
            messageID: decoded.messageID,
            sourceDeviceID: decoded.sourceDeviceID
        )

        #expect(replayed == decoded)
        #expect(replayed.messageID.canonicalValue == "550e8400-e29b-41d4-a716-446655440000")
        #expect(replayed.sourceDeviceID.canonicalValue == "7d444840-9dc0-4f4a-b2f0-6b0c885c067f")
    }
}
