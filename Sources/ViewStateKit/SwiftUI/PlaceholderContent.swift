//
//  PlacerholderContent.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 31/12/25.
//

import Foundation

enum PlaceholderContent {
    static func title(for reason: EmptyReason?) -> String {
        return switch reason {
        case .noResults: "No Results"
        case .noConnection: "No Connection"
        case .noDataYet: "Nothing Here Yet"
        case let .custom(text): text
        case .none: "Nothing to Show"
        }
    }

    static func description(for reason: EmptyReason?) -> String {
        return switch reason {
        case .noResults: "Try adjusting your search or filters."
        case .noConnection: "Check your internet connection and try again."
        case .noDataYet: "Come back later once there's something new."
        case .custom: ""
        case .none: ""
        }
    }

    static func systemImage(for reason: EmptyReason?) -> String {
        return switch reason {
        case .noConnection: "wifi.slash"
        case .noResults: "magnifyingglass"
        default: "tray"
        }
    }
}
