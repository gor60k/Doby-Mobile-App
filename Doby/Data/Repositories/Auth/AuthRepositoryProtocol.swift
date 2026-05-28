protocol AuthRepositoryProtocol {
    func register(input: RegisterInput) async throws
    func login(input: LoginInput) async throws
    func logout() async throws
    func refresh(input: RefreshInput) async throws
}
