import Foundation
import Observation

@Observable
final class OwnerRegistrationViewModel {
    
    private let userService: UserServiceProtocol
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var role: Role?
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    @MainActor
    func register() async {
        isLoading = true
        errorMessage = nil
        
        print("регистрация началась")
        
        do {
            let request = CreateUserRequest(
                name: name,
                email: email,
                password: password,
                role: role ?? .owner,
            )
            
            let createUser = try await userService.createUser(request)
            
            print("User: \(createUser)")
        } catch {
            errorMessage = error.localizedDescription
            print("ошибка регистрации:", error)
        }
        
        print("регистрация успешна")
        isLoading = false
    }
}
