import Alamofire

@MainActor
final class AppContainer {
    let userStorage = UserStorage()
    let petStorage = PetStorage()
    let cityStorage = CityStorage()
    
    let keychainService = KeychainService()
    let sessionService = SessionService()
    let tokenManager: TokenManager
    
    let apiClient: APIClient
    let authApiClient: APIClient
    
    let authRepository: AuthRepositoryProtocol
    let userRepository: UserRepositoryProtocol
    let petRepository: PetRepositoryProtocol
    
    init() {
        authApiClient = AppContainer.makePlainClient()
        
        tokenManager = TokenManager(
            authService: AuthAPI(apiClient: authApiClient),
            keychainService: keychainService,
            sessionService: sessionService
        )
        
        apiClient = AppContainer.makeAuthorizedClient(tokenManager: tokenManager)
        
        authRepository = AuthRepository(
            api: AuthAPI(apiClient: authApiClient),
            storage: userStorage,
            petStorage: petStorage,
            session: sessionService,
            keychain: keychainService
        )
        
        userRepository = UserRepository(
            api: UserAPI(apiClient: apiClient),
            userStorage: userStorage,
            petStorage: petStorage,
            cityStorage: cityStorage
        )
        
        petRepository = PetRepository(
            api: PetAPI(apiClient: apiClient),
            storage: petStorage
        )
    }
}

private extension AppContainer {
    static func makePlainClient() -> APIClient {
        let session = Session(eventMonitors: [NetworkLogService()])
        
        return APIClient(session: session)
    }
    
    static func makeAuthorizedClient(tokenManager: TokenManager) -> APIClient {
        let interceptor = AuthInterceptor(tokenManager: tokenManager)
        
        let session = Session(
            interceptor: interceptor,
            eventMonitors: [NetworkLogService()]
        )
        
        return APIClient(session: session)
    }
}


