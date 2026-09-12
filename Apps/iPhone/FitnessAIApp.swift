import SwiftUI

@main
struct FitnessAIApp: App {
    var body: some Scene {
        WindowGroup {
            IPhoneRootView()
                .environment(\.locale, Locale(identifier: "zh-Hans-CN"))
        }
    }
}
