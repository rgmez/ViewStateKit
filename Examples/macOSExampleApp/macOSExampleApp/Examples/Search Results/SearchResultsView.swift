//
//  SearchResultsView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI
import ViewStateKit

struct SearchResultsView: View {
    @State private var viewModel = SearchResultsViewModel()
    @State private var selectedOutcome: SearchResultsOutcome = .success

    var body: some View {
        DetailView("Search Results") {
            VStack(spacing: 12) {
                ControlsView(
                    outcome: $selectedOutcome,
                    outcomeTitle: \.id.capitalized,
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
                    }
                )
            }
        }
    }
}
