import Alamofire
import Observation

@Observable
final class PetContainer {
    let repository: PetRepositoryProtocol
    
    init(apiClient: APIClientProtocol) {
        let service = PetService(apiClient: apiClient)
        
        self.repository = PetRepository(
            service: service,
            storage: .shared
        )
    }
}
