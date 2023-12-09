// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Brainfuck",
    platforms: [.iOS(.v10), .macOS(.v10_12)],
    products: [
        .library(
            name: "Brainfuck",
            targets: ["Brainfuck"]),
    ],
    dependencies: [
         .package(url: "https://github.com/nerdsupremacist/Ogma.git", from: "0.1.2"),
    ],
    targets: [
        .target(
            name: "Brainfuck",
            dependencies: ["Ogma"]),
        .testTarget(
            name: "BrainfuckTests",
            dependencies: ["Brainfuck"]),
    ]
)
