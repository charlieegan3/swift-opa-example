// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "OPAExample",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/open-policy-agent/swift-opa", branch: "main"),
    ],
    targets: [
        .executableTarget(name: "OPAExample", dependencies: [
            .product(name:"SwiftOPA", package: "swift-opa"),
        ]),
    ]
)
