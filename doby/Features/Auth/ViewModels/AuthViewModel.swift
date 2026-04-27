import Foundation
import os
import Observation

@Observable
final class AuthViewModel {
    private let repository: AuthRepository
    
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
        repository: AuthRepository = .init(
            service: AuthService(),
            storage: UserStorage.shared,
            session: SessionService.shared
        )
    ) {
        self.repository = repository
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
        
        do {
            let input = RegisterInput(
                username: email,
                password: password
            )
            
            _ = try await repository.register(input: input)
        } catch {
            errorMessage = error.localizedDescription
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
        
        do {
            let input = LoginInput(
                username: email,
                password: password
            )
            
            _ = try await repository.login(input: input)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    @MainActor
    func logout() async {
        
        isLoading = true
        errorMessage = nil
        
        do {
            _ = try await repository.logout()
        } catch {
            errorMessage = error.localizedDescription
        }
       
        isLoading = false
    }
}
