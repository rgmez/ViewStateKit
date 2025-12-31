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
public enum ViewState<Content> {
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
    /// - Parameter Content: The data required to render the view.
    case content(Content)
    
    /// Indicates that loading completed successfully, but there is no content to show.
    ///
    /// This state is different from `error`: it represents a valid outcome, such as an empty list, no search results, or data that has not been created yet.
    ///
    /// - Parameter EmptyReason: An optional explanation of why the content is empty.
    case empty(EmptyReason? = nil)
    
    /// Indicates that an error occurred while loading or processing data.
    ///
    /// This state should be used when something went wrong and the user needs to be informed about the failure.
    ///
    /// - Parameter ViewError: A user-facing error description.
    case error(ViewError)
}

/// Describes why a view has no content to display.
///
/// `EmptyReason` helps distinguish between different "empty" scenarios and allows the UI to present more meaningful messages to the user.
public enum EmptyReason: Equatable, Sendable {
    /// No results were found (for example, an empty search result).
    case noResults
    
    /// The data source is valid, but no data exists yet. This is useful for first-time states or freshly created content.
    case noDataYet
    
    /// Content could not be loaded due to a missing network connection.
    case noConnection
    
    /// A custom, user-defined reason. Use this when none of the predefined cases match your scenario.
    case custom(String)
}
