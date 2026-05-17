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
