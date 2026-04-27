import Foundation
import _PhotosUI_SwiftUI
import os
import Observation
import PhotosUI

@Observable
final class PetAddingViewModel {
    private let repository: PetRepository
    
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var petStorage = PetStorage.shared
    private var logService = LogService.shared
    
    var petType: PetType = .dog
    var name: String = ""
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var breedName: String = ""
    var dietType: String = ""
    var dietPattern: String = ""

    var description: String = ""
    var selectedPhotoItems: [PhotosPickerItem] = []
    var selectedPhotosData: [Data] = []

    var feedingType: String = ""
    var feedingSchedule: String = ""
    var feedingNotes: String = ""
    
    var warningTagsViewModel = PrimaryTagsViewModel(
        type: .warning,
        placeholder: "Например: аллергия"
    )
    
    var featureTagsViewModel = PrimaryTagsViewModel(
        type: .feature,
        placeholder: "Например: любит детей"
    )
    
    var isLoading: Bool = false
    var errorMessage: String?
    
    init(
        repository: PetRepository = .init(
            service: PetService(),
            storage: PetStorage.shared
        ),
    ) {
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
    }
    
    @MainActor
    func addPet() async {
        isLoading = true
        errorMessage = nil
        
        logService.network.info("НАЧАЛО СОЗДАНИЯ ПИТОМЦА")
        
        do {
            let input = CreatePetInput(
                petType: petType,
                name: name,
                age: age,
                warningTags: warningTagsViewModel.tags,
                specificTags: featureTagsViewModel.tags,
            )
            logService.network.info("ОТПРАВКА ЗАПРОСА")
            
            _ = try await repository.createPet(input: input)
            logService.network.info("ПОЛУЧЕНИЕ ОТВЕТА")
        } catch {
            logService.network.error("ОШИБКА СОЗДАНИЯ ПИТОМЦА: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
