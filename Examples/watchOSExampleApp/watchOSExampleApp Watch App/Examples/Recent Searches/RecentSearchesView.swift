//
//  RecentSearchesView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI
import ViewStateKit

struct RecentSearchesView: View {
    @State private var viewModel = RecentSearchesViewModel()
    @State private var selectedOutcome: RecentSearchesOutcome = .success
    @State private var showResult = false

    private let title = "Recent Searches"

    var body: some View {
        ContainerView(
            title: title,
            selectedOutcome: $selectedOutcome,
            showResult: $showResult,
            outcomes: RecentSearchesOutcome.allCases,
            outcomeTitle: \.id.capitalized,
            load: viewModel.load(outcome:),
            reset: {
                viewModel.reset()
                selectedOutcome = .success
                showResult = false
            },
            state: { viewModel.state }
        )
    }
}
