import Foundation

struct LogoutEndpoint: APIEndpointProtocol {
    typealias Response = EmptyDTO

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/logout/" }
    var method: HTTPMethod { .post }
}
