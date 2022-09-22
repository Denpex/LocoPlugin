/**
 * File: Main.swift
 * Project: LocoPlugin
 * Created: Monday, 5th September 2022
 * -----
 * Copyright 2022, ©Mehdi Rashadatjou
 * -----
 */

import Foundation
import PackagePlugin

@main
struct LocoCLI {

	private func runLoco(tool: PackagePlugin.PluginContext.Tool) throws {
		// Load loco
		let locoToolUrl = URL(fileURLWithPath: tool.path.string)

		// Setup
		let process = Process()
		process.executableURL = locoToolUrl
		process.arguments = [
			"--color"
		]

		let pipe = Pipe()
		process.standardOutput = pipe

		try process.run()
		process.waitUntilExit()

		if process.terminationReason == .exit && process.terminationStatus == 0 {
			debugPrint("Loco is done ✌️✅")
		} else {
			let problem = "\(process.terminationReason):\(process.terminationStatus)"
			Diagnostics.error("Invocation failed: \(problem)")
			debugPrint("Loco has failed 👎❌")
		}

		guard let outputData = try? pipe.fileHandleForReading.readToEnd() else { return }
		guard let output = String(data: outputData, encoding: .utf8) else { return }
		try output.write(toFile: "LocoLogs.txt", atomically: true, encoding: .utf8)
	}
}

extension LocoCLI: CommandPlugin {

	public func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
		// Run in package context
		let locoTool = try context.tool(named: "loco")
		try runLoco(tool: locoTool)
	}

}


#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension LocoCLI: XcodeCommandPlugin {

	func performCommand(context: XcodeProjectPlugin.XcodePluginContext, arguments: [String]) throws {
		// Run in xcode context
		let locoTool = try context.tool(named: "loco")
		try runLoco(tool: locoTool)
	}

}

#endif
