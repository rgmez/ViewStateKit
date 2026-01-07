//
//  SearchResultsView.swift
//  tvOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
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
    @State private var viewModel = SearchResultsViewModel()
    @State private var selectedOutcome: SearchResultsOutcome = .success

    var body: some View {
        DetailView("Search Results") {
            VStack(spacing: 36) {
                ControlsView(
                    outcome: $selectedOutcome,
                    outcomeTitle: { $0.displayTitle },
                    action: viewModel.load(outcome:)
                )

                resultsContent
            }
        }
    }

    private var resultsContent: some View {
        StateDrivenView(
            state: viewModel.state,
            content: { items in
                List(items, id: \.self) { Text($0).font(.title3) }
            },
            empty: { emptyPlaceholder($0).font(.title3) },
            error: { errorPlaceholder($0).font(.title3) },
            loading: { ProgressView().scaleEffect(1.6) },
            idle: {
                Text("Choose a state or press Load.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
        )
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}
