// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "loco-plugin",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .plugin(
            name: "LocoPlugin",
            targets: ["LocoPlugin"]
        ),
    ],
    dependencies: [
        // TODO: Insert loco package
    ],
    targets: [
        .plugin(
            name: "LocoPlugin",
            capability: .command(
                intent: .sourceCodeFormatting(),
                permissions: [
                    .writeToPackageDirectory(
                        reason: "LocoPlugin will format all .lproj inside of directory."
                    )
                ]
            ),
            dependencies: [
                .target(name: "Core")
            ]
        ),
        .target(
            name: "Core",
            dependencies: []
        ),
        .testTarget(
            name: "LocoPluginTest",
            dependencies: ["LocoPlugin"]
        ),
    ]
)
