//
//  SearchResultsView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI
import ViewStateKit

struct SearchResultsView: View {
    @State private var viewModel = SearchResultsViewModel()
    @State private var selectedOutcome: SearchResultsOutcome = .success
    @State private var showResult = false

    private let title = "Search Results"

    var body: some View {
        ContainerView(
            title: title,
            selectedOutcome: $selectedOutcome,
            showResult: $showResult,
            outcomes: SearchResultsOutcome.allCases,
            outcomeTitle: \.id,
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
