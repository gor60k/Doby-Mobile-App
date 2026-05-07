import Foundation
import Observation

@Observable
final class PetStorage {
    static let shared = PetStorage()
    
    private let key = "pets"
    
    var pets: [Pet] = []
    
    init() {
        load()
    }
    
    func set(_ pets: [Pet]) {
        save(pets)
    }
    
    func add(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
        } else {
            pets.append(pet)
        }
        save(pets)
    }
    
    func update(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
        } else {
            pets.append(pet)
        }
        save(pets)
    }
    
    func remove(id: Int) {
        pets.removeAll { $0.id == id }
        save(pets)
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([Pet].self, from: data) else {
            self.pets = []
            return
        }
        pets = decoded
    }
    
    private func save(_ pets: [Pet]) {
        self.pets = pets
        
        guard let data = try? JSONEncoder().encode(pets) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
