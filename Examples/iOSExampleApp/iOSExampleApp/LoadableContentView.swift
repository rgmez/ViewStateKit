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
    }

    private var controls: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Manual states")
                .font(.headline)

            HStack {
                Button("Loading") { viewModel.update(state: .loading) }
                Button("Content") { viewModel.update(state: .content(["Alpha", "Beta", "Gamma"])) }
            }

            HStack {
                Button("Empty") { viewModel.update(state: .empty(.noResults)) }
                Button("Error") { viewModel.update(state: .error(ViewError.generic())) }
            }

            Divider().padding(.vertical, 4)

            Text("Simulated load")
                .font(.headline)

            HStack {
                Picker("Outcome", selection: $viewModel.selectedOutcome) {
                    ForEach(LoadOutcome.allCases) { outcome in
                        Text(outcome.displayTitle).tag(outcome)
                    }
                }
                .pickerStyle(.segmented)

                Button("Load") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    private var contentArea: some View {
        StateDrivenView(state: viewModel.state) { items in
            List(items, id: \.self) { item in
                Text(item)
            }
        }
    }
}
