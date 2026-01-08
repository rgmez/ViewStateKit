//
//  RecentSearchesView.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 6/1/26.
//

import SwiftUI
import ViewStateKit

struct RecentSearchesView: View {
    @State private var selectedOutcome: RecentSearchesOutcome = .success
    @State private var viewModel: RecentSearchesViewModel = .init()

    var body: some View {
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
                    List(items, id: \.self) { Text($0) }
                }
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Recent Searches")
    }
}
