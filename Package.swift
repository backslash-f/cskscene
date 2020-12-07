// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CSKScene",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CSKScene",
            targets: ["CSKScene"]),
    ],
    dependencies: [
        .package(name: "AppLogger", url: "https://github.com/backslash-f/applogger", from: "1.0.0"),
        .package(name: "GCOverseer", url: "https://github.com/backslash-f/gcoverseer", from: "0.2.1")
    ],
    targets: [
        .target(
            name: "CSKScene",
            dependencies: [
                "AppLogger",
                "GCOverseer"
            ]
        ),
        .testTarget(
            name: "CSKSceneTests",
            dependencies: ["CSKScene"]),
    ],
    swiftLanguageVersions: [.v5]
)
