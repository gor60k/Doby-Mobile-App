import SwiftUI

actor UserStorageActor {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
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
        guard let data = defaults.data(forKey: storageKey) else {
            return nil
        }

        return try? decoder.decode(User.self, from: data)
    }
    
    func save(_ user: User?) {
        guard let user else {
            defaults.removeObject(forKey: storageKey)
            return
        }

        guard let data = try? encoder.encode(user) else {
            return
        }

        defaults.set(data, forKey: storageKey)
    }
}
