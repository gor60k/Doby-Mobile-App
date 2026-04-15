import Foundation

final class PetService: PetServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func create(_ request: PetRequest) async throws -> PetResponse {
        try await apiClient.request(CreateEndpoint(request: request))
    }
    
    func fetchById(ownerUUID: UUID, petId: Int) async throws -> PetResponse {
        try await apiClient.request(FetchByIdEndpoint(ownerUUID: ownerUUID, petId: petId))
    }
}
