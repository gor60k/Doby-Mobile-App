import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpointProtocol) async throws -> T
    func voidRequest(_ endpoint: APIEndpointProtocol) async throws
}
