//
//  Untitled.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 5/1/26.
//

import Foundation

/// Describes why a view has no content to display.
///
/// `EmptyDisplayModel` helps distinguish between different "empty" scenarios and allows the UI to present more meaningful messages to the user.
public enum EmptyDisplayModel: Equatable, Sendable {
    /// No results were found (for example, an empty search result).
    case noResults
    
    /// The data source is valid, but no data exists yet. This is useful for first-time states or freshly created content.
    case noDataYet
    
    /// Content could not be loaded due to a missing network connection.
    case noConnection
    
    /// A custom, user-defined reason. Use this when none of the predefined cases match your scenario.
    case custom(String)
}
 
extension EmptyDisplayModel {
    var title: String {
        switch self {
        case .noResults: "No results"
        case .noDataYet: "No data yet"
        case .noConnection: "No connection"
        case let .custom(text): text
        }
    }

    var message: String {
        switch self {
        case .noResults: "Try adjusting your search or filters."
        case .noDataYet: "Once you add something, it will appear here."
        case .noConnection: "Check your internet connection and try again."
        case .custom: "There's no content to show."
        }
    }

    var systemImageName: String {
        switch self {
        case .noResults: "magnifyingglass"
        case .noDataYet: "tray"
        case .noConnection: "wifi.slash"
        case .custom: "tray"
        }
    }
}
