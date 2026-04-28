import Foundation

protocol PetServiceProtocol {
    func create(_ request: PetRequest) async throws -> PetResponse
    func fetchById(ownerUUID: UUID, petId: Int) async throws -> PetResponse
    func delete(_ petId: Int) async throws -> EmptyResponse
}
