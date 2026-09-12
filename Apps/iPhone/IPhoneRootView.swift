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
                    title: "训练分析",
                    symbol: "chart.xyaxis.line",
                    message: "完成本地训练闭环后，这里将展示训练趋势和分析。"
                )
            }
            .tabItem { Label(RootTab.analysis.rawValue, systemImage: RootTab.analysis.symbol) }
            .tag(RootTab.analysis)

            NavigationStack {
                PlaceholderLedgerView(
                    title: "更多",
                    symbol: "ellipsis.circle",
                    message: "账户、隐私和恢复设置将在后续版本中开放。"
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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                PreviewNotice()

                VStack(alignment: .leading, spacing: 6) {
                    Text("力量周期 · 修订版 8")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color("PlanText"))
                    Text("第 3 周，共 6 周")
                        .font(.title2.bold())
                        .foregroundStyle(Color("TextPrimary"))
                    Label("已发送至手表", systemImage: "checkmark.circle.fill")
                        .font(.subheadline.weight(.medium))
                        .foregroundStyle(Color("ConfirmedText"))
                }

                LedgerSection(title: "下一次训练", railColor: Color("PlanMark")) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("下肢力量").font(.title3.bold())
                        Text("3 个动作 · 预计 48 分钟")
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

                LedgerSection(title: "手表训练记录", railColor: Color("PendingText")) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("下肢力量 · 9 月 11 日").font(.headline)
                        Label("有 1 项未完成内容需要确认", systemImage: "exclamationmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(Color("PendingText"))
                        NavigationLink(value: AppDestination.sessionReview) {
                            Label("复核训练记录", systemImage: "doc.text.magnifyingglass")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(LedgerPrimaryButtonStyle())
                    }
                }

                NavigationLink("查看训练历史", value: AppDestination.historyPreview)
                    .font(.body.weight(.semibold))
                }
                .frame(maxWidth: 680, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, horizontalSizeClass == .regular ? 32 : 16)
                .padding(.vertical, 12)
            }
        }
        .foregroundStyle(Color("TextPrimary"))
        .navigationTitle("今日")
        .accessibilityIdentifier("iphone.today-ledger")
    }
}

private struct SessionReviewView: View {
    let exercises: [PreviewExercise]
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                PreviewNotice()
                Label("未完成 · 1 项", systemImage: "exclamationmark.circle.fill")
                    .font(.headline)
                    .foregroundStyle(Color("PendingText"))

                VStack(alignment: .leading, spacing: 4) {
                    Text("下肢力量").font(.title2.bold())
                    Text("由手表记录 · 示例接收状态")
                        .font(.subheadline)
                        .foregroundStyle(Color("TextSecondary"))
                }

                LedgerSection(title: "计划  ↔  实际", railColor: Color("ActualMark")) {
                    ForEach(exercises) { exercise in
                        VStack(alignment: .leading, spacing: 7) {
                            Text(exercise.name).font(.headline)
                            LabeledContent("计划", value: exercise.plan)
                                .foregroundStyle(Color("PlanText"))
                            LabeledContent("实际", value: exercise.actual ?? "需要确认")
                                .foregroundStyle(exercise.actual == nil ? Color("PendingText") : Color("ActualMark"))
                        }
                        .padding(.vertical, 8)
                        Divider()
                    }
                }

                Button("处理 1 项未完成内容") {}
                    .buttonStyle(LedgerPrimaryButtonStyle())
                    .accessibilityHint("预览控件，不会修改训练数据")
                }
                .frame(maxWidth: 680, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, horizontalSizeClass == .regular ? 32 : 16)
                .padding(.vertical, 12)
            }
        }
        .foregroundStyle(Color("TextPrimary"))
        .navigationTitle("训练复核")
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier("iphone.session-review")
    }
}

private struct HistoryLedgerView: View {
    let sessions: [PreviewSession]
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    PreviewNotice()
                    ForEach(sessions) { session in
                        HStack(alignment: .top, spacing: 12) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(session.state.hasPrefix("待") ? Color("PendingText") : Color("ConfirmedText"))
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
                                    .foregroundStyle(session.state.hasPrefix("待") ? Color("PendingText") : Color("ConfirmedText"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(16)
                        .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 12))
                        .accessibilityElement(children: .combine)
                    }
                }
                .frame(maxWidth: 680, alignment: .leading)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, horizontalSizeClass == .regular ? 32 : 16)
                .padding(.vertical, 12)
            }
        }
        .navigationTitle("训练记录")
        .accessibilityIdentifier("iphone.history-ledger")
    }
}

private struct PreviewNotice: View {
    var body: some View {
        Label("交互界面预览 · 仅使用示例数据", systemImage: "hammer.fill")
            .font(.caption.weight(.semibold))
            .foregroundStyle(Color("ActualMark"))
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 7))
            .accessibilityLabel("交互界面预览，仅使用示例数据，不会保存或同步任何内容")
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
