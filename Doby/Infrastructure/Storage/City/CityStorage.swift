import Foundation
import Observation

@MainActor
@Observable
final class CityStorage {
    private let actor = CityStorageActor()
    
    private(set) var cities: [City]?
    
    init() {
        Task {
            await load()
        }
    }
    
    func load() async {
        let loaded = await actor.load()
        self.cities = loaded
    }
    
    func save(_ cities: [City]?) async {
        self.cities = cities
        
    }
    
    private func persist() {
        let snapshot = cities
        
        Task {
            await actor.save(snapshot)
        }
    }
}
