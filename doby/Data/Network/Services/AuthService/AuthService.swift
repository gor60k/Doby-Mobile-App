import Foundation
import Observation

@Observable
final class AuthService: AuthServiceProtocol {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func register(user: RegisterRequest) async throws -> AuthResponse {
        try await apiClient.request(AuthServiceEndpoint.register(user: user))
    }
    
    func login(user: LoginRequest) async throws -> [User] {
        try await apiClient.request(AuthServiceEndpoint.login(user: user))
    }
    
    func logout() async throws {
        try await apiClient.voidRequest(AuthServiceEndpoint.logout)
    }
}
