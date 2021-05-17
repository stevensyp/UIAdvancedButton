// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIAdvancedButton",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UIAdvancedButton",
            targets: ["UIAdvancedButton"]),
    ],
    targets: [
        .target(
            name: "UIAdvancedButton",
            dependencies: []),
        .testTarget(
            name: "UIAdvancedButtonTests",
            dependencies: ["UIAdvancedButton"]),
    ]
)
