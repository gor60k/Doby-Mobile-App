import Foundation

final class AuthService: AuthServiceProtocol {
    private let apiClient: APIClientProtocol
    private let keychain: KeychainService

    init(
        apiClient: APIClientProtocol = APIClient(),
        keychain: KeychainService = .shared
    ) {
        self.apiClient = apiClient
        self.keychain = keychain
    }

    func register(_ request: RegisterRequest) async throws -> AuthResponse {
        let response: AuthResponse = try await apiClient.request(RegisterEndpoint(request: request))
        saveTokens(accessToken: response.access_token, refreshToken: response.refresh_token)
        return response
    }
    
    func login(_ request: LoginRequest) async throws -> AuthResponse {
        let response: AuthResponse = try await apiClient.request(LoginEndpoint(request: request))
        saveTokens(accessToken: response.access_token, refreshToken: response.refresh_token)
        return response
    }
    
    func token(_ request: TokenRequest) async throws -> TokenResponse {
        let response: TokenResponse = try await apiClient.request(TokenEndpoint(request: request))
        saveTokens(accessToken: response.access, refreshToken: response.refresh)
        return response
    }

    func logout() async throws {
        _ = try await apiClient.request(LogoutEndpoint())
        deleteTokens()
    }

    func delete() async throws {
        _ = try await apiClient.request(DeleteMeEndpoint())
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        keychain.deleteToken(for: KeychainService.TokenKey.accessToken)
        keychain.deleteToken(for: KeychainService.TokenKey.refreshToken)
        keychain.save(token: accessToken, for: KeychainService.TokenKey.accessToken)
        keychain.save(token: refreshToken, for: KeychainService.TokenKey.refreshToken)
    }
    
    private func deleteTokens() {
        keychain.deleteToken(for: KeychainService.TokenKey.accessToken)
        keychain.deleteToken(for: KeychainService.TokenKey.refreshToken)
    }
}
