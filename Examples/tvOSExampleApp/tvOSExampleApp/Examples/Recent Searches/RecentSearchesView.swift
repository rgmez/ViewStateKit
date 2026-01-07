//
//  RecentSearchesView.swift
//  tvOSExampleApp
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
    @State private var viewModel = RecentSearchesViewModel()
    @State private var selectedOutcome: RecentSearchesOutcome = .success

    var body: some View {
        DetailView("Recent Searches") {
            VStack(spacing: 36) {
                ControlsView(
                    outcome: $selectedOutcome,
                    outcomeTitle: { $0.displayTitle },
                    action: viewModel.load(outcome:)
                )

                StateDrivenView(
                    state: viewModel.state,
                    content: { items in
                        List(items, id: \.self) { Text($0).font(.title3) }
                    },
                    empty: { emptyPlaceholder($0).font(.title3) }
                )
                .padding(24)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            }
        }
    }
}
