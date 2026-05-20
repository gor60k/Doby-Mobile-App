import Foundation

protocol OldAPIClientProtocol {
    func request<E: OldAPIEndpointProtocol>(_ endpoint: E) async throws -> E.Response
}
