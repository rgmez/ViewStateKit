// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewStateKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(name: "ViewStateKit", targets: ["ViewStateKit"])
    ],
    targets: [
        .target(
            name: "ViewStateKit",
            path: "Sources/ViewStateKit"
        ),
        .testTarget(
            name: "ViewStateKitTests",
            dependencies: ["ViewStateKit"],
            path: "Tests/ViewStateKitTests"
        )
    ]
)
