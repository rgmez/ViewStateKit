import PackagePlugin
import Foundation

@main
struct GenerateLocalizationsPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        // script path in the repository (URL-based APIs)
        let script = context.package.directoryURL.appendingPathComponent("Tools/generate_localized_strings.swift")
        guard FileManager.default.fileExists(atPath: script.path) else {
            Diagnostics.error("generate_localized_strings.swift not found at \(script.path)")
            return []
        }

        // If a generated file already exists in the source tree (committed), skip generation
        let committedOut = context.package.directoryURL.appendingPathComponent("Sources/ViewStateKit/Generated/Strings+Localized.swift")
        if FileManager.default.fileExists(atPath: committedOut.path) {
            // A committed generated file exists — avoid double-generation by the plugin.
            return []
        }

        // Write generated file into the plugin work directory so SwiftPM can include it as a generated source
        let out = context.pluginWorkDirectoryURL.appendingPathComponent("Strings+Localized.swift")

        // Use /usr/bin/env to invoke swift with the script path and output path
        let env = URL(fileURLWithPath: "/usr/bin/env")
        let args = ["swift", script.path, out.path]

        return [
            .buildCommand(
                displayName: "Generate localized strings",
                executable: env,
                arguments: args,
                inputFiles: [],
                outputFiles: [out]
            )
        ]
    }
}
