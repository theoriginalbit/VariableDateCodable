@testable import VariableDateCodable
import XCTest

final class YearMonthDayStrategyTests: XCTestCase {
    func testDecodingAndEncodingYearMonthDateString_Valid() throws {
        struct Response: Codable {
            @DateCodable<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = Data(#"{"ymd": "1996-12-19"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.ymd, Date(timeIntervalSince1970: 850953600))
    }
    
    func testDecodingAndEncodingYearMonthDateString_Invalid() throws {
        struct Response: Codable {
            @DateCodable<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = Data(#"{"ymd": "1996-12-19T16:39:57-08:00"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
