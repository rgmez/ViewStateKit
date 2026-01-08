//
//  AccountSummaryView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI
import ViewStateKit

struct AccountSummaryView: View {
    @State private var viewModel = AccountSummaryViewModel()
    @State private var selectedOutcome: AccountSummaryOutcome = .success
    @State private var showResult = false

    private let title = "Account Summary"

    var body: some View {
        ContainerView(
            title: title,
            selectedOutcome: $selectedOutcome,
            showResult: $showResult,
            outcomes: AccountSummaryOutcome.allCases,
            outcomeTitle: \.id.capitalized,
            load: viewModel.load(outcome:),
            reset: {
                viewModel.reset()
                selectedOutcome = .success
                showResult = false
            }
        )
        .navigationDestination(isPresented: $showResult) {
            StateDrivenView(
                state: viewModel.state) { items in
                    List {
                        Section("Result") {
                            ForEach(items, id: \.self) { item in
                                Text(item)
                                    .lineLimit(2)
                            }
                        }
                    }
                }
        }
    }
}
