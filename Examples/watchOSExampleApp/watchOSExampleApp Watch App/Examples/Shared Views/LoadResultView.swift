//
//  LoadResultView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI
import ViewStateKit

struct LoadResultView<Failure, Empty>: View {
    let title: String
    let state: () -> ViewState<[String], Failure, Empty>

    var body: some View {
        List {
            Section("Result") {
                switch state() {
                case .idle:
                    Text("Idle")
                        .foregroundStyle(.secondary)

                case .loading:
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Loading…")
                    }

                case .content(let items):
                    ForEach(items, id: \.self) { item in
                        Text(item)
                            .lineLimit(2)
                    }

                case .empty(let emptyState):
                    emptyRow(emptyState)

                case .error(let errorState):
                    errorRow(errorState)
                }
            }
        }
        .navigationTitle(title)
    }

    // MARK: - Empty rendering

    @ViewBuilder
    private func emptyRow(_ value: Empty) -> some View {
        if let model = value as? EmptyDisplayModel {
            emptyPlaceholder(model)
        } else if value is Never {
            EmptyView()
        } else {
            Text("Empty")
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Error rendering

    @ViewBuilder
    private func errorRow(_ value: Failure) -> some View {
        if let model = value as? ErrorDisplayModel {
            errorPlaceholder(model)
        } else if value is Never {
            EmptyView()
        } else {
            Text("Error")
                .foregroundStyle(.secondary)
        }
    }
}
