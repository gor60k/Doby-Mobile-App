import SwiftUI
import Foundation
import Observation
import PhotosUI

@Observable
final class PetSettingsViewModel {
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    let photoPickerViewModel = PrimaryPhotoPickerViewModel()
    
    let photos: [Data] = []
    var currentPhotoURL: URL?
    
    let petId: Int
    let ownerUUID: String
    
    var uploadedPhotos: [Data] = []
    var selectedPhotoImage: UIImage?
    
    var isUploadingPhoto = false
    
    var petType: PetType = .dog
    var name: String = ""
    var age = 0
    var gender: PetGender = .male
    
    var breedName: String = ""
    
    var height: Int = 0
    var weight: Int = 0
    var description: String = ""
    
    var dietType: String = ""
    var dietPattern: String = ""
    var dietAdditionalInfo: String = ""
    
    var warningTags: [String] = []
    var featureTags: [String] = []
    
    var warningTagsViewModel = PrimaryTagsViewModel(
        type: .warning,
        placeholder: "Например: аллергия"
    )
    
    var featureTagsViewModel = PrimaryTagsViewModel(
        type: .feature,
        placeholder: "Например: любит детей"
    )
    
    var isLoading = false
    var error: String?
    
    private let baseURL = APIConstants.getImageBaseURL()
    
    init(
        petRepository: PetRepositoryProtocol,
        petStorage: PetStorage,
        petId: Int,
        ownerUUID: String
    ) {
        self.petRepository = petRepository
        self.petStorage = petStorage
        self.petId = petId
        self.ownerUUID = ownerUUID
        
        loadPet()
    }
    
    // MARK: - Публичные методы
    func fetchPet() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await petRepository.fetchPet(with: petId, from: ownerUUID)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func updatePet() async {
        isLoading = true
        defer { isLoading = false }
        
        warningTags = warningTagsViewModel.tags
        featureTags = featureTagsViewModel.tags
        
        do {
            let input = UpdatePetInput(
                petType: petType,
                uploadedPhotos: uploadedPhotos,
                name: name.nilIfEmpty,
                age: age.nilIfZero,
                gender: gender,
                height: height.nilIfZero,
                weight: weight.nilIfZero,
                breedName: breedName.nilIfEmpty,
                dietType: dietType.nilIfEmpty,
                dietPattern: dietPattern.nilIfEmpty,
                additionalInfo: description.nilIfEmpty,
                dietAdditionalInfo: dietAdditionalInfo.nilIfEmpty,
                warningTags: warningTags,
                specificTags: featureTags
            )
            
            print("ИНПУТ ПИТОМЦА", input)
            
            try await petRepository.updatePet(input, with: petId)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    func uploadPhoto(_ data: Data) async {
        await uploadedPhotos(data)
    }
    
    // MARK: - Приватные методы
    private func loadPet() {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        if let photoPath = loaded.photos.first(where: { $0.isMain })?.imageURL ?? loaded.photos.first?.imageURL {
            currentPhotoURL = URL(string: baseURL.absoluteString)?.appendingPathComponent(photoPath)
        }
        
        age = loaded.age
        height = loaded.height
        weight = loaded.weight
        description = loaded.additionalInfo
        
        dietType = loaded.dietType
        dietPattern = loaded.dietPatterns
        dietAdditionalInfo = loaded.dietAdditionalInfo
        
        warningTags = loaded.warningTags
        featureTags = loaded.specificTags
        warningTagsViewModel.tags = warningTags
        featureTagsViewModel.tags = featureTags
    }
    
    private func uploadedPhotos(_ data: Data) async {
        isUploadingPhoto = true
        defer { isUploadingPhoto = false }
        
        do {
            let input = PetPhotoInput(
                image: data,
                orderNumber: uploadedPhotos.count + 1,
                isMain: uploadedPhotos.isEmpty
            )
            _ = try await petRepository.uploadPetPhoto(input, with: petId)
            
            uploadedPhotos.append(data)
        } catch {
            self.error = error.localizedDescription
        }
    }
}

extension PetSettingsViewModel {
    static var mock: PetSettingsViewModel {
        let repository = MockPetRepository()
        let storage = PetStorage()
        
        return PetSettingsViewModel(
            petRepository: repository,
            petStorage: storage,
            petId: 1,
            ownerUUID: ""
        )
    }
}
