import SwiftUI
import Observation

@Observable
final class PetProfileViewModel: ViewModel {
    private let repository: PetRepositoryProtocol
    private let petStorage: PetStorage
    private let userStorage: UserStorage
    
    var currentPage = 0
    
    var pet: Pet = .placeholder
    
    var user: User? { userStorage.user }
    
    private let petId: Int
    
    private(set) var infoItems: [PetProfileInfoItem] = []
    
    init(
        repository: PetRepositoryProtocol,
        userStorage: UserStorage,
        petStorage: PetStorage,
        petId: Int
    ) {
        self.repository = repository
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.petId = petId
    }
    
    func fetchPet() async {
        guard let ownerUUID = user?.uuid else {
            error = "User not found"
            return
        }
        
        await perform {
            self.pet = try await repository.fetchPet(with: petId, from: ownerUUID)
        }
    }
}

extension PetProfileViewModel {
    static var mock: PetProfileViewModel {
        let repository = MockPetRepository()
        let userStorage = UserStorage()
        let petStorage = PetStorage.mock
        
        return PetProfileViewModel(
            repository: repository,
            userStorage: userStorage,
            petStorage: petStorage,
            petId: 1
        )
    }
}
