import SwiftUI
import XCTest
@testable import FitnessAI_Watch

final class WatchAppStateTests: XCTestCase {
    func testPreviewPhaseTransitionsRemainDeterministic() {
        var state = WatchAppState()
        XCTAssertEqual(state.phase, .entry)
        state.startWorkout()
        XCTAssertEqual(state.phase, .active)
        state.showRestResolution()
        XCTAssertEqual(state.phase, .restResolution)
        state.resolveRest()
        XCTAssertEqual(state.phase, .active)
        state.simulateSetCommit()
        XCTAssertEqual(state.savedSets, 4)
        XCTAssertEqual(state.phase, .active)
        state.simulateSetCommit()
        XCTAssertEqual(state.savedSets, 5)
        XCTAssertEqual(state.phase, .finishReview)
    }

    @MainActor
    func testPreviewRendersUnderAccessibilityAndAppearanceSettings() {
        let view = WatchRootView()
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, .accessibility1)
            .frame(width: 198, height: 242)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(width: 198, height: 242)
        XCTAssertNotNil(renderer.cgImage)
    }
}
