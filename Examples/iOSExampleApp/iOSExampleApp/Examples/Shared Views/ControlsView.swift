//
//  ControlsView.swift
//  macOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI

struct ExampleControls<Outcome: CaseIterable & Hashable>: View {
    @Binding var outcome: Outcome
    
    let outcomeTitle: (Outcome) -> String
    let action: (Outcome) async -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Simulated load")
                .font(.headline)
            
            HStack {
                Picker("Outcome", selection: $outcome) {
                    ForEach(Array(Outcome.allCases), id: \.self) { option in
                        Text(outcomeTitle(option))
                            .tag(option)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Load") {
                    Task { await action(outcome) }
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}
