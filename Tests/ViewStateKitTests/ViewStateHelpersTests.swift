import Testing
@testable import ViewStateKit

struct ViewStateHelpersTests {
    typealias State = ViewState<Int, ErrorDisplayModel, EmptyDisplayModel>
    
    private static let sampleError = ErrorDisplayModel(title: "Oops", message: "Failed")
    private static let sampleEmpty = EmptyDisplayModel.noResults
    
    @Test(arguments: [
        (state: State.idle, expected: false),
        (state: State.loading, expected: true),
        (state: State.content(1), expected: false),
        (state: State.empty(.noResults), expected: false),
        (state: State.error(sampleError), expected: false),
    ])
    func isLoading_matchesExpected(state: State, expected: Bool) {
        #expect(state.isLoading == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: false),
        (state: State.loading, expected: false),
        (state: State.content(1), expected: true),
        (state: State.empty(.noResults), expected: false),
        (state: State.error(sampleError), expected: false),
    ])
    func hasContent_matchesExpected(state: State, expected: Bool) {
        #expect(state.hasContent == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: false),
        (state: State.loading, expected: false),
        (state: State.content(1), expected: false),
        (state: State.empty(.noResults), expected: true),
        (state: State.error(sampleError), expected: false),
    ])
    func isEmpty_matchesExpected(state: State, expected: Bool) {
        #expect(state.isEmpty == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: false),
        (state: State.loading, expected: false),
        (state: State.content(1), expected: false),
        (state: State.empty(.noResults), expected: false),
        (state: State.error(sampleError), expected: true),
    ])
    func hasError_matchesExpected(state: State, expected: Bool) {
        #expect(state.hasError == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: Optional<Int>.none),
        (state: State.loading, expected: Optional<Int>.none),
        (state: State.content(7), expected: Optional(7)),
        (state: State.empty(.noResults), expected: Optional<Int>.none),
        (state: State.error(sampleError), expected: Optional<Int>.none),
    ])
    func content_returnsExpected(state: State, expected: Int?) {
        #expect(state.content == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: Optional<ErrorDisplayModel>.none),
        (state: State.loading, expected: Optional<ErrorDisplayModel>.none),
        (state: State.content(1), expected: Optional<ErrorDisplayModel>.none),
        (state: State.empty(.noResults), expected: Optional<ErrorDisplayModel>.none),
        (state: State.error(sampleError), expected: Optional(sampleError)),
    ])
    func error_returnsExpected(state: State, expected: ErrorDisplayModel?) {
        #expect(state.error == expected)
    }
    
    @Test(arguments: [
        (state: State.idle, expected: Optional<EmptyDisplayModel>.none),
        (state: State.loading, expected: Optional<EmptyDisplayModel>.none),
        (state: State.content(1), expected: Optional<EmptyDisplayModel>.none),
        (state: State.empty(sampleEmpty), expected: Optional(sampleEmpty)),
        (state: State.error(sampleError), expected: Optional<EmptyDisplayModel>.none),
    ])
    func emptyState_returnsExpected(state: State, expected: EmptyDisplayModel?) {
        #expect(state.empty == expected)
    }
}
