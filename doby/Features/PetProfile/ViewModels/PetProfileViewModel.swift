import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    private let repository: PetRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    
    private let petId: Int
    
    var currentPage: Int = 0
    var pet: Pet?
    var owner: User?
    
    var slides: [PetAvaratSlide] = []
    var infoItems: [PetProfileInfoItem] = []
    
    init(
        petId: Int,
        repository: PetRepositoryProtocol,
        userRepository: UserRepositoryProtocol,
    ) {
        self.petId = petId
        self.repository = repository
        self.userRepository = userRepository
        self.owner = userRepository.getCurrentUser()
        
        loadLocalPet()
    }
    
    var isLoading = false
    var error: String?
    
    func fetchPet() async {
        do {
            try await repository.fetchPet(ownerUUID: owner!.uuid, petId: petId)
            loadLocalPet()
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func loadLocalPet() {
        guard let pet = repository.pets.first(where: { $0.id == petId }) else { return }
        
        self.pet = pet
        
        self.slides = pet.photos.enumerated().map {
            PetAvaratSlide(id: $0.offset, image: $0.element.imageURL)
        }
        
        self.infoItems = [
            .weight(pet.weight),
            .height(pet.height),
            .color(pet.name)
        ]
    }
}
