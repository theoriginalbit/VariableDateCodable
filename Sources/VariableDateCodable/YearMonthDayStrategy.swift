import Foundation

/// Decodes `String` values of format `y-MM-dd` as a `Date`.
///
/// `YearMonthDayStrategy` decodes string values of format `y-MM-dd` as a `Date`. Encoding the `Date` will encode the value back into the original string format.
///
/// For example, decoding json data with a `String` representation  of `"2001-01-01"` produces a valid `Date` representing January 1st, 2001.
///
/// Original source: https://github.com/marksands/BetterCodable/blob/master/Sources/BetterCodable/YearMonthDayStrategy.swift
public struct YearMonthDayStrategy: DateValueCodableStrategy {
    static let dateFormatter: DateFormatter = {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.dateFormat = "y-MM-dd"
        $0.timeZone = TimeZone(secondsFromGMT: 0)
        return $0
    }(DateFormatter())

    public static func decode(_ value: String) throws -> Date {
        guard let date = dateFormatter.date(from: value) else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid YearMonthDayStrategy Date Format!"))
        }
        return date
    }

    public static func encode(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
