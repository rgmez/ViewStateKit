import Testing
@testable import ViewStateKit

struct ViewStateMapTests {
    @Test func mapTransformsContent() {
        let state: ViewState<[String]> = .content(["a", "b"])
        let mapped = state.map { $0.count }
        #expect(mapped.content == 2)
    }

    @Test func mapPreservesNonContentCases() {
        let loading: ViewState<Int> = .loading
        let mapped = loading.map { "\($0)" }
        #expect(mapped.isLoading == true)
    }
}
