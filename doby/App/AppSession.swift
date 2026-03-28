import Foundation
import Observation

@Observable
final class AppSession {
    var currentUser: User?
    var isAuthenticated: Bool = false
    
//    static let preview = AppSession(user: UserMock.owner, auth: true)
    static let guest = AppSession(user: nil, auth: false)
    
    init(user: User? = nil, auth: Bool = false) {
        self.currentUser = user
        self.isAuthenticated = auth
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
    }
}
