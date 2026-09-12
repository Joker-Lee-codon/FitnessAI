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
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Text("STRENGTH BLOCK · R8")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("PlanText"))
                Text("Lower Strength")
                    .font(.headline.weight(.semibold))
                Label("Delivered plan · sample", systemImage: "checkmark.circle.fill")
                    .font(.caption2)
                    .foregroundStyle(Color("ConfirmedText"))
                WatchRail(saved: 0, current: 1, total: 5)
                Text("Back Squat · 5 × 5 · 80 kg")
                    .font(.caption)
                    .foregroundStyle(Color("TextSecondary"))
                Button("Start planned workout") { state.startWorkout() }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("Preview recovery") { state.showRecovery() }
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
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("18:42").font(.caption2).foregroundStyle(Color("TextSecondary"))
                    Spacer()
                    Button("Finish") { state.showFinishReview() }
                        .font(.caption)
                        .foregroundStyle(Color("PendingText"))
                }
                PreviewPill()
                Text("Back Squat")
                    .font(.headline.weight(.semibold))
                HStack(alignment: .center, spacing: 10) {
                    WatchRail(saved: state.savedSets, current: state.currentSet, total: state.totalSets)
                    VStack(alignment: .leading, spacing: 1) {
                        HStack(alignment: .firstTextBaseline, spacing: 3) {
                            Text("77.5").font(.largeTitle.bold()).fontWidth(.condensed)
                            Text("kg").font(.caption.weight(.semibold))
                        }
                        Text("Plan 80 kg · 5 reps · RPE 8")
                            .font(.caption2)
                            .foregroundStyle(Color("PlanText"))
                    }
                }
                Text("Preview: \(state.savedSets) sets in saved state")
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(Color("ConfirmedText"))
                Button("Complete set \(state.currentSet)") { state.simulateSetCommit() }
                    .buttonStyle(WatchPrimaryButtonStyle(actual: true))
                    .accessibilityHint("Simulates the saved visual state; no workout data is stored")
                Button("Resolve rest prompt") { state.showRestResolution() }
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
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Text("REST · SAMPLE PROMPT")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("PendingText"))
                Text("5 reps and 77.5 kg preserved")
                    .font(.headline)
                Text("Was that Back Squat?")
                    .font(.body)
                    .foregroundStyle(Color("TextSecondary"))
                Button("Confirm") { state.resolveRest() }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("Later") { state.resolveRest() }
                    .font(.caption)
            }
        }
        .accessibilityIdentifier("watch.rest-resolution")
    }
}

private struct FinishReviewView: View {
    @Binding var state: WatchAppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Text("FINISH REVIEW")
                    .font(.caption2.weight(.semibold))
                    .foregroundStyle(Color("ActualMark"))
                Text("\(state.savedSets) sets in preview")
                    .font(.title3.bold())
                Label("1 sample item unresolved", systemImage: "exclamationmark.circle.fill")
                    .font(.caption)
                    .foregroundStyle(Color("PendingText"))
                Text("This previews an incomplete finish. Nothing will be saved or returned to iPhone.")
                    .font(.caption2)
                    .foregroundStyle(Color("TextSecondary"))
                Button("Preview finish as incomplete") { state.phase = .entry }
                    .buttonStyle(WatchPrimaryButtonStyle())
                Button("Continue workout") { state.resumeWorkout() }
                    .font(.caption)
            }
        }
        .accessibilityIdentifier("watch.finish-review")
    }
}

private struct RecoveryView: View {
    @Binding var state: WatchAppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                PreviewPill()
                Label("Workout recovered", systemImage: "arrow.clockwise.circle.fill")
                    .font(.headline)
                    .foregroundStyle(Color("ConfirmedText"))
                Text("Sample durable state: Back Squat · 3 sets")
                    .font(.caption)
                Text("One pending fragment remains separate and unresolved.")
                    .font(.caption2)
                    .foregroundStyle(Color("PendingText"))
                Button("Resume workout") { state.resumeWorkout() }
                    .buttonStyle(WatchPrimaryButtonStyle(actual: true))
                Button("Finish as incomplete") { state.showFinishReview() }
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
        .accessibilityLabel("Training sequence")
        .accessibilityValue("\(saved) of \(total) sets in saved preview state, set \(current) current")
    }
}

private struct PreviewPill: View {
    var body: some View {
        Text("UI PREVIEW · NO DATA SAVED")
            .font(.system(.caption2, design: .rounded).weight(.bold))
            .foregroundStyle(Color("ActualMark"))
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
            .background(Color("Surface"), in: RoundedRectangle(cornerRadius: 7))
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
