# VariableDateCodable

Supporting mixed date formats within `Codable` entities through property wrappers.

_This code is pretty much a clone and customisation of [marksands/BetterCodable](https://github.com/marksands/BetterCodable) but handling `Date`s specifically._

```swift
struct Response: Codable {
    @DateValue<YearMonthDayStrategy> var birthday: Date
    @DateValue<ISO8601Strategy> var updatedAt: Date
}

let json = #"{ "birthday": "1984-01-22", "updatedAt": "2019-10-19T16:14:32-08:00" }"#.data(using: .utf8)!
let result = try JSONDecoder().decode(Response.self, from: json)

// This produces two valid `Date` values, `updatedAt` representing October 19, 2019 and `birthday` January 22nd, 1984.
```

The `@DateValue` wrapper is generic across a custom `DateValueCodableStrategy`. This allows anyone to implement their own date decoding strategy and get the property wrapper behavior for free.

A few common `Date` strategies are provided.

## Strategies

### ISO8601FractionalSecondsStrategy
`@DateValue<ISO8601Strategy>` relies on an `ISO8601DateFormatter`, customised with the `.withInternetDateTime` and `.withFractionalSeconds` format options, in order to decode `String` values into `Date`s. Encoding the date will encode the value into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<ISO8601FractionalSecondsStrategy> var iso8601: Date
}
let jsonData = #"{"iso8601": "1996-12-19T16:39:57.538-08:00"}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes, 57 seconds, and 538 milliseconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### ISO8601Strategy
`@DateValue<ISO8601Strategy>` relies on an `ISO8601DateFormatter` in order to decode `String` values into `Date`s. Encoding the date will encode the value into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<ISO8601Strategy> var iso8601: Date
}
let jsonData = #"{"iso8601": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### ReferenceTimestampStrategy
`@DateValue<TimestampStrategy>` decodes `Double`s of a unix epoch into `Date`s. Encoding the date will encode the value into the original `TimeInterval` value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<ReferenceTimestampStrategy> var timestamp: Date
}
let jsonData = #"{"timestamp": 604548113.0}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 1 minute and 53 seconds after the 14th hour of February 28th, 2020.
```

### RFC2822Strategy
`@DateValue<RFC2822Strategy>` decodes RFC 2822 date `String`s into `Date`s. Encoding the date will encode the value back into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<RFC2822Strategy> var rfc2822Date: Date
}
let jsonData = #"{"rfc2822Date": "Fri, 27 Dec 2019 22:43:52 -0000"}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 43 minutes and 52 seconds after the 22nd hour of December 27th, 2019 with an offset of -00:00 from UTC.
```

### RFC3339Strategy
`@DateValue<RFC3339Strategy>` decodes RFC 3339 date `String`s into `Date`s. Encoding the date will encode the value back into the original string value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<RFC3339Strategy> var rfc3339Date: Date
}
let jsonData = #"{"rfc3339Date": "1996-12-19T16:39:57-08:00"}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing 39 minutes and 57 seconds after the 16th hour of December 19th, 1996 with an offset of -08:00 from UTC (Pacific Standard Time).
```

### TimestampStrategy
`@DateValue<TimestampStrategy>` decodes `Double`s of a unix epoch into `Date`s. Encoding the date will encode the value into the original `TimeInterval` value.

#### Usage
```swift
struct Response: Codable {
    @DateValue<TimestampStrategy> var timestamp: Date
}
let jsonData = #"{"timestamp": 978307200.0}"# .data(using: .utf8)!

let response = try JSONDecoder().decode(Response.self, from: jsonData)

// This produces a valid `Date` representing January 1st, 2001.
```

### YearMonthDayStrategy
`@DateValue<YearMonthDayStrategy>` decodes `String` values into `Date`s using the date format `y-MM-dd`. Encoding the date will encode the value back into the original string format.

#### Usage
```swift
struct Response: Codable {
    @DateValue<YearMonthDayStrategy> var ymd: Date
}
let jsonData = #"{"ymd": "2001-01-01"}"# .data(using: .utf8)!

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
