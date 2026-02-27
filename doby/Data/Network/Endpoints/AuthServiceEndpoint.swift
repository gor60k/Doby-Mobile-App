import Foundation

enum AuthServiceEndpoint {
    case register(user: RegisterRequest)
    case login(user: LoginRequest)
    case logout
    case delete(headers: [String: String]?)
}

extension AuthServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
        URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .register(let user): return "/auth/register/"
        case .login(let user): return "/auth/login/"
        case .logout: return "/auth/logout/"
        case .delete: return "/auth/delete/me/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .logout: return .post
        case .delete: return .delete
        }
    }
    
    var body: Data? {
        switch self {
        case .register(let user): return try? JSONEncoder().encode(user)
        case .login(let user): return try? JSONEncoder().encode(user)
        case .logout: return nil
        case .delete: return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .register, .login, .logout:
            return ["Content-Type": "application/json"]
        case .delete(let headers):
            return headers
        }
    }
}
