import Foundation

enum UserServiceEndpoint {
    case fetchMe(headers: [String: String]?)
}

extension UserServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
        URL(string: "http://localhost:8000/api")!
    }
    
    var path: String {
        switch self {
        case .fetchMe: return "/users/me/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchMe: return .get
        }
    }
    
    var body: Data? {
        switch self {
        case .fetchMe: return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .fetchMe(headers: let headers?): return ["Content-Type": "application/json"]
        default: return nil
//        case .fetchMe(headers: .none):
        }
    }
}
