import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var service: UserServiceProtocol
    private let storage: UserStorage
    
    var user: User? { storage.currentUser }
    
    init(
        service: UserServiceProtocol,
        storage: UserStorage = UserStorage()
    ) {
        self.service = service
        self.storage = storage
    }
    
    //TODO: - убрать эту функцию после замены на фетч
    func getCurrentUser() -> User? {
        return storage.currentUser
    }
    
    func fetchUser() async throws {
        let response = try await service.me()
        let user = UserMapper.map(dto: response)
        
        storage.set(user)
    }
}
