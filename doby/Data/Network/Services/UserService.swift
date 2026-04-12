import Foundation
import Observation

@Observable
final class UserService: UserServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func me(requestHeaders: [String: String]) async throws -> MeResponse {
        try await apiClient.request(MeEndpoint(headersValue: requestHeaders))
    }
}
