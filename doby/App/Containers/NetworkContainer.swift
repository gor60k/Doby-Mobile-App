import Alamofire

final class NetworkContainer {
    let apiClient: APIClientProtocol
    
    init(interceptor: AuthInterceptor) {
        let alamofire = Session(
            interceptor: interceptor,
            eventMonitors: [NetworkLogService()]
        )
        self.apiClient = APIClient(session: alamofire)
    }
}
