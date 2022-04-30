// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EventTransceiver",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "EventTransceiver", targets: ["EventTransceiver"])
    ],
    dependencies: [],
    targets: [
        .target(name: "EventTransceiver", dependencies: []),
        .testTarget(name: "EventTransceiverTests", dependencies: ["EventTransceiver"]),
    ]
)

