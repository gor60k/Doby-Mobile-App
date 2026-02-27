import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpointProtocol) async throws -> T
    func voidRequest(_ endpoint: APIEndpointProtocol) async throws
}

extension APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpointProtocol) async throws -> T {
        try await request(endpoint)
    }
    
    func voidRequest(_ endpoint: APIEndpointProtocol) async throws {
        try await voidRequest(endpoint)
    }
}
