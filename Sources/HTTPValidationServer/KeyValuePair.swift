import ArgumentParser

struct KeyValuePair: Codable {
	var value: String
	var key: String
}

extension KeyValuePair {
	init(argument: String) throws {
		let parts = argument.split(separator: "=", maxSplits: 1, omittingEmptySubsequences: false)
		guard parts.count == 2
		else {
			throw ValidationError("Invalid key-value pair format: \(argument)")
		}
		self.key = String(parts[0])
		self.value = String(parts[1])
	}
}
