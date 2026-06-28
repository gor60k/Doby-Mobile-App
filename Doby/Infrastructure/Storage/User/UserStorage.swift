import Foundation
import Observation

@MainActor
@Observable
final class UserStorage {
    private let actor = UserStorageActor()
    
    private(set) var user: User?
    
    init() {
        Task { [weak self] in
            await self?.load()
        }
    }
    
    func load() async {
        user = await actor.load()
    }
    
    func save(_ user: User?) {
        self.user = user
        persist()
    }
    
    func delete() {
        user = nil
        persist()
    }
    
    func update(_ mutate: (inout User) -> Void) {
        guard var user else { return }
        
        mutate(&user)
        
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

extension UserStorage: CurrentUserProviding {
    var currentUserUUID: String? {
        user?.uuid
    }
}
