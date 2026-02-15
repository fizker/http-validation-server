import FzkExtensions
import Hummingbird
import Logging

// Request context used by application
typealias AppRequestContext = HTMLFormRequestContext

///  Build application
/// - Parameter port: The port to run against
func buildApplication(port: Int, pairs: [KeyValuePair]) async throws -> some ApplicationProtocol {
	let logger = Logger(label: "HTTPValidationServer") ~ {
		$0.logLevel = .info
	}
	let router = try buildRouter(pairs: pairs)
	let app = Application(
		router: router,
		configuration: .init(address: .hostname("0.0.0.0", port: port)),
		logger: logger,
	)
	return app
}

/// Build router
func buildRouter(pairs: [KeyValuePair]) throws -> Router<AppRequestContext> {
	let router = Router(context: AppRequestContext.self)
	// Add middleware
	router.addMiddleware {
		// logging middleware
		LogRequestsMiddleware(.info)
	}

	let controller = Controller(pairs: pairs)
	controller.setup(router: router)
	return router
}

struct HTMLFormRequestContext: RequestContext {
	var coreContext: CoreRequestContextStorage

	init(source: Source) {
		self.coreContext = .init(source: source)
	}

	var requestDecoder: URLFormRequestDecoder { .init() }
}
