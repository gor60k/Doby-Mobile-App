import Foundation

struct DeleteMeEndpoint: APIEndpointProtocol {
    typealias Response = EmptyDTO

    var baseURL: URL { APIConstants.baseURL }
    var path: String { "/auth/delete/me/" }
    var method: HTTPMethod { .delete }
}
