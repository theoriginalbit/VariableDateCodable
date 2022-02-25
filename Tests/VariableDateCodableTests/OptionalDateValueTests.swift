@testable import VariableDateCodable
import XCTest

final class OptionalDateValueTests: XCTestCase {
    func testDecodingAndEncodingOptionalExists() throws {
        struct Response: Codable {
            @OptionalDateValue<YearMonthDayStrategy> var ymd: Date?
        }
        let jsonData = Data(#"{"ymd": "1996-12-19"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertNotNil(response.ymd)
        XCTAssertEqual(response.ymd, Date(timeIntervalSince1970: 850953600))
    }

    func testDecodingAndEncodingOptionalNull() throws {
        struct Response: Codable {
            @OptionalDateValue<YearMonthDayStrategy> var ymd: Date?
        }
        let jsonData = Data(#"{"ymd": null}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertNil(response.ymd)
    }

    func testDecodingAndEncodingOptionalMissing() throws {
        struct Response: Codable {
            @OptionalDateValue<YearMonthDayStrategy> var ymd: Date?
        }
        let jsonData = Data(#"{}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertNil(response.ymd)
    }
}
