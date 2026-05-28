import Foundation

actor PetStorageActor {
    
    private let storageKey: String
    private let defaults: UserDefaults
    
    init(
        storageKey: String = "pets",
        defaults: UserDefaults = .standard
    ) {
        self.storageKey = storageKey
        self.defaults = defaults
    }
    
    func load() -> [Pet] {
        guard
            let data = defaults.data(forKey: storageKey),
            let pets = try? JSONDecoder().decode([Pet].self, from: data)
        else { return [] }
        
        return pets
    }
    
    func save(_ pets: [Pet]) {
        guard let data = try? JSONEncoder().encode(pets) else { return }
        
        defaults.set(data, forKey: storageKey)
    }
}
