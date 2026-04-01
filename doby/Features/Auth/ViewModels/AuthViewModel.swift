import Foundation
import Observation

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var authService: AuthServiceProtocol
    
    private let refreshToken = "refreshToken"
    private let accessToken = "accessToken"
    
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var isPasswordValid: Bool {
        !password.isEmpty &&
        password.count >= 6 &&
        password == confirmPassword
    }
    
    var isEmailValid: Bool {
        email.contains("@") &&
        email.contains(".")
    }
    
    var isFormValid: Bool {
        isEmailValid &&
        isPasswordValid
    }
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    @MainActor
    func register() async {
        session.isRegistered = true
        session.isAuthenticated = true
        
        session.currentUser = AuthUser(
            id: 228,
            username: "",
            email: "test@gmail.com",
            avatar: ["ProfileAvatarPlaceholder"],
            phone: "",
            city: nil,
            bio: "Мне 42 и я люблю маленьких собачек",
            sitter_pofile: nil
        )
        
//        guard isPasswordValid else {
//            errorMessage = "Пароли не совпадают или слишком короткие"
//            return
//        }
//        
//        isLoading = true
//        errorMessage = nil
//        
//        print("REGISTER START")
//        
//        do {
//            let user = RegisterRequest(
//                email: email,
//                password: password,
//            )
//            
//            let response = try await authService.register(user: user)
//            
//            session.currentUser = response.user
//            
//            session.isRegistered = true
//            session.isAuthenticated = true
//            print("USER SAVED: \(response.user)")
//            
//            keychain.save(token: response.refresh_token, for: refreshToken)
//            keychain.save(token: response.access_token, for: accessToken)
//            
//            print("TOKENS SAVED: | ACCESS:\(response.access_token) | REFRESH:\(response.refresh_token)")
//            
//            print("REGISTER SUCCESS")
//        } catch {
//            errorMessage = error.localizedDescription
//            print("REGISTER ERR: \(error)")
//        }
//        
//        isLoading = false
    }
    
    func login() async {}
    
    func logout() async {
        session.isAuthenticated = false

        session.currentUser = nil
    }
    
    func deleteMe() async {
        session.isRegistered = false
        session.isAuthenticated = false

        session.currentUser = nil
    }
}
