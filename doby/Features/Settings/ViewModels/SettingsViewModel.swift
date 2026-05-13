import SwiftUI
import Observation

@Observable
final class SettingsViewModel {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let userStorage: UserStorage
    
    var username: String = ""
    var name: String = ""
    var surname: String = ""
    var city: City = City(name: "Novorossiysk", translit: "novorossiysk")
    
    var password: String = ""
    var newPassword: String = ""
    var confirmNewPassword: String = ""
    
    var phone: String = ""
    var email: String = ""
    
    var isLoading = false
    var error: String?
    
    init(
        authRespository: AuthRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        userStorage: UserStorage
    ) {
        self.authRepository = authRespository
        self.userRepository = userRepository
        self.userStorage = userStorage
        
        loadCurrentUser()
    }
    
    func fetchUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await userRepository.fetchUser()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func logout() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await authRepository.logout()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadCurrentUser() {
        guard let user = userStorage.currentUser else { return }
        
        username = user.username
        name = user.firstName ?? ""
        surname = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
    }
}
