import os

final class AuthRepository: AuthRepositoryProtocol {
    private let service: AuthAPIProtocol
    private var storage: UserStorageProtocol
    private var petStorage: PetStorageProtocol
    private let session: SessionService
    private let keychain: KeychainService
    
    private var logService = LogService.shared
    
    init(
        service: AuthAPIProtocol,
        storage: UserStorageProtocol,
        petStorage: PetStorageProtocol,
        session: SessionService,
        keychain: KeychainService
    ) {
        self.service = service
        self.storage = storage
        self.petStorage = petStorage
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
        
        storage.user = user
        petStorage.pets = user.pets ?? []
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
        
        storage.user = user
        petStorage.pets = user.pets ?? []
    }
    
    func logout() async throws {
        try await service.logout()
        deleteTokens()
        session.setAuthenticated(false)
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
