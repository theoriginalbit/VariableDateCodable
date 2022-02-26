@testable import VariableDateCodable
import XCTest

final class RFC2822StrategyTests: XCTestCase {
    func testDecodingAndEncodingRFC2822DateString_Valid() throws {
        struct Response: Codable {
            @DateCodable<RFC2822Strategy> var rfc2822Date: Date
        }
        let jsonData = Data(#"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"#.utf8)

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc2822Date, Date(timeIntervalSince1970: 1577486632))
    }
    
    func testDecodingAndEncodingRFC2822DateString_Invalid() throws {
        struct Response: Codable {
            @DateCodable<RFC2822Strategy> var rfc2822Date: Date
        }
        let jsonData = Data(#"{"rfc2822Date": "1996-12-19T16:39:57-08:00"}"#.utf8)

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }
}
