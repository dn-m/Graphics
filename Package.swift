// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Graphics",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Graphics",
            targets: ["Graphics"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "../Math", .branch("master")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Graphics",
            dependencies: ["Math"]),
        .testTarget(
            name: "GraphicsTests",
            dependencies: ["Graphics"]),
    ]
)
