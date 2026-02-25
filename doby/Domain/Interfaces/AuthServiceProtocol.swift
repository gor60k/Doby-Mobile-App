protocol AuthServiceProtocol {
    func register(user: RegisterRequest) async throws -> AuthResponse
    func login(user: LoginRequest) async throws -> [User]
    func logout() async throws
}
