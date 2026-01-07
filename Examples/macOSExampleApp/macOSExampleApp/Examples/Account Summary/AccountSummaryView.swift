//
//  AccountSummaryView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI
import ViewStateKit

typealias AccountSummaryState = ViewStateWithoutEmpty<[String], ErrorDisplayModel>

enum AccountSummaryOutcome: String, CaseIterable, Identifiable {
    case success, failure
    var id: String { rawValue }
    var displayTitle: String { rawValue.capitalized }
}

struct AccountSummaryView: View {
    @State private var selectedOutcome: AccountSummaryOutcome = .success
    @State private var viewModel: AccountSummaryViewModel = .init()

    var body: some View {
        DetailView("Account Summary") {
            VStack(spacing: 12) {
                ControlsView(
                    outcome: $selectedOutcome,
                    outcomeTitle: { $0.displayTitle },
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
