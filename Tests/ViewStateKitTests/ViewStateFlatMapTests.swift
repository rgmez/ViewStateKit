import Testing
@testable import ViewStateKit

struct ViewStateFlatMapTests {
    typealias Input = ViewState<Int, ErrorDisplayModel, EmptyDisplayModel>
    typealias Output = ViewState<String, ErrorDisplayModel, EmptyDisplayModel>

    private static let sampleError = ErrorDisplayModel(title: "Boom", message: "Nope")
    private static let sampleEmpty = EmptyDisplayModel.noResults

    @Test(arguments: [
        (input: Input.idle, expected: Output.idle),
        (input: Input.loading, expected: .loading),
        (input: Input.empty(sampleEmpty), expected: .empty(sampleEmpty)),
        (input: Input.error(sampleError), expected: .error(sampleError)),
    ])
    func flatMap_preservesNonContentStates(input: Input, expected: Output) {
        let mapped = input.flatMap { value in
            .content("value=\(value)")
        }
        #expect(mapped == expected)
    }

    @Test func flatMap_transformsContentIntoReturnedState() {
        let input: Input = .content(2)

        let mapped = input.flatMap { value in
            value == 0 ? .empty(.noResults) : .content("value=\(value)")
        }

        #expect(mapped == .content("value=2"))
    }

    @Test func flatMap_canTurnContentIntoEmpty() {
        let input: Input = .content(0)

        let mapped = input.flatMap { value in
            value == 0 ? .empty(.noResults) : .content("value=\(value)")
        }

        #expect(mapped == .empty(.noResults))
    }

    @Test(arguments: [
        Input.idle,
        Input.loading,
        Input.empty(sampleEmpty),
        Input.error(sampleError),
    ])
    func flatMap_doesNotExecuteTransformForNonContentStates(input: Input) {
        var transformCalledTimes = 0

        _ = input.flatMap { value in
            transformCalledTimes += 1
            return .content("value=\(value)")
        }

        #expect(transformCalledTimes == 0)
    }

    @Test func flatMap_executesTransformExactlyOnceForContent() {
        var transformCalledTimes = 0
        let input: Input = .content(1)

        let mapped = input.flatMap { value in
            transformCalledTimes += 1
            return .content("value=\(value + 1)")
        }

        #expect(transformCalledTimes == 1)
        #expect(mapped == .content("value=2"))
    }
}
