//
//  ViewState.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 21/12/25.
//

import Foundation

/// Represents the current state of a screen or view.
///
/// `ViewState` is designed to model the full lifecycle of a UI in a clear and predictable way, avoiding multiple boolean flags such as
/// `isLoading`, `hasError`, or `isEmpty`.
///
/// A screen should always be in exactly one state at a time.
public enum ViewState<Content, ErrorState, EmptyState> {
    /// The initial, inactive state.
    ///
    /// Use this when the view has not started loading data yet. This is typically the state right after a view appears.
    case idle
    
    /// Indicates that the view is currently loading data.
    ///
    /// While in this state, the UI should communicate progress to the user, for example by showing a spinner or a loading indicator.
    case loading
    
    /// Contains the successfully loaded content.
    ///
    /// This is the "happy path" state where data is available and ready to be displayed on screen.
    ///
    /// - Parameter content: The data required to render the view.
    case content(Content)
    
    /// Indicates that loading completed successfully, but there is no content to show.
    ///
    /// This state is different from `error`: it represents a valid outcome, such as an empty list, no search results, or data that has not been created yet.
    ///
    /// - Parameter emptyState: A value describing why or how the content is empty.
    case empty(EmptyState)
    
    /// Indicates that an error occurred while loading or processing data.
    ///
    /// This state should be used when something went wrong and the user needs to be informed about the failure.
    ///
    /// - Parameter errorState: A user-facing error value.
    case error(ErrorState)
}

extension ViewState: Equatable where Content: Equatable, ErrorState: Equatable, EmptyState: Equatable {}
extension ViewState: Sendable where Content: Sendable, ErrorState: Sendable, EmptyState: Sendable {}
