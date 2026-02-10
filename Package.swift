// swift-tools-version: 6.2

import PackageDescription

let package = Package(
	name: "http-validation-server",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.executable(
			name: "http-validation-server",
			targets: ["HTTPValidationServer"],
		),
	],
	dependencies: [
		.package(url: "https://github.com/apple/swift-argument-parser", from: "1.7.0"),
		.package(url: "https://github.com/fizker/swift-extensions.git", from:"1.5.1"),
		.package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.20.0"),
	],
	targets: [
		.executableTarget(
			name: "HTTPValidationServer",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),
				.product(name: "FzkExtensions", package: "swift-extensions"),
				.product(name: "Hummingbird", package: "hummingbird"),
			],
		),
	],
)
