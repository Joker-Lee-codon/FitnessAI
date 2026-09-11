import Domain

public protocol PersistencePortSeed: Sendable {
    func verifyAvailability() async throws
}
