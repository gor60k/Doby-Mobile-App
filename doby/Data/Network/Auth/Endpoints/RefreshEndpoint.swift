import Foundation

struct RefreshEndpoint: APIEndpointProtocol {
    typealias Response = RefreshResponse
    
    let request: RefreshRequest
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/token/refresh/" }
    var method: HTTPMethod { .post }
    var body: Data? { try? JSONEncoder().encode(request) }
}
