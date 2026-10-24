import Foundation

protocol PetAPIProtocol {
    func create(_ request: PetRequest) async throws -> PetDTO
    func fetchAll(from ownerUUID: String) async throws -> [PetDTO]
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> PetDTO
    func delete(_ petId: Int) async throws -> EmptyDTO
    func updatePet(_ request: UpdatePetRequest, with petId: Int) async throws -> PetDTO
    func uploadPetPhoto(_ request: PhotoRequest, with petId: Int) async throws -> PhotoDTO
}
