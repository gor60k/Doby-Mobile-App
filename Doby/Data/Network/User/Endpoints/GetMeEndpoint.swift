import Foundation

struct GetMeEndpoint: APIEndpointProtocol {
    typealias Response = UserDTO
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/users/me/" }
    var method: HTTPMethod { .get }
}
