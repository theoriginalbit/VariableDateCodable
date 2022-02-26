import Foundation

/// Decodes `TimeInterval` values as a `Date` since January 1, 2001.
///
/// `ReferenceTimestampStrategy` decodes `Double`s of a unix epoch into `Date`s. Encoding the `Date` will encode the value into the original `TimeInterval` value.
///
/// For example, decoding json data with a timestamp of `604548113.0` produces a valid `Date` representing 1 minute and 53 seconds after the 14th hour of February 28th, 2020.
public struct ReferenceTimestampStrategy: DateCodableStrategy {
    public static func decode(_ value: TimeInterval) throws -> Date {
        return Date(timeIntervalSinceReferenceDate: value)
    }

    public static func encode(_ date: Date) -> TimeInterval {
        return date.timeIntervalSinceReferenceDate
    }
}
