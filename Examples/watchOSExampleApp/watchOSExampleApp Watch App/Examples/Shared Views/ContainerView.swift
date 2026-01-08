//
//  ContainerView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI
import ViewStateKit

struct ContainerView<Outcome: CaseIterable & Identifiable & Hashable>: View {
    let title: String

    @Binding var selectedOutcome: Outcome
    @Binding var showResult: Bool

    let outcomes: Outcome.AllCases
    let outcomeTitle: (Outcome) -> String

    let load: (Outcome) async -> Void
    let reset: () -> Void

    var body: some View {
        List {
            Section("Controls") {
                outcomePicker(
                    selectedOutcome: $selectedOutcome,
                    outcomes: outcomes,
                    displayTitle: outcomeTitle
                )

                Button("Load") {
                    showResult = true
                    Task { await load(selectedOutcome) }
                }

                Button("Reset") {
                    reset()
                }
            }
        }
        .navigationTitle(title)
    }
}

