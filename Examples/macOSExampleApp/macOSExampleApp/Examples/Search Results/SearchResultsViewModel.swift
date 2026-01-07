//
//  SearchResultsViewModel.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import Foundation
import ViewStateKit

@MainActor
@Observable
final class SearchResultsViewModel {
    private(set) var state: SearchResultsState = .idle
    private let searchResultItems = [
        "Swift Concurrency: async/await essentials",
        "SwiftUI NavigationStack patterns",
        "Design Patterns in Swift: Bridge",
        "Swift Testing framework: best practices",
        "Observation framework: @Observable in practice",
        "SPM Tips: modularizing feature packages",
        "UIKit to SwiftUI migration: common pitfalls",
        "Performance tuning: Instruments quick wins"
    ]

    func load(outcome: SearchResultsOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 800_000_000)

        state = switch outcome {
        case .success: .content(searchResultItems)
        case .empty: .empty(.noResults)
        case .failure: .error(
            .init(
                title: "Something went wrong",
                message: "We couldn't load the data right now.",
                recoverySuggestion: "Please try again."
            )
        )
        }
    }

    func updateState(_ newState: SearchResultsState) {
        state = newState
    }
}
