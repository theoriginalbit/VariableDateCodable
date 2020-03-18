@testable import VariableDateCodable
import XCTest

final class DateValueDecodingTests: XCTestCase {
    // MARK: @DateValue Strategies

    func testDecodingISO8601FractionalSecondsDateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = try XCTUnwrap(#"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397.538))
    }

    func testDecodingISO8601DateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601Strategy> var iso8601: Date
        }
        let jsonData = try XCTUnwrap(#"{"iso8601": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingReferenceTimestamp() throws {
        struct Response: Codable {
            @DateValue<ReferenceTimestampStrategy> var timestamp: Date
        }
        let jsonData = try XCTUnwrap(#"{"timestamp": 604548113.0}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSinceReferenceDate: 604548113))
    }

    func testDecodingRFC2822DateString() throws {
        struct Response: Codable {
            @DateValue<RFC2822Strategy> var rfc2822Date: Date
        }
        let jsonData = try XCTUnwrap(#"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc2822Date, Date(timeIntervalSince1970: 1577486632))
    }

    func testDecodingRFC3339DateString() throws {
        struct Response: Codable {
            @DateValue<RFC3339Strategy> var rfc3339Date: Date
        }
        let jsonData = try XCTUnwrap(#"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.rfc3339Date, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingTimestamp() throws {
        struct Response: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }
        let jsonData = try XCTUnwrap(#"{"timestamp": 851042397.0}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.timestamp, Date(timeIntervalSince1970: 851042397))
    }

    func testDecodingYearMonthDateString() throws {
        struct Response: Codable {
            @DateValue<YearMonthDayStrategy> var ymd: Date
        }
        let jsonData = try XCTUnwrap(#"{"ymd": "1996-12-19"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.ymd, Date(timeIntervalSince1970: 850953600))
    }

    // MARK: @OptionalDateValue strategies

    func testDecodingNonOptionalWithNull() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }
        let jsonData = try XCTUnwrap(#"{"iso8601": null}"# .data(using: .utf8))

        XCTAssertThrowsError(try JSONDecoder().decode(Response.self, from: jsonData))
    }

    func testDecodingOptionalWithNull() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }
        let jsonData = try XCTUnwrap(#"{"iso8601": null}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, .none)
    }

    func testDecodingOptionalWithValue() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }
        let jsonData = try XCTUnwrap(#"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"# .data(using: .utf8))

        let response = try JSONDecoder().decode(Response.self, from: jsonData)
        XCTAssertEqual(response.iso8601, Date(timeIntervalSince1970: 851042397.538))
    }

    // MARK: XCTestManifest Contract

    static var allTests = [
        ("testDecodingISO8601FractionalSecondsDateString", testDecodingISO8601FractionalSecondsDateString),
        ("testDecodingISO8601DateString", testDecodingISO8601DateString),
        ("testDecodingReferenceTimestamp", testDecodingReferenceTimestamp),
        ("testDecodingRFC2822DateString", testDecodingRFC2822DateString),
        ("testDecodingRFC3339DateString", testDecodingRFC3339DateString),
        ("testDecodingTimestamp", testDecodingTimestamp),
        ("testDecodingYearMonthDateString", testDecodingYearMonthDateString),
        ("testDecodingNonOptionalWithNull", testDecodingNonOptionalWithNull),
        ("testDecodingOptionalWithNull", testDecodingOptionalWithNull),
        ("testDecodingOptionalWithValue", testDecodingOptionalWithValue),
    ]
}
