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
    case custom(String, String)
}
 
extension EmptyDisplayModel {
    var title: String {
        switch self {
        case .noResults: L10n.Empty.NoResults.title
        case .noDataYet: L10n.Empty.NoDataYet.title
        case .noConnection: L10n.Empty.NoConnection.title
        case let .custom(title, _): title
        }
    }

    var message: String {
        switch self {
        case .noResults: L10n.Empty.NoResults.message
        case .noDataYet: L10n.Empty.NoDataYet.message
        case .noConnection: L10n.Empty.NoConnection.message
        case .custom(_, let message): message
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
