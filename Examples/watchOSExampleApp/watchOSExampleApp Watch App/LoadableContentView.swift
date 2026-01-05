//
//  ContentView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 31/12/25.
//

import SwiftUI
import ViewStateKit

struct LoadableContentWatchView: View {
    @State private var viewModel = LoadableContentViewModel()
    @State private var selectedOutcome: LoadOutcome = .success
    @State private var showsResult = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Text("Outcome")
                    .font(.headline)
                
                HStack(spacing: 6) {
                    Button("✅") { selectedOutcome = .success }
                    Button("📭") { selectedOutcome = .empty }
                    Button("⚠️") { selectedOutcome = .failure }
                }
                .buttonStyle(.bordered)
                
                Button("Show result") {
                    showsResult = true
                    Task { await viewModel.load(outcome: selectedOutcome) }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    viewModel.reset()
                    selectedOutcome = .success
                }
                .buttonStyle(.bordered)
                
                Text("Selected: \(selectedOutcome.displayTitle)")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 10)
            .navigationDestination(isPresented: $showsResult) {
                LoadResultView(viewModel: viewModel)
            }
        }
    }
}
