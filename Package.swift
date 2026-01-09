// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewStateKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(name: "ViewStateKit", targets: ["ViewStateKit"])
    ],
    targets: [
        .target(
            name: "ViewStateKit",
            path: "Sources/ViewStateKit",
            resources: [
                .process("Resources")
            ]
            ,
            plugins: [
                .plugin(name: "GenerateLocalizationsPlugin")
            ]
        ),
        .plugin(
            name: "GenerateLocalizationsPlugin",
            capability: .buildTool(),
            path: "Plugins/GenerateLocalizationsPlugin"
        ),
        .testTarget(
            name: "ViewStateKitTests",
            dependencies: ["ViewStateKit"],
            path: "Tests/ViewStateKitTests"
        )
    ]
)
