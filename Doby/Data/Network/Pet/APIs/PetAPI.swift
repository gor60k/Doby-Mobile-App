import Foundation

final class PetAPI: PetAPIProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func create(_ request: PetRequest) async throws -> PetDTO {
        try await apiClient.request(CreateEndpoint(request: request))
    }
    
    func fetchAll(from ownerUUID: String) async throws -> [PetDTO] {
        try await apiClient.request(FetchAllEndpoint(ownerUUID: ownerUUID))
    }
    
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> PetDTO {
        try await apiClient.request(FetchByIdEndpoint(ownerUUID: ownerUUID, petId: petId))
    }
    
    func delete(_ petId: Int) async throws -> EmptyDTO {
        try await apiClient.request(DeleteEndpoint(petId: petId))
    }
    
    func updatePet(_ request: UpdatePetRequest, with petId: Int) async throws -> PetDTO {
        try await apiClient.request(UpdatePetEndpoint(request: request, petId: petId))
    }
    
    func uploadPetPhoto(_ request: PhotoRequest, with petId: Int) async throws -> PhotoDTO {
        try await apiClient.request(UploadPetPhotoEndpoint(request: request, petId: petId))
    }
}
