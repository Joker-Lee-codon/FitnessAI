import SwiftUI
import XCTest
@testable import FitnessAI

final class IPhoneAppStateTests: XCTestCase {
    func testPlanIsTheTruthfulDefaultRoot() {
        let state = IPhoneAppState()
        XCTAssertEqual(state.selectedTab, .plan)
        XCTAssertTrue(state.planDestinations.isEmpty)
        XCTAssertEqual(RootTab.allCases.map(\.rawValue), ["Plan", "History", "Analysis", "More"])
    }

    @MainActor
    func testShellRendersUnderAccessibilityAndAppearanceSettings() {
        let view = IPhoneRootView()
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, .accessibility3)
            .frame(width: 390, height: 844)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(width: 390, height: 844)
        XCTAssertNotNil(renderer.cgImage)
    }
}
