import XCTest
@testable import ViewStateKit

final class L10nTests: XCTestCase {
    func testEmptyNoResultsStrings() {
        XCTAssertEqual(L10n.Empty.NoResults.title, localized("Empty.NoResults.Title"))
        XCTAssertEqual(L10n.Empty.NoResults.message, localized("Empty.NoResults.Message"))
    }

    func testEmptyNoDataYetStrings() {
        XCTAssertEqual(L10n.Empty.NoDataYet.title, localized("Empty.NoDataYet.Title"))
        XCTAssertEqual(L10n.Empty.NoDataYet.message, localized("Empty.NoDataYet.Message"))
    }

    func testEmptyNoConnectionStrings() {
        XCTAssertEqual(L10n.Empty.NoConnection.title, localized("Empty.NoConnection.Title"))
        XCTAssertEqual(L10n.Empty.NoConnection.message, localized("Empty.NoConnection.Message"))
    }

    func testErrorGenericStrings() {
        XCTAssertEqual(L10n.Error.Generic.title, localized("Error.Generic.Title"))
        XCTAssertEqual(L10n.Error.Generic.message, localized("Error.Generic.Message"))
        // recovery string exists and matches
        XCTAssertEqual(L10n.Error.Generic.recovery, localized("Error.Generic.Recovery"))
    }
}
