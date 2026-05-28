final class SettingsRepository: SettingsRepositoryProtocol {
    private let sessionService: SessionService
    private let keychainService: KeychainService
    
    init(
        sessionService: SessionService,
        keychainService: KeychainService
    ) {
        self.sessionService = sessionService
        self.keychainService = keychainService
    }
}
