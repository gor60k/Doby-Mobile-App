import Foundation
import _PhotosUI_SwiftUI
import os
import Observation
import PhotosUI

@Observable
final class PetAddingViewModel {
    private let repository: PetRepositoryProtocol
    
    // MARK: - Обязательные поля
    var petType: PetType = .dog
    var name: String = ""
    var age: Int = 0
    var breedName: String = ""
    
    var petGender: Gender = .female
    
    // MARK: - высота и вес обязательные поля
    var height: Int?
    var weight: Int?
    var description: String = ""
    
    var dietType: String = ""
    var dietPattern: String = ""
    var dietAdditionalInfo: String = ""
    
    var selectedPhotoItems: [PhotosPickerItem] = []
    var selectedPhotosData: [Data] = []

    // MARK: - Обязательные теги
    var warningTagsViewModel = PrimaryTagsViewModel(
        type: .warning,
        placeholder: "Например: аллергия"
    )
    
    // MARK: - Обязательные теги
    var featureTagsViewModel = PrimaryTagsViewModel(
        type: .feature,
        placeholder: "Например: любит детей"
    )
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(repository: PetRepositoryProtocol) {
        self.repository = repository
    }
    
    @MainActor
    func loadSelectedPhotos() async {
        selectedPhotosData = []

        for item in selectedPhotoItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                selectedPhotosData.append(data)
            }
        }
        
        print("Loaded photos count: \(selectedPhotosData.count)")
    }
    
    @MainActor
    func addPet() async {
        isLoading = true
        defer { isLoading = false }
        
        errorMessage = nil
        
        await loadSelectedPhotos()
        
        do {
            let input = CreatePetInput(
                petType: petType,
                uploadedPhotos: selectedPhotosData,
                name: name,
                age: age,
                height: height,
                weight: weight,
                breedName: breedName,
                dietType: dietType,
                dietPattern: dietPattern,
                dietAdditionalInfo: dietAdditionalInfo,
                warningTags: warningTagsViewModel.tags,
                specificTags: featureTagsViewModel.tags
            )
            
            _ = try await repository.createPet(input: input)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
