import SwiftUI
import Observation

@Observable
final class PetProfileViewModel: ViewModel {
    private let repository: PetRepositoryProtocol
    private let petStorage: PetStorage
    private let userStorage: UserStorage
    
    var currentPage = 0
    
    var pet: Pet {
        guard let pet = petStorage.pets.first(where: { $0.id == petId })
        else {
            preconditionFailure("Питомец не найден")
        }
        return pet
    }
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
//        guard let petId = pet.id else { return }
        guard let ownerUUID = user?.uuid else {
            error = "User not found"
            return
        }
        
        await perform {
            try await repository.fetchPet(with: petId, from: ownerUUID)
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
