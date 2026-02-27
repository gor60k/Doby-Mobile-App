import Foundation

enum UserServiceEndpoint {
    case getAllUsers
    case getUser(id: String)
}

extension UserServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
        URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .getAllUsers: return "/users/"
        case .getUser(let id): return "/users/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllUsers, .getUser: return .get
            
        }
    }
    
    var body: Data? {
        switch self {
        case .getAllUsers:
            return nil
        default: return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getAllUsers:
            return ["Content-Type": "application/json"]
        case .getUser(let id):
            return ["Content-Type": "application/json"]
        }
    }
}
