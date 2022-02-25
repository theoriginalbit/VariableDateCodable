@testable import VariableDateCodable
import XCTest

final class TimestampStrategyTests: XCTestCase {
    func testDecodingAndEncodingTimestamp_Valid() throws {
        struct Response: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }
        let jsonData = Data(#"{"timestamp": 851042397.0}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSince1970: 851042397))
    }
    
    func testDecodingAndEncodingTimestamp_Invalid() throws {
        struct Response: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }
        let jsonData = Data(#"{"timestamp": "851042397.0"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
