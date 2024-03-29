import Foundation

/// Decodes `String` values as an ISO8601 `Date`.
///
/// `ISO8601Strategy` relies on an `ISO8601DateFormatter` in order to decode `String` values into `Date`s. Encoding the `Date` will encode the value into the original string value.
///
/// For example, decoding json data with a `String` representation  of `"1996-12-19T16:39:57.351-08:00"` produces a valid `Date` representing 39 minutes, 57 seconds, and 351 milliseconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
///
/// Original source: https://github.com/marksands/BetterCodable/blob/master/Sources/BetterCodable/ISO8601Strategy.swift
public struct ISO8601FractionalSecondsStrategy: DateCodableStrategy {
    private static let dateFormatter: ISO8601DateFormatter = {
        $0.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return $0
    }(ISO8601DateFormatter())

    public static func decode(_ value: String) throws -> Date {
        guard let date = dateFormatter.date(from: value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid ISO8601FractionalSecondsStrategy Date Format!"))
        }
        return date
    }

    public static func encode(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
