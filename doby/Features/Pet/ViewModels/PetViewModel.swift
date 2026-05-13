import Foundation
import Observation

@MainActor
@Observable
final class PetViewModel {
    private let repository: PetRepositoryProtocol
    
    var isLoading = false
    var error: String?
    
    init(repository: PetRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchPets(ownerUUID: String) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPets(ownerUUID: ownerUUID)
        } catch {
            print(error.localizedDescription)
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
