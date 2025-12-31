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
    ContentView: View,
    EmptyViewContent: View,
    ErrorViewContent: View,
    LoadingView: View,
    IdleView: View
>: View {
    
    private let state: ViewState<Content>
    private let content: (Content) -> ContentView
    private let empty: (EmptyReason?) -> EmptyViewContent
    private let error: (ViewError) -> ErrorViewContent
    private let loading: () -> LoadingView
    private let idle: () -> IdleView
    
    public init(
        state: ViewState<Content>,
        @ViewBuilder content: @escaping (Content) -> ContentView,
        @ViewBuilder empty: @escaping (EmptyReason?) -> EmptyViewContent = { reason in
            emptyPlaceholder(reason: reason)
        },
        @ViewBuilder error: @escaping (ViewError) -> ErrorViewContent = { viewError in
            errorPlaceholder(viewError)
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
            
        case let .empty(reason):
            empty(reason)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        case let .error(viewError):
            error(viewError)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
}
#endif
