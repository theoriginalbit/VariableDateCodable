@testable import VariableDateCodable
import XCTest

final class VariableDateCodableTests: XCTestCase {
    // MARK: @DateValue Strategies

    func testDecodingAndEncodingISO8601FractionalSecondsDateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = #"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397.538))
    }

    func testDecodingAndEncodingISO8601DateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601Strategy> var iso8601: Date
        }
        let jsonData = #"{"iso8601": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingAndEncodingReferenceTimestamp() throws {
        struct Response: Codable {
            @DateValue<ReferenceTimestampStrategy> var timestamp: Date
        }
        let jsonData = #"{"timestamp": 604548113.0}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSinceReferenceDate: 604548113))
    }

    func testDecodingAndEncodingRFC2822DateString() throws {
        struct Response: Codable {
            @DateValue<RFC2822Strategy> var rfc2822Date: Date
        }
        let jsonData = #"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc2822Date, Date(timeIntervalSince1970: 1577486632))
    }

    func testDecodingAndEncodingRFC3339DateString() throws {
        struct Response: Codable {
            @DateValue<RFC3339Strategy> var rfc3339Date: Date
        }
        let jsonData = #"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc3339Date, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingAndEncodingTimestamp() throws {
        struct Response: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }
        let jsonData = #"{"timestamp": 851042397.0}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingAndEncodingYearMonthDateString() throws {
        struct Response: Codable {
            @DateValue<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = #"{"ymd": "1996-12-19"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.ymd, Date(timeIntervalSince1970: 850953600))
    }

    // MARK: @OptionalDateValue strategies

    func testDecodingAndEncodingNonOptionalWithNull() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = #"{"iso8601": null}"# .data(using: .utf8)!

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }

    func testDecodingAndEncodingOptionalWithNull() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }
        let jsonData = #"{"iso8601": null}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, .none)
    }

    func testDecodingAndEncodingOptionalWithValue() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }
        let jsonData = #"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"# .data(using: .utf8)!

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397.538))
    }

    // MARK: XCTestManifest Contract

    static var allTests = [
        ("testDecodingAndEncodingISO8601FractionalSecondsDateString", testDecodingAndEncodingISO8601FractionalSecondsDateString),
        ("testDecodingAndEncodingISO8601DateString", testDecodingAndEncodingISO8601DateString),
        ("testDecodingAndEncodingReferenceTimestamp", testDecodingAndEncodingReferenceTimestamp),
        ("testDecodingAndEncodingRFC2822DateString", testDecodingAndEncodingRFC2822DateString),
        ("testDecodingAndEncodingRFC3339DateString", testDecodingAndEncodingRFC3339DateString),
        ("testDecodingAndEncodingTimestamp", testDecodingAndEncodingTimestamp),
        ("testDecodingAndEncodingYearMonthDateString", testDecodingAndEncodingYearMonthDateString),
        ("testDecodingAndEncodingNonOptionalWithNull", testDecodingAndEncodingNonOptionalWithNull),
        ("testDecodingAndEncodingOptionalWithNull", testDecodingAndEncodingOptionalWithNull),
        ("testDecodingAndEncodingOptionalWithValue", testDecodingAndEncodingOptionalWithValue),
    ]
}
