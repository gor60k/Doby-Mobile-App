import Foundation

struct MeEndpoint: APIEndpointProtocol {
    typealias Response = MeResponse
    
    var baseURL: URL {APIConstants.baseURL}
    var path: String { "/users/me/" }
    var method: HTTPMethod { .get }
}
