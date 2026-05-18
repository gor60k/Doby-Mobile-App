import Foundation
import Observation

@MainActor
@Observable
final class PetStorage {
    private let actor = PetStorageActor()
    
//    private let key = "pets"
    
    var pets: [Pet] = []
    
    init() {
        Task {
            await load()
        }
//        load()
    }
    
    func load() async {
        let loaded = await actor.load()
        self.pets = loaded
    }
    
    func set(_ pets: [Pet]) {
        self.pets = pets
        persist()
    }
    
    func add(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
        } else {
            pets.append(pet)
        }
        persist()
    }
    
    func update(_ pet: Pet) {
        if let index = pets.firstIndex(where: { $0.id == pet.id }) {
            pets[index] = pet
        } else {
            pets.append(pet)
        }
        persist()
    }
    
    func remove(id: Int) {
//        pets.removeAll { $0.id == id }
        pets = pets.filter { $0.id != id }
        persist()
    }
    
    func clear() {
        pets.removeAll()
        persist()
    }
    
//    private func load() {
//        guard let data = UserDefaults.standard.data(forKey: key),
//              let decoded = try? JSONDecoder().decode([Pet].self, from: data) else {
//            self.pets = []
//            return
//        }
//        pets = decoded
//    }
    
//    private func save() {
//        guard let data = try? JSONEncoder().encode(pets) else { return }
//        UserDefaults.standard.set(data, forKey: key)
//    }
    
    private func persist() {
        let snapshot = pets
        Task {
            await actor.save(snapshot)
        }
    }
}
