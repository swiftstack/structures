// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "LinkedList",
    products: [
        .library(name: "LinkedList", targets: ["ListEntry"])
    ],
    targets: [
        .target(name: "ListEntry"),
        .testTarget(name: "ListEntryTests", dependencies: ["ListEntry"])
    ]
)
