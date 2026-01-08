//
//  AccoutSummaryView.swift
//  tvOSExampleApp
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
            VStack(spacing: 36) {
                ControlsView(
                    outcome: $selectedOutcome,
                    outcomeTitle: \.id.capitalized,
                    action: viewModel.load(outcome:)
                )

                StateDrivenView(
                    state: viewModel.state,
                    content: { summary in
                        VStack(alignment: .leading, spacing: 12) {
                            Text(summary.planName).font(.title2.weight(.semibold))
                            Text("Storage: \(summary.usedStorage) / \(summary.totalStorage)")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    },
                    error: { errorPlaceholder($0).font(.title3) },
                    loading: { ProgressView().scaleEffect(1.6) }
                )
                .padding(24)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            }
        }
    }
}
