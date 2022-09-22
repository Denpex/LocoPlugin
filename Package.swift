// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "LocoPlugin",
	platforms: [
		.macOS(.v11)
	],
	products: [
		.plugin(
			name: "LocoBuild",
			targets: ["LocoBuild"]
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
		)
	]
)
