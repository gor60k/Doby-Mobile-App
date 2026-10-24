import SwiftUI

protocol PetRepositoryProtocol {
    func createPet(input: CreatePetInput) async throws -> Pet
    func fetchPets(from ownerUUID: String) async throws -> [Pet]
    func fetchPet(with petId: Int, from ownerUUID: String) async throws -> Pet
    func deletePet(id: Int) async throws
    func updatePet(_ input: UpdatePetInput, with petId: Int) async throws
    func uploadPetPhoto(_ input: PhotoInput, with petId: Int) async throws
}
