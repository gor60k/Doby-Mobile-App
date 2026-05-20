import Foundation
import Observation

@MainActor
@Observable
final class UserStorage {
    private let actor = UserStorageActor()
    
    var user: User?
    
    init() {
        Task {
            await load()
        }
    }
    
    func load() async {
        let loaded = await actor.load()
        self.user = loaded
    }
    
    func set(_ user: User?) {
        self.user = user
        persist()
    }
    
    func update(_ block: (inout User) -> Void) {
        guard var user else { return }
        block(&user)
        self.user = user
        persist()
    }
    
    private func persist() {
        let snapshot = user
        Task {
            await actor.save(snapshot)
        }
    }
}
