import Foundation

struct GetUserEndpoint: APIEndpointProtocol {
    typealias Response = UserDTO
    
    let userUUID: String
    
    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/users/\(userUUID)/" }
    var method: HTTPMethod { .get }
}
