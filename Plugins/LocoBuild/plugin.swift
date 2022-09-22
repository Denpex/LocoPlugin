import PackagePlugin
import Foundation

@main
struct LocoBuild: BuildToolPlugin {

	func createBuildCommands(context: PluginContext, target: Target) throws -> [PackagePlugin.Command] {
		debugPrint("Hello, World!")

		guard let target = target as? SourceModuleTarget else {
			fatalError("Wrong target type \(String(describing: target.self))")
		}

		let tool = try context.tool(named: "loco")
		let paths = target.sourceFiles(withSuffix: ".lproj").map { $0.path }

		debugPrint(paths)

		return [
			.buildCommand(
				displayName: "Analyzing files with loco",
				executable: tool.path,
				arguments: [],
				inputFiles: paths
			)
		]
	}

}
