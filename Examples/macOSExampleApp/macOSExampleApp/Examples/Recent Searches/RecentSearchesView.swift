//
//  RecentSearchesView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI
import ViewStateKit

typealias RecentSearchesState = ViewStateWithoutError<[String], EmptyDisplayModel>

enum RecentSearchesOutcome: String, CaseIterable, Identifiable {
    case success, empty
    var id: String { rawValue }
    var displayTitle: String { rawValue.capitalized }
}

struct RecentSearchesView: View {
    @State private var selectedOutcome: RecentSearchesOutcome = .success
    @State private var viewModel: RecentSearchesViewModel = .init()

    var body: some View {
        DetailView("Recent Searches") {
            VStack(spacing: 12) {
                ExampleControls(
                    outcome: $selectedOutcome,
                    outcomeTitle: { $0.displayTitle },
                    action: viewModel.load(outcome:)
                )
                
                Divider()
                
                StateDrivenView(
                    state: viewModel.state,
                    content: { items in
                        List(items, id: \.self) { Text($0) }
                    },
                    empty: { emptyPlaceholder($0) }
                )
            }
        }
    }
}
