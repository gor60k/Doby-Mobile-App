import Foundation
import Observation

@Observable
final class OwnerRegistrationViewModel {
    
    private let userService: UserServiceProtocol
    
    var name: String = ""
    var role: Role?
    var phone: String = ""
    
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
                role: role ?? .owner,
                phone: phone
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
