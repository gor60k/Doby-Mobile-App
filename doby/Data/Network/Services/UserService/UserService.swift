import Foundation
import Observation

@Observable
final class UserService: UserServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchMe(headers: [String : String]?) async throws -> MeResponse {
        try await apiClient.request(UserServiceEndpoint.fetchMe(headers: headers))
    }
}

