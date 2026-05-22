import SwiftUI

protocol PetRepositoryProtocol {
    func createPet(input: CreatePetInput) async throws
    func fetchPets(from ownerUUID: String) async throws
    func fetchPet(with petId: Int, from ownerUUID: String) async throws
    func deletePet(id: Int) async throws
}
