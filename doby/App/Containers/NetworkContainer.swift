import Alamofire

final class NetworkContainer {
    
    let apiClient: APIClientProtocol
    
    private let authSession: AuthSession
    private let authInterceptor: AuthInterceptor
    private let authService: AuthServiceProtocol
    private let mainSession: Session
    private let infrastructure: InfrastructureContainer
    
    init(infrastructure: InfrastructureContainer) {
        self.infrastructure = infrastructure
        
        let baseAuthSession = AuthSession(session: infrastructure.session)
        self.authSession = baseAuthSession
        
        let interceptor = AuthInterceptor(
            session: baseAuthSession,
            tokenManager: infrastructure.tokenManager
        )
        self.authInterceptor = interceptor
        
        let session = Session(interceptor: interceptor)
        self.mainSession = session
        
        self.apiClient = APIClient(session: session)
        
        let authService = AuthService(apiClient: apiClient)
        self.authService = authService
    }
}
