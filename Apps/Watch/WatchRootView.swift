import SwiftUI

struct WatchRootView: View {
    @State private var state = WatchAppState()

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            Group {
                switch state.phase {
                case .entry: WorkoutEntryView(state: $state)
                case .active: ActiveWorkoutView(state: $state)
                case .restResolution: RestResolutionView(state: $state)
                case .finishReview: FinishReviewView(state: $state)
                case .recovery: RecoveryView(state: $state)
                }
            }
        }
        .foregroundStyle(Color("TextPrimary"))
        .accessibilityIdentifier("watch.training-ledger-preview")
    }
}

private struct WorkoutEntryView: View {
    @Binding var state: WatchAppState

    var body: some View {
        WatchAdaptiveScroll {
            VStack(alignment: .leading, spacing: 8) {
                PreviewPill()
                Text("力量周期 · 修订版 8")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("PlanText"))
                Text("下肢力量")
                    .font(.headline.weight(.semibold))
                HStack(alignment: .center, spacing: 10) {
                    WatchRail(saved: 0, current: 1, total: 5)
                    VStack(alignment: .leading, spacing: 4) {
                        Label("计划已送达 · 示例", systemImage: "checkmark.circle.fill")
                            .font(.caption2)
                            .foregroundStyle(Color("ConfirmedText"))
                        Text("杠铃深蹲")
                            .font(.caption.weight(.semibold))
                        Text("5 × 5 · 80 kg")
                            .font(.caption2)
                            .foregroundStyle(Color("TextSecondary"))
                    }
                }
                Button("开始计划训练") { state.startWorkout() }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("预览训练恢复") { state.showRecovery() }
                    .font(.caption)
                    .foregroundStyle(Color("PendingText"))
            }
        }
        .accessibilityIdentifier("watch.workout-entry")
    }
}

private struct ActiveWorkoutView: View {
    @Binding var state: WatchAppState

    var body: some View {
        WatchAdaptiveScroll {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("18:42").font(.caption2).foregroundStyle(Color("TextSecondary"))
                    Spacer()
                    Button("结束") { state.showFinishReview() }
                        .font(.caption)
                        .foregroundStyle(Color("PendingText"))
                }
                PreviewPill()
                Text("杠铃深蹲")
                    .font(.headline.weight(.semibold))
                HStack(alignment: .center, spacing: 10) {
                    WatchRail(saved: state.savedSets, current: state.currentSet, total: state.totalSets)
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(alignment: .firstTextBaseline, spacing: 3) {
                            Text("77.5").font(.largeTitle.bold()).fontWidth(.condensed)
                            Text("kg").font(.caption.weight(.semibold))
                        }
                        Text("计划 80 kg · 5 次 · RPE 8")
                            .font(.caption2)
                            .foregroundStyle(Color("PlanText"))
                    }
                }
                Text("预览：\(state.savedSets) 组处于已保存状态")
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(Color("ConfirmedText"))
                Button("完成第 \(state.currentSet) 组") { state.simulateSetCommit() }
                    .buttonStyle(WatchPrimaryButtonStyle(actual: true))
                    .accessibilityHint("仅模拟保存后的界面状态，不会保存训练数据")
                Button("处理休息提示") { state.showRestResolution() }
                    .font(.caption)
                    .foregroundStyle(Color("PendingText"))
            }
        }
        .accessibilityIdentifier("watch.active-workout")
    }
}

private struct RestResolutionView: View {
    @Binding var state: WatchAppState

    var body: some View {
        WatchAdaptiveScroll {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Text("休息 · 示例提示")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("PendingText"))
                Text("已保留 5 次和 77.5 kg")
                    .font(.headline)
                Text("刚才是杠铃深蹲吗？")
                    .font(.body)
                    .foregroundStyle(Color("TextSecondary"))
                Button("确认") { state.resolveRest() }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("稍后处理") { state.resolveRest() }
                    .font(.caption)
            }
        }
        .accessibilityIdentifier("watch.rest-resolution")
    }
}

private struct FinishReviewView: View {
    @Binding var state: WatchAppState

    var body: some View {
        WatchAdaptiveScroll {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Text("结束前检查")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("ActualMark"))
                Text("预览中有 \(state.savedSets) 组")
                    .font(.title3.bold())
                Label("有 1 项示例内容未确认", systemImage: "exclamationmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(Color("PendingText"))
                Text("这里仅预览未完整结束的状态，不会保存或发送到手机。")
                    .font(.caption2)
                    .foregroundStyle(Color("TextSecondary"))
                Button("预览：以未完成状态结束") { state.phase = .entry }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("继续训练") { state.resumeWorkout() }
                    .font(.caption)
            }
        }
        .accessibilityIdentifier("watch.finish-review")
    }
}

private struct RecoveryView: View {
    @Binding var state: WatchAppState

    var body: some View {
        WatchAdaptiveScroll {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Label("已恢复训练", systemImage: "arrow.clockwise.circle.fill")
                    .font(.headline)
                    .foregroundStyle(Color("ConfirmedText"))
                Text("示例持久状态：杠铃深蹲 · 3 组")
                    .font(.caption)
                Text("仍有一段待处理数据，未与已保存记录合并。")
                    .font(.caption2)
                    .foregroundStyle(Color("PendingText"))
                Button("恢复训练") { state.resumeWorkout() }
                    .buttonStyle(WatchPrimaryButtonStyle(actual: true))
                Button("以未完成状态结束") { state.showFinishReview() }
                    .font(.caption)
                    .foregroundStyle(Color("PendingText"))
            }
        }
        .accessibilityIdentifier("watch.recovery")
    }
}

private struct WatchRail: View {
    let saved: Int
    let current: Int
    let total: Int

    var body: some View {
        VStack(spacing: 4) {
            ForEach(1...total, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(index <= saved ? Color("ConfirmedText") : .clear)
                    .overlay {
                        RoundedRectangle(cornerRadius: 2)
                            .stroke(index == current ? Color("ActualMark") : Color("PlanMark"), lineWidth: index == current ? 2 : 1)
                    }
                    .frame(width: 8, height: 12)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("训练顺序")
        .accessibilityValue("共 \(total) 组，预览中已保存 \(saved) 组，当前为第 \(current) 组")
    }
}

private struct PreviewPill: View {
    var body: some View {
        Text("界面预览 · 不保存数据")
            .font(.system(.caption2, design: .rounded).weight(.bold))
            .foregroundStyle(Color("ActualMark"))
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 7))
    }
}

private struct WatchAdaptiveScroll<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    @ViewBuilder let content: Content

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                content
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, geometry.size.width < 190 ? 6 : 10)
                    .padding(.vertical, dynamicTypeSize.isAccessibilitySize ? 8 : 4)
            }
            .scrollIndicators(.automatic)
        }
    }
}

private struct WatchPrimaryButtonStyle: ButtonStyle {
    var actual = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.weight(.semibold))
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: 48)
            .foregroundStyle(Color("OnFilled"))
            .background(
                (actual ? Color("ActualMark") : Color("ActionPrimary"))
                    .opacity(configuration.isPressed ? 0.82 : 1),
                in: RoundedRectangle(cornerRadius: 16)
            )
    }
}
