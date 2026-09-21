import SwiftUI
import XCTest
@testable import FitnessAI

final class IPhoneAppStateTests: XCTestCase {
    func testTodayIsThePreviewDefaultRoot() {
        let state = IPhoneAppState()
        XCTAssertEqual(state.selectedTab, .today)
        XCTAssertTrue(state.todayDestinations.isEmpty)
        XCTAssertEqual(RootTab.allCases.map(\.rawValue), ["今日", "记录", "分析", "更多"])
        XCTAssertEqual(state.exercises.count, 3)
        XCTAssertEqual(state.sessions.count, 3)
    }

    @MainActor
    func testPreviewRendersAcrossCompactRegularAndLandscapeScreens() {
        let sizes = [
            CGSize(width: 320, height: 568),
            CGSize(width: 390, height: 844),
            CGSize(width: 430, height: 932),
            CGSize(width: 932, height: 430)
        ]

        for size in sizes {
            assertRenders(size: size, dynamicTypeSize: .large)
        }

        assertRenders(size: CGSize(width: 320, height: 568), dynamicTypeSize: .accessibility3)
    }

    @MainActor
    private func assertRenders(size: CGSize, dynamicTypeSize: DynamicTypeSize) {
        let view = IPhoneRootView()
            .environment(\.locale, Locale(identifier: "zh-Hans-CN"))
            .environment(\.colorScheme, .dark)
            .environment(\.dynamicTypeSize, dynamicTypeSize)
            .frame(width: size.width, height: size.height)
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = ProposedViewSize(size)
        XCTAssertNotNil(renderer.cgImage, "iPhone preview failed at \(size)")
    }
}
