protocol AuthServiceProtocol {
    func register(_ request: RegisterRequest) async throws -> AuthResponse
    func login(_ request: LoginRequest) async throws -> LoginResponse
    func logout() async throws
    func delete(headers: [String: String]?) async throws
}
