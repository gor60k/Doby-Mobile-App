import Foundation
import Observation

@Observable
final class PetStorage {
    static let shared = PetStorage()
    
    private let petStorageKey = "pets"
    private init() {}
    
    var pets: [Pet] {
        get {
            guard let data = UserDefaults.standard.data(forKey: petStorageKey),
                  let decoded = try? JSONDecoder().decode([Pet].self, from: data) else {
                return []
            }
            return decoded
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: petStorageKey)
            }
        }
    }
    
    func setPets(_ pets: [Pet]) {
        self.pets = pets
    }
    
    func pet(by id: Int) -> Pet? {
        pets.first { $0.id == id }
    }
    
    func appendPet(_ pet: Pet) {
        var currentPets = pets
        currentPets.append(pet)
        self.pets = currentPets
    }
    
    func upsert(_ pet: Pet) {
        var currentPets = pets
        
        if let index = currentPets.firstIndex(where: { $0.id == pet.id }) {
            currentPets[index] = pet
        } else {
            currentPets.append(pet)
        }
        
        self.pets = currentPets
    }
    
    func removePet(by id: Int) {
        pets.removeAll { $0.id == id }
    }
    
    func clear() {
        pets = []
    }
}
