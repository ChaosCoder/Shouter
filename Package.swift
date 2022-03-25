// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Shouter",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "Shouter", targets: ["Shouter"]),
    ],
    targets: [
        .target(name: "Shouter"),
        .testTarget(name: "ShouterTests", dependencies: ["Shouter"]),
    ]
)
