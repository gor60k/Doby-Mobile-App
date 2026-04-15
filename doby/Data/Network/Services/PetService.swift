import Foundation

final class PetService: PetServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func create(_ request: PetRequest, headers: [String: String]) async throws -> PetResponse {
        try await apiClient.request(CreateEndpoint(request: request, headersValue: headers))
    }
    
    func fetchById(ownerUUID: UUID, petId: Int, headers: [String : String]) async throws -> PetResponse {
        try await apiClient.request(FetchByIdEndpoint(ownerUUID: ownerUUID, petId: petId, headersValue: headers))
    }
}
