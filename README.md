# VariableDateCodable
![Build](https://github.com/theoriginalbit/VariableDateCodable/workflows/build/badge.svg?branch=master) [![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

Supporting mixed date formats within `Codable` entities through property wrappers.

_This code is pretty much a clone of [marksands/BetterCodable](https://github.com/marksands/BetterCodable) but only handling `Date`s and adds some strategies I more commonly use, as well as support for Optionals._

```swift
struct Response: Codable {
    @DateCodable<YearMonthDayStrategy> var birthday: Date
    @DateCodable<ISO8601Strategy> var createdAt: Date
    @OptionalDateCodable<ISO8601Strategy> var updatedAt: Date?
}

let json = Data(#"{ "birthday": "1984-01-22", "createdAt": "2019-10-19T16:14:32-08:00" }"#.utf8)
let result = try JSONDecoder().decode(Response.self, from: json)

// This produces three valid `Date` values, `createdAt` representing October 19, 2019, `birthday` January 22nd, 1984, and `updatedAt` is `nil`.
```

The `@DateCodable` wrapper is generic across a custom `DateValueCodableStrategy`. This allows anyone to implement their own date decoding strategy and get the property wrapper behavior for free.

A few common `Date` strategies are provided.

`@OptionalDateCodable` behaves the same as `@DateCodable` but allows your model to make the date value optional.

## Strategies

### ISO8601FractionalSecondsStrategy
`@DateCodable<ISO8601Strategy>` relies on an `ISO8601DateFormatter`, customised with the `.withInternetDateTime` and `.withFractionalSeconds` format options, in order to decode `String` values into `Date`s. Encoding the date will encode the value into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<ISO8601FractionalSecondsStrategy> var iso8601: Date
}
let jsonData = Data(#"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes, 57 seconds, and 538 milliseconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### ISO8601Strategy
`@DateCodable<ISO8601Strategy>` relies on an `ISO8601DateFormatter` in order to decode `String` values into `Date`s. Encoding the date will encode the value into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<ISO8601Strategy> var iso8601: Date
}
let jsonData = Data(#"{"iso8601": "1996-12-19T16:39:57-08:00"}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### ReferenceTimestampStrategy
`@DateCodable<TimestampStrategy>` decodes `Double`s of a unix epoch into `Date`s. Encoding the date will encode the value into the original `TimeInterval` value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<ReferenceTimestampStrategy> var timestamp: Date
}
let jsonData = Data(#"{"timestamp": 604548113.0}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 1 minute and 53 seconds after the 14th hour of February 28th, 2020.
```

### RFC2822Strategy
`@DateCodable<RFC2822Strategy>` decodes RFC 2822 date `String`s into `Date`s. Encoding the date will encode the value back into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<RFC2822Strategy> var rfc2822Date: Date
}
let jsonData = Data(#"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 43 minutes and 52 seconds after the 22nd hour of December 27th, 2019 with an offset of -00:00 from UTC.
```

### RFC3339Strategy
`@DateCodable<RFC3339Strategy>` decodes RFC 3339 date `String`s into `Date`s. Encoding the date will encode the value back into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<RFC3339Strategy> var rfc3339Date: Date
}
let jsonData = Data(#"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### TimestampStrategy
`@DateCodable<TimestampStrategy>` decodes `Double`s of a unix epoch into `Date`s. Encoding the date will encode the value into the original `TimeInterval` value.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<TimestampStrategy> var timestamp: Date
}
let jsonData = Data(#"{"timestamp": 978307200.0}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing January 1st, 2001.
```

### YearMonthDayStrategy
`@DateCodable<YearMonthDayStrategy>` decodes `String` values into `Date`s using the date format `y-MM-dd`. Encoding the date will encode the value back into the original string format.

#### Usage
```swift
struct Response: Codable {
    @DateCodable<YearMonthDayStrategy> var ymd: Date
}
let jsonData = Data(#"{"ymd": "2001-01-01"}"#.utf8)

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing January 1st, 2001.
```

## Installation

Swift Package Manager

## Testing

From the command line run `swift test`.

Output can also be piped through [xcpretty](https://github.com/xcpretty/xcpretty) `swift test 2>&1 | xcpretty`

## Attribution

This project has been extracted and modified from [marksands/BetterCodable](https://github.com/marksands/BetterCodable) and is licensed under MIT.
