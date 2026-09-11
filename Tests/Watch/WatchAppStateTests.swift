import SwiftUI
import XCTest
@testable import FitnessAI_Watch

final class WatchAppStateTests: XCTestCase {
    func testEmptyStateDoesNotClaimACompatibleDeliveredPlan() {
        let state = WatchAppState()
        XCTAssertFalse(state.hasCompatibleDeliveredPlan)
        XCTAssertEqual(state.statusTitle, "No Plan delivered")
    }

    @MainActor
    func testShellRendersUnderAccessibilityAndAppearanceSettings() {
        let view = WatchRootView()
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, .accessibility1)
            .frame(width: 198, height: 242)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(width: 198, height: 242)
        XCTAssertNotNil(renderer.cgImage)
    }
}
