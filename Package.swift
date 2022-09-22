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
		.library(
			name: "LocoLib",
			targets: ["LocoLib"]
		),
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
		.target(
			name: "LocoLib",
			dependencies: ["loco"],
			plugins: ["LocoBuild"]
		),
		.plugin(
			name: "LocoBuild",
			capability: .buildTool(),
			dependencies: ["loco"]
		)
	]
)
