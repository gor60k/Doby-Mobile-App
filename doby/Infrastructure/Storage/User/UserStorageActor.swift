import SwiftUI

actor UserStorageActor {
    
    private let storageKey: String
    private let defaults: UserDefaults
    
    init(
        storageKey: String = "user",
        defaults: UserDefaults = .standard
    ) {
        self.storageKey = storageKey
        self.defaults = defaults
    }
    
    func load() -> User? {
        guard
            let data = defaults.data(forKey: storageKey),
            let user = try? JSONDecoder().decode(User.self, from: data)
        else { return nil }
        
        return user
    }
    
    func save(_ user: User?) {
        guard let data = try? JSONEncoder().encode(user) else { return }
        
        defaults.set(data, forKey: storageKey)
    }
    
}
