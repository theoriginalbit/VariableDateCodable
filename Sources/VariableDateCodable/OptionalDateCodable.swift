import Foundation

/// Decodes and encodes optional dates using a strategy type.
///
/// `OptionalDateCodable` decodes dates using a ``DateCodableStrategy`` which provides custom decoding and encoding functionality.
///
/// You can access the original (non-date) value through the ``projectedValue`` property directly or `$` prefix.
@propertyWrapper
public struct OptionalDateCodable<Strategy: DateCodableStrategy>: Codable {
    public var wrappedValue: Date? {
        didSet {
            if let wrappedValue = wrappedValue {
                projectedValue = Strategy.encode(wrappedValue)
            }
        }
    }

    public private(set) var projectedValue: Strategy.RawValue?

    public init(wrappedValue value: Date?) {
        wrappedValue = value
        if let value = value {
            projectedValue = Strategy.encode(value)
        } else {
            projectedValue = nil
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            projectedValue = nil
            wrappedValue = nil
        } else {
            let value = try container.decode(Strategy.RawValue.self)
            projectedValue = value
            wrappedValue = try Strategy.decode(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(projectedValue)
    }
}
