import Foundation

protocol DateRepresentable {}

extension TimeInterval: DateRepresentable {}
extension Date: DateRepresentable {}
extension String: DateRepresentable {}

public struct NewDateValue: Codable {
    public enum Strategy {
        case iso8601(ISO8601DateFormatter.Options)
        case referenceTimestamp
        case unixTimestamp
        case yearMonthDay
        case rfc2822
        case rfc3339
        case custom(DateFormatter)

        var jsonDataType: DateRepresentable.Type {
            switch self {
            case .iso8601, .yearMonthDay, .rfc2822, .rfc3339:
                return String.self
            case .referenceTimestamp, .unixTimestamp:
                return TimeInterval.self
            case .custom:
                return String.self
            }
        }
    }

    public var wrappedValue: Date

    public init(strategy: Strategy) {
        wrappedValue = Date()
    }
}

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
