import Foundation

protocol PetServiceProtocol {
    func create(_ request: PetRequest,
                headers: [String: String]
    ) async throws -> PetResponse
    
    func fetchById(
        ownerUUID: UUID,
        petId: Int,
        headers: [String: String]
    ) async throws -> PetResponse
}
