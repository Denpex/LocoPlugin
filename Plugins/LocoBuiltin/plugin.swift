import PackagePlugin
import Foundation

@main
struct LocoBuiltin: BuildToolPlugin {

	func createBuildCommands(
		context: PackagePlugin.PluginContext,
		target: PackagePlugin.Target
	) async throws -> [PackagePlugin.Command] {
		print("Starte built ")
		guard let target = target as? SourceModuleTarget else {
			return []
		}

		let files = target.sourceFiles(withSuffix: "lproj")

		return try files.map { (lproj) in
			return .buildCommand(
				displayName: "Running loco \(lproj.path)",
				executable: try context.tool(named: "loco").path,
				arguments: [],
				inputFiles: [lproj.path]
			)
		}
	}

}
