import Domain

public protocol SafetyRuleSeed: Sendable {
    func permits(_ seed: DomainSeed) -> Bool
}
