import SwiftUI

@main
struct FitnessAIWatchApp: App {
    var body: some Scene {
        WindowGroup {
            WatchRootView()
                .environment(\.locale, Locale(identifier: "zh-Hans-CN"))
        }
    }
}
