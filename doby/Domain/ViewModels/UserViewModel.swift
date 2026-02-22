import Observation

@Observable
class UserViewModel {
    var currentUser: UserModel? = UserMock.owner
    var isAuthenticated: Bool = false
    
    func updateUserName(to newName: String) {
        currentUser?.name = newName
    }
}

