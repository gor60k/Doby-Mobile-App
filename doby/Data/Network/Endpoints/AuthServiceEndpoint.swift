import Foundation

enum APIConstants {
    static let baseURL = URL(string: "https://frowsier-hungerly-thad.ngrok-free.dev/api")!
}

struct RegisterEndpoint: APIEndpointProtocol {
    typealias Response = AuthResponse

    let request: RegisterRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/register/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}

struct LoginEndpoint: APIEndpointProtocol {
    typealias Response = LoginResponse

    let request: LoginRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/token/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}

struct LogoutEndpoint: APIEndpointProtocol {
    typealias Response = EmptyResponse

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/logout/" }
    var method: HTTPMethod { .post }
    var body: Data? { nil }
    var headers: [String: String]? { ["Content-Type": "application/json"] }
}

struct DeleteMeEndpoint: APIEndpointProtocol {
    typealias Response = EmptyResponse

    let headersValue: [String: String]?

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/delete/me/" }
    var method: HTTPMethod { .delete }
    var body: Data? { nil }
    var headers: [String: String]? { headersValue }
}
