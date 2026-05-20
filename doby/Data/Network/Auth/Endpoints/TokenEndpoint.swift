import Foundation

struct TokenEndpoint: APIEndpointProtocol {
    typealias Response = TokenResponse

    let request: TokenRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/token/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}
