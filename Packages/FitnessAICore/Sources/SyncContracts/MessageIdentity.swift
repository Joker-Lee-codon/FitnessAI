import Contracts

/// Identity metadata only; transport, acknowledgements, and retry scheduling belong to later stories.
public struct MessageIdentity: Codable, Equatable, Hashable, Sendable {
    public let messageID: DeviceMessageID
    public let sourceDeviceID: SourceDeviceID

    public init(messageID: DeviceMessageID, sourceDeviceID: SourceDeviceID) {
        self.messageID = messageID
        self.sourceDeviceID = sourceDeviceID
    }
}
