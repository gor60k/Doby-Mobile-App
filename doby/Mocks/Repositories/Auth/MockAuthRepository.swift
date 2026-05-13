import os

final class MockAuthRepository: AuthRepositoryProtocol {
//    private let service: AuthServiceProtocol
//    private let storage: UserStorage
//    private let session: SessionService
//    private let keychain: KeychainService
//    
//    private var logService = LogService.shared
    
    init(
//        service: AuthServiceProtocol,
//        storage: UserStorage = .shared,
//        session: SessionService = .shared,
//        keychain: KeychainService = .shared
    ) {
//        self.service = service
//        self.storage = storage
//        self.session = session
//        self.keychain = keychain
    }
    
    func register(input: RegisterInput) async throws {}
    
    func login(input: LoginInput) async throws {}
    
    func logout() async throws {}
    
    func refresh(input: RefreshInput) async throws {}
    
    private func saveTokens(accessToken: String, refreshToken: String) {}

    private func deleteTokens() {}
}

