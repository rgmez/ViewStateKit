//
//  LoadableContentViewModel.swift
//  watchOSExampleApp
//
//  Created by Roberto Gómez on 31/12/25.
//

import Foundation
import Observation
import ViewStateKit

@MainActor
@Observable
final class LoadableContentViewModel {
    
    private(set) var state: ViewState<[String], ErrorDisplayModel, EmptyDisplayModel> = .idle
    
    func load(outcome: LoadOutcome = .success) async {
        state = .loading
        try? await Task.sleep(nanoseconds: 700_000_000)
        
        state = switch outcome {
        case .success:
                .content(["Alpha", "Beta", "Gamma"])
        case .empty:
                .empty(.noResults)
        case .failure:
                .error(
                    .init(
                        title: "Error",
                        message: "Unable to load data.",
                        recoverySuggestion: "Try again."
                    )
                )
        }
    }
    
    func reset() {
        state = .idle
    }
}

enum LoadOutcome: String, CaseIterable, Identifiable {
    case success, empty, failure
    var id: String { rawValue }
    
    var displayTitle: String {
        switch self {
        case .success: "Success"
        case .empty: "Empty"
        case .failure: "Failure"
        }
    }
}
