import Foundation

/// Decodes and encodes optional dates using a strategy type.
///
/// `DateCodable` decodes dates using a ``DateCodableStrategy`` which provides custom decoding and encoding functionality.
///
/// You can access the original (non-date) value through the ``projectedValue`` property directly or `$` prefix.
@propertyWrapper
public struct DateCodable<Strategy: DateCodableStrategy>: Codable {
    public var wrappedValue: Date {
        didSet {
            projectedValue = Strategy.encode(wrappedValue)
        }
    }

    public private(set) var projectedValue: Strategy.RawValue

    public init(wrappedValue value: Date) {
        wrappedValue = value
        projectedValue = Strategy.encode(value)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        projectedValue = try container.decode(Strategy.RawValue.self)
        wrappedValue = try Strategy.decode(projectedValue)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(projectedValue)
    }
}
