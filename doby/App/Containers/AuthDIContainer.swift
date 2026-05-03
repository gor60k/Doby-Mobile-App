import Alamofire

final class AuthDIContainer {
    private let app: AppDIContainer
    
    init(app: AppDIContainer = .shared) {
        self.app = app
    }
    
    lazy var service: AuthServiceProtocol = {
        AuthService(apiClient: app.apiClient)
    }()
    
    lazy var storage: UserStorage = UserStorage()
    
    lazy var repository: AuthRepositoryProtocol = {
        AuthRepository(
            service: service,
            storage: storage,
            session: app.sessionService,
            keychain: app.keychain
        )
    }()
    
    func makeAuthViewModel() -> AuthViewModel {
        AuthViewModel(repository: repository)
    }
}
