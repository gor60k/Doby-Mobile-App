import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    private let repository: PetRepositoryProtocol
    private let userStorage: UserStorage
    
    var currentPage = 0
    
    private(set) var pet: Pet?
    private let petId: Int
    
    var user: User? { userStorage.currentUser }
    
    private(set) var slides: [PetPhoto] = []
    private(set) var infoItems: [PetProfileInfoItem] = []
    
    init(
        repository: PetRepositoryProtocol,
        userStorage: UserStorage,
        petId: Int
    ) {
        self.repository = repository
        self.userStorage = userStorage
        self.petId = petId
        
        syncPetFromRepository()
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
            syncPetFromRepository()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func syncPetFromRepository() {
//        guard let petId = pet?.id else { return }
        guard let updatedPet = repository.pets.first(where: { $0.id == petId }) else { return }
        
        pet = updatedPet
        slides = makeSlides(from: updatedPet)
        infoItems = makeInfoItems(from: updatedPet)
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
