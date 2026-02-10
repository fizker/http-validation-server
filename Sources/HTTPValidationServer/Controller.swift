import Hummingbird

actor Controller {
	var data: [String: String] = [:]

	nonisolated func setup(router: Router<AppRequestContext>) {
		router.get("/") { _, _ in
			return HTML(html: """
				<!html>
				<style>
					form label {
						display: block;
					}
				</style>

				<h1>Add new response key</h1>
				<form method="post">
					<label>Key: <input name="key"></label>
					<label>Value:<br><textarea name="value"></textarea></label>
					<button type="submit">Add entry</button>
				</form>
				"""
			)
		}
		router.post("/") { req, context in
			let pair = try await req.decode(as: KeyValuePair.self, context: context)
			await self.add(pair)
			return Response(status: .seeOther, headers: [ .location: "/" ])
		}
		router.get("/.well-known/acme-challenge/:key") {
			req,
			context in
			let key = try context.parameters.require("key")
			guard let value = await self.data[key]
			else {
				context.logger.error("Unknown key requested for acme-challenge", metadata: [
					"key": "\(key)",
				])
				throw HTTPError(.notFound)
			}

			return Response(
				status: .ok,
				headers: [ .contentType: "application/octet-stream" ],
				body: .init(byteBuffer: .init(string: value)),
			)
		}
	}

	func add(_ pair: KeyValuePair) {
		data[pair.key] = pair.value
	}

	struct KeyValuePair: Codable {
		var value: String
		var key: String
	}
}
