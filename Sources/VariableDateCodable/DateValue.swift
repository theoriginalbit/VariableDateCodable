import Foundation

/// Decodes and encodes dates using a strategy type.
///
/// `DateValue` decodes dates using a `DateValueCodableStrategy` which provides custom decoding and encoding functionality.
@propertyWrapper
public struct DateValue<Strategy: DateValueCodableStrategy>: Codable {
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
