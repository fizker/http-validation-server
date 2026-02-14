import ArgumentParser

@main
struct AppCommand: AsyncParsableCommand {
	static let configuration = CommandConfiguration(
		commandName: "http-validation-server",
	)

	@Option(name: .shortAndLong)
	var port: Int

	@Argument(
		help: "Validation pairs. These can also be given after launch. Format: <URL token>=<response body>",
		transform: KeyValuePair.init(argument:),
	)
	var pairs: [KeyValuePair] = []

	func run() async throws {
		let app = try await buildApplication(port: port, pairs: pairs)
		try await app.runService()
	}
}
