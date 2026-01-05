//
//  StateDrivenView.swift
//  ViewStateKit
//
//  Created by Roberto Gómez on 28/12/25.
//

#if canImport(SwiftUI)
import SwiftUI

public struct StateDrivenView<
    Content,
    ErrorState,
    EmptyState,
    ContentView: View,
    EmptyViewContent: View,
    ErrorViewContent: View,
    LoadingView: View,
    IdleView: View
>: View {
    
    private let state: ViewState<Content, ErrorState, EmptyState>
    private let content: (Content) -> ContentView
    private let empty: (EmptyState) -> EmptyViewContent
    private let error: (ErrorState) -> ErrorViewContent
    private let loading: () -> LoadingView
    private let idle: () -> IdleView
    
    public init(
        state: ViewState<Content, ErrorState, EmptyState>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (EmptyState) -> EmptyViewContent,
        @ViewBuilder error: @escaping (ErrorState) -> ErrorViewContent,
        @ViewBuilder loading: @escaping () -> LoadingView = {
            ProgressView()
        },
        @ViewBuilder idle: @escaping () -> IdleView = {
            SwiftUI.EmptyView()
        }
    ) {
        self.state = state
        self.content = content
        self.empty = empty
        self.error = error
        self.loading = loading
        self.idle = idle
    }
    
    public var body: some View {
        switch state {
        case .idle:
            idle()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case .loading:
            loading()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case let .content(value):
            content(value)
            
        case let .empty(emptyState):
            empty(emptyState)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case let .error(errorState):
            error(errorState)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

// MARK: Convenience defaults for ViewState<Content, ViewError, EmptyReason>

public extension StateDrivenView where ErrorState == ErrorDisplayModel, EmptyState == EmptyDisplayModel {
    init(
        state: ViewState<Content, ErrorDisplayModel, EmptyDisplayModel?>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (EmptyDisplayModel) -> EmptyViewContent = { reason in
            emptyPlaceholder(reason)
        },
        @ViewBuilder error: @escaping (ErrorDisplayModel) -> ErrorViewContent = { viewError in
            errorPlaceholder(viewError)
        },
        @ViewBuilder loading: @escaping () -> LoadingView = {
            ProgressView()
        },
        @ViewBuilder idle: @escaping () -> IdleView = {
            SwiftUI.EmptyView()
        }
    ) {
        self.init(
            state: state,
            content: content,
            empty: empty,
            error: error,
            loading: loading,
            idle: idle
        )
    }
}
#endif
