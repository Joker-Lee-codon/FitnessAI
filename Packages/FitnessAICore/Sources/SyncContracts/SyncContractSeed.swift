import Contracts

public protocol SyncContractSeed: Sendable {
    var contractGeneration: Int { get }
}
