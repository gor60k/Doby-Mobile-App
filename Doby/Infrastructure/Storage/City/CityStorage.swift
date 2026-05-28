import Foundation
import Observation

@MainActor
@Observable
final class CityStorage {
    private let actor = CityStorageActor()
    
    var cities: [City] = []
    
    init() {
        Task {
            await load()
        }
    }
    
    func load() async {
        let loaded = await actor.load()
        self.cities = loaded
    }
}
