import Testing
@testable import ViewStateKit

struct ViewStateHelpersTests {
    @Test func contentOrNilReturnsValueOnlyForContent() {
        #expect(!(ViewState<Int>.idle).hasContent)
        #expect((ViewState<Int>.content(7)).content == 7)
    }

    @Test func errorOrNilReturnsValueOnlyForError() {
        let error = ViewError(title: "Oops", message: "Something happened")
        #expect((ViewState<Int>.error(error)).error == error)
    }
}
