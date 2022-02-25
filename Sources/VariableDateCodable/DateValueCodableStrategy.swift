import Foundation

/// A protocol for providing a custom strategy for encoding and decoding dates.
///
/// `DateValueCodableStrategy` provides a generic strategy type that the `DateValue` property wrapper can use to inject custom strategies for encoding and decoding date values.
public protocol DateValueCodableStrategy {
    associatedtype RawValue: Codable

    static func decode(_ value: RawValue) throws -> Date
    static func encode(_ date: Date) -> RawValue
}
