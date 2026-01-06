//
//  RecentSearchesView.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 6/1/26.
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
        VStack(spacing: 12) {
            controls

            Divider()

            StateDrivenView(
                state: viewModel.state,
                content: { items in
                    List(items, id: \.self) { Text($0) }
                },
                empty: { emptyPlaceholder($0) }
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Recent Searches")
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Simulated load")
                .font(.headline)

            HStack {
                Picker("Outcome", selection: $selectedOutcome) {
                    ForEach(RecentSearchesOutcome.allCases) { outcome in
                        Text(outcome.displayTitle).tag(outcome)
                    }
                }
                .pickerStyle(.segmented)

                Button("Load") {
                    Task { await viewModel.load(outcome: selectedOutcome) }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
