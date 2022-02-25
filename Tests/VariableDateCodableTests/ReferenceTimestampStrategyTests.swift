@testable import VariableDateCodable
import XCTest

final class ReferenceTimestampStrategyTests: XCTestCase {
    func testDecodingAndEncodingReferenceTimestamp_Valid() throws {
        struct Response: Codable {
            @DateValue<ReferenceTimestampStrategy> var timestamp: Date
        }
        let jsonData = Data(#"{"timestamp": 604548113.0}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSinceReferenceDate: 604548113))
    }

    func testDecodingAndEncodingReferenceTimestamp_Invalid() throws {
        struct Response: Codable {
            @DateValue<ReferenceTimestampStrategy> var timestamp: Date
        }
        let jsonData = Data(#"{"timestamp": "604548113.0"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
