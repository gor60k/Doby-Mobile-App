import Foundation

protocol PetAPIProtocol {
    func create(_ request: PetRequest) async throws -> PetResponse
    func fetchAll(_ ownerUUID: String) async throws -> [PetResponse]
    func fetchById(ownerUUID: String, petId: Int) async throws -> PetResponse
    func delete(_ petId: Int) async throws -> EmptyDTO
}
