import Hummingbird

struct HTML: ResponseGenerator {
	let status: HTTPResponse.Status = .ok
	let html: String

	public func response(from request: Request, context: some RequestContext) throws -> Response {
		let buffer = ByteBuffer(string: html)
		return .init(status: status, headers: [.contentType: "text/html"], body: .init(byteBuffer: buffer))
	}
}
