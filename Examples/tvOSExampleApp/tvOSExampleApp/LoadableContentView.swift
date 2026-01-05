//
//  ContentView.swift
//  tvOSExampleApp
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
            VStack(spacing: 36) {
                controls
                    .frame(maxWidth: .infinity, alignment: .top)
                
                contentArea
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(60)
            .navigationTitle("Loadable Content")
        }
    }
    
    private var controls: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Simulated load")
                .font(.title2.weight(.semibold))
            
            HStack(spacing: 18) {
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
                .controlSize(.large)
            }
        }
    }
    
    private var contentArea: some View {
        StateDrivenView(
            state: viewModel.state,
            content: { items in
                List(items, id: \.self) {
                    Text($0).font(.title3)
                }
            },
            empty: {
                emptyPlaceholder($0).font(.title3)
            },
            error: {
                errorPlaceholder($0).font(.title3)
            },
            loading: {
                ProgressView()
                    .scaleEffect(1.6)
            },
            idle: {
                Text("Choose a state or press Load.")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
        )
        .padding(24)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}
