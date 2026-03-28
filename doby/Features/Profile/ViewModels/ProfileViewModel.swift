import Foundation
import Observation

@Observable
class ProfileViewModel {
    
    private var session = SessionService.shared
    private var accessToken = KeychainService.shared.getToken(for: "accessToken")
    private let userService: UserServiceProtocol
    
    var isLoading: Bool = false
    var errorMessage: String?
    var user: User?
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
        
        Task {
            await fetchMe()
        }
    }
    
    @MainActor
    func fetchMe() async {
        isLoading = true
        errorMessage = nil
        
        print("FETCHING START")
        
        do {
            let response = try await userService.fetchMe(
                headers: ["Authorization": "Bearer \(accessToken ?? "")"]
            )
            
            let mappedUser = response.toUser()
            self.user = mappedUser
            
            print("USER FETCHED: \(mappedUser.username)")
            
        } catch {
            errorMessage = error.localizedDescription
            print("FETCH ERROR: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
}
