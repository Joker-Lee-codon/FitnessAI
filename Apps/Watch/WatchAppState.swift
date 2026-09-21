import Foundation

enum WatchPreviewPhase: String, Equatable {
    case entry
    case active
    case restResolution
    case finishReview
    case recovery
}

struct WatchAppState: Equatable {
    var phase: WatchPreviewPhase = .entry
    var savedSets = 3
    let totalSets = 5
    var currentSet: Int { min(savedSets + 1, totalSets) }

    mutating func startWorkout() { phase = .active }
    mutating func showRestResolution() { phase = .restResolution }
    mutating func resolveRest() { phase = .active }
    mutating func showFinishReview() { phase = .finishReview }
    mutating func showRecovery() { phase = .recovery }
    mutating func resumeWorkout() { phase = .active }

    mutating func simulateSetCommit() {
        savedSets = min(savedSets + 1, totalSets)
        phase = savedSets == totalSets ? .finishReview : .active
    }
}
