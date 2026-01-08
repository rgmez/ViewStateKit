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
    
    /// Renders a `ViewState` by mapping each state case to a SwiftUI view.
    ///
    /// Use this initializer when you want full control over all UI states: `idle`, `loading`, `content`, `empty`, and `error`.
    ///
    /// - Parameters:
    ///   - state: The current `ViewState` to render.
    ///   - content: Builds the view for the `.content` state.
    ///   - empty: Builds the view for the `.empty` state. Defaults to `emptyPlaceholder(_:)`.
    ///   - error: Builds the view for the `.error` state. Defaults to `errorPlaceholder(_:)`.
    ///   - loading: Builds the view for the `.loading` state. Defaults to `ProgressView`.
    ///   - idle: Builds the view for the `.idle` state. Defaults to `EmptyView`.
    ///
    /// Views for `idle`, `loading`, `empty`, and `error` are centered and expanded to fill the available space.
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

// MARK: Convenience defaults for ViewState<Content, ErrorDisplayModel, EmptyDisplayModel>

public extension StateDrivenView where Failure == ErrorDisplayModel, Empty == EmptyDisplayModel {
    /// Convenience initializer specialized for `ErrorDisplayModel` and `EmptyDisplayModel`.
    ///
    /// Use this initializer when your `ViewState` already carries display-ready models for empty and error states.
    ///
    /// This initializer keeps the same parameters as the designated initializer, but:
    /// - It constrains `Failure` to `ErrorDisplayModel`
    /// - It constrains `Empty` to `EmptyDisplayModel`
    /// - It provides default placeholders that accept those models.
    ///
    /// - Parameters:
    ///   - state: The current `ViewState` to render.
    ///   - content: Builds the view for the `.content` state.
    ///   - empty: Builds the view for `.empty(EmptyDisplayModel)`. Defaults to `emptyPlaceholder(_:)`.
    ///   - error: Builds the view for `.error(ErrorDisplayModel)`. Defaults to `errorPlaceholder(_:)`.
    ///   - loading: Builds the view for `.loading`. Defaults to `ProgressView`.
    ///   - idle: Builds the view for `.idle`. Defaults to `EmptyView`.
    init(
        state: ViewState<Content, ErrorDisplayModel, EmptyDisplayModel>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (EmptyDisplayModel) -> EmptyViewContent = { emptyPlaceholder($0) },
        @ViewBuilder error: @escaping (ErrorDisplayModel) -> ErrorViewContent = { errorPlaceholder($0) },
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
    /// Convenience initializer for states that cannot fail (`Failure == Never`).
    ///
    /// Use this initializer when your data source guarantees there is no error path (or errors are handled upstream), so `.error` is unrepresentable.
    ///
    /// This overload removes the `error:` parameter from the API surface.
    ///
    /// - Parameters:
    ///   - state: The current `ViewState` to render. Its failure type must be `Never`.
    ///   - content: Builds the view for the `.content` state.
    ///   - empty: Builds the view for the `.empty` state. Defaults to `emptyPlaceholder(_:)`.
    ///   - loading: Builds the view for the `.loading` state. Defaults to `ProgressView`.
    ///   - idle: Builds the view for the `.idle` state. Defaults to `EmptyView`.
    ///
    /// The `.error` branch is unreachable and is rendered as `EmptyView` internally.
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
    /// Convenience initializer for states that can never be empty (`Empty == Never`).
    ///
    /// Use this initializer when "empty" is not a valid outcome for the screen, so `.empty` is unrepresentable.
    ///
    /// This overload removes the `empty:` parameter from the API surface.
    ///
    /// - Parameters:
    ///   - state: The current `ViewState` to render. Its empty type must be `Never`.
    ///   - content: Builds the view for the `.content` state.
    ///   - error: Builds the view for the `.error` state. Defaults to `errorPlaceholder(_:)`.
    ///   - loading: Builds the view for the `.loading` state. Defaults to `ProgressView`.
    ///   - idle: Builds the view for the `.idle` state. Defaults to `EmptyView`.
    ///
    /// The `.empty` branch is unreachable and is rendered as `EmptyView` internally.
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

// MARK: Failure == Never AND Empty == Never: only `content:`

public extension StateDrivenView where Failure == Never, Empty == Never, EmptyViewContent == EmptyView, ErrorViewContent == EmptyView {
    /// Convenience initializer for screens that cannot fail and cannot be empty
    /// (`Failure == Never` and `Empty == Never`).
    ///
    /// Use this initializer for "always has content (eventually)" flows: no empty state, no error state, only `idle`, `loading`, and `content`.
    ///
    /// This overload removes both `empty:` and `error:` from the API surface.
    ///
    /// - Parameters:
    ///   - state: The current `ViewState` to render.
    ///   - content: Builds the view for the `.content` state.
    ///   - loading: Builds the view for the `.loading` state. Defaults to `ProgressView`.
    ///   - idle: Builds the view for the `.idle` state. Defaults to `EmptyView`.
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
