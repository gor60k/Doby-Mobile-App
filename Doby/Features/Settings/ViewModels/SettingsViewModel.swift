import SwiftUI
import Foundation
import Observation
import PhotosUI

//TODO: доделать логику добавления и изменения фото
@Observable
final class SettingsViewModel {
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let userStorage: UserStorage
    private let cityStorage: CityStorage
    
    let photoPickerViewModel = PrimaryPhotoPickerViewModel()
    
    var photos: [Data] = []
    var currentPhotoURL: URL?

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
    
    private let baseURL = APIConstants.getImageBaseURL()
    
    init(
        authRespository: AuthRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
        userStorage: UserStorage,
        cityStorage: CityStorage
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
    
    func uploadPhoto(_ data: Data) async {
        await uploadedPhotos(data)
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
        print("USER:", userStorage.user as Any)
        
        guard let user = userStorage.user else { return }
        
        print("PHOTOS:", user.photos as Any)

        if let photoPath = user.photos?.first(where: { $0.isMain })?.imageURL
            ?? user.photos?.first?.imageURL,
           !photoPath.isEmpty {

            currentPhotoURL = baseURL.appendingPathComponent(photoPath)
        }
        
        firstName = user.firstName ?? ""
        lastName = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
        bio = user.bio ?? ""
        selectedCityId = user.city?.id
    }
    
    private func uploadedPhotos(_ data: Data) async {
        do {
            let input = UserPhotoInput(
                image: data,
                orderNumber: photos.count + 1,
                isMain: photos.isEmpty
            )
            
            _ = try await userRepository.uploadPhoto(input)
            
            photos.append(data)
        } catch {
            self.error = error.localizedDescription
        }
    }
}

extension SettingsViewModel {
    static var mock: SettingsViewModel {
        let authRepository = MockAuthRepository()
        let userRepository = MockUserRepository()
        let userStorage = UserStorage()
        let cityStorage = CityStorage()
        
        return SettingsViewModel(
            authRespository: authRepository,
            userRepository: userRepository,
            userStorage: userStorage,
            cityStorage: cityStorage
        )
    }
}
