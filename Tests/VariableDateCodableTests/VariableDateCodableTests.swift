import XCTest
@testable import VariableDateCodable

final class VariableDateCodableTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(VariableDateCodable().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
