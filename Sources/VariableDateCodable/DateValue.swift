import Foundation

/// Decodes and encodes dates using a strategy type.
///
/// `DateValue` decodes dates using a `DateValueCodableStrategy` which provides custom decoding and encoding functionality.
@propertyWrapper
public struct DateValue<Formatter: DateValueCodableStrategy>: Codable {
    private let value: Formatter.RawValue
    public var wrappedValue: Date

    public init(wrappedValue: Date) {
        self.wrappedValue = wrappedValue
        value = Formatter.encode(wrappedValue)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            throw DecodingError.valueNotFound(Formatter.RawValue.self, .init(codingPath: [], debugDescription: "Found unexpected nil"))
        }
        value = try container.decode(Formatter.RawValue.self)
        wrappedValue = try Formatter.decode(value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(value)
    }
}
