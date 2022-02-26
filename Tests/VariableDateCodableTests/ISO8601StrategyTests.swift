@testable import VariableDateCodable
import XCTest

final class ISO8601StrategyTests: XCTestCase {
    func testDecodingAndEncodingISO8601DateString_Valid() throws {
        struct Response: Codable {
            @DateCodable<ISO8601Strategy> var iso8601: Date
        }
        let jsonData = Data(#"{"iso8601": "1996-12-19T16:39:57-08:00"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397))
    }
    
    func testDecodingAndEncodingISO8601DateString_Invalid() throws {
        struct Response: Codable {
            @DateCodable<ISO8601Strategy> var iso8601: Date
        }
        let jsonData = Data(#"{"iso8601": "1996-12-19"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
