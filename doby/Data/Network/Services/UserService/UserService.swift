import Foundation
import Observation

@Observable
final class UserService: UserServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchAllUsers() async throws -> [User] {
        try await apiClient.request(UserServiceEndpoint.getAllUsers)
    }
    
    func fetchUser(id: String) async throws -> User {
        try await apiClient.request(UserServiceEndpoint.getUser(id: id))
    }
}

