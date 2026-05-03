import Alamofire

final class AppDIContainer {
    static let shared = AppDIContainer()
    
    private init() {}
    
    lazy var session: Session = {
        Session()
    }()
    
    lazy var authSesstion: AuthSession = {
        AuthSession(session: session)
    }()
    
    lazy var tokenManager: TokenManager = {
        TokenManager()
    }()
    
    lazy var interceptor: AuthInterceptor = {
        AuthInterceptor(
            session: authSesstion,
            tokenManager: tokenManager
        )
    }()
    
    lazy var authorizedSession = Session(interceptor: interceptor)
    
    lazy var apiClient: APIClientProtocol = {
        APIClient(session: session)
    }()
    
    lazy var keychain: KeychainService = {
        KeychainService.shared
    }()
    
    lazy var sessionService: SessionService = {
        SessionService.shared
    }()
}
