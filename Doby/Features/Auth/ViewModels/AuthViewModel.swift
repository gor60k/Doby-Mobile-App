import Foundation
import os
import Observation

@Observable
final class AuthViewModel: ViewModel {
    private let repository: AuthRepositoryProtocol
    
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
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    @MainActor
    func register() async {
        guard isEmailValid else {
            error = "Некорректный email"
            return
        }
        
        guard isRegisterPasswordValid else {
            error = "Пароли не совпадают или слишком короткие"
            return
        }
        
        await perform {
            let input = RegisterInput(
                username: email,
                password: password
            )
            
            try await repository.register(input: input)
        }
    }
    
    @MainActor
    func login() async {
        guard isEmailValid else {
            error = "Некорректный email"
            return
        }
        
        guard isLoginPasswordValid else {
            error = "Введите пароль"
            return
        }
        
        await perform {
            let input = LoginInput(
                username: email,
                password: password
            )
            
            try await repository.login(input: input)
        }
    }
    
    @MainActor
    func logout() async {
        await perform {
            try await repository.logout()
        }
    }
}

extension AuthViewModel {
    static var mock: AuthViewModel {
        let reposirory = MockAuthRepository()
        
        return AuthViewModel(
            repository: reposirory,
        )
    }
}
