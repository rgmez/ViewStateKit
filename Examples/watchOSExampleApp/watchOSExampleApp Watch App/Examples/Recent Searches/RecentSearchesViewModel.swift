//
//  RecentSearchesViewModel.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import Foundation
import ViewStateKit

typealias RecentSearchesState = ViewStateWithoutError<[String], EmptyDisplayModel>

@MainActor
@Observable
final class RecentSearchesViewModel {
    private(set) var state: RecentSearchesState = .idle

    private let recentSearchQueries: [String] = [
        "Async let vs task group",
        "Swift testing parameterized tests",
        "State driven view swiftui",
        "Sendable vs @unchecked sendable",
        "SwiftUI list performance",
        "Clean architecture iOS example",
        "SPM binary target cache",
        "Observation vs combine"
    ]

    func load(outcome: RecentSearchesOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 700_000_000)

        state = switch outcome {
        case .success:
            .content(recentSearchQueries)
        case .empty:
            .empty(.noResults)
        }
    }

    func reset() {
        state = .idle
    }
}

enum RecentSearchesOutcome: String, CaseIterable, Identifiable {
    case success, empty
    var id: String { rawValue }
}
