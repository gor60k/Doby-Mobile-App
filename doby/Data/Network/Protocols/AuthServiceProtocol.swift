protocol AuthServiceProtocol {
    func register(_ request: RegisterRequest) async throws -> AuthResponse
    func login(_ request: LoginRequest) async throws -> AuthResponse
    func token(_ request: TokenRequest) async throws -> TokenResponse
    func logout() async throws
    func delete() async throws
}
