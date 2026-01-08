//
//  AccountSummaryView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI
import ViewStateKit

struct AccountSummaryView: View {
    @State private var selectedOutcome: AccountSummaryOutcome = .success
    @State private var viewModel: AccountSummaryViewModel = .init()

    var body: some View {
        DetailView("Account Summary") {
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
                    },
                    error: { errorPlaceholder($0) }
                )
            }
        }
    }
}
