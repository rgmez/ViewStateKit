import Testing
@testable import ViewStateKit

struct DisplayModelsTests {
    @Test func errorDisplayModel_generic_hasExpectedDefaults() {
        let error = ErrorDisplayModel.generic()
        
        #expect(error.title == "Error")
        #expect(error.message == "Something went wrong")
        #expect(error.recoverySuggestion == nil)
    }
    
    @Test func errorDisplayModel_generic_overridesParameters() {
        let error = ErrorDisplayModel.generic(
            message: "Custom message",
            recoverySuggestion: "Try again"
        )
        
        #expect(error.title == "Error")
        #expect(error.message == "Custom message")
        #expect(error.recoverySuggestion == "Try again")
    }
    
    @Test func errorDisplayModel_equatableBehavesAsExpected() {
        let a = ErrorDisplayModel(title: "A", message: "B", recoverySuggestion: "C")
        let b = ErrorDisplayModel(title: "A", message: "B", recoverySuggestion: "C")
        let c = ErrorDisplayModel(title: "A", message: "Different", recoverySuggestion: "C")
        
        #expect(a == b)
        #expect(a != c)
    }
    
    @Test func emptyDisplayModel_equatableBehavesAsExpected() {
        #expect(EmptyDisplayModel.noResults == .noResults)
        #expect(EmptyDisplayModel.noResults != .noDataYet)
        #expect(EmptyDisplayModel.custom("x") == .custom("x"))
        #expect(EmptyDisplayModel.custom("x") != .custom("y"))
    }
}
