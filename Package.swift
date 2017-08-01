// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "Graphics",
    products: [
        .library(name: "Geometry", targets: ["Geometry"]),
        .library(name: "Path", targets: ["Path"]),
        .library(name: "Rendering", targets: ["Rendering"]),
        .library(name: "SVG", targets: ["SVG"]),
        .library(name: "QuartzAdapter", targets: ["QuartzAdapter"])
    ],
    dependencies: [
        .package(url: "https://github.com/drmohundro/SWXMLHash", from: "4.1.1"),
        .package(url: "https://github.com/dn-m/Math", .branch("master")),
        .package(url: "https://github.com/dn-m/Structure", .branch("master"))
    ],
    targets: [

        // Sources
        .target(name: "Geometry", dependencies: ["Math", "DataStructures"]),
        .target(name: "Path", dependencies: ["Geometry", "Math"]),
        .target(name: "Rendering", dependencies: ["Path"]),
        .target(name: "SVG", dependencies: ["Rendering", "SWXMLHash"]),
        .target(name: "QuartzAdapter", dependencies: ["Rendering"]),
        .target(name: "GraphicsTesting", dependencies: ["QuartzAdapter"]),

        // Tests
        .testTarget(name: "GeometryTests", dependencies: ["Geometry"]),
        .testTarget(name: "PathTests", dependencies: ["Path"]),
        .testTarget(name: "RenderingTests", dependencies: ["Rendering"]),
        .testTarget(name: "SVGTests", dependencies: ["SVG", "GraphicsTesting"]),
        .testTarget(name: "QuartzAdapterTests", dependencies: ["QuartzAdapter", "GraphicsTesting"])
    ]
)
