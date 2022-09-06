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
struct LocoPlugin: CommandPlugin {

		public func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
				// Load loco
				let locoTool = try context.tool(named: "loco")
				let locoToolUrl = URL(fileURLWithPath: locoTool.path.string)

				// Setup
				let process = Process()
				process.executableURL = locoToolUrl
				process.arguments = [
						"--no-color"
				]

				let pipe = Pipe()
				process.standardOutput = pipe

				try process.run()
				process.waitUntilExit()

				if process.terminationReason == .exit && process.terminationStatus == 0 {
						print("Formatted the source code.")
				} else {
						let problem = "\(process.terminationReason):\(process.terminationStatus)"
						Diagnostics.error("Invocation failed: \(problem)")
				}

				guard let outputData = try? pipe.fileHandleForReading.readToEnd() else { return }
				guard let output = String(data: outputData, encoding: .utf8) else { return }
				try output.write(toFile: "Loco.txt", atomically: true, encoding: .utf8)
		}

}
