import Observation

@MainActor
@Observable
final class ProfilePetsViewModel {
    private let petRepository: PetRepositoryProtocol
    
    init(petRepository: PetRepositoryProtocol) {
        self.petRepository = petRepository
        self.pets = petRepository.pets
    }
    
    var currentPage = 0
    
    var pets: [Pet] = []
    
    var isLoading = false
    var error: String?
}
