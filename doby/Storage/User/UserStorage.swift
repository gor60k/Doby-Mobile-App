import Foundation
import Observation

@MainActor
@Observable
final class UserStorage {
    private let key = "user"
    
    var currentUser: User? {
        didSet {
            save()
        }
    }
    
    init() {
        self.currentUser = UserDefaults.standard.data(forKey: key)
            .flatMap { try? JSONDecoder().decode(User.self, from: $0) }
    }
    
    func update(_ block: (inout User) -> Void) {
        guard var user = currentUser else { return }
        block(&user)
        currentUser = user
    }
    
    private func save() {
        if let currentUser {
            let data = try? JSONEncoder().encode(currentUser)
            UserDefaults.standard.set(data, forKey: key)
        } else {
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
}
