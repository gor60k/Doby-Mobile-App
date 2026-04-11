import Foundation

enum UserServiceEndpoint {
    case me(requestHeaders: [String: String])
}

extension UserServiceEndpoint: APIEndpointProtocol {
    var baseURL: URL {
//        URL(string: "http://localhost:8000/api")!
        URL(string: "https://frowsier-hungerly-thad.ngrok-free.dev/api")!
    }
    
    var path: String {
        switch self {
        case .me: return "/users/me/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .me: return .get
        }
    }
    
    var body: Data? {
        switch self {
        case .me: return nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .me(let requestHeaders):
            return requestHeaders
        }
    }
}
