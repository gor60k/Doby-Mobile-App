import Foundation
import Observation

@MainActor
@Observable
class ProfileViewModel {
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    private let storage: UserStorage
    
    var user: User? { storage.user }
    
    private var ownerUUID: String? { user?.uuid }
    
    var isLoading = false
    var error: String?
    
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        storage: UserStorage
    ) {
        self.userRepository = userRepository
        self.petRepository = petRepository
        self.storage = storage
    }
    
    func fetchUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await userRepository.fetchUser()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    //TODO: доделать функцию для получения пользователя по uuid
    func fetchUser(with uuid: String) async {
        isLoading = true
        defer { isLoading = false }
        
        
    }
    
    func fetchPets() async {
        guard let ownerUUID else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await petRepository.fetchPets(from: ownerUUID)
        } catch {
            self.error = error.localizedDescription
        }
    }
}

extension ProfileViewModel {
    static var mock: ProfileViewModel {
        let userRepository = MockUserRepository()
        let petRepository = MockPetRepository()
        let storage = UserStorage()
        
        return ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            storage: storage
        )
    }
}
