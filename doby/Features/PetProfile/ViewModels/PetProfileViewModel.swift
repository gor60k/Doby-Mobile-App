import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    private let repository: PetRepositoryProtocol
    
    var currentPage: Int = 0
    var pet: Pet?
    
    var slides: [PetPhoto] = []
    var infoItems: [PetProfileInfoItem] = []
    
    init(
        repository: PetRepositoryProtocol,
        pet: Pet? = nil
    ) {
        self.repository = repository
        self.pet = pet
        
        loadLocalPet()
    }
    
    var isLoading = false
    var error: String?
    
    func fetchPet() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            guard let pet else { return }
            try await repository.fetchPet(ownerUUID: pet.ownerUUID, petId: pet.id)
            loadLocalPet()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadLocalPet() {
        guard let currentPet = pet else { return }
        guard let pet = repository.pets.first(where: { $0.id == currentPet.id }) else { return }
        self.pet = pet
        
        self.slides = pet.photos.enumerated().map {
            PetPhoto(id: $0.element.id, imageURL: $0.element.imageURL, orderNumber: $0.element.orderNumber, isMain: $0.element.isMain)
        }
        
        self.infoItems = [
            .weight(pet.weight),
            .height(pet.height),
        ]
    }
}
