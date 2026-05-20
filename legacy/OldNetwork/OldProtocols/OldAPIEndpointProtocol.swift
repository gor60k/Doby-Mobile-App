import Foundation

protocol OldAPIEndpointProtocol {
    associatedtype Response: Decodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: [String: String]? { get }
}

struct EmptyResponse: Decodable {}

extension OldAPIEndpointProtocol {
    var headers: [String: String]? { nil }
}
