import SwiftUI

struct IPhoneRootView: View {
    @State private var state = IPhoneAppState()

    var body: some View {
        TabView(selection: $state.selectedTab) {
            NavigationStack(path: $state.todayDestinations) {
                TodayLedgerView(state: state)
                    .navigationDestination(for: AppDestination.self) { destination in
                        switch destination {
                        case .sessionReview:
                            SessionReviewView(exercises: state.exercises)
                        case .historyPreview:
                            HistoryLedgerView(sessions: state.sessions)
                        }
                    }
            }
            .tabItem { Label(RootTab.today.rawValue, systemImage: RootTab.today.symbol) }
            .tag(RootTab.today)

            NavigationStack { HistoryLedgerView(sessions: state.sessions) }
                .tabItem { Label(RootTab.history.rawValue, systemImage: RootTab.history.symbol) }
                .tag(RootTab.history)

            NavigationStack {
                PlaceholderLedgerView(
                    title: "Analysis",
                    symbol: "chart.xyaxis.line",
                    message: "Analysis arrives after the local workout loop is functional."
                )
            }
            .tabItem { Label(RootTab.analysis.rawValue, systemImage: RootTab.analysis.symbol) }
            .tag(RootTab.analysis)

            NavigationStack {
                PlaceholderLedgerView(
                    title: "More",
                    symbol: "ellipsis.circle",
                    message: "Account, privacy, and recovery settings are outside this preview milestone."
                )
            }
            .tabItem { Label(RootTab.more.rawValue, systemImage: RootTab.more.symbol) }
            .tag(RootTab.more)
        }
        .tint(Color("ActionPrimary"))
        .accessibilityIdentifier("iphone.root.tabs")
    }
}

private struct TodayLedgerView: View {
    let state: IPhoneAppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PreviewNotice()

                VStack(alignment: .leading, spacing: 6) {
                    Text("STRENGTH BLOCK · REVISION 8")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color("PlanText"))
                    Text("Week 3 of 6")
                        .font(.title2.bold())
                        .foregroundStyle(Color("TextPrimary"))
                    Label("Delivered to Watch", systemImage: "checkmark.circle.fill")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color("ConfirmedText"))
                }

                LedgerSection(title: "NEXT SESSION", railColor: Color("PlanMark")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Lower Strength").font(.title3.bold())
                        Text("3 exercises · about 48 min")
                            .font(.subheadline)
                            .foregroundStyle(Color("TextSecondary"))
                        ForEach(state.exercises) { exercise in
                            VStack(alignment: .leading, spacing: 3) {
                                Text(exercise.name).font(.body.weight(.semibold))
                                Text(exercise.plan)
                                    .font(.caption)
                                    .foregroundStyle(Color("PlanText"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 4)
                        }
                    }
                }

                LedgerSection(title: "RETURNED FROM WATCH", railColor: Color("PendingText")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lower Strength · Sep 11").font(.headline)
                        Label("1 incomplete item needs resolution", systemImage: "exclamationmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(Color("PendingText"))
                        NavigationLink(value: AppDestination.sessionReview) {
                            Label("Review returned session", systemImage: "doc.text.magnifyingglass")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(LedgerPrimaryButtonStyle())
                    }
                }

                NavigationLink("View training history", value: AppDestination.historyPreview)
                    .font(.body.weight(.semibold))
            }
            .padding(16)
        }
        .background(Color("BackgroundCanvas").ignoresSafeArea())
        .foregroundStyle(Color("TextPrimary"))
        .navigationTitle("Today")
        .accessibilityIdentifier("iphone.today-ledger")
    }
}

private struct SessionReviewView: View {
    let exercises: [PreviewExercise]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                PreviewNotice()
                Label("Incomplete · 1 item", systemImage: "exclamationmark.circle.fill")
                    .font(.headline)
                    .foregroundStyle(Color("PendingText"))

                VStack(alignment: .leading, spacing: 4) {
                    Text("Lower Strength").font(.title2.bold())
                    Text("Recorded on Watch · sample receipt state")
                        .font(.subheadline)
                        .foregroundStyle(Color("TextSecondary"))
                }

                LedgerSection(title: "PLAN  ↔  ACTUAL", railColor: Color("ActualMark")) {
                    ForEach(exercises) { exercise in
                        VStack(alignment: .leading, spacing: 7) {
                            Text(exercise.name).font(.headline)
                            LabeledContent("Plan", value: exercise.plan)
                                .foregroundStyle(Color("PlanText"))
                            LabeledContent("Actual", value: exercise.actual ?? "Needs confirmation")
                                .foregroundStyle(exercise.actual == nil ? Color("PendingText") : Color("ActualMark"))
                        }
                        .padding(.vertical, 8)
                        Divider()
                    }
                }

                Button("Resolve 1 incomplete item") {}
                    .buttonStyle(LedgerPrimaryButtonStyle())
                    .accessibilityHint("Preview control; no workout data is changed")
            }
            .padding(16)
        }
        .background(Color("BackgroundCanvas").ignoresSafeArea())
        .foregroundStyle(Color("TextPrimary"))
        .navigationTitle("Session Review")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("iphone.session-review")
    }
}

private struct HistoryLedgerView: View {
    let sessions: [PreviewSession]

    var body: some View {
        List {
            PreviewNotice().listRowBackground(Color("BackgroundCanvas"))
            ForEach(sessions) { session in
                HStack(alignment: .top, spacing: 12) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(session.state.hasPrefix("Needs") ? Color("PendingText") : Color("ConfirmedText"))
                        .frame(width: 3)
                        .accessibilityHidden(true)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(session.date)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color("TextSecondary"))
                        Text(session.name).font(.headline)
                        Text(session.summary)
                            .font(.subheadline)
                            .foregroundStyle(Color("TextSecondary"))
                        Text(session.state)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(session.state.hasPrefix("Needs") ? Color("PendingText") : Color("ConfirmedText"))
                    }
                }
                .padding(.vertical, 6)
                .listRowBackground(Color("Surface"))
                .accessibilityElement(children: .combine)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color("BackgroundCanvas"))
        .navigationTitle("History")
        .accessibilityIdentifier("iphone.history-ledger")
    }
}

private struct PreviewNotice: View {
    var body: some View {
        Label("Interactive UI preview · sample data only", systemImage: "hammer.fill")
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color("ActualMark"))
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 7))
            .accessibilityLabel("Interactive user interface preview. Sample data only. Nothing is saved or synchronized.")
    }
}

private struct LedgerSection<Content: View>: View {
    let title: String
    let railColor: Color
    @ViewBuilder let content: Content

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RoundedRectangle(cornerRadius: 2)
                .fill(railColor)
                .frame(width: 3)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.caption.weight(.bold))
                    .foregroundStyle(Color("TextSecondary"))
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 12))
    }
}

private struct LedgerPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .foregroundStyle(Color("OnFilled"))
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(Color("ActionPrimary").opacity(configuration.isPressed ? 0.82 : 1), in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct PlaceholderLedgerView: View {
    let title: String
    let symbol: String
    let message: String

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            ContentUnavailableView(title, systemImage: symbol, description: Text(message))
                .foregroundStyle(Color("TextPrimary"), Color("TextSecondary"))
                .padding()
        }
        .navigationTitle(title)
    }
}
