import Foundation

final class UserRepository: UserRepositoryProtocol {
    
    private let storage: UserStorage
    
    init(storage: UserStorage = .shared) {
        self.storage = storage
    }
    
    func getCurrentUser() -> User? {
        return storage.currentUser
    }
}
