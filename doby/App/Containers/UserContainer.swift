import Alamofire
import Observation

@Observable
final class UserContainer {
    let repository: UserRepositoryProtocol
    
    init(apiClient: APIClientProtocol) {
        let _service = UserService(apiClient: apiClient)
        let storage = UserStorage()
        
        self.repository = UserRepository(
            storage: storage)
    }
}
