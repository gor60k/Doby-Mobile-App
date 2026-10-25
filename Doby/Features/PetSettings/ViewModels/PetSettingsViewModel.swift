import SwiftUI
import Foundation
import Observation
import PhotosUI

@Observable
final class PetSettingsViewModel: ViewModel {
    // MARK: - Dependencies
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    // MARK: - Единая форма редактирования
    var form = PetSettingsForm()
    
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
    
    // MARK: - Read-only данные питомца (URL фото, имя для title)
    private(set) var pet: Pet?
    var currentPhotoURL: URL?
    
    // MARK: - Meta
    let petId: Int
    let ownerUUID: String
    var isUploadingPhoto = false
    
    private let baseURL = APIConstants.getImageBaseURL()
    
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
    }
    
    // MARK: - Публичные методы
    
    /// Загружает питомца и инициализирует форму
    func loadPet() async {
        await perform {
            let pet = try await petRepository.fetchPet(with: petId, from: ownerUUID)
            self.pet = pet
            self.form = PetSettingsForm(from: pet)
            self.currentPhotoURL = self.makeCurrentPhotoURL(from: pet)
            
            // Синхронизируем child ViewModels с формой
            self.warningTagsViewModel = PrimaryTagsViewModel(
                type: .warning,
                placeholder: "Например: аллергия",
                tags: pet.warningTags
            )
            self.featureTagsViewModel = PrimaryTagsViewModel(
                type: .feature,
                placeholder: "Например: любит детей",
                tags: pet.specificTags
            )
        }
    }
    
    /// Сохраняет изменения на сервер
    func updatePet() async {
        // Синхронизируем теги из child ViewModels в форму перед отправкой
        form.warningTags = warningTagsViewModel.tags
        form.featureTags = featureTagsViewModel.tags
        
        await perform {
            let input = form.toUpdateInput()
            try await petRepository.updatePet(input, with: petId)
        }
    }
    
    func uploadPhoto(_ data: Data) async {
        await perform {
            let input = PhotoInput(
                image: data,
                orderNumber: (pet?.photos.count ?? 0) + 1,
                isMain: pet?.photos.isEmpty ?? true
            )
            try await petRepository.uploadPetPhoto(input, with: petId)
        }
    }
    
    // MARK: - Приватные методы
    private func makeCurrentPhotoURL(from pet: Pet) -> URL? {
        guard let photoPath = pet.photos.first(where: \.isMain)?.imageURL
              ?? pet.photos.first?.imageURL,
              !photoPath.isEmpty else { return nil }
        
        return baseURL.appendingPathComponent(photoPath)
    }
}
