//
//  ContentView.swift
//  macOSExampleApp
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
        .frame(minWidth: 700, minHeight: 520)
    }

    private var controls: some View {
        HStack(spacing: 12) {
            Text("Simulated load")
                .font(.headline)

            Picker("Outcome", selection: $selectedOutcome) {
                ForEach(LoadOutcome.allCases) { outcome in
                    Text(outcome.displayTitle).tag(outcome)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 320)

            Spacer()

            Button("Load") {
                Task { await viewModel.load(outcome: selectedOutcome) }
            }
            .keyboardShortcut(.return, modifiers: [])

            Button("Reset") {
                viewModel.update(state: .idle)
            }
            .keyboardShortcut("r", modifiers: [.command])
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
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
