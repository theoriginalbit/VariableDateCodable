import Foundation

public extension KeyedDecodingContainer {
    func decode<Strategy>(_ type: OptionalDateCodable<Strategy>.Type, forKey key: Key) throws -> OptionalDateCodable<Strategy> {
        return try decodeIfPresent(type, forKey: key) ?? OptionalDateCodable(wrappedValue: nil)
    }
}
