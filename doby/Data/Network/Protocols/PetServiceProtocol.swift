import Foundation

protocol PetServiceProtocol {
    func create(_ request: PetRequest) async throws -> PetResponse
    
    func fetchById(
        ownerUUID: UUID,
        petId: Int
    ) async throws -> PetResponse
}
