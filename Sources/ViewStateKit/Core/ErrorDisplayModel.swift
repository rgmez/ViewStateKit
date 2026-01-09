//
//  ViewError.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 21/12/25.
//

import Foundation

/// A user-facing error representation.
///
/// `ErrorDisplayModel` describes an error in a way that is suitable for presentation in the UI, rather than for debugging or logging.
public struct ErrorDisplayModel: Error, Equatable, Sendable {
    /// A short, human-readable title describing the error.
    public let title: String
    
    /// A more detailed explanation of what went wrong.
    public let message: String
    
    /// An optional suggestion to help the user recover from the error. Examples include retry instructions or guidance on what to do next.
    public let recoverySuggestion: String?
    
    public init(title: String, message: String, recoverySuggestion: String? = nil) {
        self.title = title
        self.message = message
        self.recoverySuggestion = recoverySuggestion
    }
}

public extension ErrorDisplayModel {
    static var generic: ErrorDisplayModel {
        ErrorDisplayModel(
            title: L10n.Error.Generic.title,
            message: L10n.Error.Generic.message,
            recoverySuggestion: L10n.Error.Generic.recovery
        )
    }
}
