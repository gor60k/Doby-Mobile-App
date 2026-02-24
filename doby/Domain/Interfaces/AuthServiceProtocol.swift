protocol AuthServiceProtocol {
    func register(user: RegisterRequest) async throws -> [User]
    func login(user: LoginRequest) async throws -> [User]
    func logout() async throws
}
