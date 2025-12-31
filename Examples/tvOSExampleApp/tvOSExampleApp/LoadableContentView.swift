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
    
    private let gridColumns = [
        GridItem(.adaptive(minimum: 240), spacing: 16)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                header
                
                contentArea
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .padding(40)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Loadable Content")
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Controls")
                .font(.title2)
                .fontWeight(.semibold)
            
            HStack(spacing: 16) {
                outcomePicker
                
                Button("Load") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Reset") {
                    viewModel.update(state: .idle)
                }
                .buttonStyle(.bordered)
            }
            
            HStack(spacing: 16) {
                Button("Idle") { viewModel.update(state: .idle) }
                Button("Loading") { viewModel.update(state: .loading) }
                Button("Content") { viewModel.update(state: .content(["Alpha", "Beta", "Gamma"])) }
                Button("Empty") { viewModel.update(state: .empty(.noResults)) }
                Button("Error") { viewModel.update(state: .error(ViewError.generic())) }
            }
            .buttonStyle(.bordered)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var outcomePicker: some View {
        Picker("Outcome", selection: $viewModel.selectedOutcome) {
            ForEach(LoadOutcome.allCases) { outcome in
                Text(outcome.displayTitle).tag(outcome)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: 520)
    }
    
    private var contentArea: some View {
        StateDrivenView(state: viewModel.state) { items in
            ScrollView {
                LazyVGrid(columns: gridColumns, alignment: .leading, spacing: 16) {
                    ForEach(items, id: \.self) { item in
                        ItemCard(title: item)
                    }
                }
                .padding(16)
            }
        }
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

private struct ItemCard: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(.white.opacity(0.08), lineWidth: 1)
            )
    }
}
