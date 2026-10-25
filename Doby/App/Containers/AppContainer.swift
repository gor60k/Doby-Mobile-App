import Alamofire
import GRDB
import Foundation

@MainActor
final class AppContainer {
    let dbPool: DatabasePool
    let userStorageActor: UserStorageActor
    let petStorageActor: PetStorageActor
//    let chatStorageActor: ChatStorageActor
    
    // MARK: - Хранилища
    let userStorage: UserStorage
    let petStorage: PetStorage
    let cityStorage = CityStorage()
//    let chatStorage: ChatStorage
    
    // MARK: - Сервисы инфраструктуры
    let keychainService = KeychainService()
    let sessionService = SessionService()
    let viewContextService: ViewContextService
    let tokenManager: TokenManager
    
    // MARK: - API
    let apiClient: APIClient
    let authApiClient: APIClient
    
    // MARK: - Репозитории
    let authRepository: AuthRepositoryProtocol
    let userRepository: UserRepositoryProtocol
    let petRepository: PetRepositoryProtocol
//    let chatRepository: ChatRepositoryProtocol
    
    init() throws {
        authApiClient = AppContainer.makePlainClient()
        
        let dbURL = try Self.makeDatabaseURL()
        
//        file:///Users/aleksandrsabelnikov/Library/Developer/CoreSimulator/Devices/60857DA3-E675-43DE-BD98-3813C289B97D/data/Containers/Data/Application/B97A6679-04C1-4797-9F94-072CF1B69836/Library/Application%20Support/Database/app.sqlite
        
        dbPool = try DatabasePool(path: dbURL.path)
        
        let migrator = MigrationsManager.makeMigrator()
        try migrator.migrate(dbPool)
        
        userStorageActor = UserStorageActor(dbPool: dbPool)
        userStorage = UserStorage(actor: userStorageActor)
        
        petStorageActor = PetStorageActor(dbPool: dbPool)
        petStorage = PetStorage(actor: petStorageActor)
        
//        chatStorageActor = ChatStorageActor(dbPool: dbPool)
//        chatStorage = ChatStorage(actor: chatStorageActor)
        
        viewContextService = ViewContextService(
            currentUserProvider: userStorage
        )
        
        tokenManager = TokenManager(
            authAPI: AuthAPI(apiClient: authApiClient),
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
        
//        chatRepository = ChatRepository(
//            api: ChatAPI(apiClient: apiClient),
//            storage: chatStorage
//        )
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
    
    static func makeDatabaseURL() throws -> URL {
        let appSupport = try FileManager.default
            .url(
                for: .applicationSupportDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
        
        let directory = appSupport
            .appendingPathComponent("Database", isDirectory: true)
        
        try FileManager.default
            .createDirectory(
                at: directory,
                withIntermediateDirectories: true
        )
        
        return directory.appendingPathComponent("app.sqlite")
    }
}


