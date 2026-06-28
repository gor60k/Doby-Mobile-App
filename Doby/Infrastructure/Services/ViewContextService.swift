import Observation

@Observable
final class ViewContextService {
    
    private let currentUserProvider: CurrentUserProviding
    private(set) var viewedUser: User?
    
    init(currentUserProvider: CurrentUserProviding) {
        self.currentUserProvider = currentUserProvider
    }
    
    var isCurrentUser: Bool {
        guard
            let currentUUID = currentUserProvider.currentUserUUID,
            let viewedUUID = viewedUser?.uuid
        else { return false }
        
        return currentUUID == viewedUUID
    }

    func open(user: User) {
        viewedUser = user
    }
    
    func reset() {
        viewedUser = nil
    }
}
