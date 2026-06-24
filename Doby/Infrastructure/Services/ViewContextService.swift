import Observation

@Observable
final class ViewContextService {
    var currentUserUUID: String?
    var viewedUserUUID: String?
    
    var isCurrentUser: Bool {
        guard let currentUserUUID, let viewedUserUUID else {
            return false
        }
        
        return currentUserUUID == viewedUserUUID
    }

    func configure(currentUserUUID: String?, viewedUserUUID: String?) {
        self.currentUserUUID = currentUserUUID
        self.viewedUserUUID = viewedUserUUID
    }
    
    func reset() {
        currentUserUUID = nil
        viewedUserUUID = nil
    }
}
