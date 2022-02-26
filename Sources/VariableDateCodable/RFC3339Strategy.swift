import Foundation

/// Decodes `String` values as an RFC 3339 `Date`.
///
/// `RFC3339Strategy` decodes RFC 3339 date strings into `Date`s. Encoding the `Date` will encode the value back into the original string value.
///
/// For example, decoding json data with a `String` representation  of `"1996-12-19T16:39:57-08:00"` produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
///
/// Original source: https://github.com/marksands/BetterCodable/blob/master/Sources/BetterCodable/RFC3339Strategy.swift
public struct RFC3339Strategy: DateCodableStrategy {
    private static let dateFormatter: DateFormatter = {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        return $0
    }(DateFormatter())

    public static func decode(_ value: String) throws -> Date {
        guard let date = dateFormatter.date(from: value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format!"))
        }
        return date
    }

    public static func encode(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
