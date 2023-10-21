// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Commons",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(
            name: "Commons",
            targets: ["Commons"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../NetworkPlatform"),
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.8.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.47.2"
        )
    ],
    targets: [
        .target(
            name: "Commons",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "NetworkPlatform", package: "NetworkPlatform"),
                .product(name: "Swinject", package: "Swinject"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
    ]
)
