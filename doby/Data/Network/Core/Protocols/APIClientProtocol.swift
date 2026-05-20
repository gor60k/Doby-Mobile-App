import Foundation

protocol APIClientProtocol {
    func request<E: APIEndpointProtocol>(_ endpoint: E) async throws -> E.Response
}
