import Foundation
import Observation

@Observable
final class UserRepository: UserRepositoryProtocol {
    private var service: UserServiceProtocol
    private let storage: UserStorage
    private let petStorage: PetStorage
    
    var user: User? { storage.currentUser }
    
    init(
        service: UserServiceProtocol,
        storage: UserStorage,
        petStorage: PetStorage
    ) {
        self.service = service
        self.storage = storage
        self.petStorage = petStorage
    }
    
    func fetchUser() async throws {
        let response = try await service.me()
        let user = UserMapper.map(dto: response)
        
        storage.currentUser = user
        petStorage.pets = user.pets ?? []
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
