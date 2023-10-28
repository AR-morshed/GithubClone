// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.macOS(.v12), .iOS(.v17)],
    products: [
        .library(name: "Root",
                 targets: ["Root"]),
        
        .library(name: "TrendingRepository",
                    targets: ["TrendingRepository"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Commons"),
        .package(path: "../NetworkPlatform"),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            exact: "1.2.0"
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
                "TrendingRepository"
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
    ]
)
