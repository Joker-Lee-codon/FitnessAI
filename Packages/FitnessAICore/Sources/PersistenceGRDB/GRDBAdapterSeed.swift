import GRDB
import PersistencePorts

public struct GRDBAdapterSeed: PersistencePortSeed {
    public init() {}

    public func verifyAvailability() async throws {
        _ = DatabaseQueue.self
    }
}
