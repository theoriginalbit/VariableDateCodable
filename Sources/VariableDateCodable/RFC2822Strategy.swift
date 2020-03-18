import Foundation

/// Decodes `String` values as an RFC 2822 `Date`.
///
/// `RFC2822Strategy` decodes RFC 2822 date strings into `Date`s. Encoding the `Date` will encode the value back into the original string value.
///
/// For example, decoding json data with a `String` representation  of `"Tue, 24 Dec 2019 16:39:57 -0000"` produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 24th, 2019 with an offset of -00:00 from UTC.
///
/// Original source: https://github.com/marksands/BetterCodable/blob/master/Sources/BetterCodable/RFC2822Strategy.swift
public struct RFC2822Strategy: DateValueCodableStrategy {
    static let dateFormatter: DateFormatter = {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.dateFormat = "EEE, d MMM y HH:mm:ss zzz"
        $0.timeZone = .current
        return $0
    }(DateFormatter())

    public static func decode(_ value: String) throws -> Date {
        if let date = dateFormatter.date(from: value) {
            return date
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Invalid Date Format!"))
        }
    }

    public static func encode(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
