//
//  StateDrivenPlaceholders.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 28/12/25.
//

#if canImport(SwiftUI)
import SwiftUI

@ViewBuilder
public func emptyPlaceholder(reason: EmptyReason?) -> some View {
    ContentUnavailableView {
        Label(
            PlaceholderContent.title(for: reason),
            systemImage: PlaceholderContent.systemImage(for: reason)
        )
    } description: {
        Text(PlaceholderContent.description(for: reason))
    }
}

@ViewBuilder
public func errorPlaceholder(_ error: ViewError) -> some View {
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
