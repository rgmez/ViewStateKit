//
//  AccountSummaryView.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 6/1/26.
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
        VStack(spacing: 12) {
            controls

            Divider()

            StateDrivenView(
                state: viewModel.state,
                content: { items in
                    List(items, id: \.self) { Text($0) }
                },
                error: { errorPlaceholder($0) }
            )
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Account Summary")
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Simulated load")
                .font(.headline)

            HStack {
                Picker("Outcome", selection: $selectedOutcome) {
                    ForEach(AccountSummaryOutcome.allCases) { outcome in
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

