import Foundation
import Observation

@Observable
final class UserStorage {
    static let shared = UserStorage()
    
    private let userStorageKey = "user"
    private init() {}
    
    var currentUser: User? {
        get {
            guard let data = UserDefaults.standard.data(forKey: userStorageKey) else { return nil }
            return try? JSONDecoder().decode(User.self, from: data)
        }
        set {
            guard let newValue else {
                UserDefaults.standard.removeObject(forKey: userStorageKey)
                return
            }
            
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: userStorageKey)
            }
        }
    }
    
    func save(_ user: User) {
        currentUser = user
    }
    
    func update(_ updateBlock: (inout User) -> Void) {
        guard var user = currentUser else { return }
        updateBlock(&user)
        currentUser = user
    }
    
    func clear() {
        currentUser = nil
    }
}
