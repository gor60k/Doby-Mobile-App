import Foundation
import Observation

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var authService: AuthServiceProtocol
    
    private let refreshToken = "refreshToken"
    private let accessToken = "accessToken"
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var phone: String = ""
    var city: City? = nil

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
                username: name,
                email: email,
                password: password,
                phone: phone,
                city_translit: city?.translit
            )
            
            let response = try await authService.register(user: user)
            
            session.currentUser = response.user
            
            session.isRegistered = true
            session.isAuthenticated = true
            print("USER SAVED: \(response.user)")
            
            keychain.save(token: response.refresh_token, for: refreshToken)
            keychain.save(token: response.access_token, for: accessToken)
            
            print("TOKENS SAVED: | ACCESS:\(response.access_token) | REFRESH:\(response.refresh_token)")
            
            print("REGISTER SUCCESS")
        } catch {
            errorMessage = error.localizedDescription
            print("REGISTER ERR: \(error)")
        }
        
        isLoading = false
    }
    
    func login() async {}
    
    func logout() async {}
    
    func delete() async {}
}
