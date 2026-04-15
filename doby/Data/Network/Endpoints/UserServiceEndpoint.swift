import Foundation

struct MeEndpoint: AuthorizedAPIEndpointProtocol {
    typealias Response = MeResponse
    
    let headersValue: [String: String]?
    
    var baseURL: URL {APIConstants.baseURL}
    var path: String { "/users/me/" }
    var method: HTTPMethod { .get }
    var body: Data? { nil }
}
