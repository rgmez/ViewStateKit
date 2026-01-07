//
//  SearchResultsView.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 6/1/26.
//

import SwiftUI
import ViewStateKit

typealias SearchResultsState = ViewState<[String], ErrorDisplayModel, EmptyDisplayModel>

enum SearchResultsOutcome: String, CaseIterable, Identifiable {
    case success, empty, failure
    var id: String { rawValue }
    var displayTitle: String { rawValue.capitalized }
}

struct SearchResultsView: View {
    @State private var selectedOutcome: SearchResultsOutcome = .success
    @State private var viewModel: SearchResultsViewModel = .init()

    var body: some View {
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
                empty: { emptyPlaceholder($0) },
                error: { errorPlaceholder($0) }
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Search Results")
    }
}
