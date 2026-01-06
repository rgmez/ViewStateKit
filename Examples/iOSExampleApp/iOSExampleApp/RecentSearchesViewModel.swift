//
//  RecentSearchesViewModel.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 6/1/26.
//

import Foundation
import ViewStateKit

@MainActor
@Observable
final class RecentSearchesViewModel {
    private(set) var state: RecentSearchesState = .idle
    
    func load(outcome: RecentSearchesOutcome = .success) async {
        state = .loading
        
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        state = switch outcome {
        case .success: .content([
            "Async let vs task group",
            "Swift testing parameterized tests",
            "State driven view swiftui",
            "Sendable vs @unchecked sendable",
            "Swiftui list performance",
            "Clean architecture ios example",
            "SPM binary target cache",
            "Observation vs combine"
        ])
        case .empty: .empty(.noResults)
        }
    }
    
    func updateState(_ newState: RecentSearchesState) {
        state = newState
    }
}
