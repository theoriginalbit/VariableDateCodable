import Foundation

/// Decodes `TimeInterval` values as a `Date`.
///
/// `TimestampStrategy` decodes `Double`s of a unix epoch into `Date`s. Encoding the `Date` will encode the value into the original `TimeInterval` value.
///
/// For example, decoding json data with a unix timestamp of `978307200.0` produces a valid `Date` representing January 1, 2001.
///
/// Original source: https://github.com/marksands/BetterCodable/blob/master/Sources/BetterCodable/TimestampStrategy.swift
public struct TimestampStrategy: DateCodableStrategy {
    public static func decode(_ value: TimeInterval) throws -> Date {
        return Date(timeIntervalSince1970: value)
    }

    public static func encode(_ date: Date) -> TimeInterval {
        return date.timeIntervalSince1970
    }
}
