// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chat",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Chat",
            type: .dynamic,
            targets: ["Chat"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/siteline/SwiftUI-Introspect.git",
            from: "0.1.4"
        ),
        .package(
            url: "https://github.com/lorenzofiamingo/swiftui-cached-async-image.git",
            from: "2.1.1"
        ),
        .package(
            url: "https://github.com/exyte/MediaPicker.git",
            from: "0.0.1"
        ),
        .package(
            url: "https://github.com/exyte/FloatingButton",
            from: "1.0.1"
        ),
    ],
    targets: [
        .target(
            name: "Chat",
            dependencies: [
                .product(name: "Introspect", package: "SwiftUI-Introspect"),
                .product(name: "CachedAsyncImage", package: "swiftui-cached-async-image"),
                .product(name: "MediaPicker", package: "MediaPicker"),
                .product(name: "FloatingButton", package: "FloatingButton")
            ]
        ),
        .testTarget(
            name: "ChatTests",
            dependencies: ["Chat"]),
    ]
)
