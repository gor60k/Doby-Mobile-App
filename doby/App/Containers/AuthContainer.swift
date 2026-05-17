import Alamofire

final class AuthContainer {
    let authSerive: AuthServiceProtocol
    let tokenManager: TokenManager
    let authInterceptor: AuthInterceptor
    
    init(
        apiClient: APIClientProtocol,
        services: ServiceContainer,
    ) {
        let authService = AuthService(apiClient: apiClient)
        self.authSerive = authService
        
        let tokenManager = TokenManager(
            authService: authService,
            keychainService: services.keychainService,
            sessionService: services.sessionService
        )
        self.tokenManager = tokenManager
        
        self.authInterceptor = AuthInterceptor(tokenManager: tokenManager)
    }
}
