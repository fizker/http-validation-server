import ArgumentParser

@main
struct AppCommand: AsyncParsableCommand {
	static let configuration = CommandConfiguration(
		commandName: "http-validation-server",
	)

	@Option(name: .shortAndLong)
	var port: Int

	func run() async throws {
		let app = try await buildApplication(port: port)
		try await app.runService()
	}
}
