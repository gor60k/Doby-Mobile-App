import Alamofire

@MainActor
final class AppContainer {
    let storage: StorageContainer
    let services: ServiceContainer
    let infrastructure: InfrastructureContainer
    let network: NetworkContainer
    let repositories: RepositoryContainer
    
    init() {
        let storage = StorageContainer()
        self.storage = storage
        
        self.services = ServiceContainer(
            sessionService: SessionService(
                userStorage: storage.user,
                petStorage: storage.pet
            ),
            keychainService: KeychainService(),
            logService: LogService()
        )
        
        let infrastructure = InfrastructureContainer(
            session: .default,
            tokenManager: TokenManager(
                sessionService: services.sessionService
            )
        )
        self.infrastructure = infrastructure
        
        let network = NetworkContainer(infrastructure: infrastructure)
        self.network = network
        
        self.repositories = RepositoryContainer(
            authRepository: AuthRepository(
                service: AuthService(apiClient: network.apiClient),
                storage: storage.user,
                petStorage: storage.pet,
                session: services.sessionService,
                keychain: services.keychainService
            ),
            userRepository: UserRepository(
                service: UserService(apiClient: network.apiClient),
                storage: storage.user,
                petStorage: storage.pet
            ),
            petRepository: PetRepository(
                service: PetService(apiClient: network.apiClient),
                storage: storage.pet
            )
        )
    }
}
