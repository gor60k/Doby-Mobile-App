import Alamofire

final class NAppContainer {
    let storage: StorageContainer
    let services: ServiceContainer
    let infrastructure: NInfrastructureContainer
    let network: NNetworkContainer
    let repositories: RepositoryContainer
    
    init() {
        let storage = StorageContainer()
        self.storage = storage
        
        let infrastructure = NInfrastructureContainer(
            session: .default,
            tokenManager: TokenManager()
        )
        self.infrastructure = infrastructure
        
        let network = NNetworkContainer(infrastructure: infrastructure)
        self.network = network
        
        self.services = ServiceContainer(
            authService: AuthService(apiClient: network.apiClient),
            sessionService: SessionService(),
            keychainService: KeychainService(),
            logService: LogService()
        )
        
        self.repositories = RepositoryContainer(
            authRepository: AuthRepository(
                service: AuthService(apiClient: network.apiClient),
                storage: storage.user,
                session: services.sessionService,
                keychain: services.keychainService
            ),
            userRepository: UserRepository(
                service: UserService(apiClient: network.apiClient),
                storage: storage.user
            ),
            petRepository: PetRepository(
                service: PetService(apiClient: network.apiClient),
                storage: storage.pet
            )
        )
    }
}
