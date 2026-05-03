import Alamofire

final class UserDIContainer {
    private let app: AppDIContainer
    
    init(app: AppDIContainer = .shared) {
        self.app = app
    }
    
    lazy var userRepository: UserRepositoryProtocol = {
        UserRepository()
    }()
    
    lazy var petService: PetServiceProtocol = {
        PetService(apiClient: app.apiClient)
    }()
    
    lazy var petStorage: PetStorage = {
        PetStorage()
    }()
    
    lazy var petRepository: PetRepositoryProtocol = {
        PetRepository(
            service: petService,
            storage: petStorage
        )
    }()
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            userRepository: userRepository,
            petRepository: petRepository
        )
    }
}
