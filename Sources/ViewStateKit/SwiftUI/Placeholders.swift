//
//  StateDrivenPlaceholders.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 28/12/25.
//

#if canImport(SwiftUI)
import SwiftUI

/// Default placeholder view for the `.empty` state when using `EmptyDisplayModel`.
///
/// This helper builds a `ContentUnavailableView` using:
/// - `reason.title` as the main title
/// - `reason.systemImageName` as the SF Symbol for the leading icon
/// - `reason.message` as the description text
///
/// Use this as the default `empty:` builder in `StateDrivenView`, or call it directly when you want a consistent “empty state” UI across screens.
///
/// - Parameter reason: A display-ready model describing why the content is empty.
/// - Returns: A SwiftUI view suitable for an empty state.
///
/// ### Example
/// ```swift
/// StateDrivenView(state: state) { items in
///     ItemsList(items: items)
/// } empty: { model in
///     emptyPlaceholder(model)
/// }
/// ```
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

/// Default placeholder view for the `.error` state when using `ErrorDisplayModel`.
///
/// This helper builds a `ContentUnavailableView` using:
/// - `error.title` as the main title
/// - `"exclamationmark.triangle"` as the SF Symbol for the leading icon
/// - `error.message` as the description text
///
/// Use this as the default `error:` builder in `StateDrivenView`, or call it directly when you want a consistent “error state” UI across screens.
///
/// - Parameter error: A display-ready model describing the error.
/// - Returns: A SwiftUI view suitable for an error state.
///
/// ### Example
/// ```swift
/// StateDrivenView(state: state) { value in
///     ContentView(value: value)
/// } error: { model in
///     errorPlaceholder(model)
/// }
/// ```
@ViewBuilder
public func errorPlaceholder(_ error: ErrorDisplayModel) -> some View {
    ContentUnavailableView {
        Label(
            error.title,
            systemImage: "exclamationmark.triangle"
        )
    } description: {
        VStack(spacing: 10) {
            Text(error.message)
            if let recoverySuggestion = error.recoverySuggestion {
                Text(recoverySuggestion)
            }
        }.padding(5)
    }
}

#endif
