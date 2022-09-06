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
        .package(
            url: "https://github.com/konrad1977/loco.git",
            branch: "main"
        )
    ],
    targets: [
        .plugin(
            name: "LocoPlugin",
            capability: .command(
								intent: .custom(
										verb: "loco",
										description: "Will run localization linter `loco`."
								),
                permissions: [
                    .writeToPackageDirectory(
                        reason: "LocoPlugin will format all *.lproj inside of your directory."
                    )
                ]
            ),
            dependencies: [
                .product(
                    name: "loco",
                    package: "Loco"
                ),
            ]
        ),
    ]
)
