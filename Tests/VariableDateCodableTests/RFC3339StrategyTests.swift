@testable import VariableDateCodable
import XCTest

final class RFC3339StrategyTests: XCTestCase {
    func testDecodingAndEncodingRFC3339DateString_Valid() throws {
        struct Response: Codable {
            @DateValue<RFC3339Strategy> var rfc3339Date: Date
        }
        let jsonData = Data(#"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc3339Date, Date(timeIntervalSince1970: 851042397))
    }
    
    func testDecodingAndEncodingRFC3339DateString_Invalid() throws {
        struct Response: Codable {
            @OptionalDateValue<RFC3339Strategy> var rfc3339Date: Date?
        }
        let jsonData = Data(#"{"rfc3339Date": "1996-12-19"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
