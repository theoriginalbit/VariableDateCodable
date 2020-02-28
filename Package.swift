// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "VariableDateCodable",
    platforms: [
        .iOS("11.2"),
        .macOS(.v10_13)
    ],
    products: [
        .library(name: "VariableDateCodable", targets: ["VariableDateCodable"]),
    ],
    dependencies: [],
    targets: [
        // Core
        .target(name: "VariableDateCodable"),
        
        // Opt-in Extensions
        .target(
            name: "VariableDateCodableISO8601FractionalSeconds",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["ISO8601FractionalSecondsStrategy.swift"]
        ),
        .target(
            name: "VariableDateCodableISO8601",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["ISO8601Strategy.swift"]
        ),
        .target(
            name: "VariableDateCodableReferenceTimestamp",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["ReferenceTimestampStrategy.swift"]
        ),
        .target(
            name: "VariableDateCodableRFC2822",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["RFC2822Strategy.swift"]
        ),
        .target(
            name: "VariableDateCodableRFC3339",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["RFC3339Strategy.swift"]
        ),
        .target(
            name: "VariableDateCodableTimestamp",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["TimestampStrategy.swift"]
        ),
        .target(
            name: "VariableDateCodableYearMonthDay",
            dependencies: ["VariableDateCodable"],
            path: "Sources/VariableDateCodableExtensions",
            sources: ["YearMonthDayStrategy.swift"]
        ),
        
        // Tests
        .testTarget(name: "VariableDateCodableTests", dependencies: [
            "VariableDateCodable",
            "VariableDateCodableISO8601FractionalSeconds",
            "VariableDateCodableISO8601",
            "VariableDateCodableReferenceTimestamp",
            "VariableDateCodableRFC2822",
            "VariableDateCodableRFC3339",
            "VariableDateCodableTimestamp",
            "VariableDateCodableYearMonthDay",
        ]),
    ]
)
