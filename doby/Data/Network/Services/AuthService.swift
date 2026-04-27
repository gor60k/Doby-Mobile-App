import Foundation

final class AuthService: AuthServiceProtocol {
    private let apiClient: APIClientProtocol

    init(
        apiClient: APIClientProtocol = APIClient(),
    ) {
        self.apiClient = apiClient
    }

    func register(_ request: RegisterRequest) async throws -> RegisterResponse {
        let response: RegisterResponse = try await apiClient.request(RegisterEndpoint(request: request))
        return response
    }
    
    func login(_ request: LoginRequest) async throws -> LoginResponse {
        let response: LoginResponse = try await apiClient.request(LoginEndpoint(request: request))
        return response
    }
    
    func token(_ request: TokenRequest) async throws -> TokenResponse {
        let response: TokenResponse = try await apiClient.request(TokenEndpoint(request: request))
        return response
    }

    func logout() async throws {
        _ = try await apiClient.request(LogoutEndpoint())
    }

    func delete() async throws {
        _ = try await apiClient.request(DeleteMeEndpoint())
    }
}
