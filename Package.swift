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
    targets: [
        .target(name: "VariableDateCodable"),
        .testTarget(name: "VariableDateCodableTests", dependencies: ["VariableDateCodable"]),
    ]
)
