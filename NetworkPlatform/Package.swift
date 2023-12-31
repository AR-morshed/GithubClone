// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkPlatform",
    platforms: [.macOS(.v12), .iOS(.v17)],
    products: [
        .library(name: "NetworkPlatform",
                 targets: ["NetworkPlatform"])
    ],
    
    dependencies: [
        .package(path: "../Domain"),
        .package(
            url: "https://github.com/Moya/Moya.git",
            from: "15.0.0"
        ),
        .package(
            url: "https://github.com/Swinject/Swinject.git",
            from: "2.8.0"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture",
            exact: "1.2.0"
        )
    ],
    
    targets: [
            .target(
                name: "BuildConfiguration",
                dependencies: []),
        
            .target(
                name: "NetworkPlatform",
                dependencies: [
                    "BuildConfiguration",
                    .product(name: "Domain", package: "Domain"),
                    .product(name: "Moya", package: "Moya"),
                    .product(name: "CombineMoya", package: "Moya")
                ]
            )
    ]
)
