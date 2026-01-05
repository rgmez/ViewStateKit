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
    Failure,
    Empty,
    ContentView: View,
    EmptyViewContent: View,
    ErrorViewContent: View,
    LoadingView: View,
    IdleView: View
>: View {
    
    private let state: ViewState<Content, Failure, Empty>
    private let content: (Content) -> ContentView
    private let empty: (Empty) -> EmptyViewContent
    private let error: (Failure) -> ErrorViewContent
    private let loading: () -> LoadingView
    private let idle: () -> IdleView
    
    public init(
        state: ViewState<Content, Failure, Empty>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (Empty) -> EmptyViewContent,
        @ViewBuilder error: @escaping (Failure) -> ErrorViewContent,
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
            
        case let .empty(value):
            empty(value)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case let .error(value):
            error(value)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}

// MARK: Convenience defaults for ViewState<Content, ViewError, EmptyReason>

public extension StateDrivenView where Failure == ErrorDisplayModel, Empty == EmptyDisplayModel {
    init(
        state: ViewState<Content, ErrorDisplayModel, EmptyDisplayModel>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (EmptyDisplayModel) -> EmptyViewContent = { model in
            emptyPlaceholder(model)
        },
        @ViewBuilder error: @escaping (ErrorDisplayModel) -> ErrorViewContent = { model in
            errorPlaceholder(model)
        },
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
}
#endif
