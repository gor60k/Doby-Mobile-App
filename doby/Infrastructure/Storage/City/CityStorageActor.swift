import Foundation

actor CityStorageActor {
    
    private let storageKey: String
    private let defaults: UserDefaults
    
    init(
        storageKey: String = "cities",
        defaults: UserDefaults = .standard
    ) {
        self.storageKey = storageKey
        self.defaults = defaults
    }
    
    func load() -> [City] {
        guard
            let data = defaults.data(forKey: storageKey),
            let cities = try? JSONDecoder().decode([City].self, from: data)
        else { return [] }
        
        return cities
    }
    
    func save(_ cities: [City]) {
        guard let data = try? JSONEncoder().encode(cities) else { return }
        
        defaults.set(data, forKey: storageKey)
    }
}
