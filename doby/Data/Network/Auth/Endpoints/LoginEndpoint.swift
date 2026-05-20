import Foundation

struct LoginEndpoint: APIEndpointProtocol {
    typealias Response = LoginResponse
    
    let request: LoginRequest
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/login/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}
