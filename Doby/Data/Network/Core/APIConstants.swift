import Foundation

enum APIConstants {
    static let baseURL: URL = {
        #if targetEnvironment(simulator)
            return URL(string: "http://localhost:80/api")!
        #else
            return URL(string: "https://frowsier-hungerly-thad.ngrok-free.dev/api")!
        #endif
    }()
}

extension APIConstants {
    static func getImageBaseURL() -> URL {
        if baseURL.lastPathComponent == "api" {
            return baseURL.deletingLastPathComponent()
        }
        
        return baseURL
    }
}
