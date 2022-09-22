import PackagePlugin
import Foundation

@main
struct LocoBuild: BuildToolPlugin {

	func createBuildCommands(
		context: PackagePlugin.PluginContext,
		target: PackagePlugin.Target
	) async throws -> [PackagePlugin.Command] {
		print("Hello, World!")
		guard let target = target as? SwiftSourceModuleTarget else {
			return []
		}

		let tool = try context.tool(named: "loco")

		return [
			.prebuildCommand(
				displayName: "Running loco",
				executable: tool.path,
				arguments: [target.directory.string],
				outputFilesDirectory: context.pluginWorkDirectory
			)
		]
	}

}
