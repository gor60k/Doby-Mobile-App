import Foundation

protocol PetAPIProtocol {
    func create(_ request: PetRequest) async throws -> PetResponse
    func fetchAll(from ownerUUID: String) async throws -> [PetResponse]
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> PetResponse
    func delete(_ petId: Int) async throws -> EmptyDTO
    func updatePet(_ request: UpdatePetRequest, with petId: Int) async throws -> PetResponse
}
