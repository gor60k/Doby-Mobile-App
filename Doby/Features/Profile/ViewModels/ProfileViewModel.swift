import Foundation
import Observation

@MainActor
@Observable
final class ProfileViewModel: ViewModel {
    private let userRepository: UserRepositoryProtocol
    private let petRepository: PetRepositoryProtocol
    private let storage: UserStorage
    private let displayModeService: DisplayModeService
    
//    var user: User? { storage.user }
    private(set) var user: User?
    private(set) var uuid: String?
    
    
    private var ownerUUID: String? { user?.uuid }
    
    var displayMode: DisplayMode { displayModeService.mode }
    
    init(
        userRepository: UserRepositoryProtocol,
        petRepository: PetRepositoryProtocol,
        storage: UserStorage,
        displayModeService: DisplayModeService
        
    ) {
        self.userRepository = userRepository
        self.petRepository = petRepository
        self.storage = storage
        self.displayModeService = displayModeService
    }
    
    func load() async {
        guard var uuid else { return }
        
        switch displayModeService.mode {
        case .owner:
            await fetchUser()
            user = storage.user
            uuid = user?.uuid ?? ""
        case .visitor:
            await getUser(with: uuid)
        }
        
        await fetchPets(from: uuid)
    }
    
    func fetchUser() async {
        await perform {
            try await userRepository.fetchUser()
        }
    }
    
    func getUser(with userUUID: String) async {
        await perform {
            user = try await userRepository.getUser(with: userUUID)
        }
    }
    
    func fetchPets(from userUUID: String) async {
//        guard let ownerUUID else { return }
        
        await perform {
            try await petRepository.fetchPets(from: userUUID)
        }
    }
}

extension ProfileViewModel {
    static var mock: ProfileViewModel {
        let userRepository = MockUserRepository()
        let petRepository = MockPetRepository()
        let storage = UserStorage()
        
        let displayModeService = DisplayModeService(mode: .owner)
        
        return ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository,
            storage: storage,
            displayModeService: displayModeService
        )
    }
}
