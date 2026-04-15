import Foundation

struct RegisterEndpoint: APIEndpointProtocol {
    typealias Response = AuthResponse

    let request: RegisterRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/register/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}

struct LoginEndpoint: APIEndpointProtocol {
    typealias Response = AuthResponse
    
    let request: LoginRequest
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/login/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}

struct TokenEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = TokenResponse

    let request: TokenRequest

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/token/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}

struct LogoutEndpoint: APIEndpointProtocol {
    typealias Response = EmptyResponse

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/logout/" }
    var method: HTTPMethod { .post }
    var body: Data? { nil }
}

struct DeleteMeEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = EmptyResponse

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/delete/me/" }
    var method: HTTPMethod { .delete }
    var body: Data? { nil }
}
