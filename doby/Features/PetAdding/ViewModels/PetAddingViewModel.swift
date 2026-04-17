import Foundation
import _PhotosUI_SwiftUI
import os
import Observation
import PhotosUI

@Observable
final class PetAddingViewModel {
    private var session = SessionService.shared
    private var keychain = KeychainService.shared
    private var petStorage = PetStorage.shared
    private var log = LogService.shared
    
    private var petService: PetServiceProtocol
    
    private let logger = Logger(
        subsystem: "com.app.subsystem",
        category: "PetAddingViewModel"
    )
    
    var petType: PetType = .dog
    var name: String = ""
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var breedName: String = ""

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
        petService: PetServiceProtocol = PetService()
    ) {
        self.petService = petService
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
        
        await log.logAsync("ADDPET", logger: logger) {
            let request = PetRequest(
                pet_type: petType.toDTO(),
                name: name,
                age: age,
                height: height,
                weight: weight,
                breed_name: breedName,
            )
            
            let response = try await petService.create(request)
            
            petStorage.appendPet(response.toDomain())
        }
        
        isLoading = false
    }
}
