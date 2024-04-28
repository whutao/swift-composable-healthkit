// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-composable-healthkit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "ComposableHealthKit", targets: ["ComposableHealthKit"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: Version(1, 3, 0)
        )
    ],
    targets: [
        .target(
            name: "ComposableHealthKit",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies")
            ]
        )
    ]
)
