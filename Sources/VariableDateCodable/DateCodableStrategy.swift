import Foundation

/// A protocol for providing a custom strategy for encoding and decoding dates.
///
/// `DateCodableStrategy` provides a generic strategy type that the ``DateCodable`` and ``OptionalDateCodable`` property wrappers can use to inject custom strategies for encoding and decoding date values.
public protocol DateCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}
