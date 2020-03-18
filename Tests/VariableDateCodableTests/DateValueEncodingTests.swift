@testable import VariableDateCodable
import XCTest

final class DateValueEncodingTests: XCTestCase {
    // MARK: @DateValue Strategies

    func testEncodingISO8601FractionalSecondsDateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }

        let testDate = "1996-12-20T11:39:57.538Z"
        let response = try JSONEncoder().encode(Response(iso8601: try XCTUnwrap(ISO8601FractionalSecondsStrategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":"\#(testDate)"}"#)
    }

    func testEncodingISO8601FractionalSecondsDateStringWithNonZuluTimeZone() throws {
        struct Response: Codable {
            @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
        }

        let testDate = "1996-12-20T11:39:57.538+11:00"
        let response = try JSONEncoder().encode(Response(iso8601: try XCTUnwrap(ISO8601FractionalSecondsStrategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":"\#(testDate)"}"#)
    }

    func testEncodingISO8601DateString() throws {
        struct Response: Codable {
            @DateValue<ISO8601Strategy> var iso8601: Date
        }

        let testDate = "1996-12-20T11:39:57Z"
        let response = try JSONEncoder().encode(Response(iso8601: try XCTUnwrap(ISO8601Strategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":"\#(testDate)"}"#)
    }

    func testEncodingISO8601DateStringWithNonZuluTimeZone() throws {
        struct Response: Codable {
            @DateValue<ISO8601Strategy> var iso8601: Date
        }

        let testDate = "1996-12-20T11:39:57+11:00"
        let response = try JSONEncoder().encode(Response(iso8601: try XCTUnwrap(ISO8601Strategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":"\#(testDate)"}"#)
    }

    func testEncodingReferenceTimestamp() throws {
        struct Response: Codable {
            @DateValue<ReferenceTimestampStrategy> var timestamp: Date
        }

        let response = try JSONEncoder().encode(Response(timestamp: Date(timeIntervalSinceReferenceDate: 604548113)))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"timestamp":604548113}"#)
    }

    func testEncodingRFC2822DateString() throws {
        struct Response: Codable {
            @DateValue<RFC2822Strategy> var rfc2822Date: Date
        }

        let testDate = "Fri, 27 Dec 2019 22:43:52 GMT"
        let response = try JSONEncoder().encode(Response(rfc2822Date: try XCTUnwrap(RFC2822Strategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"rfc2822Date":"\#(testDate)"}"#)
    }

    func testEncodingRFC2822DateStringWithNonGMT() throws {
        struct Response: Codable {
            @DateValue<RFC2822Strategy> var rfc2822Date: Date
        }

        let testDate = "Fri, 27 Dec 2019 22:43:52 GMT+11"
        let response = try JSONEncoder().encode(Response(rfc2822Date: try XCTUnwrap(RFC2822Strategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"rfc2822Date":"\#(testDate)"}"#)
    }

    func testEncodingRFC3339DateString() throws {
        struct Response: Codable {
            @DateValue<RFC3339Strategy> var rfc3339Date: Date
        }

        let testDate = "1996-12-20T11:39:57+11:00"
        let response = try JSONEncoder().encode(Response(rfc3339Date: try XCTUnwrap(RFC3339Strategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"rfc3339Date":"1996-12-19T16:39:57+11:00"}"#)
    }

    func testEncodingTimestamp() throws {
        struct Response: Codable {
            @DateValue<TimestampStrategy> var timestamp: Date
        }

        let response = try JSONEncoder().encode(Response(timestamp: Date(timeIntervalSince1970: 851042397)))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"timestamp":851042397}"#)
    }

    func testEncodingYearMonthDateString() throws {
        struct Response: Codable {
            @DateValue<YearMonthDayStrategy> var ymd: Date
        }

        let response = try JSONEncoder().encode(Response(ymd: Date(timeIntervalSince1970: 850953600)))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"ymd":"1996-12-19"}"#)
    }

    // MARK: @OptionalDateValue strategies

    func testEncodingOptionalWithNull() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }

        let response = try JSONEncoder().encode(Response(iso8601: nil))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":null}"#)
    }

    func testEncodingOptionalWithValue() throws {
        struct Response: Codable {
            @OptionalDateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date?
        }

        let testDate = "1996-12-20T11:39:57.538+11:00"
        let response = try JSONEncoder().encode(Response(iso8601: try XCTUnwrap(ISO8601FractionalSecondsStrategy.dateFormatter.date(from: testDate))))
        XCTAssertEqual(String(data: response, encoding: .utf8), #"{"iso8601":"\#(testDate)"}"#)
    }

    // MARK: XCTestManifest Contract

    static var allTests = [
        ("testEncodingISO8601FractionalSecondsDateString", testEncodingISO8601FractionalSecondsDateString),
        ("testEncodingISO8601FractionalSecondsDateStringWithNonZuluTimeZone", testEncodingISO8601FractionalSecondsDateStringWithNonZuluTimeZone),
        ("testEncodingISO8601DateString", testEncodingISO8601DateString),
        ("testEncodingISO8601DateStringWithNonZuluTimeZone", testEncodingISO8601DateStringWithNonZuluTimeZone),
        ("testEncodingReferenceTimestamp", testEncodingReferenceTimestamp),
        ("testEncodingRFC2822DateString", testEncodingRFC2822DateString),
        ("testEncodingRFC2822DateStringWithNonGMT", testEncodingRFC2822DateStringWithNonGMT),
        ("testEncodingRFC3339DateString", testEncodingRFC3339DateString),
        ("testEncodingTimestamp", testEncodingTimestamp),
        ("testEncodingYearMonthDateString", testEncodingYearMonthDateString),
        ("testEncodingOptionalWithNull", testEncodingOptionalWithNull),
        ("testEncodingOptionalWithValue", testEncodingOptionalWithValue),
    ]
}
