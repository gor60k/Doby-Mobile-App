import os

final class AuthRepository: AuthRepositoryProtocol {
    private let service: AuthServiceProtocol
    private let storage: UserStorage
    private let session: SessionService
    private let keychain: KeychainService
    
    private var logService = LogService.shared
    
    init(
        service: AuthServiceProtocol,
        storage: UserStorage = .shared,
        session: SessionService = .shared,
        keychain: KeychainService = .shared
    ) {
        self.service = service
        self.storage = storage
        self.session = session
        self.keychain = keychain
    }
    
    func register(input: RegisterInput) async throws {
        let request = RegisterRequestMapper.map(input: input)
        let response = try await service.register(request)
        let user = UserMapper.map(dto: response.user)
        
        saveTokens(
            accessToken: response.access_token,
            refreshToken: response.refresh_token
        )
        
        logService.network.info("ACCESS: \(response.access_token) | REFRESH: \(response.refresh_token)")
        
        session.setAuthenticated(true)
        session.setRegistered(true)
        
        storage.save(user)
    }
    
    func login(input: LoginInput) async throws {
        let request = LoginRequestMapper.map(input: input)
        let response = try await service.login(request)
        let user = UserMapper.map(dto: response.user)
        
        saveTokens(
            accessToken: response.access_token,
            refreshToken: response.refresh_token
        )
        
        logService.network.info("ACCESS: \(response.access_token) | REFRESH: \(response.refresh_token)")
        
        print(user)
        
        session.setAuthenticated(true)
        session.setRegistered(true)
        
        storage.save(user)
    }
    
    func logout() async throws {
        try await service.logout()
        deleteTokens()
        session.logout()
    }
    
    func refresh(input: RefreshInput) async throws {
        let request = RefreshRequestMapper.map(input: input)
        let response = try await service.refresh(request)
        
        saveTokens(accessToken: response.access, refreshToken: response.refresh)
    }
    
    private func saveTokens(accessToken: String, refreshToken: String) {
        keychain.deleteToken(for: .accessToken)
        keychain.deleteToken(for: .refreshToken)
        keychain.save(token: accessToken, for: .accessToken)
        keychain.save(token: refreshToken, for: .refreshToken)
        
        logService.network.info("ACCESS: \(accessToken) | REFRESH: \(refreshToken)")
    }

    private func deleteTokens() {
        keychain.deleteToken(for: .accessToken)
        keychain.deleteToken(for: .refreshToken)
    }
}
