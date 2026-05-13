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

//final class UserStorage {
//    private let key = "user"
//    
//    private(set) var currentUser: User?
//    
//    init() {
//        load()
//    }
//    
//    func set(_ user: User?) {
//        currentUser = user
//        save()
//    }
//    
//    func update(_ block: (inout User) -> Void) {
//        guard var user = currentUser else { return }
//        block(&user)
//        currentUser = user
//        save()
//    }
//    
//    func clear() {
//        currentUser = nil
//        save()
//    }
//    
//    private func load() {
//        guard let data = UserDefaults.standard.data(forKey: key),
//              let user = try? JSONDecoder().decode(User.self, from: data)
//        else {
//            currentUser = nil
//            return
//        }
//        
//        currentUser = user
//    }
//    
//    private func save() {
//        guard let currentUser else {
//            UserDefaults.standard.removeObject(forKey: key)
//            return
//        }
//        
//        guard let data = try? JSONEncoder().encode(currentUser) else { return }
//        
//        UserDefaults.standard.set(data, forKey: key)
//    }
//}
