import Foundation
import os
import Observation

@Observable
final class AuthViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var userStorage = UserStorage.shared
    private var log = LogService.shared
    
    private var authService: AuthServiceProtocol
    private var userService: UserServiceProtocol
    
    private let logger = Logger(
        subsystem: "com.app.subsystem",
        category: "AuthViewModel"
    )
    
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var isRegisterPasswordValid: Bool {
        !password.isEmpty &&
        password.count >= 8 &&
        password == confirmPassword
    }
    
    var isLoginPasswordValid: Bool {
        !password.isEmpty &&
        password.count >= 8
    }
    
    var isEmailValid: Bool {
        email.contains("@") &&
        email.contains(".")
    }
    
    var isRegisterFormValid: Bool {
        isEmailValid &&
        isRegisterPasswordValid
    }
    
    var isLoginFormValid: Bool {
        isEmailValid &&
        isLoginPasswordValid
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
        guard isEmailValid else {
            errorMessage = "Некорректный email"
            print("REGISTER STOP: invalid email")
            return
        }
        
        guard isRegisterPasswordValid else {
            errorMessage = "Пароли не совпадают или слишком короткие"
            print("REGISTER STOP: invalid password")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        await log.logAsync("REGISTER", logger: logger) {
            let request = RegisterRequest(
                username: email,
                password: password,
            )
            
            let response = try await authService.register(request)
            
            userStorage.save(User(dto: response.user))
            session.isRegistered = true
            session.isAuthenticated = true
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
        
        guard isLoginPasswordValid else {
            errorMessage = "Введите пароль"
            print("LOGIN STOP: empty password")
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        await log.logAsync("LOGIN", logger: logger) {
            let request = LoginRequest(
                username: email,
                password: password
            )
            
            let response = try await authService.login(request)
            
            userStorage.save(User(dto: response.user))
            session.isAuthenticated = true
        }
        
        isLoading = false
    }
    
    @MainActor
    func logout() async {
        await log.logAsync("LOGOUT", logger: logger) {
            _ = try await authService.logout()
        }

        session.isAuthenticated = false
        userStorage.clear()
    }
    
    @MainActor
    func deleteMe() async {
        session.isRegistered = false
        session.isAuthenticated = false

        userStorage.clear()
    }
}
