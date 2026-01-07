//
//  ControlsView.swift
//  tvOSExampleApp
//
//  Created by Roberto Gómez on 7/1/26.
//

import SwiftUI

struct ControlsView<Outcome: CaseIterable & Hashable>: View {
    @Binding var outcome: Outcome
    
    let outcomeTitle: (Outcome) -> String
    let action: (Outcome) async -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Simulated load")
                .font(.title2.weight(.semibold))
            
            HStack(spacing: 18) {
                Menu {
                    ForEach(Array(Outcome.allCases), id: \.self) { option in
                        Button(outcomeTitle(option)) {
                            outcome = option
                        }
                    }
                } label: {
                    Label(outcomeTitle(outcome), systemImage: "chevron.up.chevron.down")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                Button("Load") {
                    Task { await action(outcome) }
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
    }
}
