import Foundation
import Observation

@Observable
final class PetSettingsViewModel {
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    let petId: Int
    let ownerUUID: String
    
    var petType: PetType = .dog
    var name: String = ""
    var age = 0
    var gender: Gender = .male
    
    var uploadedPhotos: [Data] = []
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
    
    private func loadPet() {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        print(loaded)
        
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
