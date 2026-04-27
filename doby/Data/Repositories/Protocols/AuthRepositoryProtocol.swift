protocol AuthRepositoryProtocol {
    func register(input: RegisterInput) async throws -> User
    func login(input: LoginInput) async throws -> User
    func logout() async throws
}
