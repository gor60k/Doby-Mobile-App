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
    
    var photos: [Data] = []
    var selectedPhotoImage: UIImage?
    var currentPhotoURL: URL?
    var isUploadingPhoto = false

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
    
    func handlePhotoSelection(_ item: PhotosPickerItem) async {
        guard let data = try? await item.loadTransferable(type: Data.self),
              let image = UIImage(data: data) else { return }
        
        let maxDimension: CGFloat = 1200
        let originalSize = image.size
        
        let scale = min(
            maxDimension / originalSize.width,
            maxDimension / originalSize.height,
            1
        )

        let resizedSize = CGSize(
            width: originalSize.width * scale,
            height: originalSize.height * scale
        )

        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.scale = 1

        let renderer = UIGraphicsImageRenderer(
            size: resizedSize,
            format: rendererFormat
        )

        let resizedImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: resizedSize))
        }

        guard let compressedData = resizedImage.jpegData(compressionQuality: 0.35) else {
            return
        }

        print("ORIGINAL SIZE MB:", Double(data.count) / 1024 / 1024)
        print("COMPRESSED SIZE KB:", compressedData.count / 1024)

        await MainActor.run {
            selectedPhotoImage = resizedImage
        }

        await uploadedPhotos(compressedData)
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
        guard let user = userStorage.user else { return }

        if let photoPath = user.photos?.first(where: { $0.isMain })?.imageURL
            ?? user.photos?.first?.imageURL,
           !photoPath.isEmpty {

            currentPhotoURL = baseURL.appendingPathComponent(photoPath)
        }

        print("ФОТО ПОЛЬЗОВАТЕЛЯ", currentPhotoURL)
        
        firstName = user.firstName ?? ""
        lastName = user.lastName ?? ""
        phone = user.phone ?? ""
        email = user.username
        bio = user.bio ?? ""
        selectedCityId = user.city?.id
    }
    
    private func uploadedPhotos(_ data: Data) async {
        isUploadingPhoto = true
        defer { isUploadingPhoto = false }
        
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
