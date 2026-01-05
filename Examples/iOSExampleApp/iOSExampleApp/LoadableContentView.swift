//
//  ViewStateDemo.swift
//  iOSExampleApp
//
//  Created by Roberto Gómez on 31/12/25.
//

import SwiftUI
import ViewStateKit

struct LoadableContentView: View {
    @State private var viewModel = LoadableContentViewModel()
    @State private var selectedOutcome: LoadOutcome = .success

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                controls

                Divider()

                contentArea
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Loadable Content")
        }
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Simulated load")
                .font(.headline)

            HStack {
                Picker("Outcome", selection: $selectedOutcome) {
                    ForEach(LoadOutcome.allCases) { outcome in
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

    private var contentArea: some View {
        StateDrivenView(
            state: viewModel.state,
            content: { items in
                List(items, id: \.self) { Text($0) }
            },
            empty: { emptyPlaceholder($0) },
            error: { errorPlaceholder($0) }
        )
    }
}
