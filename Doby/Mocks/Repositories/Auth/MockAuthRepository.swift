import os

final class MockAuthRepository: AuthRepositoryProtocol {
    
    init() {}
    
    func register(input: RegisterInput) async throws {}
    
    func login(input: LoginInput) async throws {}
    
    func logout() async throws {}
    
    func refresh(input: RefreshInput) async throws {}
    
    private func saveTokens(accessToken: String, refreshToken: String) {}

    private func deleteTokens() {}
}

