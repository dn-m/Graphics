// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Graphics",
    products: [
        .library(name: "Geometry", targets: ["Geometry"]),
        .library(name: "Path", targets: ["Path"]),
    ],
    dependencies: [
        .package(url: "../Math", .branch("master")),
        .package(url: "../Structure", .branch("flat"))
    ],
    targets: [

        // Sources
        .target(name: "Geometry", dependencies: ["Math", "DataStructures"]),
        .target(name: "Path", dependencies: ["Geometry", "Math"]),

        // Tests
        .testTarget(name: "GeometryTests", dependencies: ["Geometry"]),
    ]
)
