import Foundation
import Observation

@Observable
final class AuthViewModel {
    private var authService: AuthServiceProtocol
    private let tokenKey = "authToken"
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var role: Role?
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    @MainActor
    func register() async {
        isLoading = true
        errorMessage = nil
        
        print("REGISTER START ")
        
        do {
            let user = RegisterRequest(
                name: name,
                email: email,
                password: password,
                role: role ?? .owner
            )
            
            let response = try await authService.register(user: user)
            
            SessionService.shared.currentUser = response.user
            SessionService.shared.isRegistered = true
            print("USER SAVED: \(response.user)")
            
            KeychainService.shared.save(token: response.token, for: tokenKey)
            print("TOKEN SAVED: \(response.token)")
            
        } catch {
            errorMessage = error.localizedDescription
            print("REGISTER ERR: \(error)")
        }
        
        print("REGISTER SUCCESS")
        isLoading = false
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        print("LOGIN START")
        
        do {
            let user = LoginRequest(
                email: email,
                password: password
            )
            
            let request = try await authService.login(user: user)
            
            print("USER: \(request)")
        } catch {
            errorMessage = error.localizedDescription
            print("LOGIN ERR: \(error)")
        }
        
        print("LOGIN SUCCESS")
        isLoading = false
    }
    
    func logout() async {
        
    }
}
