import SwiftUI
import Observation

@Observable
final class SettingsViewModel {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let userStorage: UserStorageProtocol
    private let cityStorage: CityStorageProtocol
    
    var avatar: String = ""

    var selectedCityId: Int?
    var cities: [City] { cityStorage.cities }
    
    var firstName: String = ""
    var lastName: String = ""
    var patronymic: String = ""
    var phone: String = ""
    var bio: String = ""
    
    var password: String = ""
    var newPassword: String = ""
    var confirmNewPassword: String = ""

    var email: String = ""
    
    var isLoading = false
    var error: String?
    
    init(
        authRespository: AuthRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        userStorage: UserStorageProtocol,
        cityStorage: CityStorageProtocol
    ) {
        self.authRepository = authRespository
        self.userRepository = userRepository
        self.userStorage = userStorage
        self.cityStorage = cityStorage
        
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
    
    func fetchCities() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            _ = try await userRepository.fetchCities()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func updateUser() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let input = UpdateUserInput(
                firstName: firstName.nilIfEmpty,
                lastName: lastName.nilIfEmpty,
                patronymic: patronymic.nilIfEmpty,
                phone: phone.nilIfEmpty,
                avatar: avatar.nilIfEmpty,
                city: selectedCityId,
                bio: bio.nilIfEmpty,
            )
            
            _ = try await userRepository.updateUser(input: input)
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
        guard let user = userStorage.user else { return }
    
        firstName = user.firstName ?? ""
        lastName = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
        bio = user.bio ?? ""
        selectedCityId = user.city?.id
    }
}
