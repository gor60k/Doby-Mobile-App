import Foundation

enum AuthServiceEndpoint {
    case register(user: RegisterRequest)
    case login(user: LoginRequest)
    case logout
}

extension AuthServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
        URL(string: "http://localhost:3000")!
    }
    
    var path: String {
        switch self {
        case .register(let user): return "/auth/registration/\(user.id)"
        case .login(let user): return "/auth/login/\(user.email)"
        case .logout: return "/auth/logout/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register, .login, .logout: return .post
        }
    }
    
    var body: Data? {
        switch self {
        case .register(let user): return try? JSONEncoder().encode(user)
        case .login(let user): return try? JSONEncoder().encode(user)
        case .logout: return nil
        }
    }
}
