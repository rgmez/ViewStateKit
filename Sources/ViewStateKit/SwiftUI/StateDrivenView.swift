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
        @ViewBuilder empty: @escaping (Empty) -> EmptyViewContent = { emptyPlaceholder($0) },
        @ViewBuilder error: @escaping (Failure) -> ErrorViewContent = { errorPlaceholder($0) },
        @ViewBuilder loading: @escaping () -> LoadingView = {
            ProgressView()
        },
        @ViewBuilder idle: @escaping () -> IdleView = {
            EmptyView()
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

// MARK: Failure == Never (can't fail): no `error:` required

public extension StateDrivenView where Failure == Never, ErrorViewContent == EmptyView {
    init(
        state: ViewState<Content, Never, Empty>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (Empty) -> EmptyViewContent = { emptyPlaceholder($0)},
        @ViewBuilder loading: @escaping () -> LoadingView = { ProgressView() },
        @ViewBuilder idle: @escaping () -> IdleView = { EmptyView() }
    ) {
        self.init(
            state: state,
            content: content,
            empty: empty,
            error: { _ in EmptyView() },   // unreachable
            loading: loading,
            idle: idle
        )
    }
}

// MARK: Empty == Never (never empty): no `empty:` required

public extension StateDrivenView where Empty == Never, EmptyViewContent == EmptyView {
    init(
        state: ViewState<Content, Failure, Never>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder error: @escaping (Failure) -> ErrorViewContent = { errorPlaceholder($0) },
        @ViewBuilder loading: @escaping () -> LoadingView = { ProgressView() },
        @ViewBuilder idle: @escaping () -> IdleView = { EmptyView() }
    ) {
        self.init(
            state: state,
            content: content,
            empty: { _ in EmptyView() },   // unreachable
            error: error,
            loading: loading,
            idle: idle
        )
    }
}

// MARK: - Failure == Never AND Empty == Never: only `content:`
public extension StateDrivenView where Failure == Never, Empty == Never, EmptyViewContent == EmptyView, ErrorViewContent == EmptyView {
    init(
        state: ViewState<Content, Never, Never>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder loading: @escaping () -> LoadingView = { ProgressView() },
        @ViewBuilder idle: @escaping () -> IdleView = { EmptyView() }
    ) {
        self.init(
            state: state,
            content: content,
            empty: { _ in EmptyView() },   // unreachable
            error: { _ in EmptyView() },   // unreachable
            loading: loading,
            idle: idle
        )
    }
}

#endif
