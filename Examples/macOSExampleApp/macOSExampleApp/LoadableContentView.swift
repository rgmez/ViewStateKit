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

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                controls
                    .frame(maxWidth: .infinity, alignment: .top)

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
        VStack(alignment: .leading, spacing: 10) {
            Text("Manual states")
                .font(.headline)

            HStack(spacing: 8) {
                Button("Idle") { viewModel.update(state: .idle) }
                Button("Loading") { viewModel.update(state: .loading) }
                Button("Content") { viewModel.update(state: .content(["Alpha", "Beta", "Gamma"])) }
                Button("Empty") { viewModel.update(state: .empty(.noResults)) }
                Button("Error") { viewModel.update(state: .error(ViewError.generic())) }
            }

            Divider()

            HStack(spacing: 12) {
                Text("Simulated load")
                    .font(.headline)

                Picker("Outcome", selection: $viewModel.selectedOutcome) {
                    ForEach(LoadOutcome.allCases) { outcome in
                        Text(outcome.displayTitle).tag(outcome)
                    }
                }
                .pickerStyle(.segmented)
                .frame(maxWidth: 320)

                Spacer()

                Button("Load") {
                    Task { await viewModel.load() }
                }
                .keyboardShortcut(.return, modifiers: [])

                Button("Reset") {
                    viewModel.update(state: .idle)
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
    }

    private var contentArea: some View {
        StateDrivenView(state: viewModel.state) { items in
            List(items, id: \.self) { item in
                Text(item)
            }
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
