import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var service: UserServiceProtocol
    private let storage: UserStorage
    
    var user: User? { storage.currentUser }
    
    init(
        service: UserServiceProtocol,
    ) {
        self.service = service
        self.storage = UserStorage()
    }
    
    //TODO: - убрать эту функцию после замены на фетч
    func getCurrentUser() -> User? {
        return storage.currentUser
    }
    
    func fetchUser() async throws {
        let response = try await service.me()
        let user = UserMapper.map(dto: response)
        
        storage.currentUser = user
    }
    
    func updateUser(input: UpdateUserInput) async throws {
        let request = UpdateUserRequestMapper.map(input: input)
        let response = try await service.update(request)
        let user = UserMapper.map(dto: response)
        
        storage.update { currentUser in
            currentUser.firstName = user.firstName
            currentUser.lastName = user.lastName
            currentUser.patronymic = user.patronymic
            currentUser.phone = user.phone
            currentUser.avatar = user.avatar
            currentUser.city = user.city
            currentUser.bio = user.bio
        }
    }
}
