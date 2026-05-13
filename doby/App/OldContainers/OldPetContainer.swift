import Alamofire
import Observation


//TODO: - доделать фикс реактивности данных петов
@Observable
final class OldPetContainer {
    let repository: PetRepositoryProtocol
    
    init(apiClient: APIClientProtocol) {
        let service = PetService(apiClient: apiClient)
        
        self.repository = PetRepository(
            service: service,
            storage: PetStorage()
        )
    }
}
