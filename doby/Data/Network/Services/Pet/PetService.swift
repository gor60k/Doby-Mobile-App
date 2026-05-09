import Foundation

final class PetService: PetServiceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func create(_ request: PetRequest) async throws -> PetResponse {
        try await apiClient.request(CreateEndpoint(request: request))
    }
    
    func fetchAll(_ ownerUUID: String) async throws -> [PetResponse] {
        try await apiClient.request(FetchAllEndpoint(ownerUUID: ownerUUID))
    }
    
    func fetchById(ownerUUID: String, petId: Int) async throws -> PetResponse {
        try await apiClient.request(FetchByIdEndpoint(ownerUUID: ownerUUID, petId: petId))
    }
    
    func delete(_ petId: Int) async throws -> EmptyDTO {
        try await apiClient.request(DeleteEndpoint(petId: petId))
    }
}
