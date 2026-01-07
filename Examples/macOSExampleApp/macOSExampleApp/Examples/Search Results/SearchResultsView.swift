//
//  SearchResultsView.swift
//  macOSExampleApp
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
                        List {
                            Section {
                                ForEach(items, id: \.self) { item in
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(item)
                                            .font(.body)
                                        Text("Tap to open")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, 4)
                                }
                            } header: {
                                Text("Results")
                            }
                        }
                        .listStyle(.inset)
                    },
                    empty: { emptyPlaceholder($0) },
                    error: { errorPlaceholder($0) }
                )
            }
        }
    }
}
