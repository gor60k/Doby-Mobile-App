import Foundation
import os
import Observation

@MainActor
@Observable
final class PetViewModel {
    private var petStorage = PetStorage.shared
    
    private(set) var pets: [Pet] = []
    
    init() {
        loadPets()
    }
    
    func loadPets() {
        pets = petStorage.pets
    }
}
