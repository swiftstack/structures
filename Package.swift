// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "LinkedList",
    products: [
        .library(name: "LinkedList", targets: ["ListEntry"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-stack/test.git",
            from: "0.4.0")
    ],
    targets: [
        .target(name: "ListEntry"),
        .testTarget(name: "ListEntryTests", dependencies: ["ListEntry", "Test"])
    ]
)
