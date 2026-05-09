import Alamofire

/// Описание работы сетевого слоя: чистаю сессию оборачиваем в авторизированную сессию,
/// интерцептор принимает авторизованную сессию, она обновляет токены без использования интерцептора (чистая сессия Alamofire)
/// создается еще одна сессия, которая принимает в себя интерцептор, она же и используется для всех запросов, чтобы не было циклических ошибок, что клиент api создает сам себя
final class NetworkContainer {
    private let infrastructure: InfrastructureContainer
    
    init(infrastructure: InfrastructureContainer) {
        self.infrastructure = infrastructure
    }
    
    lazy var authSession: AuthSession = AuthSession(session: infrastructure.session)
    
    lazy var authInterceptor: AuthInterceptor = AuthInterceptor(
        session: authSession,
        tokenManager: infrastructure.tokenManager
    )
    
    lazy var mainSession: Session = Session(interceptor: authInterceptor)
    
    lazy var apiClient: APIClientProtocol = APIClient(session: mainSession)
}
