// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "loco-plugin",
	platforms: [
		.macOS(.v10_15)
	],
	products: [
		.plugin(
			name: "LocoBuiltin",
			targets: ["LocoBuiltin"]
		),
		.plugin(
			name: "LocoPlugin",
			targets: ["LocoPlugin"]
		)
	],
	dependencies: [
		.package(
			url: "https://github.com/konrad1977/loco.git",
			branch: "main"
		)
	],
	targets: [
		.plugin(
			name: "LocoBuiltin",
			capability: .buildTool(),
			dependencies: [
				.product(name: "loco", package: "Loco")
			]
		),
		.plugin(
			name: "LocoPlugin",
			capability: .command(
				intent: .custom(
					verb: "loco",
					description: "Will analyize all your .lproj files and create a report with warnings and errors."
				),
				permissions: [
					.writeToPackageDirectory(
						reason: "LocoPlugin will analyize all *.lproj inside of your directory."
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
