import Foundation
import Observation

@MainActor
@Observable
final class PetViewModel {
    private let repository: PetRepositoryProtocol
    private let storage: PetStorage
    
    var pets: [Pet] { storage.pets }
    
    var isLoading = false
    var error: String?
    
    init(
        repository: PetRepositoryProtocol,
        storage: PetStorage
    ) {
        self.repository = repository
        self.storage = storage
    }
    
    func fetchPets(ownerUUID: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPets(ownerUUID: ownerUUID)
        } catch {
            self.error = error.localizedDescription
        }
    }

    func fetchPet(ownerUUID: String, petId: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPet(ownerUUID: ownerUUID, petId: petId)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func deletePet(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.deletePet(id: id)
        } catch {
            self.error = error.localizedDescription
        }
    }
}

extension PetViewModel {
    static var mock: PetViewModel {
        let storage = PetStorage()
        
        return PetViewModel(
            repository: MockPetRepository(),
            storage: storage
        )
    }
}
