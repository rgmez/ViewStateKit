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
    if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
        ContentUnavailableView {
            Label(
                PlaceholderContent.title(for: reason),
                systemImage: PlaceholderContent.systemImage(for: reason)
            )
        } description: {
            Text(PlaceholderContent.description(for: reason))
        }
    } else {
        VStack(spacing: 8) {
            Image(systemName: PlaceholderContent.systemImage(for: reason))
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(PlaceholderContent.title(for: reason))
                .font(.headline)
                .foregroundStyle(.secondary)

            Text(PlaceholderContent.description(for: reason))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

@ViewBuilder
public func errorPlaceholder(_ error: ViewError) -> some View {
    if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
        ContentUnavailableView {
            Label(
                error.title,
                systemImage: "exclamationmark.triangle"
            )
        } description: {
            Text(error.message)
        }
    } else {
        VStack(spacing: 8) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundStyle(.secondary)

            Text(error.title)
                .font(.headline)

            Text(error.message)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let recoverySuggestion = error.recoverySuggestion {
                Text(recoverySuggestion)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

#endif
