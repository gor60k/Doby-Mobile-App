import Foundation

extension UserServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
        URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .getAllUsers: return "/users/"
        case .getUser(let id): return "/users/\(id)"
        case .createUser: return "/users/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllUsers, .getUser: return .get
        case .createUser: return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .createUser(let user):
            return try? JSONEncoder().encode(user)
        default: return nil
        }
    }
}
