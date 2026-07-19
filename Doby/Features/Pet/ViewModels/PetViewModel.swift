import Foundation
import Observation

@MainActor
@Observable
final class PetViewModel: ViewModel {
    private let repository: PetRepositoryProtocol
    private let storage: PetStorage
    private let ownerUUID: String
    
//    var pets: [Pet] { storage.pets }
    
    var pets: [Pet] = []
    
    init(
        repository: PetRepositoryProtocol,
        storage: PetStorage,
        ownerUUID: String
    ) {
        self.repository = repository
        self.storage = storage
        self.ownerUUID = ownerUUID
    }
    
    func fetchPets() async {
        await perform {
            self.pets = try await repository.fetchPets(from: ownerUUID)
            
        }
    }

    func fetchPet(petId: Int) async {
        await perform {
            try await repository.fetchPet(with: petId, from: ownerUUID)
        }
    }
    
    func deletePet(id: Int) async {
        await perform {
            try await repository.deletePet(id: id)
        }
    }
}

extension PetViewModel {
    static var mock: PetViewModel {
        let storage = PetStorage()
        
        return PetViewModel(
            repository: MockPetRepository(),
            storage: storage,
            ownerUUID: ""
        )
    }
}
