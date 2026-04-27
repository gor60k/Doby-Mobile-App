final class AuthRepository: AuthRepositoryProtocol {
    private let service: AuthService
    private let storage: UserStorage
    private let session: SessionService
    private let keychain: KeychainService
    
    init(
        service: AuthService,
        storage: UserStorage,
        session: SessionService,
        keychain: KeychainService = .shared
    ) {
        self.service = service
        self.storage = storage
        self.session = session
        self.keychain = keychain
    }
    
    func register(input: RegisterInput) async throws -> User {
        let request = RegisterRequestMapper.map(input: input)
        let responce = try await service.register(request)
        let user = UserMapper.map(dto: responce.user)
        
        saveTokens(
            accessToken: responce.access_token,
            refreshToken: responce.refresh_token
        )
        
        session.isAuthenticated = true
        session.isRegistered = true
        
        storage.save(user)
        
        return user
    }
    
    func login(input: LoginInput) async throws -> User {
        let request = LoginRequestMapper.map(input: input)
        let response = try await service.login(request)
        let user = UserMapper.map(dto: response.user)
        
        saveTokens(
            accessToken: response.access_token,
            refreshToken: response.refresh_token
        )
        
        session.isAuthenticated = true
        
        storage.save(user)
        
        return user
    }
    
    func logout() async throws {
        try await service.logout()
        deleteTokens()
        session.isAuthenticated = false
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        keychain.deleteToken(for: KeychainService.TokenKey.accessToken)
        keychain.deleteToken(for: KeychainService.TokenKey.refreshToken)
        keychain.save(token: accessToken, for: KeychainService.TokenKey.accessToken)
        keychain.save(token: refreshToken, for: KeychainService.TokenKey.refreshToken)
    }

    private func deleteTokens() {
        keychain.deleteToken(for: KeychainService.TokenKey.accessToken)
        keychain.deleteToken(for: KeychainService.TokenKey.refreshToken)
    }
}
