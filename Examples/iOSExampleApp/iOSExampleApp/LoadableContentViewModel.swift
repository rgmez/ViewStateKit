//
//  LoadableContentViewModel.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 31/12/25.
//

import Foundation
import Observation
import ViewStateKit

@MainActor
@Observable
final class LoadableContentViewModel {

    private(set) var state: ViewState<[String]> = .idle
    var selectedOutcome: LoadOutcome = .success

    func load() async {
        state = .loading
        try? await Task.sleep(nanoseconds: 800_000_000)

        state = switch selectedOutcome {
        case .success:
            .content(["Alpha", "Beta", "Gamma"])
        case .empty:
            .empty(.noResults)
        case .failure:
            .error(
                .init(
                    title: "Something went wrong",
                    message: "We couldn't load the data right now.",
                    recoverySuggestion: "Please try again."
                )
            )
        }
    }

    func update(state: ViewState<[String]>) {
        self.state = state
    }
}

enum LoadOutcome: String, CaseIterable, Identifiable {
    case success
    case empty
    case failure

    var id: String { rawValue }

    var displayTitle: String {
        return switch self {
        case .success: "Success"
        case .empty: "Empty"
        case .failure: "Failure"
        }
    }
}
