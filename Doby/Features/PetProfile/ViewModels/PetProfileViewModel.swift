import SwiftUI
import Observation

@Observable
final class PetProfileViewModel {
    private let repository: PetRepositoryProtocol
    private let petStorage: PetStorage
    private let userStorage: UserStorage
    
    var currentPage = 0
    
    var pet: Pet?
    var description: String?
    
    private let petId: Int
    
    var user: User? { userStorage.user }
    
    private(set) var slides: [PetPhoto] = []
    private(set) var infoItems: [PetProfileInfoItem] = []
    
    init(
        repository: PetRepositoryProtocol,
        userStorage: UserStorage,
        petStorage: PetStorage,
        petId: Int
    ) {
        self.repository = repository
        self.userStorage = userStorage
        self.petStorage = petStorage
        self.petId = petId
    }
    
    private(set) var isLoading = false
    var error: String?
    
    func load() async {
        guard let loaded = petStorage.pets.first(where: { $0.id == petId }) else { return }
        
        pet = loaded
        slides = makeSlides(from: loaded)
    }
    
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
            try await repository.fetchPet(with: petId, from: ownerUUID)
        } catch {
            self.error = error.localizedDescription
        }
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
}

extension PetProfileViewModel {
    static var mock: PetProfileViewModel {
        let repository = MockPetRepository()
        let userStorage = UserStorage()
        let petStorage = PetStorage.mock
        
        return PetProfileViewModel(
            repository: repository,
            userStorage: userStorage,
            petStorage: petStorage,
            petId: 1
        )
    }
}
