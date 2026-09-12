import SwiftUI
import XCTest
@testable import FitnessAI

final class IPhoneAppStateTests: XCTestCase {
    func testTodayIsThePreviewDefaultRoot() {
        let state = IPhoneAppState()
        XCTAssertEqual(state.selectedTab, .today)
        XCTAssertTrue(state.todayDestinations.isEmpty)
        XCTAssertEqual(RootTab.allCases.map(\.rawValue), ["Today", "History", "Analysis", "More"])
        XCTAssertEqual(state.exercises.count, 3)
        XCTAssertEqual(state.sessions.count, 3)
    }

    @MainActor
    func testPreviewRendersUnderAccessibilityAndAppearanceSettings() {
        let view = IPhoneRootView()
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, .accessibility3)
            .frame(width: 390, height: 844)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(width: 390, height: 844)
        XCTAssertNotNil(renderer.cgImage)
    }
}
