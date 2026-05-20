//import Alamofire
//import Observation
//
//@Observable
//final class OldAuthContainer {
//    let repository: AuthRepositoryProtocol
//    
//    init(
//        apiClient: APIClientProtocol,
//        sessionService: SessionService,
//        keychainService: KeychainService
//    ) {
//        let service = AuthService(apiClient: apiClient)
//        let storage = UserStorage()
//        
//        self.repository = AuthRepository(
//            service: service,
//            storage: storage,
//            session: sessionService,
//            keychain: keychainService
//        )
//    }
//    
//    func makeAuthViewModel() -> AuthViewModel {
//        return AuthViewModel(repository: repository)
//    }
//}
