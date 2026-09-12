import Foundation

enum RootTab: String, CaseIterable, Identifiable {
    case today = "Today"
    case history = "History"
    case analysis = "Analysis"
    case more = "More"

    var id: Self { self }

    var symbol: String {
        switch self {
        case .today: "calendar"
        case .history: "clock.arrow.circlepath"
        case .analysis: "chart.xyaxis.line"
        case .more: "ellipsis.circle"
        }
    }
}

enum AppDestination: Hashable {
    case sessionReview
    case historyPreview
}

struct PreviewExercise: Identifiable, Equatable {
    let id: Int
    let name: String
    let plan: String
    let actual: String?
}

struct PreviewSession: Identifiable, Equatable {
    let id: Int
    let date: String
    let name: String
    let summary: String
    let state: String
}

struct IPhoneAppState: Equatable {
    var selectedTab: RootTab = .today
    var todayDestinations: [AppDestination] = []

    let exercises = [
        PreviewExercise(id: 1, name: "Back Squat", plan: "5 × 5 · 80 kg · RPE 8", actual: "5 × 5 · 77.5 kg"),
        PreviewExercise(id: 2, name: "Bench Press", plan: "4 × 6 · 55 kg · RPE 8", actual: "4 × 6 · 55 kg"),
        PreviewExercise(id: 3, name: "Romanian Deadlift", plan: "3 × 8 · 70 kg · RPE 7", actual: nil)
    ]

    let sessions = [
        PreviewSession(id: 1, date: "SEP 11", name: "Lower Strength", summary: "5 exercises · 18 sets · 6,240 kg", state: "Needs review · 1 item"),
        PreviewSession(id: 2, date: "SEP 09", name: "Upper Strength", summary: "6 exercises · 21 sets · 5,860 kg", state: "Complete"),
        PreviewSession(id: 3, date: "SEP 06", name: "Full Body", summary: "7 exercises · 23 sets · 7,105 kg", state: "Corrected")
    ]
}
