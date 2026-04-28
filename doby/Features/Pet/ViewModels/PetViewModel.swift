import Foundation
import os
import Observation

@MainActor
@Observable
final class PetViewModel {
    private let repository: PetRepositoryProtocol
    
    private(set) var pets: [Pet] = []
    
    init(repository: PetRepositoryProtocol = PetRepository()) {
        self.repository = repository
        loadPets()
    }
    
//    var pets: [Pet] {
//        
//    }
    
    func loadPets() {
        pets = repository.getPets()
    }

    func pet(by id: Int) -> Pet? {
        repository.getPets().first { $0.id == id }
    }
    
    func delete(petId: Int) async throws {
        _ = try await repository.deletePet(petId: petId)
        pets.removeAll { $0.id == petId }
    }
}
