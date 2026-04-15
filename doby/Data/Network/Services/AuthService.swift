import Foundation

final class AuthService: AuthServiceProtocol {
    private let apiClient: APIClientProtocol

    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }

    func register(_ request: RegisterRequest) async throws -> AuthResponse {
        try await apiClient.request(RegisterEndpoint(request: request))
    }

    func login(_ request: LoginRequest) async throws -> LoginResponse {
        try await apiClient.request(LoginEndpoint(request: request))
    }

    func logout() async throws {
        _ = try await apiClient.request(LogoutEndpoint())
    }

    func delete(headers: [String: String]?) async throws {
        _ = try await apiClient.request(DeleteMeEndpoint(headersValue: headers))
    }
}
