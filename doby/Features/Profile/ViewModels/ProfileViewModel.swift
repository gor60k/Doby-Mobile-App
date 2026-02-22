import Foundation
import Observation

@Observable
class ProfileViewModel {
    private let userService: UserServiceProtocol
    
    var user: UserModel?
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    @MainActor
    func loadUser(id: UUID) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchUser = try await userService.fetchUser(id: id.uuidString)
            self.user = fetchUser
        } catch {
            self.errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
