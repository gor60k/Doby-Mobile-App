import Foundation
import Observation

@Observable
final class PetSettingsViewModel {
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    let petId: Int
    let ownerUUID: String
    
    var age = 0
    
    var height: Int?
    var weight: Int?
    var description: String = "Описание"
    
    var isLoading = false
    var error: String?
    
    init(
        petRepository: PetRepositoryProtocol,
        petStorage: PetStorage,
        petId: Int,
        ownerUUID: String
    ) {
        self.petRepository = petRepository
        self.petStorage = petStorage
        self.petId = petId
        self.ownerUUID = ownerUUID
        
        loadPet()
    }
    
    func fetchPet() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await petRepository.fetchPet(ownerUUID: ownerUUID, petId: petId)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadPet() {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        print(loaded)
        
        age = loaded.age
        height = loaded.height
        weight = loaded.weight
    }
}
