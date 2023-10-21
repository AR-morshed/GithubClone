// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.macOS(.v12), .iOS(.v15)],
    products: [
        .library(name: "Root",
                 targets: ["Root"]),
        
        .library(name: "AppSetting",
                 targets: ["AppSetting"]),
        
        .library(name: "Authentication",
                 targets: ["Authentication"]),
        
        .library(name: "TrendingDeveloper",
                    targets: ["TrendingDeveloper"]),
        
        .library(name: "TrendingRepository",
                    targets: ["TrendingRepository"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Commons"),
        .package(path: "../NetworkPlatform"),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            from: "0.47.2"
        ),
        .package(
            url: "https://github.com/mac-cain13/R.swift.git",
            from: "7.0.1"
        ),
    ],
    targets: [
        .target(
            name: "Root",
            dependencies: [
                "AppSetting",
                "Authentication",
                "TrendingDeveloper",
                "TrendingRepository"
            ]),
        
        .target(
            name: "AppSetting",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Commons", package: "Commons"),
            ]),
        .target(
            name: "Authentication",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Commons", package: "Commons"),
                .product(name: "RswiftLibrary", package: "R.swift"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]),
        .target(
            name: "TrendingDeveloper",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Commons", package: "Commons"),
            ]),
        .target(
            name: "TrendingRepository",
            dependencies: [
                "TrendingDetails",
                .product(name: "Domain", package: "Domain"),
                .product(name: "Commons", package: "Commons"),
            ]),
        
        .target(
            name: "TrendingDetails",
            dependencies: [
                .product(name: "Domain", package: "Domain"),
                .product(name: "Commons", package: "Commons"),
            ]),
        
            .testTarget(
                name: "AppSettingTests",
                dependencies: ["AppSetting"]),
    ]
)
