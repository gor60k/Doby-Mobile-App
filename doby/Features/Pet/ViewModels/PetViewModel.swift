import Foundation
import os
import Observation

@MainActor
@Observable
final class PetViewModel {
    private let repository: PetRepository
    
    private var petStorage = PetStorage.shared
    
    private(set) var pets: [Pet] = []
    
    init(
        repository: PetRepository = .init(
            service: PetService(),
            storage: PetStorage.shared,
            logService: LogService.shared
        )
    ) {
        self.repository = repository
        loadPets()
    }
    
    func loadPets() {
        pets = petStorage.pets
    }
    
//    func delete()
}
