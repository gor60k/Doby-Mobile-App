import SwiftUI
import Foundation
import Observation
import PhotosUI

@Observable
final class SettingsViewModel {
    // MARK: - Dependencies
    private let authRepository: AuthRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let userStorage: UserStorage
    private let cityStorage: CityStorage

    // MARK: - Private Properties
    private let baseURL = APIConstants.getImageBaseURL()

    // MARK: - Child ViewModels
    let photoPickerViewModel = PrimaryPhotoPickerViewModel()

    // MARK: - User Data
    var personalInfo = PersonalInfo()
    var email: String = ""
    var bio: String = ""

    // MARK: - Photos
    var photos: [Data] = []
    var currentPhotoURL: URL?

    // MARK: - Location
    var selectedCityId: Int?
    var cities: [City] { cityStorage.cities }

    // MARK: - UI State
    var isLoading = false
    var error: String?
    
    // MARK: - Initialization
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
        
        syncFromStorage()
    }
    
    // MARK: - User Actions
    func load() async {
        await perform {
            async let userTask = userRepository.fetchUser()
            async let citiesTask = userRepository.fetchCities()

            _ = try await userTask
            _ = try await citiesTask

            syncFromStorage()
        }
    }
    
    func fetchUser() async {
        await perform {
            try await userRepository.fetchUser()
            syncFromStorage()
        }
    }
    
    func fetchCities() async {
        await perform {
            try await userRepository.fetchCities()
        }
    }
    
    func updateUser() async {
        await perform {
            let input = UpdateUserInput(
                firstName: personalInfo.firstName.nilIfEmpty,
                lastName: personalInfo.lastName.nilIfEmpty,
                phone: personalInfo.phone.nilIfEmpty,
                city: selectedCityId,
                bio: bio.nilIfEmpty,
            )
            
            try await userRepository.updateUser(input: input)
            syncFromStorage()
        }
    }
    
    func uploadPhoto(_ data: Data) async {
        await perform {
            let input = UserPhotoInput(
                image: data,
                orderNumber: photos.count + 1,
                isMain: photos.isEmpty
            )
            
            try await userRepository.uploadPhoto(input)
            syncFromStorage()
        }
    }
    
    func logout() async {
        await perform {
            try await authRepository.logout()
        }
    }
    
    // MARK: - Private Helpers
    private func perform(
        _ action: () async throws -> Void
    ) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await action()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func syncFromStorage() {
        guard let user = userStorage.user else { return }

        currentPhotoURL = makeCurrentPhotoURL(from: user)
        
        personalInfo.firstName = user.firstName ?? ""
        personalInfo.lastName = user.lastName ?? ""
        personalInfo.phone = user.phone ?? ""
        
        email = user.username
        bio = user.bio ?? ""
        selectedCityId = user.city?.id
    }

    private func makeCurrentPhotoURL(from user: User) -> URL? {
        guard let photoPath = user.photos?.first(where: { $0.isMain })?.imageURL
                ?? user.photos?.first?.imageURL,
              !photoPath.isEmpty else {
            return nil
        }

        return baseURL.appendingPathComponent(photoPath)
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
