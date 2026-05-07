import Alamofire
import Observation

@Observable
final class PetContainer {
    let repository: PetRepositoryProtocol
    
    init(apiClient: APIClientProtocol) {
        let service = PetService(apiClient: apiClient)
        let storage = PetStorage()
        
        self.repository = PetRepository(
            service: service,
            storage: storage
        )
    }
}
