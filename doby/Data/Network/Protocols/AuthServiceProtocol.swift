protocol AuthServiceProtocol {
    func register(_ request: RegisterRequest) async throws -> RegisterResponse
    func login(_ request: LoginRequest) async throws -> LoginResponse
    func token(_ request: TokenRequest) async throws -> TokenResponse
    func logout() async throws
    func delete() async throws
}
