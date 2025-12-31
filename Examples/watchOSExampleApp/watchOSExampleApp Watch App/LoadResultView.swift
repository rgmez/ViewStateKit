//
//  Untitled.swift
//  watchOSExampleApp
//
//  Created by Roberto Gómez on 31/12/25.
//

import SwiftUI
import Observation
import ViewStateKit

struct LoadResultView: View {
    @Bindable var viewModel: LoadableContentViewModel

    var body: some View {
        StateDrivenView(state: viewModel.state) { items in
            ScrollView {
                VStack(alignment: .leading, spacing: 6) {
                    ForEach(items, id: \.self) { item in
                        Text("• \(item)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Result")
    }
}
