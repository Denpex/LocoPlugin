// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "LocoPlugin",
	platforms: [
		.macOS("10.15"),
		.iOS("12.0"),
		.tvOS("12.0"),
		.watchOS("6.0")
	],
	products: [
		.plugin(
			name: "LocoBuild",
			targets: ["LocoBuild"]
		),
		.plugin(
			name: "LocoCLI",
			targets: ["LocoCLI"]
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
			name: "LocoBuild",
			capability: .buildTool(),
			dependencies: ["loco"]
		),
		.plugin(
			name: "LocoCLI",
			capability: .command(
				intent: .custom(
					verb: "loco-analyze",
					description: "Runs loco in your project directory and generates a report into LocoLogs.txt"
				),
				permissions: [
					.writeToPackageDirectory(
						reason: "Needs to generate LocoLogs.txt to write the output of loco."
					)
				]
			),
			dependencies: ["loco"]
		)
	]
)
