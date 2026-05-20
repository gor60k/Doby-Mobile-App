import Foundation

struct RegisterEndpoint: APIEndpointProtocol {
    typealias Response = RegisterResponse

    let request: RegisterRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/register/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}
