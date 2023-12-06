// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "doc_flow_sdk",
    platforms: [
        .iOS(.v14),
    ],

    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "doc_flow_sdk",
            targets: ["doc_flow_sdk"]),
    ],
    
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Swinject/Swinject.git", .exact("2.7.1")),
        .package(url: "https://github.com/SnapKit/SnapKit.git", .exact("5.6.0")),
        .package(url: "https://github.com/airbnb/HorizonCalendar.git", .exact("1.16.0")),
        .package(url: "https://github.com/scenee/FloatingPanel.git", .exact("2.8.0")),
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", .exact("2.7.0")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .exact("7.6.1")),

    ],

    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "doc_flow_sdk",
        dependencies: [
            "FloatingPanel",
            "HorizonCalendar",
            "SnapKit",
            "Kingfisher",
            "Swinject",
            "SwinjectAutoregistration",
        ],
            path: "Sources"
        ),
    ],
    
    swiftLanguageVersions: [.v5]
)
