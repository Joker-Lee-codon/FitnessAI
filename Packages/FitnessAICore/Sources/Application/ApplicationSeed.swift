import Analysis
import Domain
import PersistencePorts
import SafetyRules
import SyncContracts

public struct ApplicationSeed: Sendable {
    public init() {}

    public func validateWiring() -> DomainSeed {
        DomainSeed()
    }
}
