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
    ) {
        self.repository = repository
        
        loadLocalPet()
    }
    
    var isLoading = false
    var error: String?
    
    func fetchPet() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await repository.fetchPet(ownerUUID: pet!.ownerUUID, petId: pet!.id)
            loadLocalPet()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadLocalPet() {
        guard let pet = repository.pets.first(where: { $0.id == pet!.id }) else { return }
        
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
