import Domain

public protocol AnalysisSeed: Sendable {
    func accepts(_ seed: DomainSeed) -> Bool
}
