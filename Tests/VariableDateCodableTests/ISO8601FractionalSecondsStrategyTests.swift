@testable import VariableDateCodable
import XCTest

final class ISO8601FractionalSecondsStrategyTests: XCTestCase {
    func testDecodingAndEncodingISO8601FractionalSecondsDateString_Valid() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = Data(#"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397.538))
    }

    func testDecodingAndEncodingISO8601FractionalSecondsDateString_Invalid() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = Data(#"{"iso8601": "1996-12-19T16:39:57-08:00"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
