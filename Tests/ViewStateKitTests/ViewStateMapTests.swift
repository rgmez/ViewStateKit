import Testing
@testable import ViewStateKit

struct ViewStateMapTests {
    typealias Input = ViewState<Int, ErrorDisplayModel, EmptyDisplayModel>
    typealias Output = ViewState<String, ErrorDisplayModel, EmptyDisplayModel>

    private static let sampleError = ErrorDisplayModel(title: "Boom", message: "Nope")
    private static let sampleEmpty = EmptyDisplayModel.noDataYet

    @Test(arguments: [
        (input: Input.idle, expected: Output.idle),
        (input: Input.loading, expected: .loading),
        (input: Input.content(3), expected: .content("3")),
        (input: Input.empty(sampleEmpty), expected: .empty(sampleEmpty)),
        (input: Input.error(sampleError), expected: .error(sampleError)),
    ])
    func map_preservesStateAndTransformsContent(input: Input, expected: Output) {
        let mapped = input.map { "\($0)" }
        #expect(mapped == expected)
    }

    @Test(arguments: [
        Input.idle,
        Input.loading,
        Input.empty(sampleEmpty),
        Input.error(sampleError),
    ])
    func map_doesNotExecuteTransformForNonContentStates(input: Input) {
        var transformCalledTimes = 0

        _ = input.map { value in
            transformCalledTimes += 1
            return value
        }

        #expect(transformCalledTimes == 0)
    }

    @Test func map_executesTransformExactlyOnceForContent() {
        var transformCalledTimes = 0
        let input: Input = .content(1)

        let mapped = input.map { value in
            transformCalledTimes += 1
            return value + 1
        }

        #expect(transformCalledTimes == 1)
        #expect(mapped == .content(2))
    }
}
