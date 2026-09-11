import Foundation

enum RootTab: String, CaseIterable, Identifiable {
    case plan = "Plan"
    case history = "History"
    case analysis = "Analysis"
    case more = "More"

    var id: Self { self }

    var symbol: String {
        switch self {
        case .plan: "calendar"
        case .history: "clock.arrow.circlepath"
        case .analysis: "chart.xyaxis.line"
        case .more: "ellipsis.circle"
        }
    }
}

enum AppDestination: Hashable {}

struct IPhoneAppState: Equatable {
    var selectedTab: RootTab = .plan
    var planDestinations: [AppDestination] = []
}
