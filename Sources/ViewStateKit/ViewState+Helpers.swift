//
//  ViewState+Helpers.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 21/12/25.
//

import Foundation

public extension ViewState {
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    var hasContent: Bool {
        if case .content = self { return true }
        return false
    }
    
    var isEmpty: Bool {
        if case .empty = self { return true }
        return false
    }
    
    var hasError: Bool {
        if case .error = self { return true }
        return false
    }
    
    var content: Content? {
        if case let .content(value) = self { return value }
        return nil
    }
    
    var error: ErrorState? {
        if case let .error(value) = self { return value }
        return nil
    }
    
    var emptyState: EmptyState? {
        if case let .empty(value) = self { return value }
        return nil
    }
    
    func map<NewContent>(_ transform: (Content) -> NewContent) -> ViewState<NewContent, ErrorState, EmptyState> {
        return switch self {
        case .idle: .idle
        case .loading: .loading
        case let .content(content): .content(transform(content))
        case let .empty(emptyState): .empty(emptyState)
        case let .error(errorState): .error(errorState)
        }
    }
    
    func flatMap<NewContent>(
        _ transform: (Content) -> ViewState<NewContent, ErrorState, EmptyState>
    ) -> ViewState<NewContent, ErrorState, EmptyState> {
        return switch self {
        case .idle: .idle
        case .loading: .loading
        case let .content(content): transform(content)
        case let .empty(emptyState): .empty(emptyState)
        case let .error(errorState): .error(errorState)
        }
    }
}
