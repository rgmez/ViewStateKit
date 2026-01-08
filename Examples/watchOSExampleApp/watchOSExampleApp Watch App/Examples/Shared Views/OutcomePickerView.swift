//
//  OutcomePickerView.swift
//  watchOSExampleApp Watch App
//
//  Created by Roberto Gómez on 8/1/26.
//

import SwiftUI

@ViewBuilder
func outcomePicker<Outcome: CaseIterable & Identifiable & Hashable>(
    title: String = "Outcome",
    selectedOutcome: Binding<Outcome>,
    outcomes: Outcome.AllCases,
    displayTitle: @escaping (Outcome) -> String
) -> some View {
    Picker(title, selection: selectedOutcome) {
        ForEach(Array(outcomes)) { outcome in
            Text(displayTitle(outcome))
                .tag(outcome)
        }
    }
    .pickerStyle(.navigationLink)
}
