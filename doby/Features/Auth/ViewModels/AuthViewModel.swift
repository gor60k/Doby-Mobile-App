import Foundation
import Observation

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
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
        
        print("REGISTER START")
        
        do {
            let user = RegisterRequest(
                name: name,
                email: email,
                password: password,
                role: role ?? .owner
            )
            
            let response = try await authService.register(user: user)
            
            session.currentUser = response.user
            session.isRegistered = true
            print("USER SAVED: \(response.user)")
            
            keychain.save(token: response.token, for: tokenKey)
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
            
            let response = try await authService.login(user: user)
            
            session.currentUser = response.user
            session.isAuthenticated = true
            print("USER SAVED: \(response.user)")
            
            keychain.save(token: response.token, for: tokenKey)
            print("TOKEN SAVED: \(response.token)")
            
            print("USER: \(response)")
        } catch {
            errorMessage = error.localizedDescription
            print("LOGIN ERR: \(error)")
        }
        
        print("LOGIN SUCCESS")
        isLoading = false
    }
    
    func logout() async {
        isLoading = true
        errorMessage = nil
        
        print("LOGOUT START")
        
        do {
            let response: () = try await authService.logout()
            session.isAuthenticated = false
        } catch {
            errorMessage = error.localizedDescription
            print("LOGOUT ERR: \(error)")
        }
        
        print("LOGOUT SUCCESS")
        isLoading = false
    }
    
    func delete() async {
        isLoading = true
        errorMessage = nil
        
        print("DELETE START")
        
        guard let token = keychain.getToken(for: tokenKey) else {
            errorMessage = "No auth token found"
            isLoading = false
            return
        }
        
        do {
            try await authService.delete(headers: [
                "Authorization": "Bearer \(token)"
            ])
            
            session.currentUser = nil
            session.isRegistered = false
            session.isAuthenticated = false
                    
            keychain.deleteToken(for: tokenKey)
                    
            print("DELETE SUCCESS")
        } catch {
            errorMessage = error.localizedDescription
            print("DELETE ERR: \(error)")
        }
        
        isLoading = false
    }
}
