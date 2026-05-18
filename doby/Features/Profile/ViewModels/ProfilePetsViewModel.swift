import Observation

@MainActor
@Observable
final class ProfilePetsViewModel {
    private let petRepository: PetRepositoryProtocol
    
    init(petRepository: PetRepositoryProtocol) {
        self.petRepository = petRepository
    }
    
    var currentPage = 0
    
    var isLoading = false
    var error: String?
}
