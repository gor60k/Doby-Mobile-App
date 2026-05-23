import Foundation
import Observation

@MainActor
@Observable
final class PetViewModel {
    private let repository: PetRepositoryProtocol
    private let storage: PetStorage
    private let ownerUUID: String
    
    var pets: [Pet] { storage.pets }
    
    var isLoading = false
    var error: String?
    
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
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPets(from: ownerUUID)
        } catch {
            self.error = error.localizedDescription
        }
    }

    func fetchPet(petId: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPet(with: petId, from: ownerUUID)
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
            storage: storage,
            ownerUUID: ""
        )
    }
}
