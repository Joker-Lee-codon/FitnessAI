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
    func testPreviewRendersAcrossWatchScreenClasses() {
        let sizes = [
            CGSize(width: 176, height: 215),
            CGSize(width: 198, height: 242),
            CGSize(width: 205, height: 251)
        ]

        for size in sizes {
            assertRenders(size: size, dynamicTypeSize: .large)
        }

        assertRenders(size: CGSize(width: 176, height: 215), dynamicTypeSize: .accessibility2)
    }

    @MainActor
    private func assertRenders(size: CGSize, dynamicTypeSize: DynamicTypeSize) {
        let view = WatchRootView()
            .environment(\.locale, Locale(identifier: "zh-Hans-CN"))
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, dynamicTypeSize)
            .frame(width: size.width, height: size.height)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(size)
        XCTAssertNotNil(renderer.cgImage, "Watch preview failed at \(size)")
    }
}
