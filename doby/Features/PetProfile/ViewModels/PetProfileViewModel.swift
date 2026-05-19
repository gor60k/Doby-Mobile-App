import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    private let repository: PetRepositoryProtocol
    private let petStorage: PetStorageProtocol
    private let userStorage: UserStorageProtocol
    
    var currentPage = 0
    
    var pet: Pet?
    var petDescription: String = "Бакс — дружелюбный и энергичный пёс, который обожает долгие прогулки, игры с мячом и внимание людей. Любит вкусняшки, быстро учится новым командам и всегда рад новым знакомствам."
    
    private let petId: Int
    
    var user: User? { userStorage.user }
    
    private(set) var slides: [PetPhoto] = []
    private(set) var infoItems: [PetProfileInfoItem] = []
    
    init(
        repository: PetRepositoryProtocol,
        userStorage: UserStorageProtocol,
        petStorage: PetStorageProtocol,
        petId: Int
    ) {
        self.repository = repository
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.petId = petId
        
        loadPet()
    }
    
    private(set) var isLoading = false
    var error: String?
    
    func fetchPet() async {
        guard let petId = pet?.id else { return }
        guard let ownerUUID = user?.uuid else {
            error = "User not found"
            return
        }
        
        isLoading = true
        error = nil
        defer { isLoading = false }
        
        do {
            try await repository.fetchPet(ownerUUID: ownerUUID, petId: petId)
            loadPet()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadPet() {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        pet = loaded
        slides = makeSlides(from: loaded)
        infoItems = makeInfoItems(from: loaded)
    }
    
    private func makeSlides(from pet: Pet) -> [PetPhoto] {
        pet.photos.map {
            PetPhoto(
                id: $0.id,
                imageURL: $0.imageURL,
                orderNumber: $0.orderNumber,
                isMain: $0.isMain
            )
        }
    }
    
    private func makeInfoItems(from pet: Pet) -> [PetProfileInfoItem] {
        [
            .weight(pet.weight),
            .height(pet.height)
        ]
    }
}
