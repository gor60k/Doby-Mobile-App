import Foundation
import Observation

@Observable
final class PetSettingsViewModel {
    private let petRepository: PetRepositoryProtocol
    private let petStorage: PetStorage
    
    let petId: Int
    let ownerUUID: String
    
    var age = 0
    
    var height: Int?
    var weight: Int?
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
            try await petRepository.fetchPet(ownerUUID: ownerUUID, petId: petId)
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
