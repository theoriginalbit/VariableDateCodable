import Foundation

public extension KeyedDecodingContainer {
    func decode<Strategy>(_ type: OptionalDateValue<Strategy>.Type, forKey key: Key) throws -> OptionalDateValue<Strategy> {
        return try decodeIfPresent(type, forKey: key) ?? OptionalDateValue(wrappedValue: nil)
    }
}
