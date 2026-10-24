import SwiftUI
import Foundation
import Observation
import PhotosUI

@Observable
final class SettingsViewModel: ViewModel {
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
    var cities: [City] = []
    
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
    }
    
    // MARK: - User Actions
    func load() async {
        await perform {
            async let userTask = userRepository.getMe()
            async let citiesTask = userRepository.getCities()

            _ = try await userTask
            let cities = try await citiesTask
            print(cities)
            self.cities = cities
            syncFromStorage()
        }
    }
    
    func fetchUser() async {
        await perform {
            _ = try await userRepository.getMe()
            syncFromStorage()
        }
    }
    
    func fetchCities() async {
        await perform {
            self.cities = try await userRepository.getCities()
            print("ГОРОДА", self.cities)
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
            
            try await userRepository.updateMe(input)
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

//extension SettingsViewModel {
//    static var mock: SettingsViewModel {
//        let authRepository = MockAuthRepository()
//        let userRepository = MockUserRepository()
//        let userStorage = UserStorage()
//        let cityStorage = CityStorage()
//        
//        return SettingsViewModel(
//            authRespository: authRepository,
//            userRepository: userRepository,
//            userStorage: userStorage,
//            cityStorage: cityStorage
//        )
//    }
//}
