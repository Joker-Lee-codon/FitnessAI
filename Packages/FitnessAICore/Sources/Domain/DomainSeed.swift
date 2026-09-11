import Contracts

public struct DomainSeed: Equatable, Sendable {
    public let contractGeneration: Int

    public init(contractGeneration: Int = ContractSeed.schemaGeneration) {
        self.contractGeneration = contractGeneration
    }
}
