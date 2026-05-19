import Alamofire

@MainActor
final class AppContainer<
    UserStorageType: UserStorageProtocol,
    PetStorageType: PetStorageProtocol,
    CityStorageType: CityStorageProtocol
> {
    let storage: StorageContainer<UserStorageType, PetStorageType, CityStorageType>
    let services: ServiceContainer
    
    let auth: AuthContainer
    let network: NetworkContainer
    let repositories: RepositoryContainer
    
    init(
        userStorage: UserStorageType,
        petStorage: PetStorageType,
        cityStorage: CityStorageType
    ) {
        let rawSession = Session.default
        
        let storage = StorageContainer(
            user: userStorage,
            pet: petStorage,
            city: cityStorage
        )
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
                userStorage: storage.user,
                petStorage: storage.pet,
                cityStorage: storage.city
            ),
            petRepository: PetRepository(
                service: PetService(apiClient: network.apiClient),
                storage: storage.pet
            )
        )
    }
}
