import SwiftUI
import Foundation
import Observation
import PhotosUI

@Observable
final class PetSettingsViewModel: ViewModel {
    // MARK: - Dependencies
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    // MARK: - Private Properties
    private let baseURL = APIConstants.getImageBaseURL()
    
    // MARK: - Child ViewModels
    let photoPickerViewModel = PrimaryPhotoPickerViewModel()
    var warningTagsViewModel = PrimaryTagsViewModel(
        type: .warning,
        placeholder: "Например: аллергия"
    )
    var featureTagsViewModel = PrimaryTagsViewModel(
        type: .feature,
        placeholder: "Например: любит детей"
    )
    
    // MARK: - Pet Data
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
    
    var detailsInfo = PetDetails()
    var dietInfo = PetDiet()
    var petTags = PetTags()

    // MARK: - Initialization
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
        
//        loadPet()
    }
    
    // MARK: - Публичные методы
    func fetchPet() async {
        await perform {
            try await petRepository.fetchPet(with: petId, from: ownerUUID)
        }
    }
    
    func updatePet() async {
        petTags.warningTags = warningTagsViewModel.tags
        petTags.featureTags = featureTagsViewModel.tags
        
        await perform {
            let input = UpdatePetInput(
                petType: petType,
                uploadedPhotos: uploadedPhotos,
                name: name.nilIfEmpty,
                age: age.nilIfZero,
                gender: gender,
                height: detailsInfo.height.nilIfZero,
                weight: detailsInfo.weight.nilIfZero,
                breedName: breedName.nilIfEmpty,
                dietType: dietInfo.dietType.nilIfEmpty,
                dietPattern: dietInfo.dietPattern.nilIfEmpty,
                additionalInfo: detailsInfo.description.nilIfEmpty,
                dietAdditionalInfo: dietInfo.dietAdditionalInfo.nilIfEmpty,
                warningTags: petTags.warningTags,
                specificTags: petTags.featureTags
            )
            
            try await petRepository.updatePet(input, with: petId)
        }
    }
    
    func uploadPhoto(_ data: Data) async {
        await perform {
            let input = PetPhotoInput(
                image: data,
                orderNumber: uploadedPhotos.count + 1,
                isMain: uploadedPhotos.isEmpty
            )
            
            try await petRepository.uploadPetPhoto(input, with: petId)
        }
    }
    
    func load() {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        currentPhotoURL = makeCurrentPhotoURL(from: loaded)
        
        age = loaded.age
        
        detailsInfo.height = loaded.height
        detailsInfo.weight = loaded.weight
        detailsInfo.description = loaded.additionalInfo
        
        dietInfo.dietType = loaded.dietType
        dietInfo.dietPattern = loaded.dietPatterns
        dietInfo.dietAdditionalInfo = loaded.dietAdditionalInfo
        
        petTags.warningTags = loaded.warningTags
        petTags.featureTags = loaded.specificTags
        warningTagsViewModel.tags = petTags.warningTags
        featureTagsViewModel.tags = petTags.featureTags
    }
    
    // MARK: - Приватные методы
    private func makeCurrentPhotoURL(from pet: Pet) -> URL? {
        guard let photoPath = pet.photos.first(where: { $0.isMain })?.imageURL ?? pet.photos.first?.imageURL,
              !photoPath.isEmpty else { return nil }
        
        return baseURL.appendingPathComponent(photoPath)
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
