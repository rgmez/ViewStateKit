//
//  StateDrivenPlaceholders.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 28/12/25.
//

#if canImport(SwiftUI)
import SwiftUI

@ViewBuilder
public func emptyPlaceholder(_ reason: EmptyDisplayModel) -> some View {
    ContentUnavailableView {
        Label(
            reason.title,
            systemImage: reason.systemImageName
        )
    } description: {
        Text(reason.message)
    }
}

@ViewBuilder
public func errorPlaceholder(_ error: ErrorDisplayModel) -> some View {
    ContentUnavailableView {
        Label(
            error.title,
            systemImage: "exclamationmark.triangle"
        )
    } description: {
        Text(error.message)
    }
}

#endif
