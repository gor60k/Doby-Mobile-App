protocol AuthServiceProtocol {
    func register(user: RegisterRequest) async throws -> AuthResponse
    func login(user: LoginRequest) async throws -> AuthResponse
    func logout() async throws
    func delete(headers: [String: String]?) async throws
}
