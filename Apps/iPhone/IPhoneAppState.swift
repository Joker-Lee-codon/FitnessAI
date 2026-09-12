import Foundation

enum RootTab: String, CaseIterable, Identifiable {
    case today = "今日"
    case history = "记录"
    case analysis = "分析"
    case more = "更多"

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
        PreviewExercise(id: 1, name: "杠铃深蹲", plan: "5 × 5 · 80 kg · RPE 8", actual: "5 × 5 · 77.5 kg"),
        PreviewExercise(id: 2, name: "卧推", plan: "4 × 6 · 55 kg · RPE 8", actual: "4 × 6 · 55 kg"),
        PreviewExercise(id: 3, name: "罗马尼亚硬拉", plan: "3 × 8 · 70 kg · RPE 7", actual: nil)
    ]

    let sessions = [
        PreviewSession(id: 1, date: "9 月 11 日", name: "下肢力量", summary: "5 个动作 · 18 组 · 6,240 kg", state: "待复核 · 1 项"),
        PreviewSession(id: 2, date: "9 月 9 日", name: "上肢力量", summary: "6 个动作 · 21 组 · 5,860 kg", state: "已完成"),
        PreviewSession(id: 3, date: "9 月 6 日", name: "全身训练", summary: "7 个动作 · 23 组 · 7,105 kg", state: "已修正")
    ]
}
