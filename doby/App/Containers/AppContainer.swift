import Alamofire

@MainActor
final class AppContainer {
    let storage: StorageContainer
    let services: ServiceContainer
    
    let auth: AuthContainer
    let network: NetworkContainer
    let repositories: RepositoryContainer
    
    init() {
        let rawSession = Session.default
        
        let storage = StorageContainer()
        self.storage = storage
        
        self.services = ServiceContainer(
            sessionService: SessionService(),
            keychainService: KeychainService(),
            logService: LogService()
        )
        
        let baseAPIClient = APIClient(session: rawSession)
        
        let auth = AuthContainer(
            apiClient: baseAPIClient,
            services: services
        )
        self.auth = auth
        
        let network = NetworkContainer(interceptor: auth.authInterceptor)
        self.network = network
        
        self.repositories = RepositoryContainer(
            authRepository: AuthRepository(
                service: auth.authSerive,
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
