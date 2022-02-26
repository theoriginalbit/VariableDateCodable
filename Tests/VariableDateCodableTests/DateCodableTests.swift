@testable import VariableDateCodable
import XCTest

final class DateCodableTests: XCTestCase {
    func testDecodingAndEncodingExists() throws {
        struct Response: Codable {
            @DateCodable<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = Data(#"{"ymd": "1996-12-19"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertNotNil(response.ymd)
        XCTAssertEqual(response.ymd, Date(timeIntervalSince1970: 850953600))
    }

    func testDecodingAndEncodingNull() throws {
        struct Response: Codable {
            @DateCodable<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = Data(#"{"ymd": null}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }

    func testDecodingAndEncodingMissing() throws {
        struct Response: Codable {
            @DateCodable<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = Data(#"{}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
