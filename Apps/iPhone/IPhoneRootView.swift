import SwiftUI

struct IPhoneRootView: View {
    @State private var state = IPhoneAppState()

    var body: some View {
        TabView(selection: $state.selectedTab) {
            NavigationStack(path: $state.planDestinations) {
                TruthfulEmptyState(
                    title: "No Plan yet",
                    systemImage: "calendar.badge.plus",
                    description: "Your training plan will appear here after you create one."
                )
                .navigationTitle("Plan")
            }
            .tabItem { Label(RootTab.plan.rawValue, systemImage: RootTab.plan.symbol) }
            .tag(RootTab.plan)

            NavigationStack {
                TruthfulEmptyState(title: "No history yet", systemImage: "clock", description: "Completed sessions will appear here.")
                    .navigationTitle("History")
            }
            .tabItem { Label(RootTab.history.rawValue, systemImage: RootTab.history.symbol) }
            .tag(RootTab.history)

            NavigationStack {
                TruthfulEmptyState(title: "No analysis yet", systemImage: "chart.xyaxis.line", description: "Analysis becomes available after recorded training.")
                    .navigationTitle("Analysis")
            }
            .tabItem { Label(RootTab.analysis.rawValue, systemImage: RootTab.analysis.symbol) }
            .tag(RootTab.analysis)

            NavigationStack {
                TruthfulEmptyState(title: "Nothing to configure", systemImage: "ellipsis.circle", description: "Additional settings will appear only when they are available.")
                    .navigationTitle("More")
            }
            .tabItem { Label(RootTab.more.rawValue, systemImage: RootTab.more.symbol) }
            .tag(RootTab.more)
        }
        .tint(Color("ActionPrimary"))
        .accessibilityIdentifier("iphone.root.tabs")
    }
}

private struct TruthfulEmptyState: View {
    let title: String
    let systemImage: String
    let description: String

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            ContentUnavailableView(title, systemImage: systemImage, description: Text(description))
                .foregroundStyle(Color("TextPrimary"), Color("TextSecondary"))
                .padding()
        }
        .accessibilityElement(children: .contain)
        .accessibilityIdentifier("iphone.truthful-empty-state")
    }
}
