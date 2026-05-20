import Foundation

struct UpdateUser: APIEndpointProtocol {
    typealias Response = UserDTO
    
    let request: UpdateUserRequest
    
    var baseURL: URL {APIConstants.baseURL}
    var path: String { "/users/me/update/" }
    var method: HTTPMethod { .patch }
    var body: Data? { try? JSONEncoder().encode(request) }
}
