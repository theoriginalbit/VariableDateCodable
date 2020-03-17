import Foundation

/// Decodes and encodes optional dates using a strategy type.
///
/// `OptionalDateValue` decodes optional dates using a `DateValueCodableStrategy` which provides custom decoding and encoding functionality.
@propertyWrapper
public struct OptionalDateValue<Formatter: DateValueCodableStrategy>: Codable {
    private let value: Formatter.RawValue?
    public var wrappedValue: Date?

    public init(wrappedValue: Date?) {
        self.wrappedValue = wrappedValue
        if let wrappedValue = wrappedValue {
            value = Formatter.encode(wrappedValue)
        } else {
            value = nil
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            value = nil
            wrappedValue = nil
        } else {
            let value = try container.decode(Formatter.RawValue.self)
            self.value = value
            wrappedValue = try Formatter.decode(value)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let value = value {
            try container.encode(value)
        } else {
            try container.encodeNil()
        }
    }
}
