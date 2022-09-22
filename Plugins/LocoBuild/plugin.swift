import XcodeProjectPlugin
import PackagePlugin
import Foundation

@main
struct LocoBuild: XcodeBuildToolPlugin {

	func createBuildCommands(context: XcodeProjectPlugin.XcodePluginContext, target: XcodeProjectPlugin.XcodeTarget) throws -> [PackagePlugin.Command] {
		print("Hello, World!")

		let tool = try context.tool(named: "loco")
		let translations = target.inputFiles.filter({ $0.type == .resource })
		let paths = translations.map { $0.path }

		return [
			.buildCommand(
				displayName: "Started loco...",
				executable: tool.path,
				arguments: [],
				inputFiles: paths
			)
		]
	}

}
