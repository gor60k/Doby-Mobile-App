import Foundation
import Observation

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var authService: AuthServiceProtocol
    private var userService: UserServiceProtocol
    
    private let refreshToken = "refreshToken"
    private let accessToken = "accessToken"
    
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var isPasswordValid: Bool {
        !password.isEmpty &&
        password.count >= 8 &&
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
    
    init(
        authService: AuthServiceProtocol = AuthService(),
        userService: UserServiceProtocol = UserService()
    ) {
        self.authService = authService
        self.userService = userService
    }
    
    @MainActor
    func register() async {
        print("REGISTER CALLED | email=\(email) | isEmailValid=\(isEmailValid) | passwordCount=\(password.count) | confirmMatches=\(password == confirmPassword)")
        
        guard isEmailValid else {
            errorMessage = "Некорректный email"
            print("REGISTER STOP: invalid email")
            return
        }
        
        guard isPasswordValid else {
            errorMessage = "Пароли не совпадают или слишком короткие"
            print("REGISTER STOP: invalid password")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        print("REGISTER START")
        
        do {
            let user = RegisterRequest(
                username: email,
                password: password,
            )
            
            print("REGISTER REQUEST SEND")
            let response = try await authService.register(user: user)
            print("REGISTER RESPONSE RECEIVED")
            
            session.currentUser = User(dto: response.user)
            
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
            print("REGISTER ERR DESCRIPTION: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    @MainActor
    func login() async {
        guard isEmailValid else {
            errorMessage = "Некорректный email"
            print("LOGIN STOP: invalid email")
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Введите пароль"
            print("LOGIN STOP: empty password")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        print("LOGIN START")
        
        do {
            let request = LoginRequest(
                username: email,
                password: password
            )
            
            print("LOGIN REQUEST SEND")
            let tokens = try await authService.login(user: request)
            print("ACCESS \(tokens.access)")
            print("REFRESH \(tokens.refresh)")
            print("LOGIN TOKENS RECEIVED")
            
            keychain.save(token: tokens.refresh, for: refreshToken)
            keychain.save(token: tokens.access, for: accessToken)
            print("TOKENS SAVED")
            
            let userResponse = try await userService.me(
                requestHeaders: ["Authorization": "Bearer \(tokens.access)"]
            )
            print("ME RESPONSE RECEIVED")
            
            session.currentUser = User(dto: userResponse)
            session.isAuthenticated = true
            print("USER SAVED: \(userResponse)")
            
            print("LOGIN SUCCESS")
        } catch {
            errorMessage = error.localizedDescription
            print("LOGIN ERR: \(error)")
            print("LOGIN ERR DESCRIPTION: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    func logout() async {
        keychain.deleteToken(for: accessToken)
        keychain.deleteToken(for: refreshToken)

        session.isAuthenticated = false
        session.currentUser = nil
    }
    
    func deleteMe() async {
        session.isRegistered = false
        session.isAuthenticated = false

        session.currentUser = nil
    }
}
