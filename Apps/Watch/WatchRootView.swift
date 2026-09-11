import SwiftUI

struct WatchRootView: View {
    private let state = WatchAppState()

    var body: some View {
        ZStack {
            Color("BackgroundCanvas").ignoresSafeArea()
            VStack(spacing: 10) {
                Image(systemName: "iphone.and.arrow.forward")
                    .font(.title2)
                    .foregroundStyle(Color("ActionPrimary"))
                    .accessibilityHidden(true)
                Text(state.statusTitle)
                    .font(.headline)
                    .foregroundStyle(Color("TextPrimary"))
                    .multilineTextAlignment(.center)
                Text("Create and deliver a compatible Plan from iPhone before starting on Watch.")
                    .font(.footnote)
                    .foregroundStyle(Color("TextSecondary"))
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No Plan delivered. Create and deliver a compatible Plan from iPhone before starting on Watch.")
        .accessibilityIdentifier("watch.no-delivered-plan")
    }
}
