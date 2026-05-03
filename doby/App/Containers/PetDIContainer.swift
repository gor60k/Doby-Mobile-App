import Alamofire

final class PetDIContainer {
    private let app: AppDIContainer
    
    init(app: AppDIContainer = .shared) {
        self.app = app
    }
    
    lazy var service: PetServiceProtocol = {
        PetService(apiClient: app.apiClient)
    }()
    
    lazy var storage: PetStorage = {
        PetStorage()
    }()
    
    lazy var repository: PetRepositoryProtocol = {
        PetRepository(
            service: service,
            storage: storage
        )
    }()
    
    func makePetProfileViewModel() -> PetProfileViewModel {
        PetProfileViewModel(repository: repository)
    }
    
    func makePetViewModel() -> PetViewModel {
        PetViewModel(repository: repository)
    }
    
    func makePetAddingViewModel() -> PetAddingViewModel {
        PetAddingViewModel(repository: repository)
    }
}
