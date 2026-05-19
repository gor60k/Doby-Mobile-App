import Foundation
import Observation

@MainActor
@Observable
final class PetStorage: PetStorageProtocol {
    private let actor = PetStorageActor()
    
    var pets: [Pet] = []
    
    init() {
        Task {
            await load()
        }
    }
    
    func load() async {
        let loaded = await actor.load()
        self.pets = loaded
    }
    
    func set(_ pets: [Pet]) {
        self.pets = pets
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
        pets = pets.filter { $0.id != id }
        persist()
    }
    
    func clear() {
        pets.removeAll()
        persist()
    }
    
    private func persist() {
        let snapshot = pets
        Task {
            await actor.save(snapshot)
        }
    }
}
